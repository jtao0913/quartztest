<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>

<%@ include file="../jsp/zljs/include-head-base.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>系统设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>scripts/jquery/jquery-1.3.2.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
			 $("tr").each(function(){ 
			 	 if( $(this).find("input[type=text]").val()=='1' )
			 	 	$(this).attr("class","abletr");
			 });
		});
		
		
		function setProperty(name,settype)
	{
		jname = name.replace(/\./g,"\\.");  
		$.ajax({
				url : "<%=basePath%>admin/config-do.jsp",
				type : "post",
				dataType : "json", 
				data : {settype:settype,name:name,val:$("#"+jname).val()},
				cache :  "false" ,
				success : function(json){  
						 if(json.jsonMessage=='true')
						{  
							 
							$("#"+jname).attr("style","color:red;");
						}
		 		}//end success
		 		 
		});//end .ajax   
	}
	
	 
	</script>
	 
	<link rel="stylesheet" href="<%=basePath%>css/default.css" type="text/css" media="all"/> 
<style type="text/css">
	.headth{
		font-size:25px;
		font-weight:bold;
	}
	body{
		padding:0px;margin:0px;
		
	}
	

table {
 width: 1002px;
 padding: 0;
 margin: 0;
}
 
th {
 font: bold 12px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif; 
 border-right: 1px solid #88B7D8;
 border-bottom: 1px solid #88B7D8;
 border-top: 1px solid #88B7D8;
 letter-spacing: 2px;
 text-transform: uppercase;
 text-align: left;
 padding: 6px 6px 6px 12px; 
}
th.nobg {
 border-top: 0;
 border-left: 0;
 border-right: 1px solid #88B7D8;
 background: none;
}
td {
 border-right: 1px solid #88B7D8;
 border-bottom: 1px solid #88B7D8;
 background: #fff;
 font-size:12px;
 padding: 6px 6px 6px 12px;
  
}
.disabletr{
	background-color: gray;
	color: gray;
}

.abletr{ 
	color: green;
	font-weight: bold;
}

.used{ 
	color: red;
}
 

