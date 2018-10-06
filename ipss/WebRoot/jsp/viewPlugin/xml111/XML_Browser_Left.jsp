<%@ page contentType="text/html; charset=GBK" errorPage="/error.jsp"%>
<%String path = request.getContextPath(); %>

<style type="text/css">
<!--
.a {font-size: 9pt;}
td{font-family: "Arial"; font-size: 9pt}
.obj_table{margin-bottom:8px;border="3"}
body {margin-left: 2px;margin-top: 2px;}
-->
</style>
<%
try{
String strAN=request.getParameter("an");
String strChannelIDs=request.getParameter("channelIDs");
String strPD=request.getParameter("pd");
String CLM_Page=request.getParameter("CLM_Page");
String DES_Page=request.getParameter("DES_Page");
String DRA_Page=request.getParameter("DRA_Page");
String ft_type=request.getParameter("ft_type");

//System.out.println("XML_Browser_Left.jsp...........ft_type = "+ft_type);
//String strTRSTable=com.trs.Tools.getChannelName(strChannelIDs);

String tifPath=request.getParameter("strUrl").toUpperCase();
String tifPages=request.getParameter("strPage");

//out.println(tifPath);
if(tifPath!=null){
	tifPath=tifPath.replace("BOOKS","ThumbnailImage");
	tifPath=tifPath.replace("\\","/");
	tifPath=tifPath.replace("/000001.TIF","");
	if(tifPath.toLowerCase().indexOf("http:")==-1){
		//tifPath="http://"+strServerIP+"/"+tifPath;
	}
	//tifPath=tifPath.replace("//","/");
}else{
	return;
}
//out.println("<br>");
//out.println(tifPath);
int intTIFs=0;
if(tifPages != null && !tifPages.equals("")){
	intTIFs=Integer.parseInt(tifPages);
}
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
//System.out.println("pageIndex="+request.getParameter("pageIndex"));
	intCurrentPage=Integer.parseInt(request.getParameter("pageIndex"));
}

//out.println("共n页....>"+intPages+"<br>");
//out.println("当前页....>"+intCurrentPage+"<br>");
int intCurrentPageFirst=(intCurrentPage-1)*5+2;
//out.println("当前页开始图....>"+intCurrentPageFirst+"<br>");

int intCurrentPageTIFs=intCurrentPageFirst+4;//当前页有几件缩略图
if(intCurrentPage==intPages){
	intCurrentPageTIFs=intTIFs+1;
}

String destThumbNailImage=request.getParameter("destThumbNailImage");
if(destThumbNailImage==null || destThumbNailImage.equals("")){
	destThumbNailImage=(intCurrentPageFirst-1)+"";
}
//out.println(destThumbNailImage+"<br>");
%>

<body onLoad="javascript:HighlightDestTable()" style="overflow-x:hidden">
<a name="top"></a>
<form name="ViewXML" method="post" action="<%=basePath%>xml.do?method=viewXml" target="rightFrame">
<input type="hidden" name="an" value="<%=strAN%>">
<input type="hidden" name="channelIDs" value="<%=strChannelIDs%>">
<input type="hidden" name="pd" value="<%=strPD%>">
<input type="hidden" name="CLM_Page" value="<%=CLM_Page%>">
<input type="hidden" name="DES_Page" value="<%=DES_Page%>">
<input type="hidden" name="DRA_Page" value="<%=DRA_Page%>">
<input type="hidden" name="ft_type">
<input type="hidden" name="startpage" value="1">
<input type="hidden" name="pageno" value="1">
</form>

<form name="TurnPage" method="post">
<input name="an" value="<%=strAN%>" type="hidden">
<input name="channelIDs" value="<%=strChannelIDs%>" type="hidden">
<input name="pd" value="<%=strPD%>" type="hidden">
<input name="CLM_Page" value="<%=CLM_Page%>" type="hidden">
<input name="DES_Page" value="<%=DES_Page%>" type="hidden">
<input name="DRA_Page" value="<%=DRA_Page%>" type="hidden">
<input name="ft_type" value="<%=ft_type%>" type="hidden">
<input name="pageIndex" value="<%=intCurrentPage%>" type="hidden">
<input name="destThumbNailImage" type="hidden">
</form>

