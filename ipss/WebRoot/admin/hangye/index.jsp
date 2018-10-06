<!DOCTYPE html>
<html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ page import="java.util.*,com.trs.usermanage.Hangye"%>
<%@ page import="com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html;"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>
<%@ page import="com.cnipr.cniprgz.entity.ChannelInfo"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%@ include file="../../jsp/zljs/include-head-base.jsp"%>
<%@ include file="../../jsp/zljs/include-head.jsp"%>

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

List<ChannelInfo> channel_cn = (List<ChannelInfo>)request.getAttribute("channel_cn");
List<ChannelInfo> channel_fr = (List<ChannelInfo>)request.getAttribute("channel_fr");

Iterator<ChannelInfo> iter = channel_cn.iterator();
while(iter.hasNext())
{
	ChannelInfo ci = iter.next();
//	out.println(ci.getChrChannelName());
}
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
  	if(intType==null||intType.equals(""))
  		intType = "1";
%>



<script type="text/javascript">
var params = {};
//params.nodeId=treeNode.id;
//params.parentId
$(function() {
	showExplist(0);
});

//window.onload = function(){
function showExplist(parentid){
//alert("parentid...."+parentid);
	params.parentId = parentid;

	var text = "";
	$.ajax({	
		type : "GET",
		url : "<%=basePath%>showHangyelist.do?timeStamp=" + new Date(),
		data : {
			'parentid' : parentid,
			'intType' : '3'
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//alert(jsonresult);
//			$("#username").attr("value","guest");//清空内容 
//			$("#password").attr("value","123456");
			var ret = jsonresult.split("##");
			if(ret[0]=="error"){
				showexp(ret[1]);
			}else{
				//window.location.reload();
				//showmenu(ret[1],ret[3]);
				
				$("#strPath").html(showPath(ret[2]));

				text = text + "<tr bgcolor='#C2C6DA' td height='26'>";
				text = text + "<td width='46' align='center'><span class='style10'>序号</span></td>";
				text = text + "<td width='400'>&nbsp;<span class='style10'>名称</span></td>";
				text = text + "<td width='60'><div align='center'><span class='style10'>类 型</span></div></td>";
				text = text + "<td width='60'><div align='center'>";
				text = text + "<table border='0'>";
				text = text + "<tr>";
				text = text + "<td width='60'><div align='center' class='style10'>编辑</div></td>";
				text = text + "<td width='60'><div align='center' class='style10'>删除</div></td>";
				text = text + "</tr>";
				text = text + "</table>";
				text = text + "</div>";
				text = text + "</td>";
				text = text + "</tr>";				
				
				var jsonarray= $.parseJSON(ret[3]);
//				alert(jsonarray);

				$.each(jsonarray, function (n, result)
				{
//alert(result.overviewResponse.sectionInfos);
//alert("222==="+result.isParent+"-----"+result.name+"----"+result.cnTrsExp+"----");					

					var sColor = "";
					if(n%2 == 0)
						sColor = "#F0F5FF";
					else
						sColor = "#FFFFFF";					
					
					text = text + "<tr bgColor='"+sColor+"'>";
//					text = text + "<td align='center'>"+result.id+"</td>";
					text = text + "<td align='center'>"+(n+1)+"</td>";
					/*
					if(result.isParent){
						text = text + "<td height='24' style='cursor:pointer' onClick='javascript:showExplist("+result.id+");'>";
					}else{
						text = text + "<td height='24'>";
					}
					*/
					text = text + "<td height='24' style='cursor:pointer' onClick='javascript:showExplist("+result.id+");'>";
					text = text +"<font style='color:#3498db'>"+ result.name + "</font></td>";
					text = text + "<td><div align='center'>";
					
					if(result.isParent){
						text = text + "<img src='admin/hangye/images/folder.gif' width='16px' height='16px'></div></td>";
					}else{
						text = text + "<img src='admin/hangye/images/file.gif' width='16px' height='16px'></div></td>";
					}					

					text = text + "<td>";
					text = text + "<table style='height:20px' border='0'>";
					text = text + "<tr>";
					text = text + "<td width='40px' height='20px' align='center'>";
					text = text + "<img onClick='javascript:showExpInfo("+result.id+");' src='admin/hangye/images/edit_profile.gif' style='cursor: pointer'   width='16px' height='16px' border='0' >";
					text = text + "</td>";
					text = text + "<td width='40' align='center'>";
					text = text + "<img src='admin/hangye/images/delete.gif' onClick='javascript:del_affirm("+result.id+",\""+result.name+"\")' style='cursor: pointer' width='16px' height='16px' border='0'>";
					text = text + "</td></tr>";
					text = text + "</table>";
					text = text + "</td>";
					text = text + "</tr>";	
				})
				$('#table_list').html(text);
			}		
		}
	});
	//alert("5555");
	clearExpForm();
};

