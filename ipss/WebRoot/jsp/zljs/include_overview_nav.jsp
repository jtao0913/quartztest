<%@ page language="java" pageEncoding="UTF-8"%>

<script src="<%=basePath%>analyse/echarts.min.js"></script>
<script src="<%=basePath%>analyse/echarts-wordcloud.min.js"></script>
<script src="<%=basePath%>analyse/theme/shine.js"></script>

		<div id="nav_div" style="display:none;width:100%;clear:both;margin:auto;">
			<div class="row-fluid">
				<div name="top-navbar" class="navbar navbar-inverse">
				
					<strong>
					<div class="navbar-inner" style=" background-image: none;background-repeat:no-repeat;filter: none;background-color: #999966; border: 0px;border-bottom:0px solid #5cc0cd;">
						<div class="container">
							<div class="nav-collapse collapse">
								<ul class="nav" >
											<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;">下载 <b class="w_caret"></b> </a>
												<ul class="dropdown-menu">
													<li><a href="javascript:Download();">著录项下载</a></li>
													<li><a data-toggle="modal" data-target="#downloadBatchModal">著录项批量下载</a></li>
													
													<%if(area!=null&&area.equalsIgnoreCase("cn")){%>
													<li id='lipdfdownload'><a href='javascript:downloadPDF();'>PDF下载</a></li>
													<%}%>
												</ul>
											</li>


											<li><a href="#" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" id="bt_analyse" value="统计分析">统计分析</a></li>
											<!-- 
<li><a href="jsp/zljs/report.jsp" target="_blank" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" id="bt_analysereport" value="分析报告">分析报告</a></li>
									  -->
									<li>
										<a href="javascript:dbSearchModal()" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" id="piaslink">二次检索</a>
									</li>
<!-- 
									<li>
										<a onclick="javascript:showWordcloudModal()" data-toggle="modal" data-target="#wordcloudModal" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" id="wordcloudlink">语义筛选</a>
									</li>
 -->
								<%if(treeType==6){ %>
								<li><a href="javascript:reporter()"
									style=" background-image: none; background: none; border: 0px; color: #ffffff; font-weight: normal;"
									id="piaslink">生成报告</a></li>
								<%}%>

									<!-- 
									<li>
										<a href="javascript:showexpression()" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;">查看表达式</a>
									</li>
									 -->											
									<li class="active" style="padding-top:10px; color: #ffffff; font-weight: 600; padding-left: 15px;">
										<label class="checkbox" style="width: 30px"><input type="checkbox" value="" onClick="selectAllCheckSort(this.checked)">全选</label>
									</li>
									

								</ul>
								<ul class="nav pull-right">
									<li>
									
									<s:select name="selpagerecord" list="#{'10':'10','30':'30','50':'50'}" value="#request.pagerecord" onchange="changepagerecord()" theme="simple" cssStyle="width: 50px; padding: 0px; margin: 0px; margin-top:8px; line-height: 25px; height: 25px;"></s:select><!-- value是选中的 -->
									
									</li>

									<li>
											<select class="input-medium" id="sortcolumn" name="sortcolumn" onChange="changesortmethod()" style="width: 112px; padding: 0px; margin: 0px; margin-top:8px; line-height: 25px; height: 25px;">
												<option value="RELEVANCE" selected="selected">按相似度排序</option>
												<option value="-公开（公告）日">按公开日降序</option>
												<option value="-申请日">按申请日降序</option>												
											</select>
									</li>
									
									
								</ul>

<ul class="nav pull-right" id="pageinfo">
	<li></li>
</ul>

							</div>
						</div>
					</div>
					</strong>
				</div>
			</div>
		</div>


<!-- 模态框（Modal） -->
<div id="wordcloudModal" class="modal hide fade" style="width: 800px;" tabindex="-4" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">语义筛选</h4>
					</div>
					
                     <div id="wordcloudDiv"></div>
                     
					<div style="width: 500px;margin-left:22px;">
						<textarea style="width: 95%; resize: none;" id="wordcloudtext"></textarea>
					</div>
					
					<center style="padding-top:15px;">
					<div class="btn-group">
						<button class="btn btn-success" type="button"
							onclick="selectWordCloud()">
							<i class="icon-search icon-white"></i>&nbsp;语义筛选
						</button>
					</div>
					</center>
					<div style="height: 10px;"></div>
				</div>
			</div>
		</div>
	</div>

