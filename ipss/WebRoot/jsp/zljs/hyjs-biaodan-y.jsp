<!DOCTYPE html>
<html>

<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<head>
<%@ include file="include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>表格检索【CNIPA】-<%=website_title%></title>
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


<%
String strItemGrant = "";
if(request.getSession().getAttribute("strItemGrant")!=null)
	strItemGrant = (String) request.getSession().getAttribute("strItemGrant");
	
//System.out.println("strItemGrant:"+strItemGrant);
String hangyeID = (String)session.getAttribute("hangye");
hangyeID = request.getSession().getAttribute("hangye")==null?"":(String)request.getSession().getAttribute("hangye");
%>

</head>

<body>

<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>
<%
//out.println("path="+path);
//out.println("basePath="+basePath);
%>

<% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>                   
                      <% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
<script type='text/javascript' src="<%=basePath %>semanjs/maxlength.js"></script>
<%}}
 %>
<script type="text/javascript">
function channelChecked_sx(obj){
    var o = document.all[obj.name];   
    for(var i=0; i<o.length; i++){
         if(o[i] == obj){
              obj.checked = true;   
         }else{
              o[i].checked = false;   
         }
    }
    
    <% if(SetupAccess.getProperty(SetupConstant.QUANWENSEARCH )!=null && SetupAccess.getProperty(SetupConstant.QUANWENSEARCH).equals("1")){%>
    <% if(strItemGrant.contains(SetupConstant.QUANWENSEARCH)){%>
    document.getElementById("txtR").disabled = true;
    document.getElementById("txtR").style.background='#CCCCCC';
      document.getElementById("txtT").disabled = true;
    document.getElementById("txtT").style.background='#CCCCCC';
    <%}}%>
      <% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>
   		 <% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
    document.getElementById("txtS").disabled = true;
    document.getElementById("txtS").style.background='#CCCCCC';
    document.getElementById("sss").disabled = true;
    <%}}%>
}



function channelChecked_yx(obj){
    var o = document.all[obj.name];   
    for(var i=0; i<o.length; i++){   
         if(o[i] == obj){   
              obj.checked = true;   
         }else{   
              o[i].checked = false;   
         }   
    }
    
    <% if(SetupAccess.getProperty(SetupConstant.QUANWENSEARCH )!=null && SetupAccess.getProperty(SetupConstant.QUANWENSEARCH).equals("1")){%>
    <% if(strItemGrant.contains(SetupConstant.QUANWENSEARCH)){%>
    document.getElementById("txtR").disabled = true;
    document.getElementById("txtR").style.background='#CCCCCC';
    document.getElementById("txtT").disabled = true;
    document.getElementById("txtT").style.background='#CCCCCC';
    <%}}%>
      <% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>
   		 <% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
    document.getElementById("txtS").disabled = true;
    document.getElementById("txtS").style.background='#CCCCCC';
    document.getElementById("sss").disabled = true;
    <%}}%>
}

function channelChecked(){

<% if(SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH)!=null && SetupAccess.getProperty(SetupConstant.SHIXIAOSEARCH).equals("1")){%>
 <% if(strItemGrant.contains(SetupConstant.SHIXIAOSEARCH)){%>
	document.getElementById("sxChannel").checked = false;
<%} }%>

<% if(SetupAccess.getProperty(SetupConstant.EFFECTLIB)!=null && SetupAccess.getProperty(SetupConstant.EFFECTLIB).equals("1")){%>
 <% if(strItemGrant.contains(SetupConstant.EFFECTLIB)){%>
	document.getElementById("yxChannel").checked = false;
<%} }%>

   <% if(SetupAccess.getProperty(SetupConstant.QUANWENSEARCH)!=null && SetupAccess.getProperty(SetupConstant.QUANWENSEARCH).equals("1")){%>
	 <% if(strItemGrant.contains(SetupConstant.QUANWENSEARCH)){%>
	document.getElementById("txtR").disabled = false;
	document.getElementById("txtR").style.background='#ffffff';
	document.getElementById("txtT").disabled = false;
    document.getElementById("txtT").style.background='#ffffff';
	 <%}}%>
	  <% if(SetupAccess.getProperty(SetupConstant.YUYISEARCH)!=null && SetupAccess.getProperty(SetupConstant.YUYISEARCH).equals("1")){%>
		<% if(strItemGrant.contains(SetupConstant.YUYISEARCH)){%>
	document.getElementById("txtS").disabled = false; 
	document.getElementById("txtS").style.background='#ffffff';
	document.getElementById("sss").disabled = false; 
	<%}} %>
}

function getCopeCode() {
	<% String corpcordAppURL = DataAccess.getProperty("corpcordAppURL"); %>
	window.open('<%=corpcordAppURL%>','b','');
}

function picQuery() {
	var picwin = window.open("<%=basePath %>search/ipc.do","pic","width=836,height=800,scrollbars=yes,resizable=yes,location=no,menubar=no,titlebar=no,toolbar=no,status=no,z-look=yes");
	picwin.focus();
}