function showPath(strPath){
//alert(strPath);
//860@@3@@1 \ 862@@3@@3
	var text = "<span style='cursor:pointer;color:#3498db' onClick='javascript:showExplist(0);'>&nbsp;根节点</span>";
	
	if(strPath!=''){
		var arr = strPath.split(" \\ ");
		for(var i=0;i<arr.length;i++)
		{
//alert(arr[i]);
			var _arr = arr[i].split("@@");
			for(var j=0;j<_arr.length;j++)
			{
				//alert(_arr[j]);
			}
			text = text + " \\ <span style='cursor:pointer;color:#3498db' onClick='javascript:showExplist("+_arr[0]+");'>"+_arr[2]+"</span>";
		}
		
//		alert(arr.length);
//		alert((arr[arr.length-1].split("@@"))[0]);
		params.parentId = (arr[arr.length-1].split("@@"))[0];
	}
		
//alert(text);
	return text;
}

function showExpInfo(nodeId){
//	params.parentId = "";
	params.nodeId = nodeId;
	params.action = "edit";

	$.ajax({	
		type : "GET",
		url : "<%=basePath%>getNodeInfoByID.do?timeStamp=" + new Date(),
		data : {
			'nodeId' : nodeId,
			'treeType' : '3'
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//alert(jsonresult);
			
			var ret = jsonresult.split("##");
			if(ret[0]=="error"){
				showexp(ret[1]);
			}else{
				var result= $.parseJSON(ret[1]);
//alert(result);
//alert(result.cnTrsExp+"---"+result.enTrsExp+"---"+result.cnTrsTable+"---"+result.enTrsTable)				
//alert(result.cnTrsTable);
//alert(result.enTrsTable);
				
				$('#expid').val(nodeId);
				$('#expname').val(result.name);
				$('#chrExpression').val(result.cnTrsExp);
				$('#chrFRExpression').val(result.enTrsExp);
				
				$('#CNChannels').val(result.cnTrsTable);//CNChannels
				$('#FRChannels').val(result.enTrsTable);
								
				$('#CNChannelsName').html(result.cnTrsTableName);
				$('#FRChannelsName').html(result.enTrsTableName);
			}

		}
	});
	preEditExpNode();
}

function preAddExpNode(){
//params.parentId = parentid;
//params.parentId = "";
	params.action = "add";
	
	clearExpForm();
	
	$('#expname').attr("disabled",false);
	$('#chrExpression').attr("disabled",false);
	$('#chrFRExpression').attr("disabled",false);
	
	$('#win_cn').attr("disabled",false);
	$('#win_fr').attr("disabled",false);
	
	$('#dobutton').val("增加节点");
	$('#dobutton').attr("disabled",false);
	$('#resetbutton').attr("disabled",false);
}
function preEditExpNode(){
	params.action = "edit";
	
	$('#expname').attr("disabled",false);
	$('#chrExpression').attr("disabled",false);
	$('#chrFRExpression').attr("disabled",false);
	
	$('#win_cn').attr("disabled",false);
	$('#win_fr').attr("disabled",false);
	
	$('#dobutton').val("提交节点");
	$('#dobutton').attr("disabled",false);
	$('#resetbutton').attr("disabled",false);
}

function clearExpForm(){
	$('#expname').val("");
	$('#chrExpression').val("");
	$('#chrFRExpression').val("");
	
	$('#win_cn').attr("disabled",true);
	$('#win_fr').attr("disabled",true);
	
	$('#expname').attr("disabled",true);
	$('#chrExpression').attr("disabled",true);
	$('#chrFRExpression').attr("disabled",true);
	$('#dobutton').attr("disabled",true);
	$('#resetbutton').attr("disabled",true);
	
	$('#CNChannels').val("");
	$('#FRChannels').val("");

	$('#cnresultcount').html("");
	$('#frresultcount').html("");	
}

function doExpNode(){
	var _action = params.action;
//alert(_action);
	if(_action==='add'){
		addExpNode();
	}else if(_action==='edit'){
		editExpNode();
	}
}

