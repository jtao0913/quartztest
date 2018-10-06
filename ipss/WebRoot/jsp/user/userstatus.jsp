<!DOCTYPE html>
<html>
<%@ page contentType="text/html;charset=utf-8" errorPage="/error.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>
<head>
<title>专利信息服务平台</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<script language="JavaScript" type="text/javascript">
<!--
function userStatusSubmit()
{
   document.form1.action="";
   document.form1.submit();
}
-->
</script>
</head>

<body topmargin="0"  leftmargin="0" marginwidth="0" marginheight="0" bgcolor="#FAFFFF">
<!--导航-->
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>
<div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">

<%String menuname = "userstatus";%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>
        <div class="span10">
         <!--span10 -->
          <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>用户状态显示</strong></span></td>
				</tr>
           </table>
<center> 
<form name="form1" method="post" action="statresultshoweruser.jsp">
<table class="table table-striped table-bordered table-hover ">
    <tr>
		
      <td colspan="2" align="center" height="25">
<%
String userName=(String)request.getSession().getAttribute("username");
//int intCHCount=(Integer)request.getSession().getAttribute("intCHCount");
//int intFRCount=(Integer)request.getSession().getAttribute("intFRCount");
String dtRegisterTime=(String)request.getSession().getAttribute("dtRegisterTime");
String dtExpireTime=(String)request.getSession().getAttribute("dtExpireTime");
out.print("显示："+userName+" 用户状态");
%>
      </td>
	</tr>
	<tr  height="32">	
      <td align="right" width="50%">起始时间：</td>
      <td><%=dtRegisterTime%>&nbsp; </td>
	</tr>
	<tr height="32">
		
      <td align="right">终止时间：</td>
      <td><%=dtExpireTime%>&nbsp; </td>
	</tr>


</table>
</form>
</center>
         <!--span10 -->
        </div>
      </div>
</div>
</div>
<!--main结束-->

<%@ include file="/jsp/zljs/include-buttom.jsp"%>
</body>
</html>