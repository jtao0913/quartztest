<%@ page contentType="text/html; charset=GBK" errorPage="/error.jsp"%>
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
String searchWord="";;//检索关键字
//searchWord=request.getParameter("searchWord")==null?"":com.trs.was.bbs.RequestParameterOperation.getParameter(request,"searchWord");
//System.out.print("searchWord="+searchWord);
	int ipCount;
	int[] ipIDs;
		
	int    intPages=0;		//定义总页数
	int    countPerPage=15;		//每页显示行数
	String strCurrentPage=request.getParameter("pageIndex");	//当前页（用于输出）
	int    intCurrentPage=0;	//当前页（用于计算）

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


IPManage ipmanage=new IPManage();

String sID = request.getParameter("ipID")==null?"0":request.getParameter("ipID");
String action = request.getParameter("action");
String beginIP = request.getParameter("beginIP")==null?"":com.trs.was.bbs.RequestParameterOperation.getParameter(request,"beginIP");
String endIP = request.getParameter("endIP")==null?"":com.trs.was.bbs.RequestParameterOperation.getParameter(request,"endIP");

if(action!=null && action.equals("new"))
{
//System.out.println("beginIP = "+beginIP);
//System.out.println("endIP = "+endIP);

	int intRet=ipmanage.addIP(beginIP,endIP);
	if(intRet==1){
%>
<script>
alert("增加IP成功");
</script>
<%
	}
	if(intRet==-1){
%>
<script>
alert("增加IP失败");
</script>
<%
	}
}

if(action!=null && action.equals("edit"))
{
	int intRet=ipmanage.editIP(Integer.parseInt(sID),beginIP,endIP);
	if(intRet==1){
%>
<script>
alert("修改IP成功");
</script>
<%
	}

	if(intRet==-1){
%>
<script>
alert("修改IP失败");
</script>
<%
	}
}

if(action!=null && action.equals("del"))
{
	int intRet=ipmanage.delIP(sID);
	if(intRet==1){
%>
<script>
alert("删除IP成功");
</script>
<%
	}
	if(intRet==-1){
%>
<script>
alert("删除IP失败");
</script>
<%
	}
}
//searchWord=new String(searchWord.getBytes("8859_1"),"GBK");
	String[][] arrIPInfo = ipmanage.getIPInfo(countPerPage, intCurrentPage);
	ipCount=ipmanage.getRows();
//out.println(areaCount);
	
