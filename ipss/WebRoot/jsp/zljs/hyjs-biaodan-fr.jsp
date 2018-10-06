<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="com.cnipr.cniprgz.commons.*"%>

<%@ taglib prefix="s" uri="/struts-tags"%>

<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
%>
<html>
<head>
<%@ include file="include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>表格检索【港澳台及国外】-<%=website_title%></title>
	<meta name="keywords" content="专利检索,专利查询,专利搜索,专利下载" />
	<meta name="description" content="<%=website_title%>是-支持专利号查询搜索，Ipc查询专利、实用新型专利和外观专利，支持专利检索，批量下载" />
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />
	<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-ie6.min.css">
    <link rel="stylesheet" type="text/css" href="css/ie.css">
    <![endif]-->
</head>
<body>
<!--导航-->

<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>

<%@ include file="include-head-secondsearch.jsp"%>


<%String type = "frbiaodan";%>
<%@ include file="include-head-jiansuo.jsp"%>


<div style="width:1120px;margin:auto;">
<!-- 
<form class="form-horizontal" id="searchForm" name="searchForm" action="<%=basePath%>overviewSearch.do?area=fr&method=overviewSearch" method="post" target="_self">
-->
<div style="height:15px;"></div>
<div style="margin:auto;"><font style="font-size:14px;font-weight: bold;color:#666;padding-left:8px;">表格检索【港澳台及国外】</font></div>
<form class="form-horizontal" id="searchForm" name="searchForm"
			method="post" target="_self">
			<input type="hidden" id="area" name="area" value="fr">
			<input type="hidden" id="presearchword" name="presearchword" value="<%=request.getAttribute("presearchword") %>">
			<input type="hidden" id="strWhere" name="strWhere">
			<input type="hidden" name="strSortMethod" id="strSortMethod" value="RELEVANCE">
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要">
			<input type="hidden" name="strStat" value="">
			<input type="hidden" name="iHitPointType" value="115">
			<input type="hidden" id="bContinue" name="bContinue" value="">
			
			<input type="hidden" id="strChannels" name="strChannels">
			<input type="hidden" id="strSources" name="strSources">			
			
			<input type="hidden" id="searchKind" name="searchKind" value="tableSearch">

			<input type="hidden" id="savesearchword" name="savesearchword" value="ON">


<ol class="inline text-warning"></ol>

<input type="hidden" value="" name="channelid">
<input type="hidden" name="searchChannel" value=""> 



<!--  
 <br/>
<input name="btnSelect" selectStat="Y" id="selectBtn" type="button" alt="取消" style="cursor:hand; background:url(img/button_cancle.gif);width:50;height:21;border-width:0" onclick="Select(document.loginform,'strdb');">


<input type="checkbox" value="ON" name="secondsearch"
								<% if (request.getAttribute("secondOrFilter") == null || !request.getAttribute("secondOrFilter").equals("secondsearch")) {%> disabled <%} else if(request.getAttribute("secondOrFilter").equals("secondsearch")) {%> onClick="document.loginform.filtersearch.checked=false" checked <%} %>
									id="c1" style="cursor:hand">
								<label for="c1" style="cursor:hand">
									二次检索
								</label>
								
								<input type="checkbox" name="filtersearch" value="ON"
								<% if (request.getAttribute("secondOrFilter") == null || request.getAttribute("secondOrFilter").equals("secondsearch")) {%> disabled <%} else if(request.getAttribute("secondOrFilter").equals("filtersearch")) {%> onclick="document.loginform.secondsearch.checked=false" checked <%} %>
									id="c2" style="cursor:hand">
								<label for="c2" style="cursor:hand">
									过滤检索
								</label>
								
								<input type="checkbox" name="savesearchword" value="ON" id="c4"
									style="cursor:hand">
								<label for="c4" style="cursor:hand">
									保存检索表达式
								</label>
								
								      <% if(SetupAccess.getProperty(SetupConstant.CROSSLANGUAGE )!=null && SetupAccess.getProperty(SetupConstant.CROSSLANGUAGE).equals("1")){%>
								 <% if(strItemGrant.contains(SetupConstant.CROSSLANGUAGE)){%>
								<input type="checkbox" name="crossLanguage" value="ON" id="c5"
									style="cursor:hand">
								<label for="c5" style="cursor:hand">
									跨语言检索
								</label>
								<%} }%>
										<% if(SetupAccess.getProperty(SetupConstant.ORDEROPEN)!=null && SetupAccess.getProperty(SetupConstant.ORDEROPEN).equals("1")){%> 
<span>
&nbsp;&nbsp;排序： 
								<select  name="sortcolumn" id="sortcolumn" style="width:100px" class="gray">
									<option value="公开（公告）日">
										公开（公告）日
									</option>
									<option value="公开（公告）号">
										公开（公告）号
									</option>
									<option value="申请日">
										申请日
									</option>
									<option value="申请号">
										申请（专利）号
									</option>
									
									<option value="名称">
										名称
									</option>
									<option value="主分类号">
										主分类号
									</option>
									<option value="RELEVANCE" selected>
										相关性
									</option>
								</select>
								
								<select name="R1" class="gray">
									<option value="">
										降序
									</option>
									<option value="+">
										升序
									</option>
								</select>
  </span>
  <%} %>
