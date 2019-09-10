package com.ecity.java.mvc.web.servlet.SF;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.dao.SF.WayBillOrderDao;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.SF.api.OrderService;
import com.ecity.java.web.SF.api.SFApi;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sf.dto.WaybillDto;
import com.sf.util.Base64ImageTools;
import com.sf.util.MyJsonUtil;

/**
 * Servlet implementation class CreateOrderInfoServlet
 */
@WebServlet("/web/SF/CreateOrderInfo.json")
public class CreateOrderInfoServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  static String TempImagePath = "SFWayBillImage";

  /**
   * @see HttpServlet#HttpServlet()
   */
  public CreateOrderInfoServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub

    resp.setContentType("application/json;charset=utf-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");

    BufferedReader bufferReader = req.getReader();

    StringBuffer buffer = new StringBuffer();
    String line = " ";
    while ((line = bufferReader.readLine()) != null) {
      buffer.append(line);
    }

    JSONObject DataJson = null;
    try {
      DataJson = new JSONObject(buffer.toString());
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(resp, -1, "json错误！");
      return;
    }

    String SourceOrderNo = DataJson.getString("SourceOrderNo");
    String Orderid = DataJson.getString("Orderid");
    String Province = DataJson.getString("Province");
    String City = DataJson.getString("City");
    String County = DataJson.getString("County");
    String Company = DataJson.getString("Company");
    String Contact = DataJson.getString("Contact");
    String Tel = DataJson.getString("Tel");
    String Address = DataJson.getString("Address");
    String Cargo = DataJson.getString("Cargo");
    int PayMethod=DataJson.getString("payMethod").equals("")?1:Integer.parseInt(DataJson.getString("payMethod"));

    WayBillOrderDao orderDao = new WayBillOrderDao();
    String UserName = WebFunction.GetUserName(req);
    orderDao.insert(UserName, SourceOrderNo, Orderid, "PostRequest", DataJson.toString(),"");

    OrderService order = new OrderService(Orderid, Province, City, County, Company, Contact, Tel, Address, Cargo,PayMethod);
    String returnString = order.Send();

    orderDao.insert(UserName, SourceOrderNo, Orderid, "PostResponse", returnString,"");

    order.GetXml(returnString);
    if (order.Head.equals("ERR")) {
      System.out.println("ERROR:" + order.ERROR);
      System.out.println("ERROR code:" + order.ERRORCode);
      WebFunction.WriteMsgText(resp, -1, "接口返回错误！<br>ERROR:" + order.ERROR + "<br>ERROR code:" + order.ERRORCode);
      orderDao.insert(UserName, SourceOrderNo, Orderid, "PostResponseHead",
          "ERROR:" + order.ERROR + ";ERROR code:" + order.ERRORCode,"");
      return;
    } else {
      orderDao.insert(UserName, SourceOrderNo, Orderid, "PostResponseHead", order.Head,"");
    }

    String MailNo=order.OrderResponse_mailno;

    List<WaybillDto> waybillDtoList = new ArrayList<WaybillDto>();

    WaybillDto dto = order.getWayBill();
    waybillDtoList.add(dto);

    System.out.println("请求参数： " + MyJsonUtil.object2json(dto));

    ObjectMapper objectMapper = new ObjectMapper();
    StringWriter stringWriter = new StringWriter();
    try {
      objectMapper.writeValue(stringWriter, waybillDtoList);
    } catch (JsonGenerationException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (JsonMappingException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    orderDao.insert(UserName, SourceOrderNo, Orderid, "Print", stringWriter.toString(),MailNo);

    // String
    // url="http://ls.17ecity.cc:18888/sf/waybill/print?type=V3.0.FM_poster_100mm210mm&output=image";
    String url = SFApi.WayBillPrintURL;
    String strImg = order.WayBillPrint(url, stringWriter.toString().getBytes("UTF-8"));

    SimpleDateFormat format2 = new SimpleDateFormat("yyyyMMdd");
    String PathDate = format2.format(new Date()) + "\\";

    String imagePath = System.getProperty("catalina.home") + "\\webapps\\" + TempImagePath + "\\";
    File f = new File(imagePath + PathDate);
    if (!f.exists()) {
      f.mkdir();
    }
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
    String dateStr = format.format(new Date());

    String FileName = PathDate + "\\wayBillImage" + dateStr + ".png";
//		System.out.println(strImg);
    Base64ImageTools.generateImage(strImg.toString(), imagePath + FileName);
//		if(strImg.contains("\",\"")){
//			//如子母单及签回单需要打印两份或者以上
//			String[] arr = strImg.split("\",\""); 
//
//			/**输出图片到本地 支持.jpg、.png格式**/		
//			for(int i = 0; i < arr.length; i++) {
//				String FileName="wayBillImage"+dateStr+i+".jpg";
//				Base64ImageTools.generateImage(arr[i].toString(), imagePath+FileName);
//			}
//		}else{
//			Base64ImageTools.generateImage(strImg, "D:\\temp\\qiaoWaybill"+dateStr+".jpg");	
//		}


    orderDao.insert(UserName, SourceOrderNo, Orderid, "BillImage", FileName, MailNo);

    JSONObject ResultXml = new JSONObject();
    ResultXml.put("MsgID", 1);
    ResultXml.put("MsgText", "Sueecss");
    ResultXml.put("FileName", FileName);

    try {
      resp.setContentType("application/json;charset=utf-8");
      resp.setCharacterEncoding("UTF-8");
      resp.setHeader("Cache-Control", "no-cache");
      resp.getWriter().print(ResultXml.toString());
      resp.getWriter().flush();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    // System.exit(0);

  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    doGet(request, response);
  }

}
