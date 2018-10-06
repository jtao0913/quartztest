<%@ page language="java" pageEncoding="UTF-8"%>
<!-- 
<div style="margin-bottom:8px;"><a href="index.jsp" style="text-decoration: none;"><img style="width:236px" src="images/area/<%=com.cnipr.cniprgz.commons.Log74Access.get("log74.areacode")%>/common/com_2/img/index/s_logo.png"></a></div>
-->
<div class="well" style="height:22px;margin-top:0px;font-weight:bold;background-color: #3498db;border-color:#3498db;color:#eeeeee;padding:8px;font-size:13px;"><span id="resultfilter">结果筛选</span> <span style="margin-left:8px;"></span></div>

<div id="filter"></div>
<input id="filterexp" type="hidden"/>

<div class="panel-group" id="accordion">

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a alt="PATTYPE" data-toggle="collapse" data-parent="#accordion" 
				   href="#collapse1" style="display:block;font-size:14px; padding-left:8px; color: #fff; padding-top: 7.5px; padding-bottom: 7.5px; background-color: #bbb;margin-bottom:-8px;margin-top:-9px;">
					检索分类统计
				</a>
			</h4>
		</div>
		<div id="collapse1" class="panel-collapse collapse in" alt="PATTYPE">
			<div id="collapse_1" class="panel-body">
				加载中...
			</div>			 
			<div style="font-size:12px; padding-left: 18px; color: #666; padding-top: 4px; padding-bottom: 4px; background-color: #fff;margin-bottom: 1px;text-align: left;">
				<a class="btn btn-small" id="include" name="include" >筛 选</a>  <a class="btn btn-small" name="exclude">排 除</a>
			</div>			 
		</div>
	</div>
	<%if(area.equalsIgnoreCase("CN")){%>
	<div class="panel panel-default" id="leftflztdiv">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a alt="最新法律状态" data-toggle="collapse" data-parent="#accordion" 
				   href="#collapse2" style="display:block;font-size:14px; padding-left:8px; color: #fff; padding-top: 7.5px; padding-bottom: 7.5px; background-color: #bbb;margin-bottom:-8px;margin-top:-9px;">
					法律状态统计
				</a>
			</h4>
		</div>
		<div id="collapse2" class="panel-collapse collapse" alt="最新法律状态">
			<div id="collapse_2" class="panel-body">
				加载中...
			</div>			
			<div style="font-size:12px; padding-left: 18px; color: #666; padding-top: 4px; padding-bottom: 4px; background-color: #fff;margin-bottom: 1px;text-align: left;">
				<a class="btn btn-small" id="include" name="include" >筛 选</a>  <a class="btn btn-small" name="exclude">排 除</a>
			</div>			 
		</div>
	</div>
	<%}%>

<%
//检索分类,法律状态,
//String[] arrTitle="运营信息,申请人,第一申请人,发明人,公开年,申请年,IPC部,IPC大类,IPC小类,IPC大组,IPC分类号,专利代理机构分析,代理人分析,外观分类号,专利类型".split(",");
String[] arrTitle="运营信息,申请人,第一申请人,发明人,公开年,申请年,IPC小类,专利代理机构分析,代理人分析,外观分类号,专利类型".split(",");

if(area.equalsIgnoreCase("CN")){
	arrTitle="运营信息,申请人,第一申请人,发明人,公开年,申请年,IPC小类,外观分类号,专利代理机构分析,代理人分析,专利类型".split(",");
}else{
	arrTitle="运营信息,申请人,第一申请人,发明人,公开年,申请年,IPC小类,外观分类号".split(",");
}

for(int i=0;i<arrTitle.length;i++)
{
%>
	<div class="panel panel-default" <%if(!area.equalsIgnoreCase("CN")&&(arrTitle[i].equals("运营信息")||arrTitle[i].equals("专利类型"))){%>style="display:none"<%}%>>
		<div class="panel-heading">
			<h4 class="panel-title">
				<a alt="<%=arrTitle[i]%>" data-toggle="collapse" data-parent="#accordion" 
				   href="#collapse<%=i+3%>" style="display:block;font-size:14px; padding-left:8px; color: #fff; padding-top: 7.5px; padding-bottom: 7.5px; background-color: #bbb;margin-bottom:-8px;margin-top:-9px;">
					<%=arrTitle[i]%>统计
				</a>
			</h4>
		</div>
		<div id="collapse<%=i+3%>" class="panel-collapse collapse" alt="<%=arrTitle[i]%>">
			<div id="collapse_<%=i+3%>" class="panel-body">
				加载中...
			</div>
			 
			<div style="font-size:12px; padding-left: 18px; color: #666; padding-top: 4px; padding-bottom: 4px; background-color: #fff;margin-bottom: 1px;text-align: left;">
				<a class="btn btn-small" id="include" name="include" >筛 选</a>  <a class="btn btn-small" name="exclude">排 除</a>
			</div>
			
		</div>
	</div>
<%
}
%>


	
	
</div>

				
