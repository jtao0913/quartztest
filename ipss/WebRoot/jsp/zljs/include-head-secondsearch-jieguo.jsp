<%@ page language="java" pageEncoding="UTF-8"%>

<%
//String area = request.getParameter("area")==null?(String)request.getAttribute("area"):request.getParameter("area");
//area = area==null?"cn":area;
%>
<!--二次检索模块开始-->
<script type="text/javascript">
function expressSearch(){
//alert("111");	
	var content = $('#content').val();
	var colname = $('#colname').val();

//alert(colname+content);

var searchOption = $('#searchOption').val();
//var trsLastWhere = "(" + $('#trsLastWhere').val() + ")";
var trsLastWhere = "(" + $('#selectexp').val() + ")";

//alert(trsLastWhere);

	if(content!=null && content!=""){
//		var colname = $('#colname').val();
//		alert(colname);
		var _where = "("+colname+content+")";
		if(searchOption=='D_AND'){
			_where = _where + ' and ' + trsLastWhere;
		}
		if(searchOption=='O_NOT'){
//			_where = _where + ' not ' + trsLastWhere;
			_where = trsLastWhere + ' not ' + _where;
		}
		
		document.searchForm.strWhere.value=_where;
		//$("#searchForm").action = ${ctx}+"/expressway.do?quickSearch=1&pageType=all&quickSearchEncode=UTF8";
		$("#searchForm").submit();
	}else{
		return false;
	}

}
</script>
		<!--二次检索模块-->
		<div style="width:1120px;height：80px;margin: 0 auto;">
			<div class="row-fluid" style="margin: 0 auto;">
			
<%if(areacode!=null&&areacode.equals("041")&&!hangye.equals("")){%>
				<div class="span12 column ui-sortable" style="margin-top:-5px;">
					<a href="#" style="text-decoration: none;"><img  src="client/neimeng/images/hangye/<%=hangye%>.png"></a>
				</div>
				<div style="height:8px;"></div>
<%}else{%>

				<div class="span3 column ui-sortable" style="margin-top:-5px;">
					<a href="index.jsp" style="text-decoration: none;"><img style="width:236px" src="images/area/<%=com.cnipr.cniprgz.commons.Log74Access.get("log74.areacode")%>/common/com_2/img/index/s_logo.png"></a>
				</div>
				<div class="span9 column ui-sortable">
					<div style="padding-top:0px">
						
							<div class="input-prepend input-append">
								<div class="btn-group">
									<select id="colname" name="colname" class="input-medium">
										<option value="申请号=">申请号</option>
										<option value="公开（公告）号=">公开（公告）号</option>
										<option value="名称=">名称</option>
										<option value="摘要=">摘要</option>
										<option value="权利要求书=">权利要求书</option>
										<option value="公开（公告）日=">公开（公告）日</option>
										<option value="分类号=">分类号</option>
										<option value="申请日=">申请日</option>
										<option value="发明（设计）人=">发明（设计）人</option>
										<option value="申请（专利权）人=">申请（专利权）人</option>
										<option value="专利代理机构=">专利代理机构</option>
										<option value="代理人=">代理人</option>
										<option value="地址=">地址</option>
										<option value="国省代码=">国省代码</option>
										<option value="最新法律状态=">最新法律状态</option>
									</select>

			<input type="hidden" name="area" id="area"/>			
			<input type="hidden" name="quickSearch" value="1" id="quickSearch"/>
			<input type="hidden" name="presearchword" value="" id="presearchword"/>
			<input type="hidden" name="strChannels" value="14,15,16" id="expressway_strChannels"/>
			
			<input type="hidden" name="strSortMethod" value="RELEVANCE" id="strSortMethod"/>
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要" id="expressway_strDefautCols"/>
			<input type="hidden" name="strStat" value="" id="expressway_strStat"/>
			<input type="hidden" name="iHitPointType" value="115" id="expressway_iHitPointType"/>
		    <input type="hidden" name="searchKind" value="tableSearch" id="searchKind"/>
			<input type="hidden" name="bContinue" value="" id="bContinue"/>
			<input type="hidden" name="trsLastWhere" value="" id="trsLastWhere"/>
			<input type="hidden" name="channelid" value="" id="expressway_channelid"/>
			<input type="hidden" name="strWhere" id="strWhere"/>


								</div>
								<input class="input-xlarge" style="width:220px;" type="text" id="content" name="content" value='' onkeydown="if(event.keyCode==13){expressSearch();}">
								<div class="btn-group">
									<button class="btn btn-warning" type="button" onclick="expressSearch();">
										<i class="icon-search icon-white"></i>&nbsp;检 索</button>
								</div>
								<div class="btn-group">
									<select id="searchOption" name="searchOption" class="input-small" style="width:95px;">
										<option value="D_AND">二次检索</option>
										<option value="">重新检索</option>
										<option value="O_NOT">过滤检索</option>
									</select>
								</div>
							</div>
							<span class="help-inline">&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:showexp($('#selectexp').val())">查看表达式</a></span>
					</div>
				</div>
					 <%}%>
			</div>
		</div>