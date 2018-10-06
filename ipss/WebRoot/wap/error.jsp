<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

  <head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <%@ include file="include-head.jsp"%>
	<title>检索错误-<%=website_title%></title>
	
	<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
	<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
	<script type="text/javascript" src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/hyjs-logic.js"></script>


	</head>
	<body>
<%
     String search_error  = (String)request.getAttribute("search_error");
//out.print(search_error);
%>
<!--顶部显示-->
<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="row">
            	 <!--LOGO显示-->
            	  <div class="col-xs-2">
            	 	  <a href="javascript:history.go(-1);"><img src="<%=basePath%>wap/img/fanhui.png" style="width:20px;margin-top:4px;" class="img-responsive"  /></a>
            	  </div>
            	  <div class="col-xs-10 col-md-4 col-sm-5">
            	 	  <img  src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/gl_logo.png" style="width:280px;margin-top:3px;" class="img-responsive"/>
            	  </div>
                <!--LOGO显示结束-->
            </div>
		</div>
</div>	
<!--顶部显示-->


<div style="width:1014px;margin: auto;padding-top:40px;">
 <div class="row-fluid">
    <div class="span3">
             <img src="<%=basePath%>common/com_2/img/error.png"/> 
    </div> 
     <div class="span9" style="margin-top:60px;">
非常抱歉，检索失败：<strong style="color:#6699cc"><%=search_error%></strong>
<!-- 
没有找到与您检索 “<strong style="color:#6699cc"><%=request.getAttribute("strWhere")%></strong>” 的相关结果。
 -->
<br>
<br>
<br>

建议您：<br>
1. 请仔细查看您输入的字词是否有误，比如大小写<br>
2. 请尝试其他的检索词，去掉那些不必要的字词或者尝试前后加%<br>
3. 调整检索词，改用比较常见的字词<br>
4. 阅读《帮助中心》也许会对您有帮助:您也可以通过   <a href="<%=basePath%>wap/biaoge.jsp">表格检索</a>、<a href="<%=basePath%>wap/mingling.jsp">命令行检索</a> 进行比较全面查询。
     </div> 
  </div>   
</div>



<div style="height:60px;"></div>

<%@ include file="include-bottom.jsp"%>

	</body>
</html>
