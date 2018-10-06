<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="task" scope="session" class="com.translate.TranslateThread"/>

<%
out.println(task.getResult());
%> 
