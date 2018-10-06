<!DOCTYPE html>
<html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>专题库导航管理</title> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <body>
<!--导航-->
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>
<!--main开始-->
<div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">

<%
String menuname = "hangye";
int intAdminId = Integer.parseInt((String)request.getSession().getAttribute("userid"));

%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>

        <div class="span10">
         <!--span10 -->
         <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>专题库管理</strong></span></td>
				</tr>
           </table>
<%
  	String intType = request.getParameter("intType");
  	if(intType==null  || intType.equals(""))
  		intType = "1";
%>
<%@ include file="list.jsp"%>
<%@ include file="detail.jsp"%>
<!--
          <iframe src="<%=basePath%>admin/hangye/detail.jsp?intType=<%=intType %>" name="mainFrame" class="span12" style="height:430px;border:0px;" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
 -->
        </div>
      </div>
</div>
</div>
<!--main结束-->
 


  </body>
</html>
