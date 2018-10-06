<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.trs.usermanage.UserManage"%>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>

<%
try{
	String strAdminName= (String)request.getSession().getAttribute("username");

	int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));
	
	int intType=1;
	String intTypeStr = request.getParameter("intType");
	if(intTypeStr!=null    )
	{
		try{
			intType = Integer.parseInt(intTypeStr);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	String adminState=(String)request.getAttribute("adminState");
//	System.out.println("adminState="+adminState);
/*
int adminID=intUserID;
//adminlist中管理员管辖用户数点击弹出窗口看此管理员管辖的用户，所以可能从adminlist传进来一个adminID
String sAdminID=request.getParameter("adminID");
if(sAdminID!=null && com.trs.Tools.isNumeric(sAdminID)){
	adminID=Integer.parseInt(sAdminID);
	//out.println("adminID="+adminID);
}
*/
//**********************取得管理员ID，把属于此id的用户显示出来*****************************
    //声明变量
	String searchWord;//检索关键字
	String searchMark=null;//检索类型
	searchMark=request.getParameter("searchMark");
	searchWord=request.getParameter("searchWord")==null?"":request.getParameter("searchWord");
	
	//out.println(searchMark+"<br>");
	//out.println(searchWord);
	//System.out.println("");
	String userName[];		//用户名
	String realName[];		//用户真名
	String registerDate[];		//注册时间
	String overdueDate[];		//过期时间
	int userIDs[];		//用户ID
	String userNav1[];
	String userNav3[];
		
	int intPages=0;		//定义总页数
	int userCount=0;		//用户总数,也即记录总数
	int countPerPage=10;		//每页显示行数
	String strCurrentPage=request.getParameter("pageIndex");	//当前页（用于输出）
	int intCurrentPage=0;	//当前页（用于计算） 

//out.println("countPerPage="+countPerPage);
	
	if(strCurrentPage==null||strCurrentPage.equals("")) 
	{
	  strCurrentPage="1";
	  intCurrentPage=1;
	} 
	else
	{
	  intCurrentPage=Integer.parseInt(strCurrentPage);
	}	
	/*
	String[] arrEnterpriseInfo=UserManage.getEnterpriseInfo(adminID);
	String chrEnterpriseName=arrEnterpriseInfo[0];
	int intMaxSearchCount=Integer.parseInt(arrEnterpriseInfo[1]);
	int intMaxNavCount=Integer.parseInt(arrEnterpriseInfo[2]);
	int intMaxUserCount=Integer.parseInt(arrEnterpriseInfo[3]);	
	*/
	if(searchMark!=null && !searchMark.equals(""))
	{
	  //searchWord=new String(searchWord.getBytes("8859_1"),"GBK");
	  UserManage usermanage=new UserManage();
	  usermanage.setMulti(searchMark,searchWord,countPerPage,intCurrentPage,Integer.parseInt(adminState));	//增加一个限制项：adminID
	  userIDs=usermanage.getUserIDs();
	  userCount=usermanage.getCount();
	  overdueDate=usermanage.getExpireTimes();
      registerDate=usermanage.getRegisterTimes();  
	  realName=usermanage.getRealNames();
	  userName=usermanage.getUserNames();
	  intPages=usermanage.getPages();
	}
	else
	{
	  searchMark="";//当检索条件为空时,将检索词置空,以便下面检索参数正确
	  searchWord="";//
	  UserManage usermanage=new UserManage(countPerPage,intCurrentPage,Integer.parseInt(adminState));//增加一个限制项：adminID
	  userIDs=usermanage.getUserIDs();
      userCount=usermanage.getCount();
      overdueDate=usermanage.getExpireTimes();
      registerDate=usermanage.getRegisterTimes();  
	  realName=usermanage.getRealNames();
	  userName=usermanage.getUserNames();
	  intPages=usermanage.getPages();
	}
	
	userNav1=new String[userIDs.length];
	userNav3=new String[userIDs.length];
	
	String strUserIds="";
	
	UserManage usermanage=new UserManage();
	for(int i=0;i<userIDs.length;i++){
		userNav1[i]=usermanage.getUserTradeInfoByUserID(userIDs[i],1);		
		userNav3[i]=usermanage.getUserTradeInfoByUserID(userIDs[i],3);
		
		if(!strUserIds.equals("")){
			strUserIds+=",";
		}
		strUserIds+=userIDs[i];
	}
	
	String UserSelTradeInfo1 = "";
	for(int i=0;i<userNav1.length;i++)
	{
		if(!UserSelTradeInfo1.equals("")){
			UserSelTradeInfo1+="=";
		}
		UserSelTradeInfo1+=userNav1[i].trim();
	}
	
	String UserSelTradeInfo3 = "";
	for(int i=0;i<userNav3.length;i++)
	{
		if(!UserSelTradeInfo3.equals("")){
			UserSelTradeInfo3+="=";
		}
		UserSelTradeInfo3+=userNav3[i].trim();
	}
//	System.out.println("============================================");
	/*
	2#cnipr#750$1000$
	3#guest#	
	*/
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>后台管理-知识产权综合服务平台</title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

<script language="javascript">
function showuser(type){
	if(type==1){
		document.form3.searchMark.value="approaching";
	}
	if(type==2){
		document.form3.searchMark.value="expired";
	}
	form3.submit();
}

function selUserTrade(userId){
	_selUserTrade(userId,"TradeList1","UserSelTradeInfo1");
	_selUserTrade(userId,"TradeList3","UserSelTradeInfo3");
}
function _selUserTrade(userId,TradeList,UserSelTradeInfo){
	var options=document.getElementById(TradeList).children;
	for(var n=0;n<options.length;n++){
		options[n].selected=false;
	}
//	2#cnipr#750$1000$=3#guest#
	var UserSelTradeInfo=$("#"+UserSelTradeInfo).val();
//	alert(UserSelTradeInfo1);
	var arr1=UserSelTradeInfo.split("=");
	for(var i=0;i<arr1.length;i++){
		var arr2=arr1[i].split("#");		
		if(userId==arr2[0])
		{		
			var trade = arr2[2];
//			alert(trade);
			var arr3=trade.split("$");
			
			for(var m=0;m<options.length;m++){
				for(var n=0;n<arr3.length;n++){
//					alert(arr3[n]);
					if(options[m].value==arr3[n])
					{
						options[m].selected=true;
					}
				}
			}
		}
	}
}

function saveTrade(){
	var assignUserID=$("#assignUserID").val();
//	alert(assignUserID);
	var Trade1 = "";	
	var options=document.getElementById("TradeList1").children;
	for(var n=0;n<options.length;n++){
		if(options[n].selected){
//			alert(options[n].value);
			if(Trade1!=""){
				Trade1+=",";
			}
			Trade1+=options[n].value;
		}
	}
	
//	alert("---------------------------------------------------------");
	var Trade3 = "";
	options=document.getElementById("TradeList3").children;
	for(var n=0;n<options.length;n++){
		if(options[n].selected){
//			alert(options[n].value);
			if(Trade3!=""){
				Trade3+=",";
			}
			Trade3+=options[n].value;
		}
	}
	
//	alert(Trade1+","+Trade3)		intUserID,tradeInfo
	
	$.ajax({
		type : "GET",
		url : "<%=basePath%>assignhangye.do?timeStamp=" + new Date(),
		data : {
//			'nodeId' : nodeId,
//			'treeType' : '3'
			'userIDs':'<%=strUserIds%>',
			'assignUserID':assignUserID,
			'tradeInfo':Trade1+","+Trade3			
		},
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//alert(jsonresult);			
			var ret = jsonresult.split("##");
			if(ret[0]=="error"){
				showexp("修改失败");
			}else{				
				$("#UserSelTradeInfo1").val(ret[1]);
				$("#UserSelTradeInfo3").val(ret[2]);
				
				showexp("修改成功");
			}
		}
	});
}

function delUser(){
//alert("delexp....");
	var userIds = "";
	$("input[name='seluser']:checkbox").each(function(i) {
		if(this.checked){
//			alert(this.id);
			if(userIds!=""){
				userIds+=",";
			}
			userIds+=this.value;
		}			
	});
			
	if(userIds!="")
	{
		var msg = "您真的确定要删除吗？\n\n请确认！";
		if (confirm(msg)==true){
			$.ajax({
				type : "GET",
				url : "deleteuser.do?timeStamp=" + new Date(),					
				data : {
					'userIds' : userIds
				},
				contentType : "application/json;charset=UTF-8",
				success : function(jsonresult) {	
//					alert(jsonresult);
					if(jsonresult=="success"){
						showexp("删除成功");
						location.reload();
					}else{
						showexp("删除失败");
					}
				}
			})
		}
	}else{
		showexp("请选择要删除的用户");
	}
}
</script>
<style type="text/css">
.gray {color: #999999}
.style1 {color: #666666}
</style>
</head>

<body >
<!--导航-->
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>

<!--main开始-->
<div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">

<%
String menuname = "usermanage";
if(adminState!=null&&adminState.equals("1")){
	menuname = "adminmanage";
}else{
	menuname = "usermanage";
}
%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>

        <div class="span10">
         <!--span10 -->
           <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>用户管理</strong></span></td>
				</tr>
           </table>           
           
           <!-- 用户表格开始 -->
           <table class="table table-striped table-bordered table-hover ">	        
	        <tr>
	        <td width="8%" style="text-align: center;"><span><strong>选中</strong></span></td>
	        <td width="8%" style="text-align: center;"><span><strong>序号</strong></span></td>
	        <td width="20%" style="text-align: center;"><span><strong>用户名</strong></span></td>
	        <td width="28%" style="text-align: center;"><span><strong>用户真名</strong></span></td>
	        <td width="14%" style="text-align: center;"><span><strong>注册日期</strong></span></td>
	        <td width="14%" style="text-align: center;"><span><strong>过期日期</strong></span></td>
	        <td width="8%" style="text-align: center;"><span><strong>维护</strong></span></td>
	    	</tr>
	    <form name="form2" method="post" action="deleteuser.do?intType=<%=intType%>">
	    <%
	    for(int i=0;i<userIDs.length;i++)
	    {
	    %>
          <tr>
	      <td width="8%" style="text-align:center;overflow:hidden;"><input type="checkbox" name="seluser" value="<%=userIDs[i]%>" <%if(userName[i].equals("admin")||userName[i].equals("guest")){%>disabled<%}%>></td>
	      <td width="8%" style="text-align:center;overflow:hidden;"><%=(intCurrentPage-1)*20+i+1%></td>
	      <td width="20%" style="text-align:center;overflow:hidden;"><span><%=userName[i]%></span></td>
	      <td width="28%" style="text-align:center;overflow:hidden;"><%=realName[i]%>
	      <!-- 
	      </br>
	      【<a href="<%=basePath%>assignhangye.do?assignUserID=<%=userIDs[i]%>" target="_blank"/>分配行业库</a>】</br>
	      【<a href="<%=basePath%>assignhangye.do?assignUserID=<%=userIDs[i]%>" target="_blank"/>分配自定义导航库</a>】</br>
	   
	      【<a data-toggle="modal" data-target="#navModal" onclick="$('#navModal #assignUserID').val('<%=userIDs[i]%>')"/>分配行业库</a>】</br>
	       -->
	      【<a data-toggle="modal" data-target="#navModal" onclick="selUserTrade(<%=userIDs[i]%>);$('#navModal #assignUserID').val('<%=userIDs[i]%>')"/>分配行业库</a>】</br>
	      
	      </td>
	      <td width="14%" style="text-align: center;overflow:hidden;"><%=registerDate[i]%></td>
	      <td width="14%" style="text-align: center;overflow:hidden;"><%=overdueDate[i]%></td>
          <td width="8%" style="text-align: center;overflow:hidden;"><a href="#" onClick="javaScript:event.returnValue=false;window.open('updateuser.do?userID=<%=userIDs[i]%>&intType=<%=intType %>','','width=900,height=600,scrollbars=yes');"><img src="<%=basePath%>admin/images/icon_edit.gif" border="0"></a></td>
	    </tr>
	    <%
	    }
	    %>
	    </form> 
	  </table>
  <!-- 用户表格结束 -->         
      <div style="margin-top:10px;">
           <form name="form4">
             <span>
		      		   <%if(intCurrentPage>1) {%><a href="getUserList.do?pageIndex=1&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&adminState=<%=adminState%>&intType=<%=intType %>">首  页</a><%} else{%><span >首  页</span><%}%>
		               <%if(intCurrentPage>1) {%><a href="getUserList.do?pageIndex=<%=intCurrentPage-1%>&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&adminState=<%=adminState%>&intType=<%=intType %>">上一页</a><%} else{%><span>上一页</span><%}%>
		               <%if(intCurrentPage<intPages) {%><a href="getUserList.do?pageIndex=<%=intCurrentPage+1%>&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&adminState=<%=adminState%>&intType=<%=intType %>">下一页</a><%} else{%><span>下一页</span><%}%>
		               <%if(intCurrentPage<intPages) {%><a href="getUserList.do?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&adminState=<%=adminState%>&intType=<%=intType %>">尾 页</a><%} else{%><span >尾 页</span><%}%>
                     </span>
                     <span>(第 <%=strCurrentPage%> 页&nbsp; 共 <%=intPages%> 页  共 <%=userCount%> 个)</span>
         <!-- 
       	<input id="allsel" type="checkbox" name="selall" value="checkbox" onClick="allselect()"><label for="allsel" style="cursor:hand">全选</label>
       	 -->      
        <a onClick="javascript:delUser();" style="cursor:hand;" class="btn btn-danger btn-xs">删除用户</a>
        </form>
        </div>
           <div style="margin-top:10px;">
           <div style="width:255px;float:left;">
           <div class="input-prepend input-append">
					<form name="form1" method="post" action="getUserList.do">
					    <div class="btn-group">
									<select  name="searchMark" class="input-medium" style="width:86px;">
										<option value="userName">用户名</option>
										<option value="realName">用户真名</option>
									</select>
						</div>
						<div class="btn-group">
						  <input class="input-small" type="text" name="searchWord" style="height:18px;">
						</div>
						<div class="btn-group">
									<button style="height:32px;" class="btn btn-default" type="button" onClick="javascript:event.returnValue=false;submit();">查询</button>
						</div>
						</form>
					</div>
             </div>
             <!-- 
             <div style="width:230px;float:left;margin-left:10px;">
               <form name="form3" method="post" action="getUserList.jsp">
                   <input type="hidden" name="searchMark">
                   <input type="hidden" name="adminState" value="<%=adminState%>">
					<span><button class="btn btn-warning"  onClick="showuser(1)">即将过期用户</button>
					<button class="btn btn btn-danger"  onClick="showuser(2)">已经过期用户</button></span>
					</form>
             </div>
              -->
             <div style="width:230px;float:left;">
		  		<button class="btn btn-success"  onClick="javaScript:event.returnValue=false;window.open('adduser.do?intType=<%=intType %>','','width=900,height=590,scrollbars=yes');">新建用户</button>
             </div>
             </div>
             
         <!--span10 -->
        </div>
      </div>
</div>
</div>


<div style="width: 595px; height: 460px;overflow:hidden;" class="modal hide fade"
	id="navModal" tabindex="1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
	<div class="modal-dialog">
		<div class="modal-content" >
			<div class="modal-header mycolor" style="padding: 0px 15px;margin-top:20px;background-color: #fff;color:#666666">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">
					<%=website_title%> <font style="font-size:14px;color:red;">（多选请按住Ctrl键）</font>
				</h4>
			</div>
			
			<input id="assignUserID" type="hidden">
			
			<input id="UserSelTradeInfo1" type="hidden" value="<%=UserSelTradeInfo1%>">
			<input id="UserSelTradeInfo3" type="hidden" value="<%=UserSelTradeInfo3%>">
<div style="width:600px;">
<div style="margin-left:30px;width:260px;padding:8px;float:left;">
<div style="text-align:left;padding:8px;">行业库</div>
<%
//int intType=1;//行业分类导航是1，专题数据库是3
//UserManage usermanage=new UserManage();

String[] arrTradeInfo=usermanage.getAllTradeInfo(1);
%>
<select id="TradeList1" name="TradeList1" size="12" multiple="multiple" style="width:240px;height:280px">
<%
if(arrTradeInfo!=null){
	for(int i=0;i<arrTradeInfo.length;i++){
		String strPreNavInfo=arrTradeInfo[i].substring(0,arrTradeInfo[i].indexOf(";"));									
		String strNavInfo=arrTradeInfo[i].substring(arrTradeInfo[i].indexOf(";")+1);		
//		System.out.println("userTradeInfo="+userTradeInfo);									
//		System.out.println(strPreNavInfo+"-----------"+strNavInfo);		
		out.println("<option value='"+strPreNavInfo+"'>"+strNavInfo+"</option>");
	 }
}
%>
</select>
</div>

<div style="width:260px;padding:8px;float:left;">
<div style="text-align:left;padding:8px;">自定义库</div>
<%
//int intType=1;//行业分类导航是1，专题数据库是3
//UserManage usermanage=new UserManage();

arrTradeInfo=usermanage.getAllTradeInfo(3);
%>
<select id="TradeList3" name="TradeList3" size="12" multiple="multiple" style="width:240px;height:280px">
<%
if(arrTradeInfo!=null){
	for(int i=0;i<arrTradeInfo.length;i++){
		String strPreNavInfo=arrTradeInfo[i].substring(0,arrTradeInfo[i].indexOf(";"));									
		String strNavInfo=arrTradeInfo[i].substring(arrTradeInfo[i].indexOf(";")+1);		
//		System.out.println("userTradeInfo="+userTradeInfo);									
//		System.out.println(strPreNavInfo+"-----------"+strNavInfo);		
		out.println("<option value='"+strPreNavInfo+"'>"+strNavInfo+"</option>");
	 }
}
%>
</select>
</div>
</div>
<div style="clear:both;width:600px;text-align:center;">
<a onClick="javascript:saveTrade();" style="cursor:hand;" class="btn btn-success">保 存</a>
</div>			
		</div>
	</div>
</div>


<!--main结束-->	
<%@ include file="/jsp/zljs/include-buttom.jsp"%>

</body>
</html>
<%}catch(Exception ex){
	ex.printStackTrace();
}%>

