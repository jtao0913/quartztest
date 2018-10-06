<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<%@ include file="include-head.jsp"%>
<title>表格检索-<%=website_title%></title>

<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>	

<script type="text/javascript">

</script>
</head>
<body>
<%
//out.println("basePath="+basePath);
//out.println("path="+path);
%>

<form id="searchForm" name="searchForm"  method="post" target="_self">
	<input type="hidden" id="wap" name="wap" value="1"/>
	<input type="hidden" id="area" name="area" value="cn">
	<input type="hidden" id="strWhere" name="strWhere">
	<input type="hidden" id="strSources" name="strSources" value="">
</form>
<!--顶部显示-->
<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="row">
            	 <!--LOGO显示-->
            	  <div class="col-xs-2">
            	 	  <a href="javascript:history.go(-1);"><img  src="<%=basePath%>wap/img/fanhui.png" style="width:20px;margin-top:4px;" class="img-responsive"  /></a>
            	  </div>
            	  <div class="col-xs-10 col-md-4 col-sm-5">
            	 	  <img src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/gl_logo.png" style="width:280px;margin-top:3px;" class="img-responsive"/>
            	  </div>
                <!--LOGO显示结束-->
            </div>
		</div>
</div>
<!--顶部显示-->

<!--表格检索-->
<div class="container" style="margin-top: 60px;">
	<div class="row">
		<div class="col-xs-12" style="line-height:20px;text-align: left;color:#666666;">
			<strong>表格检索</strong>
		</div>
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	   </div>
	</div>
</div>
<!--表格检索-->
	
<!--库选择-->
<div class="container" style="color:#666666;margin-top:-10px;">
	<div class="row">
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="14" name="strdb" checked style="cursor:hand">发明</label>
			</center>
		</div>
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="15" name="strdb" checked style="cursor:hand">新型</label>
			</center>
		</div>
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="16" name="strdb" checked style="cursor:hand">外观</label>
			</center>
		</div>
		<div class="col-xs-3">
			<center>
			<label class="checkbox" style="padding-left:15px;">
			<input type="checkbox" value="17" name="strdb"  style="cursor:hand">授权</label>
			</center>
		</div>
	</div>
</div>
<!--库选择-->
<!--单条记录-->
<div id="div_biaodan" class="container dantiao">
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			名　称:
		</div>
		<div class="col-xs-9">
			<input id="名称" type="text" class="form-control input-sm" placeholder="例如:计算机">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			摘　要:
		</div>
		<div class="col-xs-9" >
			<input id="摘要" type="text" class="form-control input-sm" placeholder="例如:计算机">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			主权项:
		</div>
		<div class="col-xs-9" >
			<input id="主权项" type="text" class="form-control input-sm" placeholder="例如:计算机">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			分类号:
		</div>
		<div class="col-xs-9" >
			<input id="分类号" type="text" class="form-control input-sm" placeholder="例如:G06F15/16">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			申请号:
		</div>
		<div class="col-xs-9" >
			<input id="申请号" type="text" class="form-control input-sm" placeholder="例如:CN02144686.5">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			公开日:
		</div>
		<div class="col-xs-9" >
			<input id="公开（公告）日" type="text" class="form-control input-sm" placeholder="例如:20110105">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			申请日:
		</div>
		<div class="col-xs-9" >
			<input id="申请日" type="text" class="form-control input-sm" placeholder="例如:20101010">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			申请人:
		</div>
		<div class="col-xs-9" >
			<input id="申请（专利权）人" type="text" class="form-control input-sm" placeholder="例如:顾学平">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			代理人:
		</div>
		<div class="col-xs-9" >
			<input id="代理人" type="text" class="form-control input-sm" placeholder=" 例如:李恩庆">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-12">
			<button type="button" class="btn btn-info btn-xs" onClick="return click_a('divOne_1')">编辑隐藏著字段</button>
		</div>
	</div>
	
	<div id="divOne_1" style="display:none;">
	 <div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			公开号:
		</div>
		<div class="col-xs-9">
			<input id="公开（公告）号" type="text" class="form-control input-sm" placeholder="例如:CN1387751">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			优先权:
		</div>
		<div class="col-xs-9" >
			<input id="优先权" type="text" class="form-control input-sm" placeholder="例如:02112242">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			主分类号:
		</div>
		<div class="col-xs-9" >
			<input id="主分类号" type="text" class="form-control input-sm" placeholder="例如:G06F15/16">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			发明人:
		</div>
		<div class="col-xs-9" >
			<input id="发明（设计）人" type="text" class="form-control input-sm" placeholder="例如:顾学平">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			地　址:
		</div>
		<div class="col-xs-9" >
			<input id="地址" type="text" class="form-control input-sm" placeholder="例如:鞍山市">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			国省代码:
		</div>
		<div class="col-xs-9" >
			<input id="国省代码" type="text" class="form-control input-sm" placeholder="例如:江苏% 或 %32%">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			代理机构:
		</div>
		<div class="col-xs-9" >
			<input id="专利代理机构" type="text" class="form-control input-sm" placeholder=" 例如:柳沈">
		</div>
	</div>
    </div>
	
