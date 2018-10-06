<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>test.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
  <body>
    This is my HTML page. <br>
 
  
   <form action="http://127.0.0.1:8080/patwarn/simple/warn-manage!create.jhtml" method="post">
   <input type="hidden" value="2015" name="uid"/>
      <input type="hidden" value="cnipr" name="uname"/>
         <input type="hidden" value="[7c4a8d09ca3762af61e59520943dc26494f8941b]" name="pwd"/>
                  <input type="hidden" value="申请号=% and 申请号=% and 申请号=% and 申请号=%" name="exp"/>
                  <input type="submit" value="定期预警"/>
   </form>
   
   <form action="http://211.157.104.87/patwarn/simple/warn-manage.jhtml?zone=cnipr" name="alarmForm" method="post" target="_blank">
	  <input type="hidden" name="uid" value="3494">
	  <input type="hidden" name="uname" value="cnipr">
	  <input type="hidden" name="channels" value="">
	  <input type="hidden" name="pwd" value="[3d4f2bf07dc1be38b20cd6e46949a1071f9d0e3d]">
	  <input type="hidden" name="exp" value="">
	  <input type="submit" value="submit" name="submit" />"
	</form>
	
	
  <a href="http://127.0.0.1:8080/patwarn/simple/warn-manage!create.jhtml?uid=&uname=cnipr&pwd=[3d4f2bf07dc1be38b20cd6e46949a1071f9d0e3d]&exp=&zone=guangdong" target="_blank">
  http://127.0.0.1:8080/patwarn/simple/manage!create.jhtml?uid=3494&uname=cnipr&pwd=[3d4f2bf07dc1be38b20cd6e46949a1071f9d0e3d]&exp=&zone=guangdong</a>
  </body>
  
  
   <a href="http://127.0.0.1:8080/patwarn/simple/warn-manage!create.jhtml?uid=&uname=cjg3320&pwd=[3d4f2bf07dc1be38b20cd6e46949a1071f9d0e3d]&exp=&zone=cnipr" target="_blank">
  http://127.0.0.1:8080/patwarn/simple/manage!create.jhtml?uid=3494&uname=cnipr&pwd=[7c4a8d09ca3762af61e59520943dc26494f8941b]&exp=&zone=cnipr</a>
  </body>
</html>
