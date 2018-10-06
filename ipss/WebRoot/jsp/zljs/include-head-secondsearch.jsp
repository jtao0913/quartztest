<%@ page language="java" pageEncoding="UTF-8"%>

<%
//String area = request.getParameter("area")==null?(String)request.getAttribute("area"):request.getParameter("area");
//area = area == null?"cn":area;
//String area = request.getParameter("area")==null?"cn":request.getParameter("area");
//String area = "cn";
%>
<!--二次检索模块开始-->
<script type="text/javascript">
function expressSearch(){
	var content = $('#expressSearchForm #content').val();
	var colname = $('#expressSearchForm #colname').val();
//alert(colname+content);

	if(content!=null && content!=""){
//		var colname = $('#colname').val();
//		alert(colname);
		
//		alert(document.searchForm.strSources.value);
//		alert(document.searchForm.area.value);

//		alert($("#searchForm #area").val());
		
//		$("#expressSearchForm #strChannels").val(document.searchForm.strSources.value);

//$("#strWhere").attr("value",colname+"("+$.trim(content).replace(/\s+/g, " or ")+")");

		$("#expressSearchForm #area").val($("#searchForm #area").val());
		$("#expressSearchForm #strWhere").val(colname+"("+$.trim(content).replace(/\s+/g, " and ")+")");
		$("#expressSearchForm").attr("action", "<%=basePath%>expressSearch.do?quickSearch=1&pageType=all&quickSearchEncode=UTF8");
		$("#expressSearchForm").submit();
	}else{
		return false;
	}
}

jQuery(function(){
    $(document).keydown(function(event){
        if(event.keyCode==13){
//        	alert('sss');
			var focused = document.activeElement;
//			alert(focused.id);
			if(focused.id==='content'){
				expressSearch();
			}else{
				submitDataToSearch();
			}
/*
        	$("#expsearchbtn").focus(function(){
        		expressSearch();
        	});        	
*/
        }
    });
});

</script>
		<div style="width:1120px;height：80px;margin: 0 auto;">
			<div class="row-fluid">
			<%if(areacode!=null&&areacode.equals("041")&&!hangye.equals("")){%>
				<div class="span12" style="margin-top:5px;">
					<img style="width:875px;height:70px" src="client/neimeng/images/hangye/<%=hangye%>.png">
				</div>
			<%}else{%>
			
				<div class="span3" style="margin-top:5px;">
					<a href="index.jsp" style="text-decoration: none;"><img style="width:236px" src="images/area/<%= com.cnipr.cniprgz.commons.Log74Access.get("log74.areacode")%>/common/com_2/img/index/s_logo.png"></a>
				</div>
				<div class="span9">
				<div style="padding-top:10px">
		<!-- 
		<form class="form-inline" id="expressSearchForm" name="expressSearchForm" method="post" target="_self" >
			<input type="hidden" value="申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=" id="colname" name="colname"/>
			
			<input type="hidden" id="quickSearch" name="quickSearch" value="1"/>
			<input type="hidden" id="simpleSearch" name="simpleSearch" value="1"/>
			<input type="hidden" id="presearchword" name="presearchword" />
			<input type="hidden" id="strChannels" name="strChannels" value="" />
			<input type="hidden" id="area" name="area" value="" />
			<input type="hidden" id="savesearchword1" name="savesearchword1" value="ON">
			
			<input type="hidden" id="strSortMethod" name="strSortMethod" value="RELEVANCE"/>
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要"/>
			<input type="hidden" name="strStat" value=""/>
			<input type="hidden" name="iHitPointType" value="115"/>
		    <input type="hidden" id="searchKind" name="searchKind" value="tableSearch"/>
			<input type="hidden" id="bContinue" name="bContinue" value=""/>
			<input type="hidden" id="trsLastWhere" name="trsLastWhere" />
			<input type="hidden" name="channelid"/>
			<input type="hidden" id="strWhere" name="strWhere"/>
			
			
							<div class="input-prepend input-append">
								<input class="input-large" type="text" name="content" id="content" style="width:460px;height:20px;" placeholder="请输入申请号、名称、摘要等关键词">
								<div class="btn-group">
									<input id="expsearchbtn" class="btn btn-warning" type="button" onClick="expressSearch();" value="&nbsp;检 索"/>										
								</div>								
							</div>
		</form>
		 -->
		
		
					</div>
				</div>
				<%} %>
			</div>
		</div>
	<!--二次检索模块结束-->