-->

<%@ include file="include-fr-channel.jsp"%>
<%@ include file="include-biaodan-fr.jsp"%>

			<!--表格检索结束-->
			<!--逻辑框-->
			<div class="row-fluid">
			<div class="span7 column ui-sortable">
<!-- 
							
								
								<div style="height:40px">
									<span class="muted">逻辑框</span>
								</div>
								<div class="row-fluid">
									<span class="span2"></span>
									<textarea class="span10" rows="8" id="txtComb" name="txtComb"></textarea>
								</div>
							
 -->
                               </div>
							<div class="span5">
								<div class="text-center">
								<!-- 
									<a name="searchBtn" class="btn btn-warning" href="javascript:submitDataToSearch();"><i
										class="icon-search icon-white"></i>&nbsp;检 索</a> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
								 -->
									<button class="btn btn-warning" id="subBtn" name=submit1 onClick="javascript:submitDataToSearch();">
										<i class="icon-search icon-white"></i>&nbsp;检 索</button>
									<button class="btn btn-success" type=reset value='' name=cler1>
										<i class="icon-search icon-white"></i>&nbsp;清 除</button>
								</div>
							</div>
						</div>
						<!--逻辑框结束-->



</form>

<%@ include file="include-buttom.jsp"%>

</BODY>
</HTML>
<Script language="JavaScript"> 
//var obj = document.searchForm.txtComb;
var vCountry = "1";
</Script>