<%
if(intTIFs>0){
	//for(int i=2;i<=intTifPage;i++){
	for(int i=intCurrentPageFirst;i<=intCurrentPageTIFs;i++){
		//int pageno=i-1;
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
<a name="a<%=i-1%>"></a>
<table id="table<%=i-1%>" border="1" cellspacing="0" cellpadding="0" bordercolor="#000000" align="center">
  <tr bgcolor="#FFFFFF">
    <td>
<%
if(i>0){
%>
<a onClick="javascript:highlightTable(document,'<%=i-1%>');window.parent.rightFrame.turnToPage('<%=i-1%>')" style="cursor:hand">
<img src="<%=tifPath%>/<%=strfix%>.gif" border="0" width="85" height="120"></a>
<%}else{%>
<img src="<%=tifPath%>/<%=strfix%>.gif" border="0" width="85" height="120">
<%}%>
</td>
</tr></table>
  
<table height="33" align="center">
<tr><td align="center" ><font size="2">[<%=i-1%>]</font></td></tr></table>

<%}}%>

<%if(intTIFs>5){%>
<table align="center">

<tr><td align="center" nowrap>
[<%if(intCurrentPage!=1) {%><a onClick="javascript:turnpage(document,'<%=intCurrentPage-1%>',0);" style="cursor:hand;text-decoration:underline;color:0000FF">上 翻</a><%} else{%>上 翻<%}%>]
[<%if(intCurrentPage!=intPages) {%><a onClick="javascript:turnpage(document,'<%=intCurrentPage+1%>',0);" style="cursor:hand;text-decoration:underline;color:0000FF">下 翻</a><%} else{%>下 翻<%}%>]
</td></tr>
</table>
<%}%>

<script>
function turnpage(documentObj,pageno,i_right){
	//alert("turnpage:"+pageno);
	documentObj.TurnPage.pageIndex.value=pageno;
	documentObj.TurnPage.submit();
	
	if(i_right==0 || i_right=="0"){
		//左侧导航翻页，右侧内容不改变
		//window.parent.rightFrame.ListHTML('ThumbNailImage_Nav','<%=java.net.URLEncoder.encode("XML阅读")%>',(pageno-1)*5+1,0);
	}
	//i_right为1，是XML_Browser_Right.jsp在切换XML类型switchFT_Type时用到的，右侧xml已经显示
	if(i_right==1 || i_right=="1"){
		//window.parent.leftFrame.location="#top";
	}	
}

function HighlightDestTable(){//只有在page onload的时候调用
	var currentPage = window.parent.parent.headFrame.document.all.txtCurrentPage.value;

	var destThumbNailImage='<%=destThumbNailImage%>';
//alert("destThumbNailImage="+destThumbNailImage);
	if(destThumbNailImage!=null && destThumbNailImage!='null' && destThumbNailImage!='' && currentPage==destThumbNailImage){
		var obj=document.getElementById("table"+destThumbNailImage);
		obj.bordercolor="#666666"
		obj.cellspacing="8";
		obj.border="4";
		
		//alert(destThumbNailImage%5);
		if(destThumbNailImage%5==1 || destThumbNailImage%5=="1"){
			window.location="#top";
		}else{
			window.location="#a"+destThumbNailImage;
		}
	}
}
function highlightTable(documentObj,tifno){
	try{
		var eles=documentObj.getElementsByTagName("table");   
		for(var i=0;i<eles.length;i++)   
		{
/*
if(eles[i].id!=null && eles[i].id!=""){
	alert(eles[i].id);
}
*/
			if((eles[i].id).indexOf("table")==0)
			{
				eles[i].border="1";
			}
		}
	}catch(e){
		alert(e.name+":"+e.message);
	}
	
		//var id=parseInt(id);
		
		var obj=documentObj.getElementById("table"+tifno);
//alert("table"+id);
//alert(obj);
//obj.cellspacing="3";
//obj.style.width="500";
		obj.bordercolor="#666666"
		obj.cellspacing="8";
		obj.border="4";
//obj.cellspacing="2";
//obj.style.class=obj_tb;
//obj.border="3";
//obj.style.cellspacing="5";
//obj.style.backgroundColor="red";
//obj.style.bordercolor="#333333";
}
</script>
</body>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>