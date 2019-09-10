package com.ecity.java.web.ls.system.SQL;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.db.DBTable;
import com.java.sql.SQLCon;

public class TablePostData {
	String TableName;
	String TableKey;
	JSONArray	DataRows;
	String AutoGenID; 
	boolean IsAuto;
	public TablePostData(String TableName,String TableKey,JSONArray	DataRows )
	{
		this(TableName,TableKey,DataRows,"5",false);
	}
	public TablePostData(String TableName,String TableKey,JSONArray	DataRows,boolean IsAuto)
	{
		this(TableName,TableKey,DataRows,"5",IsAuto);
	}
	public TablePostData(String TableName,String TableKey,JSONArray	DataRows,String AutoGenID,boolean IsAuto )
	{
		
		this.TableName=TableName;
		this.TableKey=TableKey;
		this.DataRows=DataRows;
		this.AutoGenID=AutoGenID;
		this.IsAuto=IsAuto;
	}
	
	public JSONObject Post()
	{
		JSONObject ReturnJson = new JSONObject();

		ReturnJson.put("MsgID","1");
		ReturnJson.put("MsgText","Success");
		String KeyValue="";
		//System.out.println(DataRows.toString());
		for (int i=0;i<DataRows.length();i++)
		{
			JSONObject data=DataRows.getJSONObject(i);

			DBTable table=new DBTable(SQLCon.GetConnect());
			try
			{
				KeyValue=data.getString(TableKey);
				//System.out.println("KeyValue:"+KeyValue);
						
				table.SQL("select * from "+TableName+" where "+TableKey+"='"+KeyValue+"'");
				table.Open();
				if (!table.next())
				{
					//System.out.println("table.moveToInsertRow()");
					table.insertRow();
					if (KeyValue.equals("-1") && (!IsAuto))
					{
						try{
							Connection conn = SQLCon.GetConnect();
							CallableStatement c=conn.prepareCall("{call uspGetMaxId(?,?)}");//调用带参的存储过程
							//给存储过程的参数设置值
							c.setString(1,this.AutoGenID);	 //将第一个参数的值设置成测试
							c.registerOutParameter(2,java.sql.Types.VARCHAR);//第二个是返回参数	返回未Integer类型
							//执行存储过程
							c.execute();
							KeyValue=c.getString(2);
							conn.close();
						}catch(Exception e){
							e.printStackTrace();
						}
					}
				}				
				Iterator<String> iter = data.keys();
				while(iter.hasNext()){
						String str =	iter.next();
						String value=data.getString(str);
						if (!TableKey.equals(str))
						{
							//System.out.println(str+":"+table.getColumnType(str));
							if ((table.getColumnType(str)==93) && (value.equals("")))
							{
								table.UpdateValue(str, null);
							}
							else
							{
								table.UpdateValue(str, value);
							}
						}
						else
						{
							if (!IsAuto)
							{
								table.UpdateValue(TableKey, KeyValue);
							}
						}
//						System.out.println(str);
				}
				table.PostRow();
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				ReturnJson.put("MsgID","-1");
				ReturnJson.put("MsgText",e.getMessage());
				e.printStackTrace();
				return ReturnJson;
			}
			finally
			{
				table.CloseAndFree();
			}	 
		}
		ReturnJson.put("Key",KeyValue);
		return ReturnJson;
	}
}
