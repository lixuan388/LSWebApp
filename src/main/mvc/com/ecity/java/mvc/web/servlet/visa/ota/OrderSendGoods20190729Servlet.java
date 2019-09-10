package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.dao.SF.WayBillOrderDao;
import com.ecity.java.mvc.dao.uilts.SQLUilts;
import com.ecity.java.mvc.dao.visa.ota.BookingOrderImpl;
import com.ecity.java.mvc.dao.visa.ota.BookingOrderNameListImpl;
import com.ecity.java.mvc.model.visa.ota.BookingOrderNameListPO;
import com.ecity.java.mvc.model.visa.ota.BookingOrderPO;
import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.SF.api.OrderService;
import com.ecity.java.web.SF.api.SFApi;
import com.ecity.java.web.taobao.api.alitripTravelTradeQueryClass;
import com.ecity.java.web.zjun.service.IZjunService;
import com.ecity.java.web.zjun.service.ZjunService;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.sf.dto.WaybillDto;
import com.sf.util.Base64ImageTools;
import com.sf.util.MyJsonUtil;

@WebServlet("/web/visa/ota/OrderSendGoods20190729.json")
public class OrderSendGoods20190729Servlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  static String TempImagePath = "SFWayBillImage";

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderSendGoods20190729Servlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub

    response.setContentType("application/json;charset=utf-8");
    response.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");
    try {
      
      JSONObject DataJson=WebFunction.GetRequestJson(request);
      
      Date CreateDate=new Date();
      
      DataJson.put("CreateDateStr", WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,CreateDate));
      DataJson.put("CreateDate", CreateDate.getTime());
      DataJson.put("PrintState","未打印");
      
      String UserName=WebFunction.GetUserName(request);
      DataJson.put("CreateUserName",UserName);
      DataJson.put("Valid","有效");
      
      

      BookingOrderService orderService = new BookingOrderService();

      JSONArray OrderList=DataJson.getJSONArray("OrderList");
      String Orderid = SQLUilts.GetMaxIDByDatePrefix("SF");
      DataJson.put("SFOrderID", Orderid);

      //生成快递单
      JSONObject orderJson=OrderList.getJSONObject(0);
      
  
      String SourceOrderNo = DataJson.getString("SourceOrderNo");
      
      if (SourceOrderNo.equals("")) {
        WebFunction.WriteMsgText(response, -1,"版本错误，请刷新网页后重试！");
        return;
      }
      
      String Province = DataJson.getString("Province");
      String City = DataJson.getString("City");
      String County = DataJson.getString("County");
      String Company = "";
      String Contact = DataJson.getString("Contact");
      String Tel = DataJson.getString("Tel");
      String Address = DataJson.getString("Address");
      String Cargo = DataJson.getString("SendGoodsList");
      int PayMethod=DataJson.getString("PayType").equals("")?1:Integer.parseInt(DataJson.getString("PayType"));
  
      WayBillOrderDao orderDao = new WayBillOrderDao();
      
      orderDao.insert(UserName, SourceOrderNo, Orderid, "PostRequest", DataJson.toString(),"");
  
      OrderService order = new OrderService(Orderid, Province, City, County, Company, Contact, Tel, Address, Cargo,PayMethod);
      String returnString = order.Send();
  
      orderDao.insert(UserName, SourceOrderNo, Orderid, "PostResponse", returnString,"");
  
      DataJson.put("RespXml", returnString);
      
      order.GetXml(returnString);
      if (order.Head.equals("ERR")) {
        System.out.println("ERROR:" + order.ERROR);
        System.out.println("ERROR code:" + order.ERRORCode);
        WebFunction.WriteMsgText(response, -1, "接口返回错误！<br>ERROR:" + order.ERROR + "<br>ERROR code:" + order.ERRORCode);
        orderDao.insert(UserName, SourceOrderNo, Orderid, "PostResponseHead",
            "ERROR:" + order.ERROR + ";ERROR code:" + order.ERRORCode,"");
        return;
      } else {
        orderDao.insert(UserName, SourceOrderNo, Orderid, "PostResponseHead", order.Head,"");
      }
      String MailNo=order.OrderResponse_mailno;
      DataJson.put("MailNo", MailNo);
      
  
      List<WaybillDto> waybillDtoList = new ArrayList<WaybillDto>();
  
      WaybillDto dto = order.getWayBill();
      waybillDtoList.add(dto);
  
