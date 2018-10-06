<!DOCTYPE html>
<html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*,net.jbase.common.util.security.MD5"%>

<%@ include file="/jsp/zljs/include-head-base.jsp"%>
<%@ include file="/jsp/zljs/include-head.jsp"%>
<head>
    <base href="<%=basePath%>">
    
    <title><%=website_title%>-专利检索查询,专利搜索下载</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript">
	function setProperty(name,settype)
	{		
//	alert($("[name='log74_areacode']").val());
		var jname = name.replace(/\./g,"\\.");

//		alert(jname);
//		alert($("#" + jname).val());
//		out.print("{jsonMessage:'true'}"); 		
		
		$.ajax({
			url : "<%=basePath%>setProperty.do",
			type : "post",
			dataType : "json",
			data : {
				settype : settype,
				name : name,
				val : $("#" + jname).val()
			},
//			cache : "false",
			success : function(json) {
//				alert(json);
				json = eval("("+json+")");
				if (json.jsonMessage == 'true') {
					alert("修改成功");
//					$("#" + jname).attr("style", "color:red;");
				}
			}//end success
		});//end .ajax
	}
	
	function setProperty_yujing(name,settype){
		setProperty(name,settype);
//		alert("修改成功。。。。");
	}

</script>

<style type="text/css">
.headth {
	font-size: 25px;
	font-weight: bold;
}

body {
	padding: 0px;
	margin: 0px;
}

.disabletr {
	background-color: gray;
	color: gray;
}

.abletr {
	color: green;
	font-weight: bold;
}

.used {
	color: red;
}

table {
	width: 1002px;
	padding: 0;
	margin: 0;
	margin-bottom: 20px;
}

th {
	font: bold 12px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
	border-right: 1px solid #88B7D8;
	border-bottom: 1px solid #88B7D8;
	border-top: 1px solid #88B7D8;
	border-left: 1px solid #88B7D8;
	letter-spacing: 0px;
	text-transform: uppercase;
	text-align: left;	
}

th.nobg {
	border-top: 0;
	border-left: 0;
	border-right: 1px solid #88B7D8;
	background: none;
}

td {
	padding: 5px;
	border-right: 1px solid #88B7D8;
	border-bottom: 1px solid #88B7D8;
	border-left: 1px solid #88B7D8;
	border-top: 1px solid #88B7D8;
	background: #fff;
	font-size: 13px;
}
</style>
</head>

<body>

<%@ include file="/jsp/zljs/include-head-nav.jsp"%>

<% 
	String islogin = "0",pwd="";
	if(null != request.getAttribute("islogin"))
	{
		islogin = (String)request.getAttribute("islogin");
	}
	if(null != request.getAttribute("pwd"))
	{
		pwd = (String)request.getAttribute("pwd");
	}
	String log74_areacode = (String)request.getAttribute("log74_areacode");
