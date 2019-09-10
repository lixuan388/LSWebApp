<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-default navbar-fixed-top1" style="margin-bottom: 0px;">
  <div class="container" style="width:100%">
     <div class="navbar-header">
       <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
         <span class="glyphicon glyphicon-th-list"></span>
       </button>
       <a class="navbar-brand" href="<%=request.getContextPath() %>/Content/index.jsp">WebApp</a>
     </div>
     <div id="navbar" class="collapse navbar-collapse">
  	   <ul class="nav navbar-nav navbar-right">
     	<li><a><span>部门：<%=request.getSession().getAttribute("DepartmentName") %></span></a></li>
     	<li><a><span>用户：<%=request.getSession().getAttribute("UserName") %></span></a></li>
     	<li><a href="<%=request.getContextPath() %>/Login/login.jsp"><span style="color:red;">【注销】</span></a></li>
     	</ul>
     </div>
	</div>    			    
</nav>