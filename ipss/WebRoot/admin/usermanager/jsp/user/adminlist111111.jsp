<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>


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
	
int adminID=intUserID;
//**********************取得管理员ID，把属于此id的用户显示出来*****************************
    //声明变量
	String searchWord;//检索关键字
	String searchMark=null;//检索类型
	searchMark=request.getParameter("searchMark");
	searchWord=request.getParameter("searchWord")==null?"":request.getParameter("searchWord");
	
	//out.println(searchMark+"<br>");
	//out.println(searchWord);
	
	String userName[];		//用户名
	String realName[];		//用户真名
	int    userIDs[];		//用户ID
	int    child_user[];
		
	int    intPages=0;		//定义总页数
	int    userCount=0;		//用户总数,也即记录总数
	int    countPerPage=20;		//每页显示行数
	String strCurrentPage=request.getParameter("pageIndex");	//当前页（用于输出）
	int    intCurrentPage=0;	//当前页（用于计算） 

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
	
	if(searchMark!=null && !searchMark.equals(""))
	{
//	  searchWord=new String(searchWord.getBytes("8859_1"),"GBK");
	  AdminManage adminmanage=new AdminManage();
	  adminmanage.setMulti(searchMark,searchWord,countPerPage,intCurrentPage);	//增加一个限制项：adminID
	  userIDs=adminmanage.getUserIDs();
	  child_user=adminmanage.getChildUsers();
	  userCount=adminmanage.getCount();
	  realName=adminmanage.getRealNames();
	  userName=adminmanage.getUserNames();
	  intPages=adminmanage.getPages();
	}
	else
	{
	  searchMark="";//当检索条件为空时,将检索词置空,以便下面检索参数正确
	  searchWord="";//
	  AdminManage adminmanage=new AdminManage(countPerPage,intCurrentPage);//增加一个限制项：adminID
	  userIDs=adminmanage.getUserIDs();
	  child_user=adminmanage.getChildUsers();
      userCount=adminmanage.getCount();
	  realName=adminmanage.getRealNames();
	  userName=adminmanage.getUserNames();
	  intPages=adminmanage.getPages();
	}
	
	
	String strItemGrant = "";
	if(request.getSession().getAttribute("strItemGrant")!=null)
		strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>后台管理-知识产权综合服务平台</title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
<script language="javascript">
<!--
//全选开关函数 
function allselect()
{
	var i
	
	if( document.all.form2.sel==undefined )
	{
		return;
	}
	if(document.all.form4.selall.checked==true)
	{
		if( document.all.form2.sel.length == undefined )
		{
		 	document.all.form2.sel.checked=true;
		}
		else
		{
			for(i=0;i<document.all.form2.sel.length;i++)
			{
				document.all.form2.sel[i].checked=true
			}
		}
	}
	else
	{
		if( document.all.form2.sel.length == undefined )
		{
		 	document.all.form2.sel.checked=false;
		}
		else
		{
			for(i=0;i<document.all.form2.sel.length;i++)
			{
				document.all.form2.sel[i].checked=false
			}
		}
	}
}

function sure()
{
	if(typeof(document.all.form2.sel.length)!="undefined")
	{
		var v=0;
		for(i=0;i<document.all.form2.sel.length;i++)
		{
//alert(document.all.form2.sel[i].disabled);
			if(document.all.form2.sel[i].checked==true && document.all.form2.sel[i].disabled==false)
			{
				v++;
			}
		}
		if(v==0)
		{
			alert("请选中要删除的二级管理员！");
			return false;
		}
	}
	else
	{
			if(document.all.form2.sel.checked==false)
			{
				alert("请选中要删除的二级管理员！");
				return false;
			}
	}
	
	if (confirm("你确信要删除你选中的二级管理员吗?"))
	{
		form2.submit();
	}
	else
	{
		return false;
	}
}

function checkpageform(form)
{
	if(form.page1.value=="")
	{
		alert("请指定要浏览的页数！");
		return false;
	}
	if(!isInteger(form.page1.value))
	{
		alert("指定要浏览的页数必须是整数！");
		return false;
	}
	if(form.page1.value<=0 || form.page1.value><%=intPages%>)
	{
		alert("指定要浏览的页数超出了允许的范围！");
		return false;
	}
	form.pageIndex.value=form.page1.value-1;
	return true;
}
function isInteger(inputVal)
{
	inputStr = inputVal.toString();
	for(var i=0;i<inputStr.length;i++)
	{
		var oneChar = inputStr.charAt(i);
		if(oneChar=="-" && i==0)
		{
			continue;
		}
		if(oneChar<"0" || oneChar>"9")
		{
			return false;
		}
	}
	return true;
}

