<%@ page contentType="text/html; charset=GBK" errorPage="/error.jsp"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.DataAccess"%>
<style type="text/css">
<!--
.a {font-size: 9pt;}
td{font-size: 9pt}
.obj_table{
margin-bottom:8px;
border:"3";
}
body {
	margin-left: 2px;
	margin-top: 2px;
}
-->
</style>
<%
String strAN="";
String strChannelIDs="";
String tifPath="";
String ThumbnailImagePath="";
String tifPages="";
String destThumbNailImage="";

try{
strAN=request.getParameter("an");
strChannelIDs=request.getParameter("channel");
tifPath=request.getParameter("url");
ThumbnailImagePath=request.getParameter("url");
tifPages=request.getParameter("tifpages");

//String strTRSTable=com.trs.Tools.getChannelName(strChannelIDs);
tifPath = tifPath.replace("\\","\\/");

if(ThumbnailImagePath!=null){
	try {
		 
			 
		ThumbnailImagePath = ThumbnailImagePath.replace(DataAccess.getProperty("PicServerURL"),"") ;
		
		 
		String SLPicServerURL = "http://search.cnipr.com:8080";
		
		  if(DataAccess.getProperty("SLPicServerURL")!=null && DataAccess.getProperty("SLPicServerURL").equals("")==false) 
			  SLPicServerURL = DataAccess.getProperty("SLPicServerURL") ; 
		ThumbnailImagePath = SLPicServerURL + ThumbnailImagePath; 
		 
	} catch (Exception e) {
		e.printStackTrace();
		ThumbnailImagePath = "";
	}
	
	ThumbnailImagePath=ThumbnailImagePath.toLowerCase().replace("books","ThumbnailImage");
	ThumbnailImagePath=ThumbnailImagePath.replace("\\","/");
	ThumbnailImagePath=ThumbnailImagePath.replace("/000001.tif","");
	//tifPath=tifPath.replace("//","/");
}else{
	return;
}
//out.println(tifPages);

int intTIFs=Integer.parseInt(tifPages);

//System.out.println("intTIFs="+intTIFs);
//intTIFs=intTIFs-1;
int int_num_perpage=5;
int intPages=intTIFs/int_num_perpage;
if(intPages<1){intPages=1;}
else if((intTIFs%int_num_perpage)==0){intPages=intPages;}
else if((intTIFs%int_num_perpage)>0){intPages=intPages+1;}

int intCurrentPage=1;
if(request.getParameter("pageIndex")!=null)
{
	intCurrentPage=Integer.parseInt(request.getParameter("pageIndex"));
}

//out.println("共n页....>"+intPages+"<br>");
//out.println("当前页....>"+intCurrentPage+"<br>");
int intCurrentPageFirst=(intCurrentPage-1)*5+1;
//out.println("当前页开始图....>"+intCurrentPageFirst+"<br>");

int intCurrentPageTIFs=intCurrentPageFirst+4;
if(intCurrentPage==intPages){
	intCurrentPageTIFs=intTIFs;
}

destThumbNailImage=request.getParameter("destThumbNailImage");
if(destThumbNailImage==null || destThumbNailImage.equals("")){
	destThumbNailImage=intCurrentPageFirst+"";
}
//out.println(destThumbNailImage+"<br>");
%>
<style type="text/css">
<!--
body {
	margin-left: 2px;
	margin-top: 2px;
}
-->
</style>
<body onLoad="javascript:HighlightDestTable()" style="overflow-x:hidden;display:none;">
<a name="top"></a>
<form name="TurnPage" method="post">
<input name="an" value="<%=strAN%>" type="hidden">
<input name="channelIDs" value="<%=strChannelIDs%>" type="hidden">
<input name="url" value="<%=tifPath%>" type="hidden">
<input name="tifpages" value="<%=tifPages%>" type="hidden">
<input name="pageIndex" value="<%=intCurrentPage%>" type="hidden">
<input name="destThumbNailImage" type="hidden">
</form>

<%
if(intTIFs>0){
	for(int i=intCurrentPageFirst;i<=intCurrentPageTIFs;i++){
		String strfix="";
		if(i<10){
			strfix="00000"+i;
		}else if(i>9 && i<100){
			strfix="0000"+i;
		}else if(i>99 && i<1000){
			strfix="000"+i;
		}else if(i>1000){
			strfix="00"+i;
		}
%>
<a name="a<%=i%>"></a>

<table id="table<%=i%>" border="1" cellspacing="0" cellpadding="0" bordercolor="#000000" align="center">
<tr>
<td>
<a onClick="javascript:highlightTable(document,'<%=i%>');javascript:MoveTo(document,'<%=i%>')" style="cursor:hand">
<img src="<%=ThumbnailImagePath%>/<%=strfix%>.gif" border="0" width="85" height="120"></a>
</td>
</tr>
</table>

<table height="33" align="center">
<tr><td><font size="2">[<%=i%>]</font></td></tr></table>
<%}}%>

<%if(intTIFs>5){%>
<table align="center">
<tr><td align="center" nowrap>
[<%if(intCurrentPage!=1) {%><a onClick="javascript:turnpage(document,'<%=intCurrentPage-1%>',0);" style="cursor:hand;text-decoration:underline;color:0000FF">上 翻</a><%} else{%>上 翻<%}%>]
[<%if(intCurrentPage!=intPages) {%><a onClick="javascript:turnpage(document,'<%=intCurrentPage+1%>',0);" style="cursor:hand;text-decoration:underline;color:0000FF">下 翻</a><%} else{%>下 翻<%}%>]
</td></tr>
</table>
<%}%>

</body>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>
<script>
function turnpage(documentObj,pageno,i_right){
	documentObj.TurnPage.pageIndex.value=pageno;
	documentObj.TurnPage.submit();
	
	if(i_right==1 || i_right=="1"){
	//从head.htm传过来的翻页的请求,
	//由于传过来的documentObj是window.parent.mainFrame.leftFrame.document 
	//我不想再传一个window.parent.mainFrame.leftFrame或是
	//把documentObj中替换掉“.document”
		window.parent.mainFrame.leftFrame.location="#a"+pageno;
		//window.parent.mainFrame.leftFrame.location="#top";
	}
	
	if(i_right==0 || i_right=="0"){//PatentBody_Left.jsp[上5页]，[下5页]
	/*
		if(pageno==null || pageno==""){
			pageno="1";
		}
		
//alert((pageno-1)*5+1);
		var TifNo=(pageno-1)*5+1;
		//左侧导航翻页，右侧内容不改变
		window.parent.parent.topFrame.document.all.txtCurrentPage.value=TifNo;
		window.parent.parent.topFrame.document.all.lbCurrentPage.innerText = TifNo;
		window.parent.parent.topFrame.CheckButtonStatus();
	*/
	}
}

function HighlightDestTable(){
	var currentPage = window.parent.parent.topFrame.document.all.txtCurrentPage.value;

	var destThumbNailImage='<%=destThumbNailImage%>';
//alert("destThumbNailImage="+destThumbNailImage);
	if(destThumbNailImage!=null && destThumbNailImage!='null' && destThumbNailImage!='' && currentPage==destThumbNailImage){
		var obj=document.getElementById("table"+destThumbNailImage);
		obj.bordercolor="#666666"
		obj.cellspacing="8";
		obj.border="4";
		//window.location="#a"+destThumbNailImage;
		window.location="#top";
	}
}
function highlightTable(documentObj,tifno){

	var eles=documentObj.getElementsByTagName("table");   
	for(var i=0;i<eles.length;i++)   
	{
		if((eles[i].id).indexOf("table")==0)
		{
			eles[i].border="1";
		}
	}
	//alert("table"+id);
	var obj=documentObj.getElementById("table"+tifno);
	//var obj=document.getElementById("table00");
	//obj.cellspacing="3";
	//obj.style.width="500";
	obj.bordercolor="#666666"
	obj.cellspacing="8";
	obj.border="4";
}
function MoveTo(documentObj,pageno)
{
	if(window.parent.parent.topFrame.document.all.txtCurrentPage.value==pageno){
		return;
	}
	if(pageno==null || pageno==""){
		pageno="1";
	}
//alert(pageno);
	var tmpUrl = CreateUrl(pageno);
//alert(tmpUrl);
	window.status="正在接收数据...";
	SetReadUrl(tmpUrl, '<%=strAN%>');
	window.parent.rightFrame.document.body.scrollTop=0;
	window.parent.parent.topFrame.document.all.txtCurrentPage.value=pageno;
	window.parent.parent.topFrame.document.all.lbCurrentPage.innerText = pageno;
	window.parent.parent.topFrame.CheckButtonStatus();
/**************************************************************************************************/
}
function CreateUrl(str)
{
//	var sUrl = document.PatentInfo.strUrl.value;
	var sUrl = '<%=tifPath%>';
	var sPage = str;
//alert(sUrl);	
	sUrl = sUrl.substring(0,sUrl.lastIndexOf('/')+1);

	for(var i=0;i<(6-sPage.length);i++)
	{
		sUrl = sUrl + "0";
	}
	sUrl = sUrl + str + ".tif";
//	document.PatentInfo.strUrl.value = sUrl;
	return sUrl;
}
function SetReadUrl(strUrl, strAPO)
{
	window.parent.rightFrame.document.all.PatTifAcTiveX1.SetNetTifPath(strUrl,'aaaaa', strAPO);
	window.parent.rightFrame.document.body.scrollTop=0;
}
</script>