function addExpNode(){
//alert(params.parentId);

	var expname = $('#expname').val();
	var chrExpression = $('#chrExpression').val();
	var chrFRExpression = $('#chrFRExpression').val();
	var cnChannels = $('#cnChannels').val();
	var frChannels = $('#frChannels').val();
	
	if($.trim(expname)==''){
		showexp("请输入导航名称");
		return;
	}
/*
	if($.trim(chrExpression)==''){
		showexp("请输入导航中文表达式");
		return;
	}
	if($.trim(chrFRExpression)==''){
		showexp("请输入导航英文表达式");
		return;
	}
*/
	
//	alert("chrExpression="+$.trim(chrExpression));
//	alert("chrFRExpression="+$.trim(chrFRExpression));
	
	if($.trim(chrExpression)===''&&$.trim(chrFRExpression)===''){
		showexp("请输入导航表达式");
		return;
	}
//	params.parentId = parentid;
	$.ajax({
		type : "GET",
		url : "<%=basePath%>addExpNode.do?timeStamp=" + new Date(),
		data : {
//			'nodeId' : nodeId,
//			'treeType' : '3'			
			'name':expname,
			'parentid':params.parentId,
			'intType':'3',
			'chrExpression':chrExpression,
			'chrFRExpression':chrFRExpression,
			'CNChannels':cnChannels,
			'FRChannels':frChannels			
		},
//		data : $("#loginform").serialize(),
		contentType : "application/json;charset=UTF-8",
		success : function(jsonresult) {
//alert(jsonresult);			
			var ret = jsonresult.split("##");
			if(ret[0]=="error"){
//				showexp("节点添加失败");
				showexp(ret[1]);
			}else{
				showexp("节点添加成功");
				showExplist(params.parentId);//params.parentId
			}
		}
	});
}

function editExpNode(){
//alert($('#expid').val());	
		var expid = $('#expid').val();
		var expname = $('#expname').val();
		var chrExpression = $('#chrExpression').val();
		var chrFRExpression = $('#chrFRExpression').val();
		var CNChannels = $('#CNChannels').val();
		var FRChannels = $('#FRChannels').val();
		
		if($.trim(expname)==''){
			showexp("请输入导航名称");
			return;
		}
		/*
		if($.trim(chrExpression)==''){
			showexp("请输入导航中文表达式");
			return;
		}
		if($.trim(chrFRExpression)==''){
			showexp("请输入导航英文表达式");
			return;
		}
		*/
//		if($.trim(chrExpression)==''||$.trim(chrFRExpression)==''){			
		if($.trim(chrExpression)===''&&$.trim(chrFRExpression)===''){
			showexp("请输入导航表达式");
			return;
		}
//		params.parentId = parentid;
		$.ajax({	
			type : "GET",
			url : "<%=basePath%>editExpNode.do?timeStamp=" + new Date(),
			data : {
//				'nodeId' : nodeId,
//				'treeType' : '3'
				'parentid':params.parentId,
				'name':expname,
				'nodeID':expid,
				'intType':'3',
				'chrExpression':chrExpression,
				'chrFRExpression':chrFRExpression,
				'CNChannels':CNChannels,
				'FRChannels':FRChannels
			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
//alert(jsonresult);				
				var ret = jsonresult.split("##");
				if(ret[0]=="error"){
//					showexp("节点编辑失败");
					showexp(ret[1]);
				}else{
					showexp("节点编辑成功");
					showExplist(params.parentId);//params.parentId
				}
			}
		});
//		showExplist(params.parentId);
	}
	
function del_affirm(id,name)
{
	var info="您确认要删除“"+name+"”节点么？";
//var info="您确认要删除此节点么？";
	var con;
	con=confirm(info);
	if(con==true)
	{	
//parent.window.mainFrame.location.href = '<%=basePath%>deleteNode.do?action=deletenode&intType=<%=intType%>&id='+id;
//this.location.href = 'list.jsp?parentid='+id;

		$.ajax({	
			type : "GET",
			url : "<%=basePath%>deleteExpNode.do?timeStamp=" + new Date(),
			data : {
//				'nodeId' : nodeId,
//				'treeType' : '3'
				'nodeId':id
			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
	//alert(jsonresult);
				
				var ret = jsonresult.split("##");
				if(ret[0]=="error"){
					showexp("节点删除失败");
				}else{
					showexp("节点删除成功");
//					showExplist(params.parentId);//params.parentId
				}
			}
		});

	}
	
	showExplist(params.parentId);//params.parentId
}

