<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib prefix="n" uri="/WEB-INF/n.tld"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>
<%
	String path = request.getContextPath(); 
	int pageCount = Integer.parseInt(request.getParameter("pageCount"));
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	String ft_type = request.getParameter("ft_type");
	if (ft_type == null || ft_type.equals("")) {
		ft_type = "1";
	}
	int userrole = 0;
	
	String strItemGrant = "";
	if(request.getSession().getAttribute("strItemGrant")!=null)
		strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
%>
<html>
<head>
<title></title>
<Script src="<%=basePath%>js/jquery-1.3.2.min.js"></Script>
<script type="text/javascript" language="javascript" src="<%=basePath%>js/lytebox.js"></script>
<style type="text/css">
			body {
				margin-left: 0px;
				margin-top: 0px;
				margin-right: 0px;
				margin-bottom: 0px;
				text-align:center;
				scrollbar-face-color:ffffff; 
				scrollbar-shadow-color:C1C1BB; 
				scrollbar-highlight-color:C1C1BB; 
				scrollbar-3dlight-color:EBEBE4; 
				scrollbar-darkshadow-color:EBEBE4; 
				scrollbar-track-color:F4F4F0; 
				scrollbar-arrow-color:CACAB7; 
				
			}
			
			A:link {
			    COLOR: #000000;
			    text-decoration: none;
			}
			A:visited {
			    COLOR: #000000;
			    text-decoration: none;
			}
			A:hover {
			    COLOR: #FF9900;
			    text-decoration: none;
			}
			A:active {
			    COLOR: #000000;
			    text-decoration: none;
			}
			.style4 {font-size: 13px;
				font-family: Verdana, 宋体;}
			.style3 {font-size: 14px;
				font-family: Verdana, 宋体;
				margin-top: 5px;
				margin-right: 0px;
				margin-bottom: 0px;
				text-align:center;}
		</style>
<script type="text/javascript" src="<%=basePath%>js/lytebox.js"></script>

<script type="text/javascript">
function nextPage(pageIndex){
	document.ViewXML.pageIndex.value = pageIndex - 1;
	document.ViewXML.submit();
	document.headForm.pageIndex.value = pageIndex;
	document.headForm.submit();
}	

function gotoPage() {
	var gotoPage = document.getElementById("page").value;
	var totalPage = <%=pageCount%>;
	if (gotoPage <= totalPage && gotoPage >= 1) {
		document.ViewXML.pageIndex.value = gotoPage - 1;
		document.ViewXML.submit();
		document.headForm.pageIndex.value = gotoPage;
		document.headForm.submit();
	} else {
		alert("输入的页数错误！");
	}
}

function DownloadXML() {

  <% if(SetupAccess.getProperty(SetupConstant.DAIMAHUADOWNLOAD)!=null && SetupAccess.getProperty(SetupConstant.DAIMAHUADOWNLOAD).equals("1")){%>
				 <% if(strItemGrant.contains(SetupConstant.DAIMAHUADOWNLOAD)){%>
	//var returnval=window.showModalDialog("assign_find.jsp?rd="+random,obj,"dialogWidth=400px;dialogHeight="+strHeight+";status=no;scroll:no"); 
	var returnval = window.showModalDialog("<%=basePath%>download.do?method=downloadXml","","dialogHeight:120px;dialogWidth:280px;center:yes;resizable:no;help:no;status:no;scroll:no");
	var verify="";
	if(returnval != null){
		verify=returnval[0];
	}
	
	if(verify=="Wrong"){
		alert("验证码输入错误！");
	}
	//alert(hangyeUser);
	if(verify=="Right"){
		document.downloadXML.submit();
		/*var m_strFTType = window.parent.mainFrame.rightFrame.document.PatentInfo.ft_type.value;
		var m_strPageNum = window.parent.mainFrame.rightFrame.document.PatentInfo.pagenum.value;

		var CLM_Page = window.parent.mainFrame.rightFrame.document.PatentInfo.CLM_Page.value;
		var DES_Page = window.parent.mainFrame.rightFrame.document.PatentInfo.DES_Page.value;
		var DRA_Page = window.parent.mainFrame.rightFrame.document.PatentInfo.DRA_Page.value;

		var inargs=new Array(m_strFTType,CLM_Page,DES_Page,DRA_Page);
	
		var strHeight = "240";
		var returnval = window.showModalDialog("DownloadXMLset.jsp",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:360px;center:yes;resizable:no;help:no;status:no;scroll:no");
	
		if(returnval != null)
		{
			var r_strFTType = returnval[0];
			var r_strSelect = returnval[1];
			var r_strBeginPageNumber = returnval[2];
			var r_strEndPageNumber = returnval[3];
			
			window.parent.mainFrame.rightFrame.document.PatentInfo.ft_type.value = r_strFTType;
			window.parent.mainFrame.rightFrame.document.PatentInfo.strSelect.value = r_strSelect;
			window.parent.mainFrame.rightFrame.document.PatentInfo.int_start.value = r_strBeginPageNumber;
			window.parent.mainFrame.rightFrame.document.PatentInfo.int_end.value = r_strEndPageNumber;
			window.parent.mainFrame.rightFrame.document.PatentInfo.action="/download.do?method=doDownloadXML";
			window.parent.mainFrame.rightFrame.document.PatentInfo.target="_blank"
			window.parent.mainFrame.rightFrame.document.PatentInfo.submit();
		}*/
	}	
	<%}else{
		out.print("alert('无权限下载代码化！');");
	}
	}else
	{
		out.print("alert('无下载代码化功能！');");
	}
	%>
	//window.close();
}