</div>
<!--单条记录-->

<!--下一页-->
<div class="container" style="line-height:40px;margin-top:10px;">
	<div class="row">
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;"></div>
	</div>
	<div class="row">
		<div class="col-xs-12">
			<center>
			<button class="btn btn-warning" id="subBtn" name=submit1 onClick="javascript:submitDataToSearch();">
										<i class="icon-search icon-white"></i>&nbsp;检 索</button>
									</a> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
										<button class="btn btn-success" type="button" value="" id="clear1" name="clear1">
										<i class="icon-search icon-white"></i>&nbsp;清 除</button>
            </center>
		</div>
	</div>
	</div>
<!--下一页-->
<div style="height:60px;"></div>


<%@ include file="include-bottom.jsp"%>


</body>
</html>
<script language="javascript" type="text/javascript">

	$("input:checkbox").bind('click',function(event){
	//$("div").html("Event: " + event.type);
	//	$(this).attr("type","checkbox");
		$(this).attr("checked",!($(this).attr("checked")));
	});
	
	$("#clear1").bind('click',function(event){
		$("input[type='text']").val("");
	});

    function submitDataToSearch1(){
		strdbValid();
//		alert($('#searchForm #strChannels').val());
		var strSources = $('#strSources').val();
		//$("#strChannels").val("14,15,16");
		var strWhere = $("#strWhere").val();
		
		if(validLogicInput()){
//			alert(document.searchForm.strWhere.value);
//			alert(document.searchForm.strChannels.value);
			
//			document.searchForm.strWhere.value = strWhere;
//			document.searchForm.strChannels.value = strChannels;
            document.searchForm.action="<%=basePath%>wappretoJsonOverView.do";
            document.searchForm.submit();
        }		
	}
	
    function submitDataToSearch(){
		strdbValid();
		
		if(validLogicInput()){
			var strSources = $('#searchForm #strSources').val();
			var strWhere = $("#searchForm #strWhere").val();
//			strWhere = escape(strWhere);
			
			strWhere=encodeURI(strWhere);
			strWhere=encodeURI(strWhere);
			
//			alert(strChannels);
//			alert(strWhere);
			
//          $("#searchForm #strWhere").attr("value",strWhere);
//          $("#searchForm #strChannels").attr("value",strChannels);
            $("#searchForm").attr("action","<%=basePath%>wapoverviewSearch.do?wap=1&strWhere="+strWhere+"&strSources="+strSources);		
			$("#searchForm").submit();
        }
	}



	function strdbValid(){
//var checkedLength=0;
		var strSources = "";
		$("input[name='strdb']").each(function(){		 
//alert($(this).val() + "-----" + $(this).attr("checked"));

			if($(this).attr("checked")){
//				checkedLength++;
				if(strSources!=""){
					strSources += ",";
				}
				strSources += $(this).val();
			}
		});
		
		if(strSources==""){
			alert("请选择检索库");
			return false;
		}else{
			//$('#searchForm #strChannels').val(strChannels);
			$('#searchForm #strSources').val(strSources);
			return true;
		}
	}
	
	function validLogicInput(){
		var searchCond="";
//		$("input[name='strdb']").each(function(){
		$('#div_biaodan input[type="text"]').each(function() {
			
			if($(this).val()!=""){
//				alert($(this).attr("id") + "=" + $(this).val());
				if(searchCond != ""){
					searchCond += " and ";
				}
				searchCond += $(this).attr("id") + "=" + $(this).val();
			}
			document.searchForm.strWhere.value = searchCond;
//alert($(this).val() + "-----" + $(this).attr("checked"));
		});
		
    	if(searchCond==''){//如果检索条件为空,返回错误
    		alert("请输入检索表达式");
    		return false;
    	}else{
//    		$("#searchForm #strWhere").attr("value",searchCond);
//    		$("#searchForm #strWhere").val(searchCond);
			$("#searchForm #strWhere").val(searchCond);
    		return true;
    	}
	}
	
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