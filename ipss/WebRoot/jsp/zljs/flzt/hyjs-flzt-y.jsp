<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>
<%@ page import="net.jbase.common.util.*"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<html>
<head>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>法律状态检索【中国】-<%=website_title%></title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
	<meta name="description" content="<%=website_title%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->



<!-- 智能检索类库导入 -->


<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
%>

</head>

<!--导航-->

<%@ include file="/jsp/zljs/include-head.jsp"%>
<%@ include file="../include-head-nav.jsp"%>
<!--
<script src="<%=basePath %>semanjs/wordtips.js"></Script>
<Script src="<%=basePath %>semanjs/jquery.autocomplete.min.js"></Script>
<script type="text/javascript" src="<%=basePath %>semanjs/ui/ui.core.js"></script>
<script type="text/javascript" src="<%=basePath %>semanjs/ui/ui.dialog.js"></script>
<script type="text/javascript" src="<%=basePath %>semanjs/external/bgiframe/jquery.bgiframe.js"></script>
-->
<script language=javascript>

		function  trim(str)
		{
		//alert("trim="+str);
			for(var  i=0;i<str.length  &&  str.charAt(i)==" ";i++);
			for(var  j=str.length;j>0  &&  str.charAt(j-1)==" ";j--);
			if(i>j)  return  "";
		//alert("str.substring(i,j)="+str.substring(i,j));
			return  str.substring(i,j);  
		} 

        function formSubmit()
        {
         var sqhs="";		//申请（专利）号
         var flzt="";   	//法律状态
         var flztinfo="";	//法律状态信息
         var flztggr="";	//法律状态公告日
//		 var sqggh="";		//授权公告号
         var str="";		//检索表达式
         var str_leng="";
         
         sqhs=document.flztSearchForm.sqhs.value;
         flzt=document.flztSearchForm.flzt.value;
         flztinfo=document.flztSearchForm.flztinfo.value;
//       sqggh=document.flztSearchForm.textfield3.value;
	     flztggr=document.flztSearchForm.flztggr.value;
	     
	     
	     //alert(sqhs);
	     //alert(flzt);
	     //alert(flztinfo);
	     //alert(flztggr);
	     
		 
		 sqhs=sqhs.replace(/(^\s*)|(\s*$)/g, "");
		 sqhs=sqhs.replace('，', ",");
		 flzt=flzt.replace(/(^\s*)|(\s*$)/g, "");
		 flztinfo=flztinfo.replace(/(^\s*)|(\s*$)/g, "");
		 		 
//		 sqggh=sqggh.replace(/(^\s*)|(\s*$)/g, "");
		 flztggr=flztggr.replace(/(^\s*)|(\s*$)/g, "");
		 
		 var sqhinfo = "";
		 var sqh = "";
		 sqhs=trim(sqhs);
//alert("trim="+num)
         if(sqhs!="") {
			var arrsqh=sqhs.split(",");      
			for (i=0;i<arrsqh.length ;i++ )
			{
/*
				if(arrsqh[i].indexOf("CN")==0||arrsqh[i].indexOf("cn")==0)
				{
					sqh=arrsqh[i].substring(2);
				}else{
					sqh=arrsqh[i];
				}
//alert(sqh);
				if(sqh.indexOf(".")<0)
				{
					sqh=sqh+"%";
				}
				
				//sqhinfo=sqhinfo+","+sqh;
				
				str=str +  "申请号=(" + sqh + ") or ";
*/
				
				sqh=arrsqh[i];
				if(sqh.indexOf("CN")==0||sqh.indexOf("cn")==0){
					sqh=sqh.substring(2);
				}
				if(sqh.indexOf(".")<0)
				{
					sqh=sqh+"%";
				}
				str=str +  "(申请号=(CN" + sqh + ") or 申请号=(" + sqh + ")) or ";				
			}         	
		 }

//alert("#"+str.substring(str.length-4,str.length)+"#");
//lastIndexOf
		if(str!=""&&str.length>4&&str.substring(str.length-4,str.length)==" or "){
			str=str.substring(0,str.lastIndexOf(" or "));
			str = "(" + str + ")";
		}
//		alert(str);
		if(str!=""){
			str=str+" and ";
		}
		
		
         if(flztggr!="") {
            str=str +  "法律状态公告日=(" + flztggr + ") and ";
         }

        if(flzt!="") {
			str=str + "法律状态=" + flzt+ " and ";
		}
        if(flztinfo!="") {
			str=str + "法律状态信息=" + flztinfo+ " and ";
		}

        str_leng=str.length;
//alert(str);

		if (str_leng==0)
		{str="";}
		else
		{
			str=str.substring(0,str_leng-4);
		}

//alert(str);

		document.flztSearchForm.strWhere.value=str;
		if (str=="")
		{
			alert("检索表达式不能为空");
			return false;
		}else{		
			document.flztSearchForm.action = "<%=basePath%>legalStatusSearch.do";
	        document.flztSearchForm.submit();
        }

		}
</script>

<%@ include file="../include-head-secondsearch.jsp"%>

<%String type = "flzt";%>
<%@ include file="../include-head-jiansuo.jsp"%>

	<body>
	



   <div style="width:1014px;margin: auto;">
 	 <!--表格检索-->
		<div class="row-fluid muted" style="padding-left:30px;">
			<div style="height:30px;"></div>	
			<form class="form-horizontal" method="post" id="flztSearchForm" name="flztSearchForm" >
			<input type="hidden" name="strWhere">
			<input type="hidden" name="textfield3">
			<div class="row-fluid">
				<div class="span2" style="text-align:right;padding-right:10px;line-height:50px;">
					<strong>申请（专利）号：</strong>
				</div>
				<textarea  rows="2" id="sqhs" name="sqhs" style="width:268px;"></textarea>
				&nbsp;&nbsp;（例如：201210518155.5，多值用','或换行分隔）
				
			</div>
			<br />
			<div class="row-fluid">
				<div class="span2" style="text-align:right;padding-right:10px;">
					<strong>法律状态公告日：</strong>
				</div>
				<input id="flztggr" name="flztggr" class="input-xlarge" type="text" />
				&nbsp;&nbsp;（例如：2015.11.25）
			</div>
			<br />
			<div class="row-fluid">
				<div class="span2" style="text-align:right;padding-right:10px;">
					<strong>法律状态：</strong>
				</div>
				<input id="flzt" name="flzt" class="input-xlarge" type="text" />
				&nbsp;&nbsp;（例如：公开）
			</div>
			<br />
			<div class="row-fluid">
				<div class="span2" style="text-align:right;padding-right:10px;">
					<strong>法律状态信息：</strong>
				</div>
				<input class="input-xlarge" type="text" id="flztinfo" name="flztinfo" />
				&nbsp;&nbsp;（例如：未缴年费专利权终止）
			</div>
			<br />
			<div class="row-fluid">
				<div class="offset2">
					<button class="btn btn-warning" type="button" onClick="javascript:formSubmit();"><i class="icon-search icon-white"></i>&nbsp;检 索</button>
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<button class="btn btn-success" type="reset"><i class="icon-repeat icon-white"></i>&nbsp;重 置</button>
				</div>
			</div>
		</form>
		
				</div>
			<!--表格检索结束-->
</div>


<%@ include file="../include-buttom.jsp"%>

	</body>
</html>