function CheckButtonStatus() {
	if (<%=ft_type%> == 2) {
		$('#pagetag1 :input').attr('disabled', true); 
		$('#pagetag1 :a').attr('disabled', true); 

		$('#pagetag2 :input').attr('disabled', true); 
		$('#pagetag2 :a').attr('disabled', true); 
		
		var aLinkArr = document.getElementsByTagName("a");    
		for(var j = 0; j < aLinkArr.length; j++)   
		{      
		    if(aLinkArr[j].disabled)   
		    {     
		    aLinkArr[j].removeAttribute('href');   
		    }   
		}

		$('#showxml').attr('innerHTML', '说明书显示');
	}
}


function showDraws() {
	if (<%=ft_type%> == 1) {
		document.ViewXML.pageIndex.value = document.ViewXML.DES_Page.value + 1;
		document.ViewXML.ft_type.value = 2;
		document.ViewXML.submit();
		document.headForm.ft_type.value = 2;
		document.headForm.submit();
	} else {
		if (<%=userrole%> == 9) {
			document.ViewXML.pageIndex.value = 0;
			document.headForm.pageIndex.value = 1;
		} else {
			document.ViewXML.pageIndex.value = document.getElementById("page").value - 1;
		}
		
		document.ViewXML.ft_type.value = 1;
		document.ViewXML.submit();
		document.headForm.ft_type.value = 1;
		document.headForm.submit();
	}
}

function PrintXml() {
	window.parent.rightFrame.focus();
	try{
		window.parent.rightFrame.printxml();
	} catch (err) {
		alert(err);
	}
	
}
</script>
</head>
<body bgcolor="#ECE9D8">

<form name="ViewXML" method="post" action="<%=basePath%>xml.do?method=renderXML" target="rightFrame">
<input type="hidden" name="an" value="<%=request.getParameter("an")%>">
<input type="hidden" name="channelIDs" value="<%=request.getParameter("channelIDs")%>">
<input type="hidden" name="pd" value="<%=request.getParameter("pd")%>"">
<input type="hidden" name="CLM_Page" value="<%=request.getParameter("CLM_Page")%>">
<input type="hidden" name="DES_Page" value="<%=request.getParameter("DES_Page")%>">
<input type="hidden" name="DRA_Page" value="<%=request.getParameter("DRA_Page")%>">
<input type="hidden" name="pageIndex" value="<%=pageIndex%>">
<input type="hidden" name="ft_type" value="<%=ft_type%>">
</form>
<form name="headForm" method="post" action="<%=basePath%>jsp/viewPlugin/xml/XML_Browser_Head.jsp" target="_self">
<input type="hidden" name="an" value="<%=request.getParameter("an")%>">
<input type="hidden" name="channelIDs" value="<%=request.getParameter("channelIDs")%>">
<input type="hidden" name="pd" value="<%=request.getParameter("pd")%>"">
<input type="hidden" name="CLM_Page" value="<%=request.getParameter("CLM_Page")%>">
<input type="hidden" name="DES_Page" value="<%=request.getParameter("DES_Page")%>">
<input type="hidden" name="DRA_Page" value="<%=request.getParameter("DRA_Page")%>">
<input type="hidden" name="DRA_Page" value="<%=request.getParameter("DRA_Page")%>">
<input type="hidden" name="pageIndex" value="<%=pageIndex%>">
<input type="hidden" name="pageCount" value="<%=request.getParameter("pageCount")%>">
<input type="hidden" name="ft_type" value="<%=ft_type%>">
</form>
<form name="downloadXML" method="post" action="<%=basePath%>download.do?method=doDownloadXML" target="_blank">
<input type="hidden" name="an" value="<%=request.getParameter("an")%>">
<input type="hidden" name="channelIDs" value="<%=request.getParameter("channelIDs")%>">
<input type="hidden" name="pd" value="<%=request.getParameter("pd")%>">
</form>
<div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
								<td nowrap id="pagetag1" width="550" class="style4">
								<n:xmlnav pageCount="<%=pageCount%>"
										pageIndex="<%=pageIndex%>"
										navigationUrl=""
										params=""></n:xmlnav>
								</td>

										<td>&nbsp;<input type="button" value=" 打印 " onclick="javascript:PrintXml()" id="btnPrint">
										&nbsp;<input type="button" value=" 下载 " onclick="javascript:DownloadXML()" id="btnDownload"></td>
										<td class="style3"><a href="javascript:showDraws()" id="showxml">说明书附图显示</a></td>
										
										</tr></table>
</div>
</body>

</html>
<Script Language="JavaScript">
CheckButtonStatus();
</Script>
<%/*}catch(Exception ex){
	ex.printStackTrace();
}*/%>