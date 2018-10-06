<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.cnipr.cniprgz.entity.IprUser"%>
<%@page import="com.cnipr.cniprgz.commons.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if(basePath.endsWith("//")){
	basePath = basePath.substring(0,basePath.length()-1);
}

IprUser userInfo  =  request.getAttribute("userInfo")==null?null:(IprUser)request.getAttribute("userInfo");
%>
<style>
<!--
.blocktitle{
	float:left;
	height:30px; 
	color:#ffffff;
	text-align:left; 
	padding-left:0px;
	border:1px solid #ffffff; 
	background-image: url('<%=basePath%>images/bginner.jpg'); 
	background-color:#ffffff;
}
-->
</style>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script> 
<script type="text/javascript" src="<%=basePath%>js/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/validate/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>js/validate/message_cn.js"></script>
<script type="text/javascript">
<!--
 function checkedAllBox(formId, name) {
		var form = document.getElementById(formId); 
		for (var i=0; i<form.elements.length; i++) {
			var element = form.elements[i];  
			name =   (name=="undefined")?"id":name;  
			if (element.name == name && element.type=='checkbox')
				element.checked = true;
		}
	} 
	
	function unCheckedAllBox(formId, name) {
		var form = document.getElementById(formId);
		for (var i=0; i<form.elements.length; i++) {
			var element = form.elements[i];
			name =  (name=="undefined")?"id":name;
			if (element.name == name && element.type=='checkbox')
				element.checked = false;
		}
	}
//-->
</script>
<div id="editAdminDiv" style="border:0px solid;width:100%;height:350px; cursor:default;float:left; ">   
	<table border='0'cellpadding="0" align='left' cellspacing="0" width="100%" class="blocktitle">
 	  	<tr><td width='33'></td>
 	  	<td valign="middle"> 
		 <span class="word14 darkblue1 bold" >修改权限</span>
		 </td>
		 <td align='right'><a href='#' onclick='$.unblockUI({fadeOut:0});return false;' >
	<img src='<%=basePath%>images/close3.gif' border='0' width='26' height='22' />
</a></td>
		 </tr>
	  </table>
	  
	  
	  

<div style="clear:both;width:100%;">
<!--
	<form id="editAdminForm" name="editAdminForm" action="<%=basePath%>user.do?method=changeLimit" method="post">
-->	 
	<table class="table table-striped table-bordered table-hover ">
	<form id="editAdminForm" name="editAdminForm" action="<%=basePath%>changeLimit.do" method="post">
	<%  Set keys = LimitConstant.getLimitMap().keySet(); 
		Iterator iterator =keys.iterator();
		int i=0;
		while(iterator.hasNext()){ 
			String key = (String)iterator.next();
			if(SetupAccess.getProperty(key)!=null && SetupAccess.getProperty(key).equals("0"))
				continue;
			if(i==0){
				out.print("<tr>"); 
			}
			else if(i==keys.size())
			{
				out.print("</tr>"); 
			}
			else if(i%2==0)
			{				
				out.print("</tr><tr>"); 
			}
			%> 
				 <td width="50%"><input type="checkbox" name="limit" value="<%=key %>" <%if(userInfo.getChrItemGrant()!=null && userInfo.getChrItemGrant().contains(key))out.print("checked"); %>/>
				 <%= LimitConstant.getLimitMap().get(key) %>
				</td> 
			<%
			i++;
		}
	%>
	 <td width="50%"></td> 
	 
	<tr class="trbg00"><td colspan='5' height="35"><center> 
	  <input type="hidden" id="userid" value="<%=userInfo.getIntUserId() %>" name="userid"  />
	  <input type="button" id="no" value=" 全 选 " class="button2" onclick="checkedAllBox('editAdminForm','limit');"/>
	  <input type="button" id="no" value=" 全不选 " class="button2" onclick="unCheckedAllBox('editAdminForm','limit');"/>
	 <input type="submit" id="yes" value=" 提 交 " class="button2"/>
	 <input type="button" id="no" value=" 取 消 " class="button2" onclick="$.unblockUI({fadeOut:0});"/>
	 </center>
	</td></tr>
		</form> 
	</table> 
</div>

</div>
<script type="text/javascript">  

//验证添加员工表单
var validator = $("#editAdminForm").validate({  		
				submitHandler: function(form) { 
					 $(form).ajaxSubmit({
								dataType:'json',	
								cache :  "false" ,			
				                success: function(data){  
									if(data.jsonMessage=='true')
									{ 
										$.blockUI({ message: $('#alert'), css: { width: '275px',height:'90px' } , fadeIn: 0 }); 
									} 
									else 
										{
											$("#warnMessage").html(data.jsonMessage);
										}
									 
				                } 
				            });  
				            return false;
				}  
			});//end validate

			
 
</script>
