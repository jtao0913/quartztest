<!DOCTYPE html>
<html>
<%@ page contentType="text/html;charset=utf-8" errorPage="/error.jsp"%>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>
<%
String pwdChangeRes = (String)request.getAttribute("pwdChangeRes");
if (pwdChangeRes == null) {
	pwdChangeRes = "";
} else if (pwdChangeRes.equals("1")) {
	pwdChangeRes = "修改成功！";
} else {
	pwdChangeRes = "修改失败，原密码错误！";
}
%>
<head>
<title>修改密码</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<link rel="stylesheet" href="was_style.css" type="text/css">
<SCRIPT language="javascript">
function checkform()
{
	var t;
	t=document.form1.oldpasswd.value;
	if(t=="")
	{alert("原密码不能为空");
		return false;
	}
	t=document.form1.newpasswd.value;
	if(t="")
	{alert("新密码不能为空");
		return false;
	}
	if(document.form1.newpasswd.value!=document.form1.repasswd.value)
	{
		alert("两次输入的密码不一致");
		document.form1.newpasswd.value='';
		document.form1.repasswd.value='';
		return false;
	}
	else
	{
//		document.form1.action.value='<%=basePath%>changePwd.do';
//		document.form1.submit();

//		$("#form1").attr("action", "<%=basePath%>changePwd.do");
		$('#form1').submit();		
	}
	
}
</script>
</head>

<body topmargin="0" leftmargin="0">
<!--导航-->
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>
<div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">

<%String menuname = "passwdchange";%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>

        <div class="span10">
         <!--span10 -->
          <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>用户密码修改</strong></span></td>
				</tr>
           </table>
      <form name="form1" method="post" action="<%=basePath%>changePwd.do">
       <table  border=0 align=center cellspacing=0 width="765" cellpadding=3 bgcolor=#ECF4FC bordercolorlight=#B0D8F5 bordercolordark=#ffffff>
                    <tr> 
                      <td align="right" width="40%">原 密 码:</td>
                      <td> 
                        <input type="password" name="oldpasswd" size="20"> &nbsp;<font color="#ff0000"><%=pwdChangeRes %></font>
                      </td>
                    </tr>
                    <tr> 
                      <td align="right" width="30%">新 密 码:</td>
                      <td> 
                      <input type="password" name="newpasswd" size="20">
                      </td>
                    </tr>
                    <tr> 
                      <td align="right" width="30%">密码确认:</td>
                      <td> 
                      <input type="password" name="repasswd" size="20" >
                      </td>
                    </tr>
                    <tr height="20"> 
                        <td align="center" colspan="2">
                          <button class="btn btn-info" onclick="checkform()">修改密码</button>
                          <!--<input type="button" name="subcl" value="关闭" onclick="window.close()">
			--></td>
                    </tr>
                  </table>
      </form>
          
         <!--span10 -->
        </div>
      </div>
</div>
</div>
<!--main结束-->

<%@ include file="/jsp/zljs/include-buttom.jsp"%>
</body>
</html>
