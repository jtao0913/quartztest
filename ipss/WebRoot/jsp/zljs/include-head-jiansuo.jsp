<%@ page language="java" pageEncoding="UTF-8"%>

<!--二次检索模块开始-->
<script type="text/javascript">
function doQsearch(){
	var content = $('#content').val();
	var colname = $('#colname').val();

//alert(colname+content);

	if(content!=null && content!=""){
//		var colname = $('#colname').val();
//		alert(colname);
		
		$("#strWhere").val(colname+content);
		$("#expressSearchForm").submit();
	}else{
		return false;
	}
}
</script>

<%
//String area = request.getParameter("area")==null?"":request.getParameter("area");
//System.out.println("------------------area="+area);

//type=cnbiaodan
//String type = request.getParameter("type")==null?"":request.getParameter("type");
//String navID = request.getSession().getAttribute("navID")==null?null:(String)request.getSession().getAttribute("navID");
%>
	<!--分类开始	
	<div style="width:1114px;margin: auto;">
	 <div class="btn-toolbar" style="display: inline-block;">
		<div class="btn-group">
		 <a class="btn btn-default <%if(type.equals("cnbiaodan")){%>btn btn-warning<%}%>" href="<%=basePath%>showSearchForm.do?area=cn" ><span title="表格检索【CNIPA】"> 表格检索【CNIPA】</span>		
		  </a>
		   <a class="btn btn-default <%if(type.equals("frbiaodan")){%>btn btn-warning<%}%>" href="<%=basePath%>showSearchForm.do?area=fr" ><span  title="表格检索【国外及港澳台】"> 表格检索【港澳台及海外】</span>		
		  </a>
		  <%
//		  System.out.println("------------------navID="+navID);
//		  if(navID.equals("0")){
		  %>
		  <a class="btn btn-default <%if(type.equals("cnlogic")){%>btn btn-warning<%}%>" href="<%=basePath%>showLogicForm.do?area=cn"> 专家检索【CNIPA】</span>
		  </a>
		   <a class="btn btn-default <%if(type.equals("frlogic")){%>btn btn-warning<%}%>" href="<%=basePath%>showLogicForm.do?area=fr" ><span  title="专家检索【CNIPA】"><span  title="专家检索【国外及港澳台】"> 专家检索【港澳台及海外】</span>		
		  </a>
		  
		  <!-- 
		  <a class="btn btn-default" href="<%=basePath%>jsp/zljs/menutest.jsp"><span  title="失效检索" <%if(type.equals("sxbiaodan")){%>style="background-image:none;color: #ffffff;background-color: #3498db;"<%}%>> 失效检索</span>		
		  </a>
		   -->
		   <!--
		  <a class="btn btn-default <%if(type.equals("flzt")){%>btn btn-warning<%}%>"  href="<%=basePath%>showFlztSearchForm.do" ><span  title="法律状态检索"> 法律状态检索</span>		
		  </a>
		  <a class="btn btn-default <%if(type.equals("ipc")){%>btn btn-warning<%}%>"  href="<%=basePath%>mytreeipc.do" ><span  title="IPC导航分类"> IPC导航分类</span>		
		  </a>
		  <a class="btn btn-default <%if(type.equals("gmjj")){%>btn btn-warning<%}%>"  href="<%=basePath%>mytreegmjj.do" ><span  title="国民经济分类导航"> 国民经济分类导航</span>		
		  </a>
	    </div>
	 </div>
   </div>
   -->
   <!--分类结束-->