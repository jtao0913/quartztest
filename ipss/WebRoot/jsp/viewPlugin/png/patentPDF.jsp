<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" dir="ltr">

<head>
<%@ include file="/jsp/zljs/include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Online View PDF</title>
<script type="text/javascript" src="<%=basePath%>jsp/viewPlugin/png/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>jsp/viewPlugin/png/jquery.media.js"></script>
<script type="text/javascript">
    $(function() {
        $('a.media').media({width:800, height:600});
    });
</script>
</head>
 
<body>



<a class="media" href="<%=basePath%>jsp/viewPlugin/png/111.pdf"></a>
</body>
</html>