function showcnwin(){
	$("#txtComb").val($("#chrExpression").val());
}
function showfrwin(){
	$("#frtxtComb").val($("#chrFRExpression").val());
}
</script>









					<table style="width: 100%; margin-bottom: 100px;" border="0"
						align="center" cellpadding="2" cellspacing="2">
						<tr>
							<td valign="top">
								<table style="width: 100%; height: 20px" border="0"
									cellpadding="3" cellspacing="3">
									<tr height="32">
										<td width="440" id="strPath"></td>
										<td width="130"  align="right">
											<div align="right" onClick="javascript:preAddExpNode();">
											<button class="btn btn-small btn-success" type="button">添加节点</button>
											</div>
										</td>
									</tr>
								</table>

								<table style="width: 100%;" border="0" cellpadding="2"
									cellspacing="2" id="table_list"></table>

							</td>
						</tr>
					</table>



<table width="90%" height="240" border="0" align="center">
  <tr>
    <td width="100%" height="253" bordercolor="#0000CC">
<fieldset>
<legend>内容编辑</legend>
<form name="form1" method="post" action="<%=basePath%>addNode.do" onSubmit="return checkform();">
<table width="90%" height="201" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
<input type="hidden" id="parentid" name="parentid">
<input type="hidden" id="action" name="action">
<input type="hidden" id="id" name="id">
<input type="hidden" id="intType" name="intType">
<input type="hidden" id="CNChannels" name="CNChannels">
<input type="hidden" id="FRChannels" name="FRChannels">
<input type="hidden" id="expid" name="expid">

    <td width="69">节点名称</td>
    <td colspan="2"><input id="expname" name="expname" type="text" style="width:360px;height:20px;"></td>
  </tr>
<!--   <tr>
    <td>顺序号</td>
    <td colspan=2><input id="SequenceNum" name="SequenceNum" type="text" style="width:50">
      <span class="style1">管理员可以通过修改“顺序号”来改变导航的显示顺序</span></td>
  </tr> -->
 <tr>
    <td>&nbsp</td>
    <td></td>
  </tr> 

  <tr>
    <td rowspan="2">SIPO专利（中文）</td>
    <td>
    <input type="hidden" id="_cnchannels" name="_cnchannels">
    <span id="_cnchannelnames"></span>
    <textarea id="chrExpression" name="chrExpression" style="width:360px;"  rows="4"></textarea>
	结果数：<span id="cnresultcount"></span>
    <input id="win_cn" data-toggle="modal" onclick="javascript:showcnwin();" data-target="#cnexpModal" class="btn btn-small" type="button" value="编辑表达式">
    
    
    </td>
    <!-- 
    <td width="102" rowspan="2" align="center">
	<input type="button" name="bt_CNFormSearch" value=" 检 索11 " onClick="renderSearchExpression(0)"></td>
	 -->
  </tr>
  <tr>
    <td id="CNChannelsName"></td>
  </tr>
  <tr>
    <td rowspan="2">港澳台及海外（英文）</td>
    <td>
    <input type="hidden" id="frchannels" name="frchannels">
    <span id="frchannelnames"></span>
    <textarea id="chrFRExpression" name="chrFRExpression" style="width:360px;"rows="4"></textarea>
    结果数：<span id="frresultcount"></span>
    <input id="win_fr" data-toggle="modal" onclick="javascript:showfrwin();" data-target="#frexpModal" type="button" class="btn btn-small" value="编辑表达式">
    <!-- 
     <img name="renderFRExpression" src="images/button_foreign.gif" value="生成国外专利导航表达式" onClick="renderExpression(1)" style="cursor:hand">
      -->
     
     </td>
     <!-- 
    <td rowspan="2" align="center">
	<input type="button" name="bt_FRFormSearch" value=" 检 索 " onClick="renderSearchExpression(1)">	</td>
	 -->
  </tr>
  <tr>
    <td id="FRChannelsName"></td>
  </tr>
<!-- <tr>
    <td height="16">备注</td>
    <td colspan="2"><input name="memo" type="text"></td>
  </tr> -->
  <tr>
    <td height="29" colspan="3"><table width="360" border="0" align="center">
        <tr>
          <td width="40%"><div align="right">
            <input class="btn btn-small btn-info"  type="button" id="dobutton" onClick="javascript:doExpNode();" value="提交节点">
          </div></td>
          <td width="40%"><div align="center">
            <input  class="btn btn-small btn-success"  id="resetbutton" type="reset" name="Submit2" value="重  置">
          </div></td>
        </tr>
    </table></td>
    </tr>
 </table>
</form>
</fieldset></td>
  </tr>
</table>





        </div>
      </div>
</div>
</div>
<!--main结束-->

<%@ include file="include-cnexp.jsp"%>
<%@ include file="include-frexp.jsp"%>
<%@ include file="ipcgmjjwindow.jsp"%>


<%@ include file="../../jsp/zljs/include-buttom.jsp"%>

  </body>
</html>