<script type="text/javascript">
    jQuery(function(){
    	/*
        $(document).keydown(function(event){
            if(event.keyCode==13){
				submitDataToSearch();
            }
        });
    	*/
        $('#selectAll').change(function(){
        	if(this.checked){
        		$('input[name="channelId"]').attr({'checked':true});
        	}else{
        		$('input[name="channelId"]').attr({'checked':false});
        	}
        });
        $('#inverSelect').change(function(){
        	if(this.checked){
        		$('input[name="channelId"]').each(function(){
        			if(this.checked){
        				$(this).attr({'checked':false});
        			}else{
        				$(this).attr({'checked':true});
        			}
        		})
        	}else{
        		$('input[name="channelId"]').each(function(){
        			if(this.checked){
        				$(this).attr({'checked':false});
        			}else{
        				$(this).attr({'checked':true});
        			}
        		})
        	}
        });
    });
    $(function(){
    	 //获得用户的历史表达式
        getHistoryExp();
    });
    function getHistoryExp(){
    	$.ajax({
      		type: "POST",
      		url: ctx+"/search/json/getUserHistoryExp",
      		success: function(data){
      	  		if(data.rCode == "100000"){
      	  			var tempText= "";
      	  			$(data.data.result).each(function(i){
      	  				var tempValue = this.trsExp;
      	  				if(tempValue.length >10){
      	  					tempValue = tempValue.substring(0,7)+"...";
      	  				}
      	  				tempText += '<li><a href="javascript:showExtExp(\''+(i+"history")+'\');" title='+this.trsExp+' >'+tempValue+'</a></li>'
      	  				+'<input type="hidden" value=\"'+this.trsExp+'\" id=\"'+(i+"history")+'\">';
      	  			});
	  				$('#historyExp').html(tempText);
      	  		}
      		}
      	});
    }

    function submitDataToSearch1(){	   
 	   if(strdbValid()){
 		   if(validLogicInput()){
 			   document.searchForm.action="<%=basePath%>overviewSearch.do?area=fr";
 		   }
 	   }
 	}
    
    function submitDataToSearch(){	   
       if(strdbValid()){
    	   if(validLogicInput()){
    		   document.searchForm.action="<%=basePath %>pretoJsonOverView.do?area=fr";
    	   }
       }
    }

	function strdbValid(){
//		var strChannels = $('#searchForm #strChannels').val();
		var strChannels = "";
//		alert("strChannels1=" + strChannels);
		
		 $("input[name='strdb']").each(function(){
			if($(this).attr("checked")){
//				checkedLength++;
				if(strChannels!=""){
					strChannels += ",";
				}
				strChannels += $(this).val();
			}
		});

//alert("strChannels=" + strChannels);
		 
		if(strChannels==""){
			alert("请选择检索库");
			return false;
		}else{
			$('#searchForm #strChannels').val(strChannels);
			$('#searchForm #strSources').val(strChannels);			
			return true;
		}
	}
    /**
    *
    *解析表达式
    *
    **/
    function validLogicInput(){
//    alert("validLogicInput..");    	
    	var searchCond="";
    	
    	var fieldShortName=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V"];
//    	var txtComb=" " + document.searchForm.txtComb.value + " ";
    		
//    	var combinedTxt="";
//    	txtComb = $.trim(txtComb);

//    	alert(txtComb);
/*
    	if(txtComb!=""){
    		searchCond=txtComb;
    	}else
    	*/
    	{
//    		alert("1111......"+fieldShortName);
    		$(fieldShortName).each(function(){
    			var idFlag="#txt_"+this;
//alert("idFlag="+idFlag);    			
    			var param=jQuery.trim($(idFlag).val());    			
//alert("param="+param);    			
    			if(param!=''){
    				if(searchCond==''){
    					if(this=='S'){
    						searchCond+=$(idFlag).attr("field")+"="+parseSemanticExp();
    					}else{
    						if($(idFlag).attr("field")=='申请号'||$(idFlag).attr("field")=='公开（公告）号'){
								/*
    							if($(idFlag).val().toLowerCase().indexOf('cn')==0){
    								searchCond+=$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=$(idFlag).attr("field")+"=(CN"+$(idFlag).val()+")";
    							}
    							*/
    							searchCond+=$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    						}else{ 
    							if($(idFlag).attr("field")=='anFR'){
    								searchCond+="an=("+$(idFlag).val()+")";
    							}else if($(idFlag).attr("field")=='pnFR'){
    								searchCond+="pn=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}
    						}
    					}
    				}else{
    					if(this=='S'){
    						searchCond+=" and "+ $(idFlag).attr("field")+"=("+parseSemanticExp()+")";
    					}else{
    						if($(idFlag).attr("field")=='申请号'||$(idFlag).attr("field")=='公开（公告）号'){
    							if($(idFlag).val().toLowerCase().indexOf('cn')==0){
    								searchCond+=" and "+$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=" and "+$(idFlag).attr("field")+"=(CN"+$(idFlag).val()+")";
    							}
    						}else{
    							if($(idFlag).attr("field")=='anFR'){
    								searchCond+=" and an=("+$(idFlag).val()+")";
    							}else if($(idFlag).attr("field")=='pnFR'){
    								searchCond+=" and pn=("+$(idFlag).val()+")";
    							}else{
    								searchCond+=" and "+$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}
    						}
    					}
    				}
    			}
    		});    		
//    		alert("searchCond="+searchCond);		
//    		searchCond==''?alert("请输入检索条件"):"";
    	}
    	
    	if(searchCond==''){//如果检索条件为空,返回错误
    		alert("请输入检索表达式");
    		return false;
    	}else{
    		var left_bracket=0;
    		var right_bracket=0;
    		
    		for(i=0;i<searchCond.length;i++){
//    			 alert(str.charAt(i));
				var _char = searchCond.charAt(i);
    			if(_char==='('||_char==='（')
    			{
    				left_bracket++;
    			}
    			if(_char===')'||_char==='）')
    			{
    				right_bracket++;
    			}    			 
    		}
    		
    		if(left_bracket!=right_bracket){
    			alert("您输入的表达式左右括号不匹配，请重新输入");
    			return false;
    		}else{
	    		$("#searchForm #strWhere").val(searchCond);
	    		return true;
    		}
    	}
    }
    
    function showExtExp(historyId){
    	$('#currentExp').html($('#'+historyId).val());
    	$('#showExpModel').modal('show');
    }
</script>