function sicQuery() {
	var sicwin = window.open("<%=basePath %>search/ipc.do","sic","width=836,height=800,scrollbars=yes,resizable=yes,location=no,menubar=no,titlebar=no,toolbar=no,status=no,z-look=yes");
	sicwin.focus();
}
	
function submitDataToSearch(){	   
   if(strdbValid()){
	   if(validLogicInput()){
		   document.searchForm.action="<%=basePath %>pretoJsonOverView.do?area=cn";
	   }
   }
}
</script>
<!--
<link href="<%=basePath %>semancss/jquery.autocomplete.css" rel="stylesheet" type="text/css">
<link type="text/css" href="<%=basePath %>semanjs/themes/ui-lightness/ui.all.css" rel="stylesheet" />
 智能检索结束 -->


<%@ include file="include-head-secondsearch.jsp"%>

<%
String type = "cnbiaodan";
%>
<%@ include file="include-head-jiansuo.jsp"%>

<div style="width:1120px;margin: auto;">
<div style="height:15px;"></div>
<div style="margin: auto;"><font style="font-size:14px;font-weight: bold;color:#666;padding-left:8px;">表格检索【CNIPA】</font></div>
<form class="form-horizontal" id="searchForm" name="searchForm" method="post" target="_self">
			<input type="hidden" id="area" name="area" value="cn">
			<input type="hidden" id="channelid" name="channelid">
			<input type="hidden" id="synonymous" name="synonymous" value="0">
			<input type="hidden" id="presearchword" name="presearchword" value="<%=request.getAttribute("presearchword") %>">
			<input type="hidden" id="strWhere" name="strWhere">			
			<input type="hidden" id="strSynonymous" name="strSynonymous" value="1">
			<input type="hidden" id="strSortMethod" name="strSortMethod" value="RELEVANCE">
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要">
			<input type="hidden" name="strStat" value="">
			<input type="hidden" name="iHitPointType" value="115">
			
			<input type="hidden" id="savesearchword" name="savesearchword" value="ON">
			
			<input type="hidden" id="strChannels" name="strChannels">
			
			<input type="hidden" id="strSources" name="strSources">
		    <input type="hidden" id="searchKind" name="searchKind" value="tableSearch">
			<input type="hidden" id="bContinue" name="bContinue" value="">
			<input type="hidden" id="trsLastWhere" name="trsLastWhere" value="<%=request.getAttribute("trsLastWhere") %>">
			<input type="hidden" id="iOption" name="iOption" value="0">

<!--国别选择结束-->
	





<!-- <tr> 
                <td height="35" height="28" bgcolor="C7E1F7" class="gray" width="74%">&nbsp;
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
								<input type="checkbox" name="synonymous" value="1" id="c3"
									style="cursor:hand">
								<label for="c3" style="cursor:hand">
									同义词检索
								</label>
								
								<input type="checkbox" name="savesearchword" value="ON" id="c4"
									style="cursor:hand">
								<label for="c4" style="cursor:hand">
									保存检索表达式
								</label>
								<% if(SetupAccess.getProperty(SetupConstant.ZICISEARCH)!=null && SetupAccess.getProperty(SetupConstant.ZICISEARCH).equals("1")){%>
								<select size="1" name="iOption" id="iOption" class="gray">>
									<option value="2" <% if (request.getAttribute("cizi") == null || request.getAttribute("cizi").equals("2")) {%> selected <%} %> >
										按字检索
									</option>
									<option value="0" <% if (request.getAttribute("cizi") != null && request.getAttribute("cizi").equals("0")) {%> selected <%} %>>
										按词检索
									</option>
								</select>
								<%} %>
								<span>
								
								<% if(SetupAccess.getProperty(SetupConstant.ORDEROPEN)!=null && SetupAccess.getProperty(SetupConstant.ORDEROPEN).equals("1")){%> 
								&nbsp;&nbsp;排序： 
								<select  name="sortcolumn" id="sortcolumn" style="width:100px" class="gray">>
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
									<option value="颁证日">颁证日</option>
									<option value="名称">
										名称
									</option>
									<option value="主分类号">
										主分类号
									</option>
									<option value="RELEVANCE" selected>
										相关性
									</option>
								</select><select name="R1" id="R1" class="gray">>
									<option value="">
										降序
									</option>
									<option value="+">
										升序
									</option>
								</select>
								
								<%} %>
  </span>
</td>
              </tr> -->


<!--表格检索-->
<style type="text/css">
input[type=text]{width:165px;height:18px;}
</style>

<%@ include file="include-biaodan-y.jsp"%>
            
       
			<!--表格检索结束-->
			<!--逻辑框-->
			<div class="row-fluid">
			<div class="span7 column ui-sortable">	
