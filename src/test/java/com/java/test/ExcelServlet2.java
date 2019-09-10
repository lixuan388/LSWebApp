package com.java.test;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;




@WebServlet("/Excel2")
public class ExcelServlet2 extends HttpServlet {
	
	private static final long serialVersionUID = 3655349618159330684L;	

	private static final int MaxStoreSize=4*1024;
	private static final int MaxFileUploadExceptionSize=1024*1024*1024;
	

	private static Map<String, String> map = new HashMap<String, String>();
    
    
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		resp.setContentType("text/html;charset=utf-8"); 
		resp.setCharacterEncoding("UTF-8");  
		resp.setHeader("Cache-Control", "no-cache");

		final String SessionID= request.getSession().getId();      
           
        //获取根目录对应的真实物理路径  
		String uploadPathString =getServletContext().getRealPath("/").replace(request.getContextPath().replace("/", "")+"\\", "")+"UploadFile";
		
        File uploadPath = new File(uploadPathString);  
        //临时目录  
		String tempPathString =getServletContext().getRealPath("/").replace(request.getContextPath().replace("/", "")+"\\", "")+"UploadTempFile";
        File tempPath =new File(tempPathString);  

        //从item_upload.jsp中拿取数据，因为上传页的编码格式跟一般的不同，使用的是enctype="multipart/form-data"  
        //form提交采用multipart/form-data,无法采用req.getParameter()取得数据  
        //String itemNo = req.getParameter("itemNo");  
        //System.out.println("itemNo======" + itemNo);  
              
          
    /********************************使用 FileUpload 组件解析表单********************/  

        System.out.println("DiskFileItemFactory");  
        //DiskFileItemFactory：创建 FileItem 对象的工厂，在这个工厂类中可以配置内存缓冲区大小和存放临时文件的目录。  
        DiskFileItemFactory factory = new DiskFileItemFactory();  
        // maximum size that will be stored in memory  
        factory.setSizeThreshold(MaxStoreSize);  
        // the location for saving data that is larger than getSizeThreshold()  
        factory.setRepository(tempPath);  
          
        //ServletFileUpload：负责处理上传的文件数据，并将每部分的数据封装成一到 FileItem 对象中。  
        //在接收上传文件数据时，会将内容保存到内存缓存区中，如果文件内容超过了 DiskFileItemFactory 指定的缓冲区的大小，  
        //那么文件将被保存到磁盘上，存储为 DiskFileItemFactory 指定目录中的临时文件。  
        //等文件数据都接收完毕后，ServletUpload再从文件中将数据写入到上传文件目录下的文件中

        System.out.println("ServletFileUpload");  
        
        ServletFileUpload upload = new ServletFileUpload(factory);  
        // maximum size before a FileUploadException will be thrown  
        upload.setSizeMax(MaxFileUploadExceptionSize);        
        
          
        /*******************************解析表单传递过来的数据，返回List集合数据-类型:FileItem***********/  
          
        try {                
            List fileItems = upload.parseRequest(request);     

            
            for (Iterator iter = fileItems.iterator(); iter.hasNext();) {
                //获得序列中的下一个元素  
                FileItem item = (FileItem) iter.next();  
                //判断是文件还是文本信息  
                if (!item.isFormField()) {    
                	String filename = item.getName();
                	
                	
                    try {
                            Workbook wb;
                            String[] split = filename.split("\\.");  //.是特殊字符，需要转义！！！！！

                            InputStream instream = item.getInputStream();
                            
                            //根据文件后缀（xls/xlsx）进行判断
                            if ( "xls".equals(split[1])){
                                wb = new HSSFWorkbook(instream);
                            }else if ("xlsx".equals(split[1])){
                                wb = new XSSFWorkbook(instream);
                            }else {
                                System.out.println("文件类型错误!");
                                resp.getWriter().print("文件类型错误!");
                                return;
                            }

                            //开始解析
                            Sheet sheet = wb.getSheetAt(0);     //读取sheet 0

                            
                            int firstRowIndex = sheet.getFirstRowNum()+1;   //第一行是列名，所以不读
                            int lastRowIndex = sheet.getLastRowNum();
                            System.out.println("firstRowIndex: "+firstRowIndex);
                            System.out.println("lastRowIndex: "+lastRowIndex);
                            map.clear();
                            for(int rIndex = firstRowIndex; rIndex <= lastRowIndex; rIndex++) {   //遍历行
                                System.out.println("rIndex: " + rIndex);
                                Row row = sheet.getRow(rIndex);
                                if (row != null) {   
                                    Cell cell = row.getCell(17);                                    
                                    String Name=cell.getStringCellValue();
                                    sign(Name);                                    
                                }
                            }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                	
                }  
            }  
            

    		
    		
    		
        } catch (Exception e) {  
            e.printStackTrace();  
        }     
        
		for(Map.Entry entry:map.entrySet()){
			String v=(String)entry.getValue();
			
			resp.getWriter().println(entry.getKey()+":"+v.length()+"<br>");

		}
		
		
		
	    resp.getWriter().flush();		
	    
	    
	}
	public static void sign(String key)
	{
		if (map.get(key)==null)
		{
			map.put(key, "1");
		}
		else
		{
			String v=map.get(key);
			map.put(key,v+"1");
		}
	}


	
}
