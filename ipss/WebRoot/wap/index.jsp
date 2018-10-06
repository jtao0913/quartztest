<!DOCTYPE html>
<html lang="en">
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
  
<%@ include file="include-head.jsp"%>
<title><%=website_title%>-专利检索查询,专利搜索下载</title>
		
<link href="<%=basePath%>common/com_3/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>wap/css/wap.css" rel="stylesheet">
<script src="<%=basePath%>common/com_2/js/bootstrap.min.js"></script>
<script type="text/javascript">
			function doQsearch(){
//alert("doQsearch.....");
				var content = $('#content').val();
				var strWhere = $('#content').val();
//alert(colname);
//alert("---"+content+"---");
				if(strWhere!="语义检索：请输入一段技术信息文字或者公开号" && strWhere!=undefined && strWhere!=null && strWhere!=""){
//					$("#strWhere").attr("value",colname+""+content);
//					$("#strChannels").val("14,15,16");
					
//					var strWhere = colname+content;
	strWhere = strWhere.replace(/'/g, " ");
	strWhere = strWhere.replace(/\"/g, " ");

	var regRN = /\r\n/g;
	strWhere = strWhere.replace(regRN," ");
	
	var regR = /\r/g;
	var regN = /\n/g;
	strWhere = strWhere.replace(regR," ").replace(regN," ");
	
//alert(strWhere);
//$("#searchForm #strWhere").val("主权项语义,摘要语义+='"+strWhere+"'");
//strWhere = "("+$.trim(content).replace(/\s+/g, " and ")+")";
//alert(strWhere);
					
					var strChannels = "14,15,16";
					
					strWhere=encodeURI(strWhere);
					strWhere=encodeURI(strWhere);
//alert(strWhere);
//pretoJsonOverView.do?area=cn";
					$("#searchForm").attr("action","<%=basePath%>wappretoJsonOverView.do?wap=1&searchType=2&strWhere="+strWhere+"&strSources="+strChannels+"&pageType=all&quickSearchEncode=UTF8");
					$("#searchForm").submit();
				}else{
					alert("检索表达式不能为空");
					return false;
				}
			}
</script>


	</head>
	<body>
	<div style="display:none"><img src='<%=basePath%>wap/img/weixin.png'/></div>
		<header class="site-header">
			<div class="container">
				<div style="height: 30px"></div>
				<div class="row">
					<div class="col-xs-12">
						
						<center>
						<img src="<%=basePath%>images/area/<%=Log74Access.get("log74.areacode")%>/common/com_2/img/index/sy_logo.png" class="img-responsive" style="max-width:260px ;">
						</center>				
						
			<form id="searchForm" name="searchForm" method="post" target="_self">
			<!-- <input type="hidden" id="colname" value="申请号,公开（公告）号,申请（专利权）人,发明（设计）人,地址,名称,摘要+=" name="colname" /> -->
			<input type="hidden" id="colname" value="主权项语义,摘要语义+=" name="colname" />
			<input type="hidden" id="wap" name="wap" value="1"/>
			<input type="hidden" id="strWhere" name="strWhere"/>
			<input type="hidden" id="simpleSearch" name="simpleSearch" value="1"/>
			<input type="hidden" id="presearchword" name="presearchword" />
			
			<input type="hidden" id="strChannels" name="strChannels"/>
			
			<input type="hidden" id="strSortMethod" name="strSortMethod" value="RELEVANCE"/>
			<input type="hidden" name="strDefautCols" value="主权项, 名称, 摘要"/>
			<input type="hidden" name="strStat" value=""/>
			<input type="hidden" name="iHitPointType" value="115"/>
		    <input type="hidden" id="searchKind" name="searchKind" value="tableSearch"/>
			<input type="hidden" id="bContinue" name="bContinue" value=""/>
			<input type="hidden" id="trsLastWhere" name="trsLastWhere" />
			<input type="hidden" value="" name="channelid"/>
												
					<div class="input-group">
					
					<input type="text" id="content" name="content" class="form-control" value="语义检索：请输入一段技术信息文字或者公开号" onFocus="if(value=='语义检索：请输入一段技术信息文字或者公开号') {value=''}" onBlur="if (value=='') {value='语义检索：请输入一段技术信息文字或者公开号'}" placeholder="语义检索：请输入一段技术信息文字或者公开号"/>
										
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" onClick="doQsearch()">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</span>
				</div><!-- /input-group -->
					<div style="height: 30px"></div>
			</form>
					</div>
				</div>
			</div>
		</header>
		<div style="height:20px"></div>
		<!-- /input-group
		<div class="container">
     <center>
 	<div class="row" style="max-height:300px;color: #FFFFFF;font-size: 12px;">
 		<div class="col-xs-4" style="background-color: #6D3353;height:40px ;line-height: 40px;">
          命令行检索
    </div>
 		
 		<div class="col-xs-4" style="background-color: #009999;height:40px ;line-height: 40px;">
           表格检索
    </div>
 		<div class="col-xs-4" style="background-color: #6666FF;height:40px ;line-height: 40px;">
          法律状态检索		
 		</div>
    </center>
 </div>
  -->
 <div class="container">
			<div class="row">
				<div class="col-xs-3 font-size12"><center><a href="<%=basePath%>wap/biaoge.jsp"><img src="img/biaoge.png" class="img-responsive"></a><br />表格检索</center></div>
				<div class="col-xs-3 font-size12"><center><a href="<%=basePath%>wap/mingling.jsp"><img src="img/mingling.png" class="img-responsive"></a><br />命令行检索</center></div>
				<div class="col-xs-3 font-size12"><center><a href="<%=basePath%>wap/falv.jsp"><img src="img/falv.png" class="img-responsive"></a><br />法律状态检索</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.cnipr.com/sj/zx/"><img src="img/zixun.png" class="img-responsive"></a><br />CNIPR视角</center></div>

		<!--
		武汉
		<div class="col-xs-3 font-size12"><center><a href="http://www.whst.gov.cn/xwzx.aspx"><img src="img/zixun.png" class="img-responsive"></a><br />新闻中心</center></div>
		
		<div class="col-xs-3 font-size12"><center><a href="http://www.lnipo.gov.cn/xwzx/yw/"><img src="img/zixun.png" class="img-responsive"></a><br />新闻中心</center></div>
		-->
		</div>
		</div>
		<div style="height:20px"></div>
		<div class="container">
			<div class="row">
				<div class="col-xs-3 font-size12"><center><a href="http://www.cnipr.com/fw/"><img src="img/shijiao.png" class="img-responsive"></a><br />CNIPR服务</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.cnipr.com/xy/swzs/"><img src="img/sifa.png" class="img-responsive"></a><br />CNIPR学院</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.cnipr.com/zy/ipsqzn/"><img src="img/ketang.png" class="img-responsive"></a><br />CNIPR资源</center></div>
        		<div class="col-xs-3 font-size12"><center><a href="http://www.piac-china.com/"><img src="img/nianhui.png" class="img-responsive"></a><br />中国专利年会 </center></div>
			
			<!--
			武汉
				<div class="col-xs-3 font-size12"><center><a href="http://www.whst.gov.cn/wsbs.aspx"><img src="img/shijiao.png" class="img-responsive"></a><br />为民服务</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.whst.gov.cn/wsbs/show/31978.aspx"><img src="img/sifa.png" class="img-responsive"></a><br />科技文献</center></div>
				<div class="col-xs-3 font-size12"><center><a href=" http://www.whst.gov.cn/wsbs/list/1140.aspx"><img src="img/ketang.png" class="img-responsive"></a><br />专利服务</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.whst.gov.cn/wsbs/list/564.aspx"><img src="img/nianhui.png" class="img-responsive"></a><br />知识产权保护</center></div>
				
				<div class="col-xs-3 font-size12"><center><a href="http://www.lnipo.gov.cn/gztz/"><img src="img/shijiao.png" class="img-responsive"></a><br />通知公告</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.lnipo.gov.cn/zlsjk/"><img src="img/sifa.png" class="img-responsive"></a><br />专题数据库</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.lnipo.gov.cn/cyyjbg/"><img src="img/ketang.png" class="img-responsive"></a><br />产业研究报告</center></div>
				<div class="col-xs-3 font-size12"><center><a href="http://www.lnipo.gov.cn/bszn/zlywbllc/zlsq/"><img src="img/nianhui.png" class="img-responsive"></a><br />专利申请</center></div>
			-->
			</div>
    </div>
   <!--底部展示-->
  <div style="height:10px;"></div>
  <div class="container" style="font-size: 11px;color:#999999;padding:20px 50px 20px 50px;">
        <div class="row text-center">
        ©2018 IPPH.cn&nbsp; <%=website_title%>  技术支持：知识产权出版社  IT运维电话：4001880860 <a href="<%=basePath%>index.jsp?showtype=computer">电脑版</a>
        </div>
    </div>
  <div style="height:20px;"></div>


<%@ include file="include-bottom.jsp"%>

</body>
</html>
