<!DOCTYPE html>
<html lang="en">

<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	
<%@ include file="include-head.jsp"%>
<title>法律状态检索-<%=website_title%></title>

<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/hyjs-logic.js"></script>
	
<script language=javascript>

function formSubmit()
{
         var sqhs="";		//申请（专利）号
         var flzt="";   	//法律状态
         var flztinfo="";	//法律状态信息
         var flztggr="";	//法律状态公告日
//		 var sqggh="";		//授权公告号
         var str="";		//检索表达式
         var str_leng="";
		 
         sqhs = $('#flztSearchForm #sqhs').val();
         flzt = $('#flztSearchForm #flzt').val();
         flztinfo = $('#flztSearchForm #flztinfo').val();
//       sqggh=document.flztSearchForm.textfield3.value;
	     flztggr = $('#flztSearchForm #flztggr').val();
	     
	     //alert(sqhs);
	     //alert(flzt);
	     //alert(flztinfo);
//alert(flztggr);
		 
		 sqhs=sqhs.replace(/(^\s*)|(\s*$)/g, "");
		 sqhs=sqhs.replace('，', ",");
		 flzt=flzt.replace(/(^\s*)|(\s*$)/g, "");
		 flztinfo=flztinfo.replace(/(^\s*)|(\s*$)/g, "");
//		 sqggh=sqggh.replace(/(^\s*)|(\s*$)/g, "");
		 flztggr=flztggr.replace(/(^\s*)|(\s*$)/g, "");
		 
//alert(flztggr);
		 
		 var sqhinfo = "";
		 var sqh = "";
		 sqhs = $.trim(sqhs);
//alert("trim="+num)
         if(sqhs!="") {
			var arrsqh=sqhs.split(",");      
			for (i=0;i<arrsqh.length ;i++ )
			{
				sqh=arrsqh[i];
				if(sqh.indexOf("CN")==0||sqh.indexOf("cn")==0){
					sqh=sqh.substring(2);
				}
				if(sqh.indexOf(".")<0)
				{
					sqh=sqh+"%";
				}
				str=str +  "(申请号=(CN" + sqh + ") or 申请号=(" + sqh + ")) or ";				
			}         	
		 }

//alert("#"+str.substring(str.length-4,str.length)+"#");
//lastIndexOf
		if(str!=""&&str.length>4&&str.substring(str.length-4,str.length)==" or "){
			str=str.substring(0,str.lastIndexOf(" or "));
			str = "(" + str + ")";
		}
//		alert(str);
		if(str!=""){
			str=str+" and ";
		}
		
        if(flztggr!="") {
            str=str +  "法律状态公告日=(" + flztggr + ") and ";
        }

        if(flzt!="") {
			str=str + "法律状态=" + flzt+ " and ";
		}
        if(flztinfo!="") {
			str=str + "法律状态信息=" + flztinfo+ " and ";
		}

        str_leng=str.length;
		
//		alert("str_leng="+str_leng);
		
//		alert("str="+str);

		if (str_leng==0)
		{
			str="";
		}
		else
		{
			str=str.substring(0,str_leng-4);
		}
		
		document.flztSearchForm.strWhere.value=str;
		
		if (str=="")
		{
			alert("检索表达式不能为空");
			return false;
		}else{
			str=encodeURI(str);
			str=encodeURI(str);
//			alert("22222");
			document.flztSearchForm.action = "<%=basePath%>waplegalStatusSearch.do?wap=1&strWhere="+str;
	        document.flztSearchForm.submit();
        }
}
</script>


	</head>
	<body>

<!--顶部显示-->
<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="row">
            	 <!--LOGO显示-->
            	  <div class="col-xs-2">
            	 	  <a href="javascript:history.go(-1);"><img src="<%=basePath%>wap/img/fanhui.png" style="width:20px;margin-top:4px;" class="img-responsive"  /></a>
            	  </div>
            	  <div class="col-xs-10 col-md-4 col-sm-5">
            	 	  <img  src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/gl_logo.png" style="width:280px;margin-top:3px;" class="img-responsive"/>
            	  </div>
                <!--LOGO显示结束-->
            </div>
		</div>
</div>	
<!--顶部显示-->

<!--法律状态检索-->
<div class="container" style="margin-top: 60px;">
	<div class="row">
		<div class="col-xs-12" style="line-height:20px;text-align: left;color:#666666;">
			<strong>法律状态检索</strong>
		</div>
		<div class="col-xs-12"><hr style="border:1px dashed #bbb;border-bottom:0;border-right:0;
           border-left:0;">
        </div>
	</div>
</div>
<!--法律状态检索-->
<!--单条记录-->
<form id="searchForm" name="searchForm"  method="post" target="_self"></form>

<form class="form-horizontal" method="post" id="flztSearchForm" name="flztSearchForm" >
<input type="hidden" id="wap" name="wap" value="1"/>
<input type="hidden" id="strWhere" name="strWhere">
<div class="container dantiao">
	<div style="height:8px;"></div>

	<div class="row">
		<div class="col-xs-3">
			申请号:
		</div>
		<div class="col-xs-9">
			<input type="text" id="sqhs" name="sqhs" class="form-control input-sm" placeholder="例如：201210518155.5，多值用','或换行分隔">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			公开日:
		</div>
		<div class="col-xs-9" >
			<input type="text" id="flztggr" name="flztggr" class="form-control input-sm" placeholder="例如：2015.11.25">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			状　态:
		</div>
		<div class="col-xs-9" >
			<input type="text" id="flzt" name="flzt" class="form-control input-sm" placeholder="例如：公开">
		</div>
	</div>
	<div style="height:8px;"></div>
	<div class="row">
		<div class="col-xs-3">
			信　息:
		</div>
		<div class="col-xs-9" >
			<input type="text" id="flztinfo" name="flztinfo" class="form-control input-sm" placeholder="例如：未缴年费专利权终止">
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
			<button class="btn btn-warning" id="subBtn" name=submit1 onClick="javascript:formSubmit();">
										<i class="icon-search icon-white"></i>&nbsp;检 索</button>
									    <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
										<button class="btn btn-success" type="reset" value="" name=cler1>
										<i class="icon-search icon-white"></i>&nbsp;清 除</button>
            </center>
		</div>
	</div>
</div>
</form>
<!--下一页-->
<div style="height:60px;"></div>

<%@ include file="include-bottom.jsp"%>

	</body>
</html>
