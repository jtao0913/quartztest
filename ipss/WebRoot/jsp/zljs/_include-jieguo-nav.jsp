<%@ page language="java" pageEncoding="UTF-8"%>

<div id="top-navbar" name="top-navbar" style="display: none;" class="navbar navbar-inverse">

<strong>
					<div class="navbar-inner" style="background-image: none;background-repeat:no-repeat;filter: none;background-color: #ffffff;border: 0px;border-bottom:0px solid #5cc0cd;">
						<div class="container">
							<div class="nav-collapse collapse">
								<ul class="nav">
											<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;color:#666;font-size:13px; ">下载 <b class="w_caret"></b> </a>
												<ul id="downloadmenu" class="dropdown-menu" >
													<li><a href="javascript:Download();">著录项下载</a></li>
													<li><a data-toggle="modal" data-target="#downloadBatchModal">著录项批量下载</a></li>
												</ul>
											</li>											


											
											<% if(SetupAccess.getProperty(SetupConstant.FENXI)!=null && SetupAccess.getProperty(SetupConstant.FENXI).equals("1")){%>
													    <% 
													    //if(strItemGrant.contains(SetupConstant.FENXI))
													    {%>
											<li>
											<a href="#" style="background-image: none;background:none;border: 0px;font-weight: normal;color:#666;font-size:13px;" id="bt_analyse">统计分析</a>
											</li>
														<%} %>
											<%} %>
											<% if(SetupAccess.getProperty(SetupConstant.DINGQIYUJING)!=null && SetupAccess.getProperty(SetupConstant.DINGQIYUJING).equals("1")){%>
												 	 <% 
												 	 //if(strItemGrant.contains(SetupConstant.DINGQIYUJING))
												 	 {
												 	 %>
											<li><a href="#" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" onClick="javascript:warning();"><font style="color:#666;font-size:13px;">专利预警</font></a></li>
													<%} %>
											<%}%>
											
											<%if((","+(String)session.getAttribute("userMenu")).indexOf(",3500,")>-1){%>
											<li><a href="#" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;"  id="piaslink" onClick="javascript:preSaveFavorite();"><font style="color:#666;font-size:13px;">加入收藏</font></a></li>
											<%}%>
											
									<li class="active" style="padding-top:10px; color: #ffffff; font-weight: 600; padding-left: 10px;">
										<label class="checkbox" style="width:30px"><input id="chkall" type="checkbox" value="" onClick="selectAllCheckSort(this.checked)"><font style="color:#666;font-size:13px;">全选</font></label>
									</li>
									
									<li><a href="javascript:dbSearchModal()" style="background-image: none;background:none;border: 0px;color:#ffffff;font-weight: normal;" id="piaslink"><font style="color:#666;font-size:13px;">二次检索</font></a></li>
									
									<li>
										<select class="input-medium" style="width:150px;" id="sectionInfos" onChange="channelsChange(this.value);"></select>
									</li>
								</ul>




		<input type="hidden" name="translate" id="translate" value="<%=translate%>">
		<input type="hidden" name="type" id="type" value="<%=type%>">
		<input type="hidden" name="hangye" id="hangye" value="<%=hangye%>">
		
		<input type="hidden" name="jumpNavID" id="jumpNavID" value="<%=jumpNavID%>">
		
		<input type="hidden" name="nodeId" id="nodeId">
		<input type="hidden" name="shixiao" id="shixiao" value="<%=shixiao%>">
		
		<input type="hidden" name="RecordCount" id="RecordCount">
		<input type="hidden" name="selectexp" id="selectexp">
		<input type="hidden" name="selectdbs" id="selectdbs">
		<input type="hidden" name="SecurityCode" id="SecurityCode">
		<input type="hidden" name="URLEncoderWhere" id="URLEncoderWhere">
		<input type="hidden" name="area" id="area">
		
		<input type="hidden" name="unfilterTotalCount" id="unfilterTotalCount">
		
		
								<ul class="nav pull-right" id="pageinfo">
									<li></li>
									<!-- 
									<s:select name="selpagerecord" list="#{'10':'10','30':'30','50':'50'}" value="#request.pagerecord" onchange="changepagerecord()" theme="simple" cssStyle="width: 50px; padding: 0px; margin: 0px; margin-top:8px; line-height: 25px; height: 25px;"></s:select>
									</li>
									<li>
											<select class="input-medium" onChange="#" style="width: 112px; padding: 0px; margin: 0px; margin-top:8px; line-height: 25px; height: 25px;">
												<option value="-公开（公告）日" >按公开日降序</option>
												<option value="RELEVANCE" selected="selected">按相似度排序</option>
												<option value="+公开（公告）日" >按公开日升序</option>
												<option value="-申请日" >按申请日降序</option>
												<option value="+申请日" >按申请日升序</option>
											</select>		
									</li>
									-->									
								</ul>
							</div>
						</div>
					</div>
					</strong>
			</div>