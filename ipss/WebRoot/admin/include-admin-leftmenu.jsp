        <div class="span2" >
          <div class="well sidebar-nav">
            <div class="panel-group" id="accordion">
<%if(intAdministerState!=null&&intAdministerState.equals(1)){%>         
  <div class="panel panel-default">
    <div class="panel-heading">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"><strong>管理选项</strong></a>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse in">
      <ul class="nav nav-pills nav-stacked">
		<li><a href="<%=basePath%>getUserList.do" <%if(menuname.equals("usermanage")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>用户管理</a></li>
		
		<%if(username!=null&&username.equals("admin")){%><li><a href="<%=basePath%>getAdminList.do" <%if(menuname.equals("adminmanage")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>管理员管理</a></li><%}%>
		
		<li><a href="<%=basePath%>hangyemanage.do" <%if(menuname.equals("hangye")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>专题库管理</a></li>
		
		<%if(username!=null&&username.equals("admin")){%><li><a href="<%=basePath%>statmanage.do" <%if(menuname.equals("statmanage")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>统计管理</a></li><%}%>
		<!-- 
		<li><a href="#" <%if(menuname.equals("datascope")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>数据范围</a></li>
		-->
	  </ul>
    </div>
  </div>
<%}%>
 <div class="panel panel-default">
    <div class="panel-heading">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><strong>我的账户</strong></a>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <ul class="nav nav-pills nav-stacked">
      
      <%if(SetupAccess.getProperty(SetupConstant.DINGQIYUJING)!=null && SetupAccess.getProperty(SetupConstant.DINGQIYUJING).equals("1")){ %>
              <li><a href="<%=basePath%>getMyWarm.do" <%if(menuname.equals("simplewarn")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>我的预警</a></li>
      <%}%>
        <!--  
        <li><a href="<%=basePath%>getFavorite.do?method=getFavorite" <%if(menuname.equals("favorite")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>我的收藏夹</a></li>
		-->
		<!--
		<%if(username!=null&&!username.equals("guest")){%><li><a href="<%=basePath%>passwdchange.do" <%if(menuname.equals("passwdchange")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>修改密码</a></li><%}%>
		<li><a href="<%=basePath %>changeInfoPage.do">修改信息</a></li>
		<li><a href="<%=basePath%>getUserStatus.do" <%if(menuname.equals("userstatus")){%>style="background-image:none;color:#ffffff;background-color:#66ccff;"<%}%>>用户状态</a></li>
		-->
	  </ul>
    </div>
  </div>
  <!-- 
  <div class="panel panel-default">
    <div class="panel-heading">
        <a data-toggle="collapse" data-parent="#accordion" href="#"><strong>专题库管理</strong></a>
    </div>
  </div> 
  <div class="panel panel-default">
    <div class="panel-heading">
        <a data-toggle="collapse" data-parent="#accordion" href="#"><strong>我的收藏夹</strong></a>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
        <a data-toggle="collapse" data-parent="#accordion" href="#"><strong>我的预警</strong></a>
    </div>
  </div>
    -->
  
</div>
          </div><!--/.well -->
        </div><!--/span-->