intPages=0;
intPages=ipCount/countPerPage;
//out.println(areaCount%countPerPage);
if(ipCount%countPerPage>0){
	intPages=intPages+1;
}
if(intPages<1){intPages=1;}
%>
<html>
<head>
<title>检索服务平台后台管理</title> 
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
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
			alert("请选中要删除的IP！");
			return false;
		}
	}
	else
	{
			if(document.all.form2.sel.checked==false)
			{
				alert("请选中要删除的IP！");
				return false;
			}
	}
	
	if (confirm("你确信要删除你选中的IP吗?"))
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
	form.pageIndex.value=form.page1.value;
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
function doIP(action,para1,para2,para3)
{
  	var theDate =new Date();
	var random=theDate.getTime();

	var strHeight = "210px";
	if(g_fIsSP2)
		strHeight = "180px";
		
	var inargs = new Array("PRINT");
	
	var obj = ipform;
//var returnval = window.showModalDialog("newParameter.jsp?action="+action+"&para1="+para1+"&para2="+para2+"&rd="+random,inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
//var ReturnValue = window.showModalDialog("newParameter.jsp?action="+action+"&rd="+random,inargs,"dialogHeight:" + strHeight + "px;dialogWidth:320px;center:yes;resizable:no;help:no;status:no;scroll:no");
	ReturnValue=window.showModalDialog("newip.jsp?action="+action+"&para1="+para1+"&para2="+para2+"&para3="+para3+"&rd="+random,obj,"dialogWidth=380px;dialogHeight="+strHeight+";status=no;scroll:no"); 
//alert(ReturnValue);
//alert("资源窗口="+document.resourceform.ResourceName.value);
	if(action=="new" && document.ipform.beginIP.value!="" && document.ipform.endIP.value!=""){
		document.ipform.action.value = "new";		
		document.ipform.submit();
	}
	if(action=="edit" && document.ipform.beginIP.value!="" && document.ipform.endIP.value!=""){
	//alert(document.resourceform.ResourceName.value);
		document.ipform.ipID.value = para1;
		document.ipform.action.value = "edit";
		document.ipform.submit();
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
	
	document.ipform.ipID.value = delIDs;
	document.ipform.action.value = "del";
	document.ipform.submit();

}
-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="ipform" method="post" action="iplist.jsp">
<input type="hidden" name="action">
<input type="hidden" name="ipID">
<input type="hidden" name="beginIP">
<input type="hidden" name="endIP">
</form>
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0">
  <tr>
<td align="center" valign="top"><img src="../../images/snipgl.gif" width="288" height="22"></td>
  </tr>
</table>
<table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" background="../../../images/bg_list.gif">
  <tr>
    <td valign="top">
      <table width="100%" height="52" border="0" cellpadding="0" cellspacing="0" class="listbg" background="../../../images/tlbg_list.gif">
        <tr> 
          <td height="28">
		  <!--
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
                  <form name="form1" method="post" action="iplist.jsp">
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
			-->
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
		      		    <td width="54" height="18"><%if(intCurrentPage!=1) {%><a href="iplist.jsp?pageIndex=1&searchWord=<%=searchWord%>">首  页</a><%} else{%><span class="style1">首  页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=1) {%><a href="iplist.jsp?pageIndex=<%=intCurrentPage-1%>&searchWord=<%=searchWord%>">上一页</a><%} else{%><span class="style1">上一页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=intPages) {%><a href="iplist.jsp?pageIndex=<%=intCurrentPage+1%>&searchWord=<%=searchWord%>">下一页</a><%} else{%><span class="style1">下一页</span><%}%></td>
		                <td width="55"><%if(intCurrentPage!=intPages) {%><a href="iplist.jsp?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>">尾 页</a><%} else{%><span class="style1">尾 页</span><%}%></td>
		      		  </tr>
		      		</table>
                </td>
                <td width="105" > 
                  <table width="105" height="20" border="0" cellpadding="0" cellspacing="0" class="12h">
                    <form name="formpage" method="post" action="iplist.jsp" onSubmit="javaScript:return checkpageform(this);">
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
		  <img src="../../../images/xjip.gif" width="118" height="32" border="0" onClick="doIP('new','','')">
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
(第 <%=strCurrentPage%> 页&nbsp; 共 <%=intPages%> 页 <%=ipCount%> 个)
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
	  <form name="form2" method="post">        
	    <tr bgcolor="#4787b8"> 
	      <td width="6%" align="center"><font color="#FFFFFF"><b>选 中</b></font></td>
	      <td width="10%" align="center" ><font color="#FFFFFF"><b>序 号</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>起始</b></font></td>
	      <td width="15%" align="center" ><font color="#FFFFFF"><b>终止</b></font></td>
	    </tr>
	    <%
			//int intCurrentPage=Integer.parseInt(strCurrentPage);
		int i = 0;
	    for(String[] IPInfo:arrIPInfo)
	    {
	    %>
       <tr>
	      <td width="6%" align="center"><input type="checkbox" name="sel" value="<%=IPInfo[0]%>"></td>
	      <td width="10%" align="center"><%=(intCurrentPage-1)*15+i+1%></td>
	      <td width="15%" align="center"><span onClick="doIP('edit','<%=IPInfo[0]%>','<%=IPInfo[1]%>','<%=IPInfo[2]%>')" style="cursor:hand;"><font color="#3300CC"><%=IPInfo[1]%></font></span></td>
	      <td width="15%" align="center"><%=IPInfo[2]%>&nbsp;</td>
	    </tr>
	    <%
			i++;
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
		      		    <td width="54" height="18"><%if(intCurrentPage!=1) {%><a href="iplist.jsp?pageIndex=1&searchWord=<%=searchWord%>">首  页</a><%} else{%><span class="style1">首  页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=1) {%><a href="iplist.jsp?pageIndex=<%=intCurrentPage-1%>&searchWord=<%=searchWord%>">上一页</a><%} else{%><span class="style1">上一页</span><%}%></td>
		                <td width="54"><%if(intCurrentPage!=intPages) {%><a href="iplist.jsp?pageIndex=<%=intCurrentPage+1%>&searchWord=<%=searchWord%>">下一页</a><%} else{%><span class="style1">下一页</span><%}%></td>
		                <td width="55"><%if(intCurrentPage!=intPages) {%><a href="iplist.jsp?pageIndex=<%=intPages%>&searchWord=<%=searchWord%>">尾 页</a><%} else{%><span class="style1">尾 页</span><%}%></td>
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
}catch(Exception ex){
	ex.printStackTrace();
}
%>