<!DOCTYPE html>
<html>

<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<head>
<%@ include file="include-head-base.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>我的收藏夹-<%=website_title%></title>
	<meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10,IE=11" />

</head>

<body>


<%@ include file="include-head.jsp"%>
<%@ include file="include-head-nav.jsp"%>

		<script type="text/javascript">
			function getDetail(strSource, strAn) {
				document.detail.strSources.value = strSource;
				document.detail.strWhere.value = "申请号=" + strAn;
				document.detail.submit();
			}
			
			function delSingleFavorite(strTi, favoriteId){
				var ti = strTi.replace(/<font color=red>/g,"");
				ti = ti.replace(/<\/font>/g,"");
				
			　　if (confirm("您确实要从收藏夹中删除专利\""+ti+"\"么？"))
			　　{
					window.location.href= "<%=basePath%>delSingleFavorite.do?method=delSingleFavorite&favoriteId=" + favoriteId;
				}
			}
			
			function delAllFavorite(){
			　　if (confirm("您确实要删除收藏夹中的所有专利么？"))
			　　{
					window.location.href= "<%=basePath%>delAllFavorite.do";
				}
			}
		</script>
<div class="container" style="width:1024px;margin: auto;">
	<div class="container-fluid">
      <div class="row-fluid">		
	<%String menuname = "favorite";%>
<%@ include file="/admin/include-admin-leftmenu.jsp"%>
        <div class="span10">
         <!--span10 -->
         <table style="width: 100%" class="table table-striped table-bordered table-hover ">
                <tr>
					<td colspan="6" style="text-align:center;background-color:#f5f5f5;color: #3498db;height:6px;"><span><strong>我的收藏夹</strong></span></td>
				</tr>
           </table>
     <form name="detail" action="<%=basePath%>detailSearch.do?method=detailSearch" method="post" target="_blank">
			<input type="hidden" name="strChannels"
				value="">
			<input type="hidden" name="strWhere"
				value="">
			<input type="hidden" name="strSources"
				value="">
			<input type="hidden" name="strSortMethod"
				value="">
			<input type="hidden" name="strDefautCols"
				value="">
			<input type="hidden" name="strStat" value="">
			<input type="hidden" name="iOption" value="2">
			<input type="hidden" name="iHitPointType"
				value="115">
			<input type="hidden" name="bContinue"
				value="">
			<input type="hidden" name="index" value="0">
			<input type="hidden" name="area" value="cn">
			<input type="hidden" name="dateLimit" id="dateLimit" value="">
			<input type="hidden" name="appNum" id="appNum"  value="">
			<input type="hidden" name="simFlag" id="simFlag"  value="">
			<input type="hidden" name="apdRange" id="apdRange"  value="">
		</form>	
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<td >
								<table width="96%" border="0" align="center" cellpadding="0"
									cellspacing="1" bordercolor="#88B0DD">
									<tr>
										<td height="20" colspan="4" bgcolor="#FEFFE8" class="t1">
											<!-- 
											<div align="center">
												只能保存50条信息（超过记录会自动删除）
											</div>
											 -->
											<div align="left">
												&nbsp;&nbsp;以下收藏记录按收藏时间倒排序
											</div>
										</td>
									</tr>
									<tr bgcolor="#9FBFE3">
										<td width="8%" height="25" class="t1">
											<div align="center">
												序号
											</div>
										</td>
										<td width="15%" class="t1">
											<div align="center">
												申请（专利）号
											</div>
										</td>
										<td width="49%" class="t1">
											<div align="center">
												名称
											</div>
										</td>
										<td width="12%" class="t1">
											<div align="center">
												&nbsp;
											</div>
										</td>
									</tr>

									<c:forEach var="favorite" items="${requestScope.favoriteList}">
										<tr>
											<td height="8" bgcolor="#E8F3FF" class="t1">
												<div align="center">
													&nbsp;${favorite.index}
												</div>
											</td>
											<td height="15" bgcolor="#E8F3FF" class="t1">
												<div align="center">
													<a href="#" onClick="javascript:getDetail('${favorite.chrChannelID}','${favorite.chrAPO}')" style="cursor:hand"><span class="style1">&nbsp;${favorite.chrAPO}</span>
													</a>
												</div>
											</td>
											<td height="25" bgcolor="#E8F3FF" class="t1">
												<div align="left">
													&nbsp;${favorite.chrTI}
												</div>
											</td>
											<td height="25" bgcolor="#E8F3FF" class="t1">
												<div align="center">
													<a href="#" onClick="javascript:delSingleFavorite('${favorite.chrTI}','${favorite.id}')" style="cursor:hand">删除</a>
												</div>
											</td>
										</tr>
									</c:forEach>

								</table>

								<p style="text-align:center;margin:8px;">
									<button type="button" class="btn btn-success" onClick="javascript:delAllFavorite()">全部删除</button>
							</td>
						</tr>
						<tr>
							<td height="15">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="100" bgcolor="#EEF7FF">&nbsp;
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="0" ></td>
						</tr>
					</table>
				</td>
				<td width="0" bgcolor="#000000"></td>
			</tr>
		</table>
         <!--span10 -->
        </div>
      </div>
</div>
</div>
<!--main结束-->	
<%@ include file="include-buttom.jsp"%>

	</BODY>
</HTML>

