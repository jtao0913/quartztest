function PrintXML()
{
	var returnval = window.showModalDialog("verify.jsp","","dialogHeight:120px;dialogWidth:260px;center:yes;resizable:no;help:no;status:no;scroll:no");
	var verify="";
	if(returnval != null){
		verify=returnval[0];
	}
	
	if(verify=="Wrong"){
		alert("验证码输入错误！");
	}
	//alert(hangyeUser);
	if(verify=="Right"){
		var m_strFTType = document.PatentInfo.ft_type.value;
		var m_strPageNum = document.PatentInfo.pagenum.value;

		var CLM_Page = document.PatentInfo.CLM_Page.value;
		var DES_Page = document.PatentInfo.DES_Page.value;
		var DRA_Page = document.PatentInfo.DRA_Page.value;

		var inargs=new Array(m_strFTType,CLM_Page,DES_Page,DRA_Page);
	
		var strHeight = "255";
		var returnval = window.showModalDialog("PrintXMLset.jsp",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:360px;center:yes;resizable:no;help:no;status:no;scroll:no");
	
		if(returnval != null)
		{
			var r_strFTType = returnval[0];
			var r_strSelect = returnval[1];
			var r_strBeginPageNumber = returnval[2];
			var r_strEndPageNumber = returnval[3];
			
			document.PatentInfo.ft_type.value = r_strFTType;
			document.PatentInfo.strSelect.value = r_strSelect;
			document.PatentInfo.int_start.value = r_strBeginPageNumber;
			document.PatentInfo.int_end.value = r_strEndPageNumber;
	
			document.PatentInfo.action="PrintXML.jsp"
			document.PatentInfo.target="_blank"
			document.PatentInfo.submit();
		}
	}
}

function DownloadXML()
{
	//var returnval=window.showModalDialog("assign_find.jsp?rd="+random,obj,"dialogWidth=400px;dialogHeight="+strHeight+";status=no;scroll:no"); 
	var returnval = window.showModalDialog("verify.jsp","","dialogHeight:120px;dialogWidth:260px;center:yes;resizable:no;help:no;status:no;scroll:no");
	var verify="";
	if(returnval != null){
		verify=returnval[0];
	}
	
	if(verify=="Wrong"){
		alert("验证码输入错误！");
	}
	//alert(hangyeUser);
	if(verify=="Right"){
		var m_strFTType = document.PatentInfo.ft_type.value;
		var m_strPageNum = document.PatentInfo.pagenum.value;

		var CLM_Page = document.PatentInfo.CLM_Page.value;
		var DES_Page = document.PatentInfo.DES_Page.value;
		var DRA_Page = document.PatentInfo.DRA_Page.value;

		var inargs=new Array(m_strFTType,CLM_Page,DES_Page,DRA_Page);
	
		var strHeight = "240";
		var returnval = window.showModalDialog("DownloadXMLset.jsp",inargs,"dialogHeight:" + strHeight + "px;dialogWidth:360px;center:yes;resizable:no;help:no;status:no;scroll:no");
	
		if(returnval != null)
		{
			var r_strFTType = returnval[0];
			var r_strSelect = returnval[1];
			var r_strBeginPageNumber = returnval[2];
			var r_strEndPageNumber = returnval[3];
			
			document.PatentInfo.ft_type.value = r_strFTType;
			document.PatentInfo.strSelect.value = r_strSelect;
			document.PatentInfo.int_start.value = r_strBeginPageNumber;
			document.PatentInfo.int_end.value = r_strEndPageNumber;
			
			document.PatentInfo.action="DownloadXML.jsp"
			document.PatentInfo.target="_self"
			document.PatentInfo.submit();
		}
	}	
	//window.close();
}

function turnToPage(page) {
	window.parent.parent.headFrame.document.all.txtCurrentPage.value=page;
	window.parent.parent.headFrame.document.all.lbCurrentPage.innerText = page;
	window.parent.parent.headFrame.CheckButtonStatus();
	window.parent.leftFrame.ViewXML.pageno.value=page;
	window.parent.leftFrame.ViewXML.submit();
}

