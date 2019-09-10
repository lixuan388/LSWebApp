package com.ecity.java.mvc.web.servlet.File;

import javax.servlet.http.HttpServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.web.fileServer.FileUpload.FileUpload;


@WebServlet("/web/File/UploadFile.json")


public class UploadFileServlet extends HttpServlet {

  /**
   * 
   */
  private static final long serialVersionUID = -5845329787968738408L;

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    
    final HttpServletResponse resp2=resp;
    FileUpload upload=new FileUpload() {
      @Override
      public void doUploadOK(JSONArray FileList) throws IOException {
        // TODO Auto-generated method stub
//        super.doUploadOK(FileList);
        JSONObject json = new JSONObject();
        json.put("FileList",FileList);
        json.put("MsgID", 1);
        resp2.getWriter().print(json.toString());
        resp2.getWriter().flush();
      }
    };
    upload.doUpload(req);
    
    
    
  }

}
