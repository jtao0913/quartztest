<%@ page language="java" import="java.util.*, com.cnipr.cniprgz.entity.MenuInfo, com.cnipr.cniprgz.commons.DataAccess" pageEncoding="UTF-8"%>
<%@ page import="com.cnipr.cniprgz.commons.SetupAccess,com.cnipr.cniprgz.commons.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
%>
<% String tabno = "0";
  	String autosearch = "0";
  	
  	 if(request.getParameter("tabno")!=null && request.getParameter("tabno").equals("")==false)
  		 tabno = request.getParameter("tabno");
  	 
  	if(request.getAttribute("autosearch")!=null && request.getAttribute("autosearch").equals("")==false)
  		autosearch = (String)request.getAttribute("autosearch");
  	
  	//System.out.println("menu.jsp:autosearch="+autosearch);
  %>
<link href="<%=basePath%>common/com_2/css/bootstrap.min.css" rel="stylesheet"/>
<link href="<%=basePath%>common/com_2/css/main.css" rel="stylesheet"/>

<body>	
<!--导航-->
		<nav class="navbar navbar-default small" role="navigation">
			<div class="navbar navbar-inverse">
				<div class="navbar-bg-color">
					<div class="row-fluid">
						<div class="nav-collapse" style="overflow: visible;">
							<ul class="nav">
<% 
							List<MenuInfo> menuList =  (List<MenuInfo>)request.getAttribute("menuList");
							if (menuList != null && menuList.size() > 0) {							
								int i = 0;
								for (MenuInfo menuInfo : menuList) {
if(menuInfo.getIntParentID()==0){
	List<MenuInfo> subMenuList =  menuInfo.getChildMenu();
	if(subMenuList==null||subMenuList.size()==0){
%>
<li><a href="<%=menuInfo.getChrMenuURL()%>"><%=menuInfo.getChrMenuName()%></a></li>
<%
	}else{
%>	
<li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=menuInfo.getChrMenuName()%><b class="w_caret"></b></a>
<ul class="dropdown-menu">
<%for (MenuInfo subMenuInfo : subMenuList) {%>
<li><a href="<%=subMenuInfo.getChrMenuURL() %>" target="rightFrame"><%=subMenuInfo.getChrMenuName() %></a></li>
<%}%>
</ul>
</li>
<%
	}
}
}}
%>
</ul>
</div>
						

						
						<div id="UserDiv" class="pull-right">
							<ul class="nav">
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" >个人中心 <b class="w_caret" ></b></a>
									<ul class="dropdown-menu">
										<li><a href="#">账户信息</a></li>
										<li><a href="#">我的收藏</a></li>
										<li><a href="#">我的预警</a></li>
										<li class="divider"></li>
										<li class="nav-header">管理选项</li>
										<li><a href="#">用户管理</a></li>
										<li><a href="#">管理员管理</a></li>
										<li><a href="#">专题库导航管理</a></li>
									</ul>
								</li>
								<li><a href="#" data-toggle="modal" data-target="#myModal">登录</a></li>
								<li><a href="#" onclick="location.href='<%=basePath%>logoff.do?method=logoff&temp=';return false;" >退出</a></li>
								<li><a href="javascript:loginOut();">帮助中心</a></li>
								<li><a href="javascript:loginOut();">意见反馈</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</nav>
		</body>
		
<script src="<%=basePath%>common/com_2/js/jquery-1.12.0.min.js"></script>
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script src="<%=basePath%>common/com_2/js/jquery.leanModal.min.js"></script>