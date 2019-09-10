package com.ecity.java.mvc.web.servlet.VisaInterview;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.db.DBQuery;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.htmltopdf.HtmlToPdf;
import com.java.sql.SQLCon;

@WebServlet("/web/VisaInterview/CreatePDF")

public class CreatePDFServlet extends HttpServlet {

  private static final long serialVersionUID = 1221671299145751538L;

  /*
   * (non-Javadoc)
   * 
   * @see
   * javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
   * javax.servlet.http.HttpServletResponse)
   */
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub

    Map<String, String[]> params = req.getParameterMap();
    String ID = params.get("ID") == null ? "" : (String) (params.get("ID")[0]);
    if (ID.equals("")) {
      WriteErr(req, resp, "-1", "缺少参数（ID）！");
      return;
    }
    DBTable table =new DBTable(SQLCon.GetConnect(),"select * from avin_visa_interview_notice where avin_status<>'D' and avin_id="+ID);

    try {
      table.Open();
      if (table.next()) {
        int avin_type=(int) table.GetValue("avin_type");
        switch (avin_type) {
        case 1:

//          String avin_file_name=table.getString("avin_file_name");
          String Url = WebFunction.GetServerNameUrl(req)+WebFunction.GetContextPath(req)
              + "/OutSide/VisaInterview/EuropeTemplate.jsp?ID=" + ID;          
          String PDFFile = CreatePDF(Url);
          if (PDFFile.equals("")) {
            WriteErr(req, resp, "-1", "PDF文件生成失败！");
            return;
          }
          DBQuery update=new DBQuery(SQLCon.GetConnect());
          update.Execute("update avin_visa_interview_notice set avin_pdf_url='"+PDFFile+"',avin_status='E',avin_date_lst=getdate(),avin_user_lst='CreatePDF'  where avin_id="+ID);
          update.CloseAndFree();
          JSONObject resultJson=WebFunction.WriteMsgToJson(1,"Success");
          resultJson.put("FileName", PDFFile);
          WebFunction.ResponseJson(resp, resultJson);
          return;

        default:
          break;
        }        
      }
      else {
        WriteErr(req, resp, "-1", "记录不存在");
      }
    }catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      WriteErr(req, resp, "-1", e.getMessage());
    } finally {
      // TODO: handle finally clause
      table.CloseAndFree();
    }
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    doGet(req, resp);

  }

  public String CreatePDF(String Url) {

    String UploadPath = getServletContext().getInitParameter("FileServerPath");

    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
    java.util.Date currentTime = new java.util.Date();
    String str_date1 = formatter.format(currentTime);
    String LocalPathName = "PDF/" + str_date1 + "/";
    File uploadPath = new File(LocalPathName);
    // 如果目录不存在
    if (!uploadPath.exists()) {
      // 创建目录
      uploadPath.mkdir();
    }
    UUID uuid = UUID.randomUUID();
    String PDFFileName = uuid.toString().replaceAll("-", "").toUpperCase() + ".PDF";

    if (HtmlToPdf.convert(Url, UploadPath + LocalPathName + PDFFileName)) {
      return LocalPathName + PDFFileName;
    } else {
      return "";
    }
  }

  public void WriteErr(HttpServletRequest req, HttpServletResponse resp, String MsgID, String MsgTest)
      throws IOException {
    resp.setContentType("application/json;charset=utf-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");

    net.sf.json.JSONObject ReturnJson = new net.sf.json.JSONObject();
    ReturnJson.put("MsgID", MsgID);
    ReturnJson.put("MsgTest", MsgTest);
    resp.getWriter().print(ReturnJson.toString());
    resp.getWriter().flush();
  }
}