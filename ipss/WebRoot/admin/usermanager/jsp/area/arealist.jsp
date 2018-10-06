<%@ page contentType="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@ page import="com.trs.usermanage.*"%>
<style type="text/css">
<!--
.gray {color: #999999}
.style1 {color: #666666}
-->
</style>
<%

String strAdminName= (String)request.getSession().getAttribute("username");

int intUserID = Integer.parseInt((String)request.getSession().getAttribute("userid"));

int adminID=intUserID;
%>
<%
//**********************取得管理员ID，把属于此id的用户显示出来*****************************
//声明变量
try{
	String searchWord;//检索关键字
	searchWord=request.getParameter("searchWord")==null?"":request.getParameter("searchWord");
//System.out.print("searchWord="+searchWord);
	int areaCount;
	int[] areaIDs;
	String[] areaNames;
	String[] areaMemos;
		
	int    intPages=0;		//定义总页数
	int    countPerPage=15;		//每页显示行数
	String strCurrentPage=request.getParameter("pageIndex");	//当前页（用于输出）
	int    intCurrentPage=0;	//当前页（用于计算）

AreaManage areamanage=new AreaManage();

String sID = request.getParameter("areaID")==null?"0":request.getParameter("areaID");
String action = request.getParameter("action");
String areaName = request.getParameter("areaName")==null?"":request.getParameter("areaName");
String areaMemo = request.getParameter("areaMemo")==null?"":request.getParameter("areaMemo");

if(action!=null && action.equals("new"))
{
	int intRet=areamanage.addArea(areaName,areaMemo);
	if(intRet==1){
%>
<script>
alert("新建地区成功");
</script>
<%
	}
	if(intRet==-2){
%>
<script>
alert("地区名重复");
</script>
<%
	}
	if(intRet==-1){
%>
<script>
alert("新建地区失败");
</script>
<%
	}
}

if(action!=null && action.equals("edit"))
{
	int intRet=areamanage.editArea(Integer.parseInt(sID),areaName,areaMemo);
	if(intRet==1){
%>
<script>
alert("修改地区成功");
</script>
<%
	}
	if(intRet==-2){
%>
<script>
alert("地区名重复");
</script>
<%
	}
	if(intRet==-1){
%>
<script>
alert("修改地区失败");
</script>
<%
	}
}

if(action!=null && action.equals("del"))
{
	int intRet=areamanage.delArea(sID);
	if(intRet==1){
%>
<script>
alert("删除地区成功");
</script>
<%
	}
	if(intRet==-1){
%>
<script>
alert("删除地区失败");
</script>
<%
	}
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	if(strCurrentPage==null||strCurrentPage.equals("")) 
	{
	  strCurrentPage="1";
	  intCurrentPage=1;
	} 
	else
	{
	  intCurrentPage=Integer.parseInt(strCurrentPage);
	}	

	  //searchWord=new String(searchWord.getBytes("8859_1"),"GBK");
	  
	  areamanage.setMulti(searchWord,countPerPage,intCurrentPage);
	  
	areaCount=areamanage.getRows();
//out.println(areaCount);
	areaIDs=areamanage.getAreaIDs();
	areaNames=areamanage.getAreaNames();
	areaMemos=areamanage.getAreaMemos();
	
intPages=0;
intPages=areaCount/countPerPage;
//out.println(areaCount%countPerPage);
if(areaCount%countPerPage>0){
	intPages=intPages+1;
}
if(intPages<1){intPages=1;}
%>
<html>
<head>
<title>检索服务平台后台管理</title> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../../../css/style.css" type="text/css">
<link rel="stylesheet" href="../../../css/cds_style.css" type="text/css">
<link href="../../../css/dataUpdate.css" rel="stylesheet" type="text/css" ></link>
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
			if(document.all.form2.sel[i].checked==true)
			{
				v++;
			}
		}
		if(v==0)
		{
			alert("请选中要删除的用户！");
			return false;
		}
	}
	else
	{
			if(document.all.form2.sel.checked==false)
			{
				alert("请选中要删除的用户！");
				return false;
			}
	}
	
	if (confirm("你确信要删除你选中的用户吗?"))
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
var g_fIsSP2 = false;
function browserVersion()
{
   g_fIsSP2 = (window.navigator.userAgent.indexOf("SV1") != -1);
/*
   if (g_fIsSP2)
   {
   //This browser is Internet Explorer in SP2. 
   }
   else
   {
   //This browser is not Internet Explorer in SP2.
   }
*/
}
function doArea(action,para1,para2,para3)
{
  	var theDate =new Date();
	var random=theDate.getTime();

	var strHeight = "210px";
	if(g_fIsSP2)
		strHeight = "180px";
		
	var inargs = new Array("PRINT");
	
	var obj = areaform;
//var returnval = window.showModalDialog("newParameter.jsp?action="+action+"&para1="+para1+"&para2="+para2+"&rd="+random,inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
//var ReturnValue = window.showModalDialog("newParameter.jsp?action="+action+"&rd="+random,inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
	ReturnValue=window.showModalDialog("newArea.jsp?action="+action+"&para1="+para1+"&para2="+para2+"&para3="+para3+"&rd="+random,obj,"dialogWidth=380px;dialogHeight="+strHeight+";status=no;scroll:no"); 
//alert(ReturnValue);
//alert("资源窗口="+document.resourceform.ResourceName.value);
	if(action=="new" && document.areaform.areaName.value!=""){
		document.areaform.action.value = "new";		
		document.areaform.submit();
	}
	if(action=="edit" && document.areaform.areaName.value!=""){
	//alert(document.resourceform.ResourceName.value);
		document.areaform.areaID.value = para1;
		document.areaform.action.value = "edit";
		document.areaform.submit();
	}
}

function delSel(){
	var delIDs="";
	sure();
	var objs = document.getElementsByName("sel");
	for(var i=0;i<objs.length;i++){
		//objs[i].parentNode.removeChild(objs[i]);
		if(objs[i].checked){
			//alert(objs[i].value);
			delIDs+=objs[i].value+",";
		}
	}
	//alert(delIDs);
	
	document.areaform.areaID.value = delIDs;
	document.areaform.action.value = "del";
	document.areaform.submit();

}
-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="areaform" method="post" action="arealist.jsp">
<input type="hidden" name="action">
<input type="hidden" name="areaID">
<input type="hidden" name="areaName">
<input type="hidden" name="areaMemo">
</form>
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
<td align="center" valign="top"><img src="../../images/snqygl.gif" width="288" height="22"></td>
  </tr>
</table>
<table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" background="../../../images/bg_list.gif">
  <tr>
    <td valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="listbg" background="../../../images/tlbg_list.gif">
        <tr> 
          <td height="28">
          	<table width="100%" height="4" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          		<tr>
          			<td height="4"></td>
          		</tr>
          	</table>
            <table width="100%" height="28" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="7%" align="left" valign="top"><img src="../../../images/tl_list.gif" width="20" height="28"></td>
                <td width="93%"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <form name="form1" method="post" action="arealist.jsp">
                  <tr>
			          <td colspan="4" align="center"> 
               
                      <input type="text" name="searchWord" size="15" value="">
				  </td>
	                  <td width="30%"> 
	                    <div align="left"><a href="a" onclick="javascript:event.returnValue=false;submit();"><img src="../../../images/search_list.gif" border="0" width="54" height="18" style="cursor:hand;"></a></div>
	                  </td>
	               </tr>
                   </form>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="24" valign="top">
            <table width="361" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr align="left">
              	<td width="20">&nbsp;</td>
              	<td width="236" height="18">
              		<table width="217" cellspacing="0" border="0" cellpadding="0">
		      		  <tr>
		      		    <td width="54" height="18"><%if(intCurrentPage!=1) {%><a href="arealist.jsp?pageIndex=1&searchWord=<%=searchWord%>">首  页</a><%} else{%><span class="style1">首  页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=1) {%><a href="arealist.jsp?pageIndex=<%=intCurrentPage-1%>&searchWord=<%=searchWord%>">上一页</a><%} else{%><span class="style1">上一页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=intPages) {%><a href="arealist.jsp?pageIndex=<%=intCurrentPage+1%>&searchWord=<%=searchWord%>">下一页</a><%} else{%><span class="style1">下一页</span><%}%></td>
		                <td width="55"><%if(intCurrentPage!=intPages) {%><a href="arealist.jsp?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>">尾 页</a><%} else{%><span class="style1">尾 页</span><%}%></td>
		      		  </tr>
		      		</table>
                </td>
                <td width="105" > 
                  <table width="105" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
                    <form name="formpage" method="post" action="arealist.jsp" onSubmit="javaScript:return checkpageform(this);">
                      <tr> 
                        <td width="15"> 到 </td>
                        <td width="45" align="left" valign="top"><input name="page1" type="text" class="10int" size="4"></td>
                        <td width="15"> 页 </td>
						<td width="30"><input name="imageField2" type="image" src="../../../images/go_list.gif" width="19" height="11" border="0" style="cursor:hand();"></td>
                      </tr>
					  <input type="hidden" name="searchWord" value="<%=searchWord%>">
					  <input type="hidden" name="pageIndex" value="">
                    </form>
                   </table>
                </td>          
			  </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="12h">
        <tr> 
          <td width="96%" height="32" align="right">
		  <!--a href="a" onClick="doArea('new','','');"><img src="../../../images/xjyh.gif" border="0"></a-->
		  <input type="button" name="new" value="新建地区" onClick="doArea('new','','')">
		  <!--a href="a" onClick="javaScript:event.returnValue=false;window.open('../../../help/usermanager_jsp_user_userlist.htm','','width=800,height=600,scrollbars=yes');"><img src="../../../images/help_list.gif" height="32" border="0"></a></td-->
          <td width="4%" height="32">&nbsp;</td>
        </tr>
        <tr> 
          <td height="20" align="right" valign="top">
            <table width="220" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
              <tr>       
                <td align="right" valign="top">
                  <table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td ></td>
                    </tr>
                  </table>
(第 <%=strCurrentPage%> 页&nbsp; 共 <%=intPages%> 页 <%=areaCount%> 个)
                </td>
              </tr>
            </table>
          </td>
          <td height="20">&nbsp;</td>
        </tr>
      </table>
    </td>    
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top">
      <table cellspacing=0 bordercolordark=#ffffff width="100%" bordercolorlight=#4787b8 border=1>
	  <form name="form2" method="post" action="deleteuser.jsp">        
	    <tr bgcolor="#4787b8"> 
	      <td width="6%" align="center"><font color="#FFFFFF"><b>选 中</b></font></td>
	      <td width="10%" align="center" ><font color="#FFFFFF"><b>序 号</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>地区</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>备注</b></font></td>
	    </tr>
	    <%
			//int intCurrentPage=Integer.parseInt(strCurrentPage);

	    for(int i=0;i<areaIDs.length;i++)
	    {
	    %>
       <tr>
	      <td width="6%" align="center"><input type="checkbox" name="sel" value="<%=areaIDs[i]%>"></td>
	      <td width="10%" align="center"><%=(intCurrentPage-1)*15+i+1%></td>
	      <td width="15%" align="center"><span onClick="doArea('edit','<%=areaIDs[i]%>','<%=areaNames[i]%>','<%=areaMemos[i]%>')" style="cursor:hand;"><font color="#3300CC"><%=areaNames[i]%></font></span></td>
	      <td width="15%" align="center"><%=areaMemos[i]%>&nbsp;</td>
	    </tr>
	    <%
	    }
	    %>
	    </form> 
	  </table>
    </td>
  </tr>
</table>
<table width="100%" height="20" border="0" cellpadding="0" cellspacing="0" bgcolor="#BDD6F4">
<form name="form4">
  <tr> 
    <td width="58%">
      <table width="361" height="20" border="0" cellpadding="0" cellspacing="0">
        <tr align="left"> 
          <td width="20">&nbsp;</td>
          <td width="236">
                    <table width="217" cellspacing="0" border="0" cellpadding="0">
		      		  <tr>
		      		    <td width="54" height="18"><%if(intCurrentPage!=1) {%><a href="arealist.jsp?pageIndex=1&searchWord=<%=searchWord%>">首  页</a><%} else{%><span class="style1">首  页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=1) {%><a href="arealist.jsp?pageIndex=<%=intCurrentPage-1%>&searchWord=<%=searchWord%>">上一页</a><%} else{%><span class="style1">上一页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=intPages) {%><a href="arealist.jsp?pageIndex=<%=intCurrentPage+1%>&searchWord=<%=searchWord%>">下一页</a><%} else{%><span class="style1">下一页</span><%}%></td>
		                <td width="55"><%if(intCurrentPage!=intPages) {%><a href="arealist.jsp?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>">尾 页</a><%} else{%><span class="style1">尾 页</span><%}%></td>
		      		  </tr>
		      		</table>
          </td>
        </tr>
      </table>
    </td>
    <td width="42%" align="right" nowrap>
       	<input id="allsel" type="checkbox" name="selall" value="checkbox" onclick="allselect()"><label for="allsel" style="cursor:hand">全选</label>
        <a onclick="delSel()" style="cursor:hand;"><img src="../../../images/delete_blue.gif" border="0"></a>
    </td>
  </tr>
  <tr bgcolor="#5F97DB">
    <td height="1" colspan="2"></td>
  </tr>
</form>  
</table>
</center>
</body>
</html>
<%
}catch(Exception exp){
	exp.printStackTrace();
}
%>