</style>
  </head>
  
  <body>
  <% 
  String islogin = "0";
  if(null != request.getAttribute("islogin"))
    islogin = (String)request.getAttribute("islogin");
  if(islogin!=null && islogin.equals("1"))
  {
	  String configlife = DataAccess.get("configlife");
	  if(configlife!=null && configlife.equals("")==false)
	  {
		  	int conlife = Integer.parseInt(configlife)-1;
		  	System.out.println("conlife="+conlife);
		  	if(conlife<0)
		  	{
		  		out.print("密码失效，请联系管理员");
		  		return;
		  	}else
		  		DataAccess.set("configlife",conlife+"");
		   
	  }
		  
  %>
 
     <table     cellpadding="0" cellspacing="0" align='center'>
     	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom' colspan='2' ><span class="headth">系统图形及链接参数设置（重启Tomcat后生效）</span></th></tr>
     	<tr class="used"><td width="30%">检索服务地址</td><td><input type="text" size="100" name="SearchServerUrl" id="SearchServerUrl" value="<%= DataAccess.get("SearchServerUrl") %>"/><input type="button" onClick="setProperty('SearchServerUrl','app');" value="保存"/></td></tr>
     	
     	<tr class="used"><td>XML代码化查看数据检索地址</td><td><input type="text" size="100" name="SearchServerUrl_xml" id="SearchServerUrl_xml" value="<%= DataAccess.get("SearchServerUrl_xml") %>"/><input type="button" onClick="setProperty('SearchServerUrl_xml','app');" value="保存"/></td></tr>
     	<tr class="used"><td>XML代码化附图地址</td><td><input type="text" size="100" name="XMLServerURL" id="XMLServerURL" value="<%= DataAccess.get("XMLServerURL") %>"/><input type="button" onClick="setProperty('XMLServerURL','app');" value="保存"/></td></tr>
     	<tr class="used"><td>XML代码化附图判断地址（需要服务器连通）</td><td><input type="text" size="100" name="XMLIntranetServerURL" id="XMLIntranetServerURL" value="<%= DataAccess.get("XMLIntranetServerURL") %>"/><input type="button" onClick="setProperty('XMLIntranetServerURL','app');" value="保存"/></td></tr>
        <tr class="used"><td>XML代码化附图类型（tif或gif）</td><td><input type="text" size="5" name="xmlfututype" id="xmlfututype" value="<%= SetupAccess.get("xmlfututype") %>"/><input type="button" onClick="setProperty('xmlfututype','setup');" value="保存"/></td></tr> 
	   
        <tr class="used"><td>全文图形地址</td><td><input type="text" size="100" name="PicServerURL" id="PicServerURL" value="<%= DataAccess.get("PicServerURL") %>"/><input type="button" onClick="setProperty('PicServerURL','app');" value="保存"/></td></tr>
        <tr class="used"><td>全文图形浏览是否有缩略图开关(需配置图形链接)</td><td><input type="text" size="5" name="suoluepic" id="suoluepic" value="<%= SetupAccess.get("suoluepic") %>"/><input type="button" onClick="setProperty('suoluepic','setup');" value="保存"/></td></tr> 
	    <tr><td>全文缩略图连接地址</td><td><input type="text" size="100" name="SLPicServerURL" id="SLPicServerURL" value="<%= DataAccess.get("SLPicServerURL") %>"/><input type="button" onClick="setProperty('SLPicServerURL','app');" value="保存"/></td></tr>
     	
     	<tr class="used"><td>摘要附图类型（tif或gif）</td><td><input type="text" size="5" name="zhaiyaofututype" id="zhaiyaofututype" value="<%= SetupAccess.get("zhaiyaofututype") %>"/><input type="button" onClick="setProperty('zhaiyaofututype','setup');" value="保存"/></td></tr>
	   
        <tr class="used"><td>摘要附图地址</td><td><input type="text" size="100" name="PicFuTuServerURL" id="PicFuTuServerURL" value="<%= DataAccess.get("PicFuTuServerURL") %>"/><input type="button" onClick="setProperty('PicFuTuServerURL','app');" value="保存"/></td></tr>
        <tr class="used"><td>判断摘要附图是否存在地址（需要服务器连通）</td><td><input type="text" size="100" name="PicIntranetServerURL" id="PicIntranetServerURL" value="<%= DataAccess.get("PicIntranetServerURL") %>"/><input type="button" onClick="setProperty('PicIntranetServerURL','app');" value="保存"/></td></tr>
        
        <tr><td>47家及地方国外摘要附图开关</td><td><input type="text" size="5" name="frzhaiyaopic47" id="frzhaiyaopic47" value="<%= SetupAccess.get("frzhaiyaopic47") %>"/><input type="button" onClick="setProperty('frzhaiyaopic47','setup');" value="保存"/></td></tr> 
	    
	    <tr class="used"><td>外观细缆小图开关,需配置外观小图路径</td><td><input type="text" size="5" name="viewwgsmallpic" id="viewwgsmallpic" value="<%= SetupAccess.get("viewwgsmallpic") %>"/><input type="button" onClick="setProperty('viewwgsmallpic','setup');" value="保存"/></td></tr>
	    <tr class="used"><td>外观细缆小图形地址<br>（推荐jpg格式，如果本地没有小图则配置成大图地址，如：http://pic.cnipr.com:8080/books/，如果有小图则用http://pic.cnipr.com:8080/ThumbnailImage地址）</td><td><input type="text" size="100" name="WGPicServerURL" id="WGPicServerURL" value="<%= DataAccess.get("WGPicServerURL") %>"/><input type="button" onClick="setProperty('WGPicServerURL','app');" value="保存"/></td></tr>
     	<tr class="used"><td>外观细缆大图地址</td><td><input type="text" size="100" name="WGTifServerURL" id="WGTifServerURL" value="<%= DataAccess.get("WGTifServerURL") %>"/><input type="button" onClick="setProperty('WGTifServerURL','app');" value="保存"/></td></tr>
        <tr class="used"><td>外观大图是（tif或jpg）</td><td><input type="text" size="5" name="wglargepic" id="wglargepic" value="<%= SetupAccess.get("wglargepic") %>"/><input type="button" onClick="setProperty('wglargepic','setup');" value="保存"/></td> </tr>
	   
	   
        <tr><td>细缆同族专利链接地址</td><td><input type="text" size="100" name="FamilyURL" id="FamilyURL" value="<%= DataAccess.get("FamilyURL") %>"/><input type="button" onClick="setProperty('FamilyURL','app');" value="保存"/></td></tr>
        <tr><td>公司代码辅助查询地址</td><td><input type="text" size="100" name="corpcordAppURL" id="corpcordAppURL" value="<%= DataAccess.get("corpcordAppURL") %>"/><input type="button" onClick="setProperty('corpcordAppURL','app');" value="保存"/></td></tr>
        
        <tr><td>分析系统地址</td><td><input type="text" size="100" name="analyseSystemAddr" id="analyseSystemAddr" value="<%= DataAccess.get("analyseSystemAddr") %>"/><input type="button" onClick="setProperty('analyseSystemAddr','app');" value="保存"/></td></tr>
        <tr><td>活跃指数预警系统地址</td><td><input type="text" size="100" name="hyzsSystemAddr" id="hyzsSystemAddr" value="<%= DataAccess.get("hyzsSystemAddr") %>"/><input type="button" onClick="setProperty('hyzsSystemAddr','app');" value="保存"/></td></tr>
    	
    	
    	
	   
    	<tr class="disabletr"><td>技术路线图系统地址（暂停用）</td><td><input type="text" size="100" name="trmAddr" id="trmAddr" value="<%= DataAccess.get("trmAddr") %>"/><input type="button" onClick="setProperty('trmAddr','app');" value="保存"/></td></tr>
     	<tr class="disabletr"><td>公知公用分析地址（暂停用）</td><td><input type="text" size="100" name="gzgyAnalyseURL" id="gzgyAnalyseURL" value="<%= DataAccess.get("gzgyAnalyseURL") %>"/><input type="button" onClick="setProperty('gzgyAnalyseURL','app');" value="保存"/></td></tr>
     	<tr class="disabletr"><td>新颖性与侵权性分析地址（暂停用）</td><td><input type="text" size="100" name="xinyinxingAnalyse" id="xinyinxingAnalyse" value="<%= DataAccess.get("xinyinxingAnalyse") %>"/><input type="button" onClick="setProperty('xinyinxingAnalyse','app');" value="保存"/></td></tr>
        
        
        <tr><td>机器翻译地址（需服务器连通）</td><td><input type="text" size="100" name="TranslateServer" id="TranslateServer" value="<%= DataAccess.get("TranslateServer") %>"/><input type="button" onClick="setProperty('TranslateServer','app');" value="保存"/></td></tr>
     
        <tr><td>平台默认的用户名 ID （免登陆时）</td><td><input type="text" size="100" name="defaultUserId" id="defaultUserId" value="<%= DataAccess.get("defaultUserId") %>"/><input type="button" onClick="setProperty('defaultUserId','app');" value="保存"/></td></tr>
     
         
	    
     	</tr>
    </table>
     	 
     	 
     
     
       <table   cellpadding="0" cellspacing="0" align='center'>
     	<tr class="simpleWarnFirstTR"><th height="50" valign='bottom'   colspan="6" ><span class="headth">地方网点监控日志</span></th></tr>
     	<tr>
	     	<td width="30%">地方监控日志开关</td><td><input type="text" size="80" name="log74.open" id="log74.open" value="<%= Log74Access.get("log74.open") %>"/> <input type="button" onClick="setProperty('log74.open','log74');" value="保存"/></td> 
	     </tr>
	     <tr>
	     	<td>历史日志重写开关，若为0，则系统不覆盖历史日志，若为1，则系统会重写历史日志到当前日期，此项设置需在log74.open开启时启用</td>
	     	<td><input type="text" size="80" name="log74.history.open" id="log74.history.open" value="<%= Log74Access.get("log74.history.open") %>"/> <input type="button" onClick="setProperty('log74.history.open','log74');" value="保存"/></td> 
	     </tr>
	     <tr>
	     	<td>地方日志默认存放路径,注意使用反斜杠'/',正斜杠需'\\'</td><td><input type="text" size="80" name="log74.dir" id="log74.dir" value="<%= Log74Access.get("log74.dir") %>"/> <input type="button" onClick="setProperty('log74.dir','log74');" value="保存"/></td> 
	     </tr>
	     <tr>
	     	<td>地方区域编码</td><td><input type="text" size="80" name="log74.areacode" id="log74.areacode" value="<%= Log74Access.get("log74.areacode") %>"/> <input type="button" onClick="setProperty('log74.areacode','log74');" value="保存"/></td> 
	     </tr>
	     </table>
     
     	 
     <%}else
    	 {    	 
    	 	out.println("你想干嘛？无权访问！");
    	 }%>
  </body>
</html>