//      System.out.println("请求参数： " + MyJsonUtil.object2json(dto));
  
      ObjectMapper objectMapper = new ObjectMapper();
      StringWriter stringWriter = new StringWriter();
      try {
        objectMapper.writeValue(stringWriter, waybillDtoList);
      } catch (JsonGenerationException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();          
        WebFunction.WriteMsgText(response, -1, e.getMessage());
        return;
      } catch (JsonMappingException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        WebFunction.WriteMsgText(response, -1, e.getMessage());
        return;
      } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        WebFunction.WriteMsgText(response, -1, e.getMessage());
        return;
      }
      orderDao.insert(UserName, SourceOrderNo, Orderid, "Print", stringWriter.toString(),MailNo);
  
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
      Base64ImageTools.generateImage(strImg.toString(), imagePath + FileName);

      BookingOrderService service = new BookingOrderService();
      
      //s
      for (int i =0;i<OrderList.length();i++) {
        String _SourceOrderNo =OrderList.getJSONObject(i).getString("OrderID");
        JSONObject ResultJson2 = service.UpdateMailNo(_SourceOrderNo,MailNo,UserName);
        if (ResultJson2.getInt("MsgID")!=1) {  
          WebFunction.WriteMsgText(response, -1,ResultJson2.getString("MsgText"));
          return;
        }
        orderDao.insert(UserName, _SourceOrderNo, Orderid, "BillImage", FileName,MailNo);  
      }
      
      DataJson.put("BillImage", FileName);



      String SMS=DataJson.getString("SMS");
      if (SMS.equals("on"))
      {      
        String content =DataJson.getString("SendMsgContent");
        if (!Contact.equals(""))
        {
          String mobile =DataJson.getString("SendPhone");
          String EboID =DataJson.getString("EboID");
    
          IZjunService zjunService = new ZjunService();
          JSONObject ReturnJson = zjunService.v2smsSend(content, mobile);
          
    
          MongoDatabase database = MongoCon.GetConnect();
          MongoCollection<Document> collection = database.getCollection("sms");
          Document document = Document.parse(ReturnJson.toString());
          document.put("mobile", mobile);
          document.put("content", content);
          document.put("EboID", EboID);
          List<Document> documents = new ArrayList<Document>();
          documents.add(document);
          collection.insertMany(documents);
          
          orderService.InsertHistory(EboID, WebFunction.GetUserName(request), "短信", "号码：" + mobile + "；内容：" + content);
        }
      }

      BookingOrderNameListService NameListService = new BookingOrderNameListService();
      BookingOrderService bookingOrderService = new BookingOrderService();
      TaoBaoOTAService taobaoService = new TaoBaoOTAService();
      String alitripCode="1013";
      
      for (int i =0;i<OrderList.length();i++)
      {
        JSONArray checkList=OrderList.getJSONObject(i).getJSONArray("checkList");
        String OrderCode=OrderList.getJSONObject(i).getString("OrderID");
        String eboID=OrderList.getJSONObject(i).getString("EboID");
        for (int j=0;j<checkList.length();j++)
        {
          
          JSONObject c=checkList.getJSONObject(j);
          String ApplyID=c.getString("_ApplyId");
          String currentApplyStatus=c.getString("_currentApplyStatus");
          if (!ApplyID.equals(""))
          {
            JSONObject Result =NameListService.TravelvisaApplicantUpdate(OrderCode, ApplyID, alitripCode, currentApplyStatus,MailNo,"SF","顺丰","","","","");
            if (Result.getInt("MsgID")==1)
            {
              bookingOrderService.InsertHistory(eboID, UserName, "签证状态","更新申请人签证进度,ApplyID:" + ApplyID + ";state:" + alitripCode);
              NameListService.UpdateApplictionStateByApplyID(ApplyID,taobaoService.GetVisaStateName(Integer.parseInt(alitripCode)));
              bookingOrderService.UpdateStatus(eboID, UserName, taobaoService.GetVisaStateName(Integer.parseInt(alitripCode)),"");
              alitripTravelTradeQueryClass.OrderInfo(OrderCode, true);
              NameListService.UpdateApplyState(OrderCode);
            }
          }
        }
        
      }
      
      JSONObject ResultData=orderService.OrderSendGoods(DataJson);

      ResultData.put("SFOrderID", DataJson.getString("SFOrderID"));
      ResultData.put("MailNo",MailNo);
      ResultData.put("BillImage", FileName);
  
      response.getWriter().println(ResultData.toString());
      response.getWriter().flush();

    } catch (Exception e) {
      // TODO: handle exception
      WebFunction.WriteMsgText(response, -1, e.getMessage());
      return;
    }
    
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