function distribute_hangye(){
  	var theDate =new Date();
	var random=theDate.getTime();

	var strHeight = "180px";
		
	var inargs = new Array("PRINT");
	
	var obj = hangye_user;
	document.all.hangye_user.value="";
//var returnval = window.showModalDialog("newParameter.jsp?action="+action+"&para1="+para1+"&para2="+para2+"&rd="+random,inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
//var ReturnValue = window.showModalDialog("newParameter.jsp?action="+action+"&rd="+random,inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
	var returnval=window.showModalDialog("assign_find.jsp?intType=1&rd="+random,obj,"dialogWidth=400px;dialogHeight="+strHeight+";status=no;scroll:no"); 

	var hangyeUser=document.all.hangye_user.value;
	//alert(hangyeUser);
	if(hangyeUser!=""){
		returnval=window.showModalDialog("assign_hangye.jsp?username="+hangyeUser+"&rd="+random,obj,"dialogWidth=400px;dialogHeight=400px;status=no;scroll:no"); 
	}
}

-->
</script>
</head>
<input type="hidden" name="hangye_user">
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--导航-->
<%@ include file="/jsp/zljs/include-head-nav.jsp"%>
<!--main开始-->
<div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">

<%String menuname = "adminmanage";%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>

        <div class="span10">
         <!--span10 -->
          <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>管理员管理</strong></span></td>
				</tr>
           </table>
             <!-- 用户表格开始 -->
           <table class="table table-striped table-bordered table-hover ">
	        <form name="form2" method="post" action="deleteuser.do?intType=<%=intType %>">        
	        <tr> 
	        <td width="8%" style="text-align: center;"><span><strong>选中</strong></span></td>
	        <td width="8%" style="text-align: center;"><span><strong>序号</strong></span></td>
	        <td width="20%" style="text-align: center;"><span ><strong>管理员名</strong></span></td>
	        <td width="28%" style="text-align: center;"><span><strong>管理员真名</strong></span></td>
	        <td width="14%" style="text-align: center;"><span><strong>管理用户</strong></span></td>
	        <td width="8%" style="text-align: center;"><span><strong>维护</strong></span></td>
	    </tr>
	   <%
	    for(int i=0;i<userIDs.length;i++)
	    {
	    %>
            <tr>
	      <td width="11%" style="text-align: center;"><input type="checkbox" name="sel" value="<%=userIDs[i]%>" <%if(userName[i].equals("admin")||userName[i].equals("guest")){%>disabled<%}%>></td>
	      <td width="11%" style="text-align: center;"><%=(intCurrentPage-1)*20+i+1%></td>
	      <td width="20%" style="text-align: center;"><%=userName[i]%><%--<a href="#" onclick="editLimit('<%=userIDs[i] %>');"/>【功能】</a>
	       --%><% 
	       
	       if(SetupAccess.getProperty(SetupConstant.OPENPHYSICALDB )!=null && SetupAccess.getProperty(SetupConstant.OPENPHYSICALDB).equals("1")){%>
				 <% if(strItemGrant.contains(SetupConstant.OPENPHYSICALDBADMIN)){%>
				  <a href="<%=basePath%>jsp/physical/user-create.jsp?userid=<%=userIDs[i] %>" onclick=""/>【添加到物理库用户】</a>
			<%}} %>
	      </td>
	      <td width="20%" style="text-align: center;"><%=realName[i]%><a href="assignhangye.do?assignUserID=<%=userIDs[i]%>" target="_blank"/>【分配行业库】</a></td>
	      <td width="23%" style="text-align: center;">
		  <%if(userIDs[i]==1){%>
		  <a href="getUserList.do?adminID=<%=userIDs[i]%>" onClick="javaScript:event.returnValue=false;window.open('getUserList.do?adminID=<%=userIDs[i]%>&intType=<%=intType %>','','width=900,height=622,scrollbars=yes');"><span class="style2">全部用户</span></a>
		  <%}else if(child_user[i]>0){%>
		  <a href="getUserList.do?adminID=<%=userIDs[i]%>" onClick="javaScript:event.returnValue=false;window.open('getUserList.do?adminID=<%=userIDs[i]%>&intType=<%=intType %>','','width=900,height=622,scrollbars=yes');"><span class="style2"><%=child_user[i]%></span></a>
		  <%}else{%>
		  <%=child_user[i]%>
		  <%}%>
		  </td>
	      <td width="15%" style="text-align: center;"><a href="#" onClick="javaScript:event.returnValue=false;window.open('updateuser.do?userID=<%=userIDs[i]%>&intType=<%=intType %>','','width=900,height=600,scrollbars=yes');"><img src="<%=basePath%>admin/images/icon_edit.gif" border="0"></a></td>
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
		      		   <%if(intCurrentPage!=1) {%><a href="getAdminList.do?pageIndex=1&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&intType=<%=intType %>">首  页</a><%} else{%><span class="style1">首  页</span><%}%>
		               <%if(intCurrentPage!=1) {%><a href="getAdminList.do?pageIndex=<%=intCurrentPage-1%>&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&intType=<%=intType %>">上一页</a><%} else{%><span class="style1">上一页</span><%}%>
		               <%if(intCurrentPage!=intPages) {%><a href="getAdminList.do?pageIndex=<%=intCurrentPage+1%>&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&intType=<%=intType %>">下一页</a><%} else{%><span class="style1">下一页</span><%}%>
		               <%if(intCurrentPage!=intPages) {%><a href="getAdminList.do?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>&searchMark=<%=searchMark%>&intType=<%=intType %>">尾 页</a><%} else{%><span class="style1">尾 页</span><%}%>
             </span>
             <span>(第 <%=strCurrentPage%> 页&nbsp; 共 <%=intPages%> 页  共<%=userCount%> 个)</span>
         <!-- 
       	<input id="allsel" type="checkbox" name="selall" value="checkbox" onClick="allselect()"><label for="allsel" style="cursor:hand">全选</label>
       	 -->
         <a onClick="javascript:sure(1);" style="cursor:hand;" class="btn btn-danger btn-xs">删除管理员</a>
        </form>
           </div> 
           <div style="margin-top:10px;">
           <div style="width:435px;float:left;">
              <div class="input-prepend input-append">       
					 <form name="form1" method="post" action="getAdminList.do?intType=3">
					    <div class="btn-group">
						<select name="searchMark" style="width:112px;">
	                      <option value="userName">管理员名</option>
	                      <option value="realName">管理员真名</option>
					     </select> 
					<input type="text" name="searchWord" size="15" value="">  
						</div>
						<div class="btn-group">
						 <button style="height:32px;" class="btn btn-default" type="button" onclick="javascript:event.returnValue=false;submit();">查询</button>
						</div>
			        </form>
			   </div>
			 </div>
			 <div style="width:230px;float:left;">
                <!--<button class="btn btn-info"  onClick="distribute_hangye()">分配行业库权限</button>
                  --><!--  
		        <button class="btn btn-success"  onClick="javaScript:event.returnValue=false;window.open('adduser.jsp?intType=<%=intType %>','','width=900,height=590,scrollbars=yes');">新建用户</button>
		         -->
             </div>
             </div>      
</div>   
<div id="editLimit" style="display:none;"></div>
<div id="alert" style="display:none; cursor: default;padding-top:10px"> 
	       <table align='center'>
		       <tr>
		       <td valign='middle' width="35"><img src="<%=basePath%>images/right.png" border="0" width="35" height="35" /></td>
		       <td height='35'>操作成功</td></tr>
		        <tr> 
		        <td colspan='2'>
		        <input type="button" id="alert_yes" class="button2" onClick="$.unblockUI({fadeOut:0});location.reload();" value="确定" /> 
		        </td>
		        </tr>
  </table>
</div>	
<script type="text/javascript">
function editLimit(id)//编辑员工
{  
	$("#editLimit").load("<%=basePath%>getUserInfoLimit.do?userid="+id+"&random="+Math.random());
	$.blockUI({ message: $('#editLimit'), css: { width:'380px',height:'350px',margin:'auto',top:'10%'  } , fadeIn: 0 }); 
	return false;
}
</script>    
         <!--span10 -->
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