<!-- 
														
								<div style="height:40px">
									<span class="muted">逻 辑 框</span>
								</div>
								<div class="row-fluid">
									<span class="span2"></span>
									<textarea class="span10" rows="8" id="txtComb" name="txtComb"></textarea>
								</div>								
							
							 -->
							 </div>
							<div class="span5">
								<div class="text-center">      
                                     <button class="btn btn-warning" id="subBtn" name=submit1  onClick="javascript:submitDataToSearch();">
										<i class="icon-search icon-white"></i>&nbsp;检 索</button>
									</a> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
										<button class="btn btn-success" type="reset" value="" name=cler1>
										<i class="icon-search icon-white"></i>&nbsp;清 除</button>
										
								</div>
							</div>
						</div>
						<!--逻辑框结束-->
</form>
</div>

                  
<%@ include file="include-buttom.jsp"%>


</BODY>
</HTML>
<Script language="JavaScript"> 
var obj = document.searchForm.txtComb;
var vCountry = "1";
</Script>


<script language="javascript" type="text/javascript">
function click_a(divDisplay)
{
	if(document.getElementById(divDisplay).style.display != "block")
	{
		document.getElementById(divDisplay).style.display = "block";
	}
	else
	{
		document.getElementById(divDisplay).style.display = "none";
	}
}
</script>

<script type="text/javascript">
    jQuery(function(){

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

    function _submitDataToSearch(){
	   if(strdbValid()){
		   if(validLogicInput()){
			   document.searchForm.action="<%=basePath%>overviewSearch.do?area=cn";
		   }
	   }
	}

    /*
    function showExtExp(historyId){
    	$('#currentExp').html($('#'+historyId).val());
    	$('#showExpModel').modal('show');
    }
    */
	function strdbValid(){
//		var checkedLength=0;
		var strChannels = "";
		 $("input[name='strdb']").each(function(){
			if($(this).attr("checked")){
//				alert($(this).val());
//				checkedLength++;
				if(strChannels!=""){
					strChannels += ",";
				}
				strChannels += $(this).val();
			}
		});
		
//		alert("strChannels="+strChannels);
		
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
    	var searchCond="";
    	
    	var fieldShortName=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V"];
//    	var txtComb=" " + document.searchForm.txtComb.value + " ";
    		
    	var combinedTxt="";
//    	txtComb = $.trim(txtComb);

//    	alert(txtComb);
/*
    	if(txtComb!=""){
    		searchCond=txtComb;
    	}else
*/
    	{
    		$(fieldShortName).each(function(){
    			var idFlag="#txt_"+this;    			
    			var param=jQuery.trim($(idFlag).val());
    			
    			if(param!=''){
    				if(searchCond==''){
    					/*
    					if(this=='S'){
    						searchCond+=$(idFlag).attr("field")+"="+parseSemanticExp();
    					}else
    					*/
    					{
    						if($(idFlag).attr("field")=='申请号'||$(idFlag).attr("field")=='公开（公告）号'){
    							/*
    							if($(idFlag).val()==="%"){
    								searchCond+=$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
    							}else{
	    							if($(idFlag).val().toLowerCase().indexOf('cn')==0){
	    								searchCond+=$(idFlag).attr("field")+"=("+$(idFlag).val()+")";
	    							}else{
	    								searchCond+=$(idFlag).attr("field")+"=(CN"+$(idFlag).val()+")";
	    							}
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
    					/*
    					if(this=='S'){
    						searchCond+=" and "+ $(idFlag).attr("field")+"=("+parseSemanticExp()+")";
    					}else
    					*/
    					{
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
//    	alert("searchCond="+searchCond);
    	if(searchCond==''){//如果检索条件为空,返回错误
    		alert("请输入检索表达式");
    		return false;
    	}else{
    		//是否进行了二次检索
    		/*
    		if(secondSearch()){
    			$("#searchForm #strWhere").attr("value","("+searchCond+") and ("+$("#searchForm #presearchword").val()+")"); 
    			$("#searchForm #bContinue").attr("value", "1");
    			return true;
    		}if(filterSearch()){
    			$("#searchForm #strWhere").attr("value","("+searchCond+") not ("+$("#presearchword").val()+")");
    			$("#searchForm #strWhere").attr("value"," ("+$("#searchForm #presearchword").val()+") not ("+searchCond+")");
    			return true;
    		} else {
    			strWhere=searchCond;
    		}
    		*/
//    		$("#searchForm #strWhere").attr("value",searchCond);
    		    		
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
    		
//    		alert("left_bracket="+left_bracket);
//    		alert("right_bracket="+right_bracket);
//    		alert(left_bracket!=right_bracket);
    		
    		if(left_bracket!=right_bracket){
    			alert("您输入的表达式左右括号不匹配，请重新输入");
    			return false;
    		}else{    		
	    		$("#searchForm #strWhere").val(searchCond);
	    		return true;
    		}
    	}
    }
</script>