//  System.out.println("log74_areacode=" + log74_areacode);
//  if(islogin!=null && islogin.equals("1"))
  { 
	 String md5key = "";
	 String configlife = "";
	 String configkey = "";
	 
	  if(null != request.getAttribute("md5key"))
		  md5key = (String)request.getAttribute("md5key");
	  
	  if(null != request.getAttribute("configlife"))
		  configlife = (String)request.getAttribute("configlife");
	  
	  if(null != request.getAttribute("configkey"))
		  configkey = (String)request.getAttribute("configkey");
   %>
   
   <center>
   <table cellpadding="0" cellspacing="0" align='center'>
     	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom' colspan='2'><span class="headth">系统图形及链接参数设置（重启Tomcat后生效）</span></th></tr>
     	<!--
     	<tr><td width="40%">平台名称</td><td><input type="text" style="width:400px;height:20px" name="title" id="title" value="<%= SetupAccess.getProperty("title") %>"/> <input type="button" class="btn btn-success" onClick="setProperty('title','setup');" value="  保存  "/></td></tr>
		-->
     	<tr><td width="40%" style="color:#0066cc">检索服务地址</td><td><input type="text" style="width:400px;height:20px" name="SearchServerUrl" id="SearchServerUrl" value="<%= DataAccess.get("SearchServerUrl") %>"/> <input type="button" class="btn btn-success" onClick="setProperty('SearchServerUrl','app');" value="  保存  "/></td></tr>
     	<tr><td width="40%" style="color:#0066cc">检索服务地址（国外）</td><td><input type="text" style="width:400px;height:20px" name="SearchServerUrl_fr" id="SearchServerUrl_fr" value="<%= DataAccess.get("SearchServerUrl_fr") %>"/> <input type="button" class="btn btn-success" onClick="setProperty('SearchServerUrl_fr','app');" value="  保存  "/></td></tr>
		
		<tr><td width="40%" style="color:#00A600">手机版开关（0：关；1：开）</td><td><input type="text" style="width:400px;height:20px" name="wap" id="wap" value="<%= DataAccess.get("wap") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('wap','app');" value="  保存  "/></td></tr>
     	<tr><td width="40%" style="color:#00A600">检索服务地址（手机版）</td><td><input type="text" style="width:400px;height:20px" name="SearchServerUrl_wap" id="SearchServerUrl_wap" value="<%= DataAccess.get("SearchServerUrl_wap") %>"/> <input type="button" class="btn btn-success" onClick="setProperty('SearchServerUrl_wap','app');" value="  保存  "/></td></tr>
     	     	
     	<tr><td>细览查看全文XML代码化开关（0：关；1：开）</td><td><input type="text" style="width:400px;height:20px" name="cnAbXML" id="cnAbXML" value="<%= DataAccess.get("cnAbXML") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('cnAbXML','app');" value="  保存  "/></td></tr>
     	
     	<tr><td>XML代码化查看数据检索地址</td><td><input type="text" style="width:400px;height:20px" name="SearchServerUrl_xml" id="SearchServerUrl_xml" value="<%= DataAccess.get("SearchServerUrl_xml") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('SearchServerUrl_xml','app');" value="  保存  "/></td></tr>

     	<tr><td>XML代码化附图地址（ps：摘要附图）</td><td><input type="text" style="width:400px;height:20px" name="XMLServerURL" id="XMLServerURL" value="<%= DataAccess.get("XMLServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('XMLServerURL','app');" value="  保存  "/></td></tr>
     	<tr><td>XML代码化附图判断地址（需要服务器连通）</td><td><input type="text" style="width:400px;height:20px" name="XMLIntranetServerURL" id="XMLIntranetServerURL" value="<%= DataAccess.get("XMLIntranetServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('XMLIntranetServerURL','app');" value="  保存  "/></td></tr>
<!-- 
        <tr><td>XML代码化附图类型（tif或gif）</td><td><input type="text" style="width:400px;height:20px" name="xmlfututype" id="xmlfututype" value="<%= SetupAccess.get("xmlfututype") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('xmlfututype','setup');" value="  保存  "/></td></tr> 
 -->

        <tr><td style="color:#BF0060">全文图形类型（0:TIF;1:PNG）</td><td><input type="text" style="width:400px;height:20px" name="showPIC" id="showPIC" value="<%= DataAccess.get("showPIC") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('showPIC','app');" value="  保存  "/></td></tr>
        		
        <tr><td style="color:#BF0060">TIF全文图形地址</td><td><input type="text" style="width:400px;height:20px" name="PicServerURL" id="PicServerURL" value="<%= DataAccess.get("PicServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('PicServerURL','app');" value="  保存  "/></td></tr>
        <tr><td style="color:#BF0060">PNG全文图形地址</td><td><input type="text" style="width:400px;height:20px" name="PNGServerURL" id="PNGServerURL" value="<%= DataAccess.get("PNGServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('PNGServerURL','app');" value="  保存  "/></td></tr>
        

<!-- 
        <tr><td>全文图形浏览是否有缩略图开关(需配置图形链接)</td><td><input type="text" style="width:400px;height:20px" name="suoluepic" id="suoluepic" value="<%= SetupAccess.get("suoluepic") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('suoluepic','setup');" value="  保存  "/></td></tr> 
	    <tr><td>全文缩略图连接地址</td><td><input type="text" style="width:400px;height:20px" name="SLPicServerURL" id="SLPicServerURL" value="<%= DataAccess.get("SLPicServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('SLPicServerURL','app');" value="  保存  "/></td></tr>

     	<tr><td>摘要附图类型（tif或gif）</td><td><input type="text" style="width:400px;height:20px" name="zhaiyaofututype" id="zhaiyaofututype" value="<%= SetupAccess.get("zhaiyaofututype") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('zhaiyaofututype','setup');" value="  保存  "/></td></tr>
	   
        <tr><td>摘要附图地址</td><td><input type="text" style="width:400px;height:20px" name="PicFuTuServerURL" id="PicFuTuServerURL" value="<%= DataAccess.get("PicFuTuServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('PicFuTuServerURL','app');" value="  保存  "/></td></tr>
        <tr><td>判断摘要附图是否存在地址（需要服务器连通）</td><td><input type="text" style="width:400px;height:20px" name="PicIntranetServerURL" id="PicIntranetServerURL" value="<%= DataAccess.get("PicIntranetServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('PicIntranetServerURL','app');" value="  保存  "/></td></tr>
 -->
        <tr><td style="color:#FF8000">103个国家和地区开关</td><td><input type="text" style="width:400px;height:20px" name="OtherPatent" id="OtherPatent" value="<%= DataAccess.get("OtherPatent") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('OtherPatent','app');" value="  保存  "/></td></tr>

<tr><td style="color:#AE0000">中国（发明、新型、授权）摘要附图开关（0：关；1：开）</td><td><input type="text" style="width:400px;height:20px" name="cnAbfigure" id="cnAbfigure" value="<%= DataAccess.get("cnAbfigure") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('cnAbfigure','app');" value="  保存  "/></td></tr>
<tr><td style="color:#AE0000">中国外观摘要附图开关（0：关；1：开）</td><td><input type="text" style="width:400px;height:20px" name="cnwgAbfigure" id="cnwgAbfigure" value="<%= DataAccess.get("cnwgAbfigure") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('cnwgAbfigure','app');" value="  保存  "/></td></tr>
<tr><td style="color:#AE0000">国外摘要附图开关（0：关；1：开）</td><td><input type="text" style="width:400px;height:20px" name="frAbfigure" id="frAbfigure" value="<%= DataAccess.get("frAbfigure") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('frAbfigure','app');" value="  保存  "/></td></tr>


     	<tr><td>失效专利库查询开关(需安装TRS失效数据库)</td><td><input type="text" style="width:400px;height:20px" name="shixiaosearch" id="shixiaosearch" value="<%= SetupAccess.get("shixiaosearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('shixiaosearch','setup');" value="  保存  "/></td></tr>
	    <tr><td>默认失效行业导航频道号（依照mysql中ipr_channel库频道号）（一般情况下不用动）</td><td><input type="text" style="width:400px;height:20px" name="navsxchannels" id="navsxchannels" value="<%= SetupAccess.get("navsxchannels") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('navsxchannels','setup');" value="  保存  "/></td></tr>
	    
	    <tr><td>51.la网站统计</td><td><input type="text" style="width:400px;height:20px" name="navsxchannels" id="navsxchannels" value="<%= DataAccess.get("51laStat") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('51laStat','app');" value="  保存  "/></td></tr>
	    
	    <tr><td>guest用户登录</td><td><input type="text" style="width:400px;height:20px" name="guestlogin" id="guestlogin" value="<%= DataAccess.get("guestlogin") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('guestlogin','app');" value="  保存  "/></td></tr>
	    
	    <tr><td>开放注册功能</td><td><input type="text" style="width:400px;height:20px" name="register" id="register" value="<%= DataAccess.get("register") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('register','app');" value="  保存  "/></td></tr>
	    
	    <tr><td width="40%" style="color:#AE0000">翻译开关</td><td><input type="text" style="width:400px;height:20px" name="translate" id="translate" value="<%= SetupAccess.get("translate") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('translate','setup');" value="  保存  "/></td>  </tr>
<!-- 
        <tr><td>国外摘要附图开关</td><td><input type="text" style="width:400px;height:20px" name="frzhaiyaopic47" id="frzhaiyaopic47" value="<%= SetupAccess.get("frzhaiyaopic47") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('frzhaiyaopic47','setup');" value="  保存  "/></td></tr> 
	    
	    <tr><td>外观细缆小图开关,需配置外观小图路径</td><td><input type="text" style="width:400px;height:20px" name="viewwgsmallpic" id="viewwgsmallpic" value="<%= SetupAccess.get("viewwgsmallpic") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewwgsmallpic','setup');" value="  保存  "/></td></tr>
	    <tr><td>外观细缆小图形地址<br>（推荐jpg格式，如果本地没有小图则配置成大图地址，如：http://pic.cnipr.com:8080/books/，如果有小图则用http://pic.cnipr.com:8080/ThumbnailImage地址）</td><td><input type="text" style="width:400px;height:20px" name="WGPicServerURL" id="WGPicServerURL" value="<%= DataAccess.get("WGPicServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('WGPicServerURL','app');" value="  保存  "/></td></tr>
     	<tr><td>外观细缆大图地址</td><td><input type="text" style="width:400px;height:20px" name="WGTifServerURL" id="WGTifServerURL" value="<%= DataAccess.get("WGTifServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('WGTifServerURL','app');" value="  保存  "/></td></tr>
        <tr><td>外观大图是（tif或jpg）</td><td><input type="text" style="width:400px;height:20px" name="wglargepic" id="wglargepic" value="<%= SetupAccess.get("wglargepic") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('wglargepic','setup');" value="  保存  "/></td> </tr>
 -->
	    
        <!-- <tr><td>细缆同族专利链接地址</td><td><input type="text" style="width:400px;height:20px" name="FamilyURL" id="FamilyURL" value="<%= DataAccess.get("FamilyURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('FamilyURL','app');" value="  保存  "/></td></tr>
        <tr><td>公司代码辅助查询地址</td><td><input type="text" style="width:400px;height:20px" name="corpcordAppURL" id="corpcordAppURL" value="<%= DataAccess.get("corpcordAppURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('corpcordAppURL','app');" value="  保存  "/></td></tr> -->
        
        
        
        <!--<tr><td>活跃指数预警系统地址</td><td><input type="text" style="width:400px;height:20px" name="hyzsSystemAddr" id="hyzsSystemAddr" value="<%= DataAccess.get("hyzsSystemAddr") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('hyzsSystemAddr','app');" value="  保存  "/></td></tr>
    	
    	
    	
	   
    	<tr class="disabletr"><td>技术路线图系统地址（暂停用）</td><td><input type="text" style="width:400px;height:20px" name="trmAddr" id="trmAddr" value="<%= DataAccess.get("trmAddr") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('trmAddr','app');" value="  保存  "/></td></tr>
     	<tr class="disabletr"><td>公知公用分析地址（暂停用）</td><td><input type="text" style="width:400px;height:20px" name="gzgyAnalyseURL" id="gzgyAnalyseURL" value="<%= DataAccess.get("gzgyAnalyseURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('gzgyAnalyseURL','app');" value="  保存  "/></td></tr>
     	<tr class="disabletr"><td>新颖性与侵权性分析地址（暂停用）</td><td><input type="text" style="width:400px;height:20px" name="xinyinxingAnalyse" id="xinyinxingAnalyse" value="<%= DataAccess.get("xinyinxingAnalyse") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('xinyinxingAnalyse','app');" value="  保存  "/></td></tr>
        
        <tr><td>事物公报地址</td><td><input type="text" style="width:400px;height:20px" name="GBServerURL" id="GBServerURL" value="<%= DataAccess.get("GBServerURL") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('GBServerURL','app');" value="  保存  "/></td> </tr>
	   
        
        <tr><td>机器翻译地址（需服务器连通）</td><td><input type="text" style="width:400px;height:20px" name="TranslateServer" id="TranslateServer" value="<%= DataAccess.get("TranslateServer") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('TranslateServer','app');" value="  保存  "/></td></tr>
     
        <tr><td>平台默认的用户名 ID （免登陆时）</td><td><input type="text" style="width:400px;height:20px" name="defaultUserId" id="defaultUserId" value="<%= DataAccess.get("defaultUserId") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('defaultUserId','app');" value="  保存  "/></td></tr> 
     
         
	    
     	</tr>
		-->
    </table>
     
   
   
   
   <table  cellpadding="0" cellspacing="0" align='center'>
     	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom'   colspan="6" ><span class="headth">IP地址限制功能设置（重启Tomcat后生效）</span></th></tr>
     	

     	<!--
	     <tr><td width="40%">企业自建专题库开关</td><td><input type="text" style="width:400px;height:20px" name="corpcodebase" id="corpcodebase" value="<%= SetupAccess.get("corpcodebase") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('corpcodebase','setup');" value="  保存  "/></td></tr> 
	     <tr><td>行业导航库开关</td><td><input type="text" style="width:400px;height:20px" name="hangye" id="hangye" value="<%= SetupAccess.get("hangye") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('hangye','setup');" value="  保存  "/></td></tr>
	     <tr><td>行业、企业导航管理开关</td><td><input type="text" style="width:400px;height:20px" name="hangyeadmin" id="hangyeadmin" value="<%= SetupAccess.get("hangyeadmin") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('hangyeadmin','setup');" value="  保存  "/></td></tr>
	    
	     <tr><td>概览结果条数设置</td><td><input type="text" style="width:400px;height:20px" name="PAGERECORD" id="PAGERECORD" value="<%= SetupAccess.get("PAGERECORD") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('PAGERECORD','setup');" value="  保存  "/></td></tr> 
	   
	   
	    <tr><td>mysql表达式频道为空时,默认国内行业导航频道号（一般情况下不用动）</td><td><input type="text" style="width:400px;height:20px" name="navcnchannels" id="navcnchannels" value="<%= SetupAccess.get("navcnchannels") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('navcnchannels','setup');" value="  保存  "/></td></tr>
	     <tr><td>mysql表达式频道为空时,默认国外行业导航频道号（一般情况下不用动）</td><td><input type="text" style="width:400px;height:20px" name="navfrchannels" id="navfrchannels" value="<%= SetupAccess.get("navfrchannels") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('navfrchannels','setup');" value="  保存  "/></td></tr>
	     

	    
	     <tr><td>公司代码辅助查询开关（注意配置查询链接）</td><td><input type="text" style="width:400px;height:20px" name="gongsidaima" id="gongsidaima" value="<%= SetupAccess.get("gongsidaima") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('gongsidaima','setup');" value="  保存  "/></td></tr> 
         <tr><td>字词检索开关</td><td><input type="text" style="width:400px;height:20px" name="zicisearch" id="zicisearch" value="<%= SetupAccess.get("zicisearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('zicisearch','setup');" value="  保存  "/></td></tr> 
	      
	    
	    <tr><td>是否有国外频道开关</td><td><input type="text" style="width:400px;height:20px" name="frchannel" id="frchannel" value="<%= SetupAccess.get("frchannel") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('frchannel','setup');" value="  保存  "/></td></tr> 
	    <tr><td>首页行业导航入口自动检索开关</td><td><input type="text" style="width:400px;height:20px" name="autosearch" id="autosearch" value="<%= SetupAccess.get("autosearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('autosearch','setup');" value="  保存  "/></td></tr>
	    <tr><td>机器翻译开关(本功能链接机器翻译引擎，请设置链接)</td><td><input type="text" style="width:400px;height:20px" name="translate" id="translate" value="<%= SetupAccess.get("translate") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('translate','setup');" value="  保存  "/></td></tr>
	    
	    
	     
	    
	     <tr><td>代码化查看开关</td><td><input type="text" style="width:400px;height:20px" name="daimahuaview" id="daimahuaview" value="<%= SetupAccess.get("daimahuaview") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('daimahuaview','setup');" value="  保存  "/></td></tr>
	     <tr><td>每页代码化显示的段数</td><td><input type="text" style="width:400px;height:20px" name="XmlPageNUM" id="XmlPageNUM" value="<%= SetupAccess.get("XmlPageNUM") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('XmlPageNUM','setup');" value="  保存  "/></td> </tr>
	     <tr><td>代码化下载模块开关</td><td><input type="text" style="width:400px;height:20px" name="daimahuadownload" id="daimahuadownload" value="<%= SetupAccess.get("daimahuadownload") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('daimahuadownload','setup');" value="  保存  "/></td></tr>
	    
	   
	    <tr><td>全文图形查看</td><td><input type="text" style="width:400px;height:20px" name="viewtif" id="viewtif" value="<%= SetupAccess.get("viewtif") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewtif','setup');" value="  保存  "/></td></tr>
	    
	    <tr><td>是否有帮助文档</td><td><input type="text" style="width:400px;height:20px" name="helpword" id="helpword" value="<%= SetupAccess.get("helpword") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('helpword','setup');" value="  保存  "/></td></tr>
	    <tr><td>帮助文档的连接</td><td><input type="text" style="width:400px;height:20px" name="helpwordurl" id="helpwordurl" value="<%= SetupAccess.get("helpwordurl") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('helpwordurl','setup');" value="  保存  "/></td></tr>
	    	    
	    <tr><td>全文（说明书以及权利要求书）检索开关</td><td><input type="text" style="width:400px;height:20px" name="quanwensearch" id="quanwensearch" value="<%= SetupAccess.get("quanwensearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('quanwensearch','setup');" value="  保存  "/></td> </tr>
	    --> 
	    
	    <tr><td width="40%" style="color:#AE0000">IP限制开关</td><td><input type="text" style="width:400px;height:20px" name="iplimit" id="iplimit" value="<%= SetupAccess.get("iplimit") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('iplimit','setup');" value="  保存  "/></td>  </tr>
	    <tr><td style="color:#AE0000">限制IP段</td><td><input type="text" style="width:400px;height:20px" name="ipsegment" id="ipsegment" value="<%= SetupAccess.get("ipsegment") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('ipsegment','setup');" value="  保存  "/></td>  </tr>
	    
	    <!--
	    <tr><td>最大登录数控制开关</td><td><input type="text" style="width:400px;height:20px" name="maxloginamount" id="maxloginamount" value="<%= SetupAccess.get("maxloginamount") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('maxloginamount','setup');" value="  保存  "/></td> </tr>
	   
	     
	    <tr><td>细缆代码化法律状态数据带不带CN（旧格式不带CN，新库带CN）</td><td><input type="text" style="width:400px;height:20px" name="viewLegalStatuscn" id="viewLegalStatuscn" value="<%= SetupAccess.get("viewLegalStatuscn") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewLegalStatuscn','setup');" value="  保存  "/></td></tr>
	    <tr><td>检索排序开关（依照TRS排序限制条数内有效）</td><td><input type="text" style="width:400px;height:20px" name="orderopen" id="orderopen" value="<%= SetupAccess.get("orderopen") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('orderopen','setup');" value="  保存  "/></td></tr>
	    
	     
	     <tr><td>集团用户登录开关</td><td><input type="text" style="width:400px;height:20px" name="jituanlogin" id="jituanlogin" value="<%= SetupAccess.get("jituanlogin") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('jituanlogin','setup');" value="  保存  "/></td></tr> 
	     <tr><td>逻辑检索页面高级运算符开关</td><td><input type="text" style="width:400px;height:20px" name="senioroperator" id="senioroperator" value="<%= SetupAccess.get("senioroperator") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('senioroperator','setup');" value="  保存  "/></td></tr>
	     
	    
	     <tr><td>文摘批量n千条下载开关</td><td><input type="text" style="width:400px;height:20px" name="openbatchdownload" id="openbatchdownload" value="<%= SetupAccess.get("openbatchdownload") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('openbatchdownload','setup');" value="  保存  "/></td> </tr> 
	     <tr><td>文摘批量n千下载限制条数</td><td><input type="text" style="width:400px;height:20px" name="batchdownloadnum" id="batchdownloadnum" value="<%= SetupAccess.get("batchdownloadnum") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('batchdownloadnum','setup');" value="  保存  "/></td> </tr>
	     <tr><td>文摘批量下载次数限制(-1为不限制)</td><td><input type="text" style="width:400px;height:20px" name="batchdownloadlimits" id="batchdownloadlimits" value="<%= SetupAccess.get("batchdownloadlimits") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('batchdownloadlimits','setup');" value="  保存  "/></td></tr>
	   
	    -->

	   <!-- 
	     <tr><td>法律状态预警开关</td><td><input type="text" style="width:400px;height:20px" name="lawwarn" id="lawwarn" value="<%= SetupAccess.get("lawwarn") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('lawwarn','setup');" value="  保存  "/></td></tr>
	     <tr><td>法律状态预警，用户默认续订预警次数</td><td><input type="text" style="width:400px;height:20px" name="lawwarnrenewnum" id="lawwarnrenewnum" value="<%= SetupAccess.get("lawwarnrenewnum") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('lawwarnrenewnum','setup');" value="  保存  "/></td></tr> 
	     <tr><td>法律状态预警，用户最多预警表达式数量</td><td><input type="text" style="width:400px;height:20px" name="lawwarnmax" id="lawwarnmax" value="<%= SetupAccess.get("lawwarnmax") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('lawwarnmax','setup');" value="  保存  "/></td></tr>
	   
	     <tr><td>首页访问量统计开关只限于非定制首页index.jsp</td><td><input type="text" style="width:400px;height:20px" name="indexcount" id="indexcount" value="<%= SetupAccess.get("indexcount") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('indexcount','setup');" value="  保存  "/></td></tr> 
	     	    
	     <tr><td>是否有退出按钮</td><td><input type="text" style="width:400px;height:20px" name="havelogoffbutton" id="havelogoffbutton" value="<%= SetupAccess.get("havelogoffbutton") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('havelogoffbutton','setup');" value="  保存  "/></td></tr> 
	   -->
	   
	  </table>
     	 

    <table  cellpadding="0" cellspacing="0" align='center'>
    	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom'   colspan="6" ><span class="headth">定期预警</span></th></tr>
	    <tr><td width="40%">定期预警开关</td><td><input type="text" style="width:400px;height:20px" name="dingqiyujing" id="dingqiyujing" value="<%=SetupAccess.get("dingqiyujing") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty_yujing('dingqiyujing','setup');" value="  保存  "/></td></tr>
	    <tr><td>定期预警，用户默认续订预警次数</td><td><input type="text" style="width:400px;height:20px" name="simplewarnrenewnum" id="simplewarnrenewnum" value="<%= SetupAccess.get("simplewarnrenewnum") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('simplewarnrenewnum','setup');" value="  保存  "/></td></tr> 
	    <tr><td>定期预警，用户最多预警表达式数量</td><td><input type="text" style="width:400px;height:20px" name="simplewarnmax" id="simplewarnmax" value="<%= SetupAccess.get("simplewarnmax") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('simplewarnmax','setup');" value="  保存  "/></td></tr>
	    <tr><td>每天定期执行预警的小时数，24小时制</td><td><input type="text" style="width:400px;height:20px" name="HOUR_OF_DAY" id="HOUR_OF_DAY" value="<%= SetupAccess.get("HOUR_OF_DAY") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('HOUR_OF_DAY','setup');" value="  保存  "/></td></tr>
	    <tr><td>每天定期执行预警的分钟，24小时制</td><td><input type="text" style="width:400px;height:20px" name="MINUTE_OF_DAY" id="MINUTE_OF_DAY" value="<%= SetupAccess.get("MINUTE_OF_DAY") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('MINUTE_OF_DAY','setup');" value="  保存  "/></td></tr>
	</table>
     	 <!--------------------------- 系统高级功能设置   --------------------->
     	 
    <table  cellpadding="0" cellspacing="0" align='center'>
    	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom'   colspan="6" ><span class="headth">分析系统（托管）功能设置（重启Tomcat后生效）</span></th></tr>
    	  <tr><td width="40%">分析模块开关(因需oracle，不能本地化，只能链接service服务器)</td>
    	  <td><input type="text" style="width:400px;height:20px" name="fenxi" id="fenxi" value="<%= SetupAccess.get("fenxi") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('fenxi','setup');" value="  保存  "/></td></tr> 
	      <tr><td>分析系统地址</td><td><input type="text" size="100" style="width:400px;height:20px" name="analyseSystemAddr" id="analyseSystemAddr" value="<%= DataAccess.get("analyseSystemAddr") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('analyseSystemAddr','app');" value="  保存  "/></td></tr>

	      
	      <!--<tr><td>高级分析-聚类和引证分析开关(此功能是分析系统一个高级功能模块，默认不开启)</td><td><input type="text" style="width:400px;height:20px" name="gaojifenxi" id="gaojifenxi" value="<%= SetupAccess.get("gaojifenxi") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('gaojifenxi','setup');" value="  保存  "/></td></tr> 
	  
	      <tr><td>跨语言检索开关(注意配置jdk/bin目录)</td><td><input type="text" style="width:400px;height:20px" name="crossLanguage" id="crossLanguage" value="<%= SetupAccess.get("crossLanguage") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('crossLanguage','setup');" value="  保存  "/></td></tr>
	      <tr><td>活跃指数预警开关（因需oracle及TRSCKM，不能本地化，只能链接service服务器）</td><td><input type="text" style="width:400px;height:20px" name="huoyuezhishuyujing" id="huoyuezhishuyujing" value="<%= SetupAccess.get("huoyuezhishuyujing") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('huoyuezhishuyujing','setup');" value="  保存  "/></td></tr>
	     
    	  <tr class="disabletr"><td>高级预警预警度分析(暂停开启)</td><td><input type="text" style="width:400px;height:20px" name="gaojiyujing" id="gaojiyujing" value="<%= SetupAccess.get("gaojiyujing") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('gaojiyujing','setup');" value="  保存  "/></td></tr>
	   	  <tr><td>语义智能检索开关（因需oracle及TRSCKM，不能本地化，只能链接service服务器）</td><td><input type="text" style="width:400px;height:20px" name="yuyisearch" id="yuyisearch" value="<%= SetupAccess.get("yuyisearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('yuyisearch','setup');" value="  保存  "/></td></tr>
	     
	      <tr><td>细缆相似检索开关（因需TRSCKM，不能本地化，专利检索服务只能链接service服务器才能开启）</td><td><input type="text" style="width:400px;height:20px" name="detailxiangsisearch" id="detailxiangsisearch" value="<%= SetupAccess.get("detailxiangsisearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('detailxiangsisearch','setup');" value="  保存  "/></td></tr>
   		  <tr  class="disabletr"><td>新颖性与侵权性分析开关（暂停开启）</td><td><input type="text" style="width:400px;height:20px" name="xinyingxingqinquanxingfenxi" id="xinyingxingqinquanxingfenxi" value="<%= SetupAccess.get("xinyingxingqinquanxingfenxi") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('xinyingxingqinquanxingfenxi','setup');" value="  保存  "/></td></tr>
	  
   		  <tr class="disabletr"><td>公知公用分析开关(暂停开启)</td><td><input type="text" style="width:400px;height:20px" name="gzgyAnalyse" id="gzgyAnalyse" value="<%= SetupAccess.get("gzgyAnalyse") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('gzgyAnalyse','setup');" value="  保存  "/></td> </tr> -->
	      <!--<tr><td>查看自动标引开关</td><td><input type="text" style="width:400px;height:20px" name="autoIndex" id="autoIndex" value="<%= SetupAccess.get("autoIndex") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('autoIndex','setup');" value="  保存  "/></td></tr>
	      <tr><td>开放注册地址开关(不推荐开启,本功能没美工)(/ipss/admin/usermanager/jsp/user/register-user.jsp</td><td><input type="text" style="width:400px;height:20px" name="registeruser" id="registeruser" value="<%= SetupAccess.get("registeruser") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('registeruser','setup');" value="  保存  "/></td></tr>	    
    	  <tr><td>批量检索功能页面开关</td><td><input type="text" style="width:400px;height:20px" name="batchsearch" id="batchsearch" value="<%= SetupAccess.get("batchsearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('batchsearch','setup');" value="  保存  "/></td> </tr>
    	  <tr><td>MySql后台统计开关(新格式记录全文以及代码化下载日志、检索概览、细缆日志、全文及代码化浏览日志，记录开关)</td><td><input type="text" style="width:400px;height:20px" name="databaselog" id="databaselog" value="<%= SetupAccess.get("databaselog") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('databaselog','setup');" value="  保存  "/></td></tr>
	      <tr><td>MySql后台统计管理开关</td><td><input type="text" style="width:400px;height:20px" name="databaselogadmin" id="databaselogadmin" value="<%= SetupAccess.get("databaselogadmin") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('databaselogadmin','setup');" value="  保存  "/></td></tr> -->
	     
    	<!--  <tr><td>IPC表格检索辅助查询开关(此功能需要本地化TRS表：分类号对照表_部、分类号对照表_大类、分类号对照表_小类、分类号对照表_大组、分类号对照表_小组)</td><td><input type="text" style="width:400px;height:20px" name="ipchelpsearch" id="ipchelpsearch" value="<%= SetupAccess.get("ipchelpsearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('ipchelpsearch','setup');" value="  保存  "/></td></tr>
    	  <tr><td>专利评估系统开关（需要部署eval和evaluation）</td><td><input type="text" style="width:400px;height:20px" name="evaluation" id="evaluation" value="<%= SetupAccess.get("evaluation") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('evaluation','setup');" value="  保存  "/></td></tr>
    	
    	<tr><td>物理库模块开关</td><td><input type="text" style="width:400px;height:20px" name="openphysicaldb" id="openphysicaldb" value="<%= SetupAccess.get("openphysicaldb") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('openphysicaldb','setup');" value="  保存  "/></td> </tr>
	    <tr><td>物理库地址</td><td><input type="text" size="26" name="physicalurl" id="physicalurl" value="<%= SetupAccess.get("physicalurl") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('physicalurl','setup');" value="  保存  "/></td></tr>
	    <tr><td>物理库批量检索报告,必须有物理库模块</td><td><input type="text" style="width:400px;height:20px" name="physicalreport" id="physicalreport" value="<%= SetupAccess.get("physicalreport") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('physicalreport','setup');" value="  保存  "/></td></tr>
	    <tr><td>简单检索菜单开关</td><td><input type="text" style="width:400px;height:20px" name="simplesearchleft" id="simplesearchleft" value="<%= SetupAccess.get("simplesearchleft") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('simplesearchleft','setup');" value="  保存  "/></td> </tr> 
	       
	       
       <tr><td>代理机构查询开关(代理机构数据不全，只有四个省)</td><td><input type="text" style="width:400px;height:20px" name="agencysearch" id="agencysearch" value="<%= SetupAccess.get("agencysearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('agencysearch','setup');" value="  保存  "/></td></tr> 
       <tr><td>代理机构辅助查询开关</td><td><input type="text" style="width:400px;height:20px" name="agencyhelpsearch" id="agencyhelpsearch" value="<%= SetupAccess.get("agencyhelpsearch") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('agencyhelpsearch','setup');" value="  保存  "/></td></tr>
	   
        <tr><td>有效库模块开关（只能本地化，service目前没有，需安装TRS有效库及数据，并给客户更新）</td><td><input type="text" style="width:400px;height:20px" name="effectlib" id="effectlib" value="<%= SetupAccess.get("effectlib") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('effectlib','setup');" value="  保存  "/></td></tr> 
	    <tr><td>有效库行业导航频道号</td><td><input type="text" size="26" name="naveffectchannel" id="naveffectchannel" value="<%= SetupAccess.get("naveffectchannel") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('naveffectchannel','setup');" value="  保存  "/></td></tr>
	    
	    <tr class="disabletr"><td>数据权限组管理（数据权限是旧版遗留问题，暂关闭）</td><td><input type="text" style="width:400px;height:20px" name="datagroup" id="datagroup" value="<%= SetupAccess.get("datagroup") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('datagroup','setup');" value="  保存  "/></td></tr>
	   
    
         <tr><td>细缆检索报告开关</td><td><input type="text" style="width:400px;height:20px" name="detailsearchreport" id="detailsearchreport" value="<%= SetupAccess.get("detailsearchreport") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('detailsearchreport','setup');" value="  保存  "/></td></tr> 
	     <tr><td>检索报告下载时摘要附图下载地址</td><td><input type="text" size="26" name="searchreportpic" id="searchreportpic" value="<%= SetupAccess.get("searchreportpic") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('searchreportpic','setup');" value="  保存  "/></td></tr>
	     <tr><td>外观公报浏览开关(请配置app外观公报地址，旧版广东用，新版用统一公报)</td><td><input type="text" style="width:400px;height:20px" name="viewwggb" id="viewwggb" value="<%= SetupAccess.get("viewwggb") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewwggb','setup');" value="  保存  "/></td></tr>
	    
	     
	     <tr><td>法律状态批量下载开关</td><td><input type="text" style="width:400px;height:20px" name="batchdownloadlawstatus" id="batchdownloadlawstatus" value="<%= SetupAccess.get("batchdownloadlawstatus") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('batchdownloadlawstatus','setup');" value="  保存  "/></td></tr>
	     <tr><td>法律状态批量下载最大下载量</td><td><input type="text" style="width:400px;height:20px" name="batchdownloadlawstatusmax" id="batchdownloadlawstatusmax" value="<%= SetupAccess.get("batchdownloadlawstatusmax") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('batchdownloadlawstatusmax','setup');" value="  保存  "/></td></tr> 
	     <tr><td>概览结果聚类按钮（需TRSCMK，不能本地化，推荐链接service）</td><td><input type="text" style="width:400px;height:20px" name="juleigailan" id="juleigailan" value="<%= SetupAccess.get("juleigailan") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('juleigailan','setup');" value="  保存  "/></td> </tr> 
	       
	     <tr><td>是否浏览事务公报</td><td><input type="text" style="width:400px;height:20px" name="viewSWGB" id="viewSWGB" value="<%= SetupAccess.get("viewSWGB") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewSWGB','setup');" value="  保存  "/></td></tr>  
	     <tr><td>事务公报tif图形名称位数,4或6</td><td><input type="text" style="width:400px;height:20px" name="viewSWGBTIFnum" id="viewSWGBTIFnum" value="<%= SetupAccess.get("viewSWGBTIFnum") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewSWGBTIFnum','setup');" value="  保存  "/></td> </tr> 
	     <tr><td>事务公报中有没有扉页</td><td><input type="text" style="width:400px;height:20px" name="viewswgbfeiye" id="viewswgbfeiye" value="<%= SetupAccess.get("viewswgbfeiye") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewswgbfeiye','setup');" value="  保存  "/></td></tr> 
	     
	     <tr><td>是否浏览专利公报</td><td><input type="text" style="width:400px;height:20px" name="viewGB" id="viewGB" value="<%= SetupAccess.get("viewGB") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewGB','setup');" value="  保存  "/></td></tr> 
	     <tr><td>专利公报tif图形名称位数,4或6</td><td><input type="text" style="width:400px;height:20px" name="viewGBTIFnum" id="viewGBTIFnum" value="<%= SetupAccess.get("viewGBTIFnum") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewGBTIFnum','setup');" value="  保存  "/></td> </tr>
	     <tr><td>专利公报中有没有扉页</td><td><input type="text" style="width:400px;height:20px" name="viewgbfeiye" id="viewgbfeiye" value="<%= SetupAccess.get("viewgbfeiye") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('viewgbfeiye','setup');" value="  保存  "/></td></tr>
	     
	     
	     <tr><td>细缆同族分析表</td><td><input type="text" style="width:400px;height:20px" name="detailtongzutable" id="detailtongzutable" value="<%= SetupAccess.get("detailtongzutable") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('detailtongzutable','setup');" value="  保存  "/></td></tr> 
	     <tr><td>国外细缆引证图</td><td><input type="text" style="width:400px;height:20px" name="detailyz" id="detailyz" value="<%= SetupAccess.get("detailyz") %>"/>  <input type="button" class="btn btn-success" onClick="setProperty('detailyz','setup');" value="  保存  "/></td></tr>
	         -->
	       
    </table>
         
     	<table   cellpadding="0" cellspacing="0" align='center'>
     	<!--
     	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom'   colspan="6" ><span class="headth">页面设置（重启Tomcat后生效）</span></th></tr>
     	 
     	<tr>
	     	<td width="40%">首页指定（不填默认index.jsp）</td><td><input type="text" style="width:400px;height:20px" name="indexhtml" id="indexhtml" value="<%= SetupAccess.get("indexhtml") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('indexhtml','setup');" value="  保存  "/></td> 
	     </tr>
	     
	     <tr>
	     	<td>浏览器页签上的名称</td><td><input type="text" style="width:400px;height:20px" name="title" id="title" value="<%= SetupAccess.get("title") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('title','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>默认登陆首页左下角名称</td><td><input type="text" style="width:400px;height:20px" name="footword" id="footword" value="<%= SetupAccess.get("footword") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('footword','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>默认登陆首页logo中文字图片</td><td><input type="text" style="width:400px;height:20px" name="loginlogoword" id="loginlogoword" value="<%= SetupAccess.get("loginlogoword") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('loginlogoword','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>默认登陆首页logo英文字图片</td><td><input type="text" style="width:400px;height:20px" name="loginlogoword2" id="loginlogoword2" value="<%= SetupAccess.get("loginlogoword2") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('loginlogoword2','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>二级页面头部logo图片</td><td><input type="text" style="width:400px;height:20px" name="secondpagelogo" id="secondpagelogo" value="<%= SetupAccess.get("secondpagelogo") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpagelogo','setup');" value="  保存  "/></td> 
	     </tr>
	     
	     <tr>
	     	<td>二级页面logo随行业库变化开关（在secondpagei中配置logo路径）</td><td><input type="text" style="width:400px;height:20px" name="opensecondpagelogo" id="opensecondpagelogo" value="<%= SetupAccess.get("opensecondpagelogo") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('opensecondpagelogo','setup');" value="  保存  "/></td> 
	     </tr>
	     
	      <tr>
	     	<td>首页登录页面上是否显示各频道入口</td><td><input type="text" style="width:400px;height:20px" name="openhref" id="openhref" value="<%= SetupAccess.get("openhref") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('openhref','setup');" value="  保存  "/></td> 
	     </tr>
	     
	      <tr>
	     	<td>首页登录页面上是否显示行业库导航入口（在secondpagei中配置logo名称）</td><td><input type="text" style="width:400px;height:20px" name="openhangyehref" id="openhangyehref" value="<%= SetupAccess.get("openhangyehref") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('openhangyehref','setup');" value="  保存  "/></td> 
	     </tr>
	      -->
	     
	     <!-- <tr>
	     	<td  colspan='2'><b>行业库对应的二级logo图片,以及名称配置,最多20组,格式：行业导航intid 路径</b></td> 
	     </tr>
	    
	      <tr>
	     	<td>secondpage1</td><td><input type="text" style="width:400px;height:20px" name="secondpage1" id="secondpage1" value="<%= SetupAccess.get("secondpage1") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage1','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage2</td><td><input type="text" style="width:400px;height:20px" name="secondpage2" id="secondpage2" value="<%= SetupAccess.get("secondpage2") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage2','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage3</td><td><input type="text" style="width:400px;height:20px" name="secondpage3" id="secondpage3" value="<%= SetupAccess.get("secondpage3") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage3','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage4</td><td><input type="text" style="width:400px;height:20px" name="secondpage4" id="secondpage4" value="<%= SetupAccess.get("secondpage4") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage4','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage5</td><td><input type="text" style="width:400px;height:20px" name="secondpage5" id="secondpage5" value="<%= SetupAccess.get("secondpage5") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage5','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage6</td><td><input type="text" style="width:400px;height:20px" name="secondpage6" id="secondpage6" value="<%= SetupAccess.get("secondpage6") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage6','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage7</td><td><input type="text" style="width:400px;height:20px" name="secondpage7" id="secondpage7" value="<%= SetupAccess.get("secondpage7") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage7','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage8</td><td><input type="text" style="width:400px;height:20px" name="secondpage8" id="secondpage8" value="<%= SetupAccess.get("secondpage8") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage8','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage9</td><td><input type="text" style="width:400px;height:20px" name="secondpage9" id="secondpage9" value="<%= SetupAccess.get("secondpage9") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage9','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage10</td><td><input type="text" style="width:400px;height:20px" name="secondpage10" id="secondpage10" value="<%= SetupAccess.get("secondpage10") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage10','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage11</td><td><input type="text" style="width:400px;height:20px" name="secondpage11" id="secondpage11" value="<%= SetupAccess.get("secondpage11") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage11','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage12</td><td><input type="text" style="width:400px;height:20px" name="secondpage12" id="secondpage12" value="<%= SetupAccess.get("secondpage12") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage12','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage13</td><td><input type="text" style="width:400px;height:20px" name="secondpage13" id="secondpage13" value="<%= SetupAccess.get("secondpage13") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage13','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage14</td><td><input type="text" style="width:400px;height:20px" name="secondpage14" id="secondpage14" value="<%= SetupAccess.get("secondpage14") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage14','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage15</td><td><input type="text" style="width:400px;height:20px" name="secondpage15" id="secondpage15" value="<%= SetupAccess.get("secondpage15") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage15','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage16</td><td><input type="text" style="width:400px;height:20px" name="secondpage16" id="secondpage16" value="<%= SetupAccess.get("secondpage16") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage16','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage17</td><td><input type="text" style="width:400px;height:20px" name="secondpage17" id="secondpage17" value="<%= SetupAccess.get("secondpage17") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage17','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage18</td><td><input type="text" style="width:400px;height:20px" name="secondpage18" id="secondpage18" value="<%= SetupAccess.get("secondpage18") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage18','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage19</td><td><input type="text" style="width:400px;height:20px" name="secondpage19" id="secondpage19" value="<%= SetupAccess.get("secondpage19") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage19','setup');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>secondpage20</td><td><input type="text" style="width:400px;height:20px" name="secondpage20" id="secondpage20" value="<%= SetupAccess.get("secondpage20") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('secondpage20','setup');" value="  保存  "/></td> 
	     </tr> -->
	     </table>
	     
	     
	     
	    <table cellpadding="0" cellspacing="0" align='center'> 
     	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom' colspan="6" ><span class="headth">地方网点监控日志</span></th></tr>
     	<tr>
	     	<td width="40%">地方监控日志开关</td><td><input type="text" style="width:400px;height:20px" name="log74.open" id="log74.open" value="<%= Log74Access.get("log74.open") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('log74.open','log74');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>历史日志重写开关，若为0，则系统不覆盖历史日志，若为1，则系统会重写历史日志到当前日期，此项设置需在log74.open开启时启用</td>
	     	<td><input type="text" style="width:400px;height:20px" name="log74.history.open" id="log74.history.open" value="<%= Log74Access.get("log74.history.open") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('log74.history.open','log74');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>地方日志默认存放路径,注意使用反斜杠'/',正斜杠需'\\'</td><td><input type="text" style="width:400px;height:20px" name="log74.dir" id="log74.dir" value="<%= Log74Access.get("log74.dir") %>"/>   <input type="button" class="btn btn-success" onClick="setProperty('log74.dir','log74');" value="  保存  "/></td> 
	     </tr>
	     <tr>
	     	<td>地方区域编码</td><td>
	     	<!-- 
	     	<input type="text" style="width:400px;height:20px" name="log74.areacode" id="log74.areacode" value="<%= Log74Access.get("log74.areacode") %>"/>
	     	 -->
	     	<s:select alt="log74_areacode" multiple="false" size="10" id="log74.areacode" name="log74_areacode" list="#application.hm_areacode" required="true" theme="simple" cssStyle="width:200px"/>
	     	
	     	
	     	<input type="button" class="btn btn-success" onClick="setProperty('log74.areacode','log74');" value="  保存  "/></td> 
	     </tr>
	     </table>
   <%}%>
   
<script type="text/javascript">
$("[name='log74_areacode']").val('<%=log74_areacode%>');
</script>
   
   <%@ include file="/jsp/zljs/include-buttom.jsp"%>
   </center>
  </body>
  
 
</html>
