<%@ page language="java" import="java.util.*,com.trs.usermanage.Hangye" pageEncoding="utf-8" errorPage="error.jsp"%>
<%@ page import="com.cnipr.cniprgz.security.SecurityTools,java.net.URLEncoder" contentType="text/html;"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>

<%
try{
com.opensymphony.xwork2.ActionContext _cxt = com.opensymphony.xwork2.ActionContext.getContext();
Map<String, Object> _application = _cxt.getApplication();

String parentID=request.getParameter("parentid")==null?"0":request.getParameter("parentid");
//out.println(parentID);
/*
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("/admin/login.htm");
}
String strAdminName=(String)session.getAttribute("adminName");
*/

//int intAdminId = Integer.parseInt((String)request.getSession().getAttribute("userid"));

//String name="";
int intSequenceNum=0;
//String Expression="";
//String FRExpression="";
//String memo="";
String CNChannelIds="";
String FRChannelIds="";

String CNChannelTableNames="";
String FRChannelTableNames="";

//Hangye hangye=new Hangye();
String action="noaction";
int id =0;
//int parentid =0;
//String intType = request.getParameter("intType");
	if(intType==null  || intType.equals(""))
		intType = "1";
	
if ((request.getParameter("action") == null|| request.getParameter("action").equals(""))
	&& (request.getParameter("id") == null|| request.getParameter("id").equals("")))	
{

}else	
{	
	id = Integer.parseInt(request.getParameter("id")==null?"0":request.getParameter("id"));
	//parentid = Integer.parseInt(request.getParameter("parentid"));
	action=(String)request.getParameter("action");
	
//	System.out.println("detail.jsp ---> action: "+action);
	if (action.equals("newnode")){
		//输入框中无内容
	}
	else if(action.equals("editnode")){		
		_hangye.getInfo(id,intAdminId);
	
		name = _hangye.getName();
		intSequenceNum = _hangye.getIntSequenceNum();
		Expression = _hangye.getchrExpression();
		FRExpression = _hangye.getchrFRExpression();
		memo = _hangye.getchrMemo();
		CNChannelIds = _hangye.getCNChannels();
		CNChannelTableNames = com.cnipr.cniprgz.commons.Util.getPatentTableName(_application,CNChannelIds);
//		com.cnipr.cniprgz.commons.Util.getPatentTable(_application,CNChannelIds);
		
		FRChannelIds = _hangye.getFRChannels();
		CNChannelTableNames = com.cnipr.cniprgz.commons.Util.getPatentTableName(_application,FRChannelIds);
		//System.out.println("detail.jsp ---> name: "+name);
	}else if(action.equals("renode")){
		//name=request.getParameter("name");
		name = com.trs.was.bbs.RequestParameterOperation.getParameter(request,"name");
		Expression = com.trs.was.bbs.RequestParameterOperation.getParameter(request,"chrExpression");
		FRExpression = com.trs.was.bbs.RequestParameterOperation.getParameter(request,"chrFRExpression");
	}
}

//int intMaxSearchCount=Integer.parseInt(request.getParameter("intMaxSearchCount")==null?"0":request.getParameter("intMaxSearchCount"));
String OtherPatent = com.cnipr.cniprgz.commons.DataAccess.getProperty("OtherPatent");
int openwindowheight = 450;
if(OtherPatent!=null&&OtherPatent.equals("1")){
	openwindowheight = 600;
}
%>


<style> 
.spanstyle    
{  
font: 12pt verdana;  
font-weight:700; 
color:orange; 
} 
.buttonstyle  
{  
font: 8pt verdana; 
background-color:lightgreen; 
border-color:black; 
width:100  
} 
.inputstyle   
{  
font: 14pt verdana; 
background-color:yellow; 
border-style:dashed; 
border-color:red; 
width:300;  
} 
.style1 {
	color: #666666;
	font-size: 12px;
}
</style>
<script language="javascript">
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
function checkform()
{
	var val=document.form1.name.value;
	if(val.replace(/(^\s*)|(\s*$)/g, "")=='')
	{
		alert("显示名称不能为空，请重新输入");
		return false; 
	}
	var SequenceNum=document.form1.SequenceNum.value;
	if(SequenceNum.replace(/(^\s*)|(\s*$)/g, "")=='')
	{
		alert("顺序号不能为空，请重新输入");
		return false; 		
	}
	if(!isInteger(SequenceNum))
	{
		alert("顺序号必须是整数！");
		return false;
	}	
	/*
	val=document.form1.chrExpression.value;
	if(val.replace(/(^\s*)|(\s*$)/g, "")=='')
	{
		alert("国内表达式不能为空，请重新输入");
		return false; 
	}
	val=document.form1.chrFRExpression.value;
	if(val.replace(/(^\s*)|(\s*$)/g, "")=='')
	{
		alert("国外表达式不能为空，请重新输入");
		return false; 
	}
	*/
	
document.form1.CNChannels.value = document.all.cnTRS.innerText;
document.form1.FRChannels.value = document.all.frTRS.innerText;
	
	return true;
}

function buttonStatus(action){
//alert("buttonStatus");
	if(action=='newnode'){
	//alert("new");
		document.getElementById('Submit1').value="增加节点";
		document.getElementById('Submit1').disabled=false;
		document.getElementById('Submit2').disabled=false;
		document.getElementById('name').disabled=false;
		document.getElementById('chrExpression').disabled=false;
		document.getElementById('chrFRExpression').disabled=false;		
		document.getElementById('memo').disabled=false;
		document.getElementById('bt_CNFormSearch').disabled=false;
		document.getElementById('bt_FRFormSearch').disabled=false;
	}
	else if(action=='editnode'){
	//alert("edit");
		document.getElementById('Submit1').value="编辑节点";
		document.getElementById('Submit1').disabled=false;
		document.getElementById('Submit2').disabled=false;
		document.getElementById('name').disabled=false;
		document.getElementById('chrExpression').disabled=false;
		document.getElementById('chrFRExpression').disabled=false;
		document.getElementById('memo').disabled=false;
		document.getElementById('bt_CNFormSearch').disabled=false;
		document.getElementById('bt_FRFormSearch').disabled=false;
	}
	else if(action=='noaction'){
		document.getElementById('Submit1').disabled=true;
		document.getElementById('Submit2').disabled=true;
		document.getElementById('name').disabled=true;
		document.getElementById('chrExpression').disabled=true;
		document.getElementById('chrFRExpression').disabled=true;
		document.getElementById('memo').disabled=true;
		document.getElementById('bt_CNFormSearch').disabled=true;
		document.getElementById('bt_FRFormSearch').disabled=true;
	}
}

function renderSearchExpression(cnfr)
{
	if(cnfr==0){
//		document.searchForm.strChannels.value="<%=SetupAccess.getProperty("navcnchannels") %>";
		document.searchForm.strChannels.value=document.all.cnTRS.innerText;
		document.searchForm.area.value="cn";
		document.searchForm.strWhere.value = document.form1.chrExpression.value;
	}else{
		document.searchForm.strChannels.value=document.all.frTRS.innerText;
		document.searchForm.area.value="fr";
		document.searchForm.strWhere.value = document.form1.chrFRExpression.value;
	}
	
	document.searchForm.submit();
}

function renderExpression(cnfr)
{
  	var theDate =new Date();
	var random=theDate.getTime();
	
	var inargs = new Object();
	
	if(cnfr==0){	
		inargs.Expression = document.form1.chrExpression.value;
		
//		var channels = document.all.cnTRS.innerText;
		var channels = document.getElementById("cnTRS").innerText;
//alert(channels);
		if(channels != ""){
			channels = channels.replace("[","");
			channels = channels.replace("]","");
//			channels = getTRSTableNames(0,channels);
		}
		inargs.Channels = channels;

//		inargs.Expression = '';
//		inargs.Channels = '';
	}else{
		inargs.Expression = document.form1.chrFRExpression.value;
		
//		var channels = document.all.frTRS.innerText;
		var channels = document.getElementById("frTRS").innerText;
//alert(channels);
		if(channels != ""){
			channels = channels.replace("[","");
			channels = channels.replace("]","");
//			channels = getTRSTableNames(1,channels);
		}
//		channels = "<%=SetupAccess.getProperty("fr") %>";

		inargs.Channels = channels;
	}
	var url;
	var strWidth="600";
	if(cnfr==0){
		url="hyjs-biaodan-y-back.jsp";
	}
	if(cnfr==1){
		url="hyjs-biaodan-fr-back.jsp";
		strWidth="680";
	}

	var strHeight = "<%=openwindowheight%>";//450
	
	var returnval = window.showModalDialog("../../jsp/zljs/"+url+"?rd="+random,inargs,"dialogHeight:" + strHeight + "px;dialogWidth:"+strWidth+"px;center:yes;resizable:no;help:no;status:no;scroll:no");
	if(returnval != null)
	{
		var chrExpression = returnval[0];		
		var channels=returnval[1];
		
//alert(chrExpression + "....." + channels);
		
		if(cnfr==0){
//alert(document.all.tdcnTRS.innerText);
			document.form1.CNChannels.value=channels;
			document.all.tdcnTRS.innerText="["+getTRSTableNames(channels)+"]";
			document.all.cnTRS.innerText=channels;
			document.form1.chrExpression.value=chrExpression;
		}else{
//alert(document.all.tdfrTRS.innerText);
			document.form1.FRChannels.value=channels;
			document.all.tdfrTRS.innerText="["+getTRSTableNames(channels)+"]";
			document.all.frTRS.innerText=channels;
			document.form1.chrFRExpression.value=chrExpression;
		}
	}
}

function showTRS(cnchannels,frchannels){
	document.form1.CNChannels.value=cnchannels;
	document.all.cnTRS.innerText=getTRSTableNames(cnchannels);

	document.form1.FRChannels.value=frchannels;
	document.all.frTRS.innerText=getTRSTableNames(frchannels);
}

function getTRSTableNames(tableIDs){
	var strTRSTableIDs="";
	
	var cnChannels = "<%=com.cnipr.cniprgz.commons.Util.getPatentTableIDsByArea(_application,"cn")%>";
	var cnChannelNames = "<%=com.cnipr.cniprgz.commons.Util.getPatentTableName(_application,com.cnipr.cniprgz.commons.Util.getPatentTableIDsByArea(_application,"cn"))%>";
	var frChannels = "<%=com.cnipr.cniprgz.commons.Util.getPatentTableIDsByArea(_application,"fr")%>";
	var frChannelNames = "<%=com.cnipr.cniprgz.commons.Util.getPatentTableName(_application,com.cnipr.cniprgz.commons.Util.getPatentTableIDsByArea(_application,"fr"))%>";
	
//	alert(cnChannels + "---" + frChannels + "---"  + tableIDs);
//	alert(cnChannelNames + "---" + frChannelNames + "---"  + tableIDs);

	Channels = cnChannels + "," + frChannels;
	ChannelNames = cnChannelNames + "," + frChannelNames;
	
	var arrChannel = Channels.split(",");
	var arrChannelName = ChannelNames.split(",");
	
	var arr = new Array();
	if(tableIDs!="" && typeof(tableIDs)!='undefined' )
	{	
		arr = tableIDs.split(",");
		
		for (var i = 0; i < arr.length; i++) {
			for (var j = 0; j < arrChannel.length; j++) {
				if(arr[i]==arrChannel[j]){
//					arr[i]="fmzl";
					strTRSTableIDs += arrChannelName[j]+",";
				}
			}
		}
	}	
	
//	alert(strTRSTableIDs);
	if(strTRSTableIDs!=null && strTRSTableIDs!=""){
		strTRSTableIDs=strTRSTableIDs.substring(0,strTRSTableIDs.length-1);
	}
	return strTRSTableIDs;
}
</script>






		
<body topmargin="0" onLoad="buttonStatus('<%=action%>');showTRS('<%=CNChannelIds%>','<%=FRChannelIds%>')" >
  <FORM name="searchForm" method="post" action="<%=basePath%>overviewSearch.do" target="_blank"> 
   	<input type="hidden" name="appType" value="0" /> 
	<input type="hidden" name="method" value="overviewSearch"/>                     
	<input type="hidden" name="area" />
	<input type="hidden" name="iOption" value="2" />
	<input type="hidden" name="index" value="0" />                         
	<input type="hidden" name="strSortMethod" value="RELEVANCE" />                 
	<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要" />
	<input type="hidden" name="strStat" value="" />                           
	<input type="hidden" name="iHitPointType" value="115" />                     
	<input type="hidden" name="bContinue" id="bContinue" value="" />    
	<input type="hidden" name="strChannels"/>
	<input type="hidden" name="appNum" id="appNum"  value="" />
	<input type="hidden" name="simFlag" id="simFlag"  value="" />
	<input type="hidden" name="apdRange" id="apdRange"  value="" />
	<input type="hidden" name="navID" id="navID"  value="0" />
	<input type="hidden" name="dateLimit" id="dateLimit" value="" />
	<input type="hidden" name="strWhere" id="strWhere"  />
  </FORM>
  
<table width="90%" height="240" border="0" align="center">
  <tr>
    <td width="100%" height="253" bordercolor="#0000CC">
<fieldset>
<legend>内容编辑</legend>
<form name="form1" method="post" action="<%=basePath%>addNode.do" onSubmit="return checkform();">
<table width="90%" height="201" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
<input type="hidden" name="parentid" value="<%=parentID%>">
<input type="hidden" name="action" value="<%=action%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="intMaxSearchCount" value="<%=intMaxSearchCount%>">
<input type="hidden" name="intType" value="<%=intType%>">
<input type="hidden" name="CNChannels">
<input type="hidden" name="FRChannels">
    <td width="69">显示名称</td>
    <td colspan="2"><input name="name" type="text" value="<%=name%>" style="width:280">
	</td>
  </tr>
  <tr>
    <td>顺序号</td>
    <td colspan=2><input name="SequenceNum" type="text" value="<%=intSequenceNum%>" style="width:50">
      <span class="style1">管理员可以通过修改“顺序号”来改变导航的显示顺序</span></td>
  </tr>

  <tr>
    <td height="68" rowspan="2">国内表达式</td>
    <td width="412"><textarea name="chrExpression" cols="55" rows="4"><%=Expression%></textarea>
    <img name="renderCNExpression" src="../../images/button_china.gif" value="生成中国专利导航表达式" onClick="renderExpression(0)" style="cursor:hand">
    </td>
    
    <td width="102" rowspan="2" align="center">
	<input type="button" name="bt_CNFormSearch" value=" 检 索 " onClick="renderSearchExpression(0)"></td>	
  </tr>
  <tr>
    <td id="tdcnTRS"><%=com.cnipr.cniprgz.commons.Util.getPatentTableName(_application,CNChannelIds)%></td>
    <span id="cnTRS" style="display:none"><%=CNChannelIds%></span>
  </tr>
  <tr>
    <td height="68" rowspan="2">国外表达式</td>
    <td><textarea name="chrFRExpression" cols="55" rows="4"><%=FRExpression%></textarea>
     <img name="renderFRExpression" src="../../images/button_foreign.gif" value="生成国外专利导航表达式" onClick="renderExpression(1)" style="cursor:hand">
     </td>
     
    <td rowspan="2" align="center">
	<input type="button" name="bt_FRFormSearch" value=" 检 索 " onClick="renderSearchExpression(1)">	</td>
	
  </tr>
  <tr>
    <td id="tdfrTRS"><%=com.cnipr.cniprgz.commons.Util.getPatentTableName(_application,FRChannelIds)%></td>
    <span id="frTRS" style="display:none"><%=FRChannelIds%></span>
  </tr>
  <tr>
    <td height="16">备注</td>
    <td colspan="2"><input name="memo" type="text" value="<%=memo%>"></td>
  </tr>
  <tr>
    <td height="29" colspan="3"><table width="299" border="0" align="center">
        <tr>
          <td width="50%"><div align="center">
            <input type="submit" name="Submit1" value="编辑节点">
          </div></td>
          <td width="50%"><div align="center">
            <input type="reset" name="Submit2" value="重  置">
          </div></td>
        </tr>
    </table></td>
    </tr>
 </table>
</form>
</fieldset></td>
  </tr>
</table>
  </body>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>