<%@ page language="java" pageEncoding="UTF-8"%>

<script type="text/javascript">
</script>

<div id="downloadModal" class="modal hide fade" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">请选择要下载的字段</h4>
	</div>
	<div class="modal-body" id="downloadTableInfo" style="font-size:12px;">
		<table class="table table-bordered table-striped" >
			<tr>
				<td><input type="checkbox" checked="checked" value="申请号" name='downloadColumn'>申请（专利）号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="申请日" name='downloadColumn'>申请日&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="公开（公告）日" name='downloadColumn'>公开（公告）日&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="公开（公告）号" name='downloadColumn'>公开（公告）号&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="申请（专利权）人" name='downloadColumn'>申请（专利权）人&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="发明（设计）人" name='downloadColumn'>发明（设计）人&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="主分类号" name='downloadColumn'>主分类号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="分类号" name='downloadColumn'>分类号&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="专利代理机构" name='downloadColumn'>专利代理机构&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="代理人" name='downloadColumn'>代理人&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="地址" name='downloadColumn'>地址&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="摘要" name='downloadColumn'>摘要&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="国省代码" name='downloadColumn'>国省代码&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="名称" name='downloadColumn'>名称&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="优先权" name='downloadColumn'>优先权&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="最新法律状态" name='downloadColumn'>最新法律状态&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="主IPC小类" name='downloadColumn'>主IPC小类&nbsp;&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
<!-- 
			<tr>
				<td><input type="checkbox" checked="checked" value="权利要求书页数" name='downloadColumn'>权利要求书页数&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="说明书页数" name='downloadColumn'>说明书页数&nbsp;&nbsp;</td>
			</tr>
 -->
		</table>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button class="btn btn-primary" onClick="beginDownload()" data-dismiss="modal" aria-hidden="true">开始下载</button>
	</div>
</div>

<div id="downloadBatchModal" class="modal hide fade" tabindex="-3" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">请选择要下载的字段</h4>
	</div>
	<div class="modal-body" id="downloadBatchTableInfo" style="font-size: 12px;">
		<table class="table table-bordered table-striped" >
			<tr>
				<td><input type="checkbox" checked="checked" value="申请（专利）号" name='downloadColumn'>申请（专利）号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="申请日" name='downloadColumn'>申请日&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="公开（公告）日" name='downloadColumn'>公开（公告）日&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="公开（公告）号" name='downloadColumn'>公开（公告）号&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="申请（专利权）人" name='downloadColumn'>申请（专利权）人&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="发明（设计）人" name='downloadColumn'>发明（设计）人&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="主分类号" name='downloadColumn'>主分类号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="分类号" name='downloadColumn'>分类号&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="专利代理机构" name='downloadColumn'>专利代理机构&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="代理人" name='downloadColumn'>代理人&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="地址" name='downloadColumn'>地址&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="摘要" name='downloadColumn'>摘要&nbsp;&nbsp;</td>
			</tr>
			<tr >
				<td><input type="checkbox" checked="checked" value="国省代码" name='downloadColumn'>国省代码&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="名称" name='downloadColumn'>名称&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="优先权" name='downloadColumn'>优先权&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="最新法律状态" name='downloadColumn'>最新法律状态&nbsp;&nbsp;</td>
			</tr>
<!-- 
			<tr>
				<td><input type="checkbox" checked="checked" value="权利要求书页数" name='downloadColumn'>权利要求书页数&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="说明书页数" name='downloadColumn'>说明书页数&nbsp;&nbsp;</td>
			</tr>
 -->
		</table>
		<table>
			<tr>
				<td>开始：<input type="text" id="_begin" placeholder="请输入下载的开始索引"></td>
				<td>结束：<input type="text" id="_end" placeholder="请输入下载的结束索引"></td>
			</tr>
			<!-- 
			<tr>
				<c:choose>
					<c:when test="${sessionScope.loginUser.permissionId =='PERMISSIONM' }">
						<td colspan="2"><span style="font-size: 11px;color: #996699;float: right;">下载上限为3000条,下载索引从1开始</span></td>
					</c:when>
					<c:when test="${sessionScope.loginUser.permissionId == 'PERMISSIONG'}">
						<td colspan="2"><span style="font-size: 11px;color: #996699;float: right;">下载上限为50条,下载索引从1开始</span></td>
					</c:when>
					<c:otherwise>
						<td colspan="2"><span style="font-size: 11px;color: #996699;float: right;">下载上限为2000条,下载索引从1开始</span></td>
					</c:otherwise>
				</c:choose>
			</tr>
			 -->
		</table>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button class="btn btn-primary" onClick="_download2000()" data-dismiss="modal" aria-hidden="true">开始下载</button>
	</div>
</div>


<div id="frdownloadModal" class="modal hide fade" tabindex="-4" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">请选择要下载的字段</h4>
	</div>
	<div class="modal-body" id="frdownloadTableInfo" style="font-size: 12px;">
		<table class="table table-bordered table-striped" >
			<tr>
				<td><input type="checkbox" checked="checked" value="申请号" name='downloadColumn'>申请号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="申请日" name='downloadColumn'>申请日&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="专利号" name='downloadColumn'>专利号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="公开（公告）日" name='downloadColumn'>公开（公告）日&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="名称" name='downloadColumn'>名称&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="摘要" name='downloadColumn'>摘要&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="申请（专利权）人" name='downloadColumn'>申请（专利权）人&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="发明（设计）人" name='downloadColumn'>发明（设计）人&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="主分类号" name='downloadColumn'>主分类号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="分类号" name='downloadColumn'>分类号&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="优先权" name='downloadColumn'>优先权&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="同族专利项" name='downloadColumn'>同族专利项&nbsp;&nbsp;</td>
			</tr>
		</table>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button class="btn btn-primary" onClick="beginDownload()" data-dismiss="modal" aria-hidden="true">开始下载</button>
	</div>
</div>

<div id="frdownloadBatchModal" class="modal hide fade" tabindex="-5" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4 id="myModalLabel">请选择要下载的字段</h4>
	</div>
	<div class="modal-body" id="frdownloadBatchTableInfo" style="font-size: 12px;">
		<table class="table table-bordered table-striped" >
			<tr>
				<td><input type="checkbox" checked="checked" value="申请号" name='downloadColumn'>申请号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="申请日" name='downloadColumn'>申请日&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="专利号" name='downloadColumn'>专利号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="公开（公告）日" name='downloadColumn'>公开（公告）日&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="名称" name='downloadColumn'>名称&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="摘要" name='downloadColumn'>摘要&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="申请（专利权）人" name='downloadColumn'>申请（专利权）人&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="发明（设计）人" name='downloadColumn'>发明（设计）人&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="主分类号" name='downloadColumn'>主分类号&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="分类号" name='downloadColumn'>分类号&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><input type="checkbox" checked="checked" value="优先权" name='downloadColumn'>优先权&nbsp;&nbsp;</td>
				<td><input type="checkbox" checked="checked" value="同族专利项" name='downloadColumn'>同族专利项&nbsp;&nbsp;</td>
			</tr>
		</table>
		<table>
			<tr>
				<td>开始：<input type="text" id="_begin" placeholder="请输入下载的开始索引"></td>
				<td>结束：<input type="text" id="_end" placeholder="请输入下载的结束索引"></td>
			</tr>
			<!-- 
			<tr>
				<c:choose>
					<c:when test="${sessionScope.loginUser.permissionId =='PERMISSIONM' }">
						<td colspan="2"><span style="font-size: 11px;color: #996699;float: right;">下载上限为3000条,下载索引从1开始</span></td>
					</c:when>
					<c:when test="${sessionScope.loginUser.permissionId == 'PERMISSIONG'}">
						<td colspan="2"><span style="font-size: 11px;color: #996699;float: right;">下载上限为50条,下载索引从1开始</span></td>
					</c:when>
					<c:otherwise>
						<td colspan="2"><span style="font-size: 11px;color: #996699;float: right;">下载上限为2000条,下载索引从1开始</span></td>
					</c:otherwise>
				</c:choose>
			</tr>
			 -->
		</table>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button class="btn btn-primary" onClick="_download2000()" data-dismiss="modal" aria-hidden="true">开始下载</button>
	</div>
</div>
<div id="db-search-modal" class="modal hide fade" style="width: 600px;" tabindex="-4" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">二次检索</h4>
					</div>
					<div id="cn_secondsearch_item" class="label-container-patent" style="padding-top: 15px;">
						<a href="javascript:insertDBtitle('申请号=')"><span class="label">申请号</span>
						</a> <a href="javascript:insertDBtitle('公开（公告）号=')"><span class="label">公开（公告）号 </span>
						</a> <a href="javascript:insertDBtitle('名称=')"><span class="label">名称</span>
						</a> <a href="javascript:insertDBtitle('摘要=')"><span class="label">摘要</span>
						</a> <a href="javascript:insertDBtitle('主权项=')"><span class="label">主权项</span>						
						</a> <a href="javascript:insertDBtitle('公开（公告）日=')"><span class="label">公开（公告）日</span>
						</a> <a href="javascript:insertDBtitle('主分类号=')"><span class="label">主分类号</span>
						</a> <a href="javascript:insertDBtitle('分类号=')"><span class="label">分类号</span>
						</a> <a href="javascript:insertDBtitle('申请日=')"><span class="label">申请日</span>
						</a> <a href="javascript:insertDBtitle('发明（设计）人=')"><span class="label">发明（设计）人</span>
						</a> <a href="javascript:insertDBtitle('申请（专利权）人=')"><span class="label">申请（专利权）人</span>
						</a> <a href="javascript:insertDBtitle('专利代理机构=')"><span class="label">专利代理机构</span>
						</a> <a href="javascript:insertDBtitle('代理人=')"><span class="label">代理人</span>
						</a> <a href="javascript:insertDBtitle('地址=')"><span class="label">地址</span>
						</a> <a href="javascript:insertDBtitle('国省代码=')"><span class="label">国省代码</span>
						</a> <a href="javascript:insertDBtitle('最新法律状态=')"><span class="label">最新法律状态</span>						
						</a> <a href="javascript:insertDBtitle('国民经济代码=')"><span class="label">国民经济代码</span>
						</a> <a href="javascript:insertDBtitle('说明书=')"><span class="label">说明书</span>
						</a> <a href="javascript:insertDBtitle('权利要求书=')"><span class="label">权利要求书</span>
						</a>
					</div>
					<div id="fr_secondsearch_item" class="label-container-patent" style="padding-top: 15px;">
						<a href="javascript:insertDBtitle('申请号=')"><span class="label">申请号</span>
						</a> <a href="javascript:insertDBtitle('申请日=')"><span class="label">申请日</span>
						</a> <a href="javascript:insertDBtitle('专利号=')"><span class="label">专利号 </span>
						</a> <a href="javascript:insertDBtitle('公开（公告）日=')"><span class="label">公开（公告）日</span>
						</a> <a href="javascript:insertDBtitle('名称=')"><span class="label">名称</span>
						</a> <a href="javascript:insertDBtitle('摘要=')"><span class="label">摘要</span>						
						</a> <a href="javascript:insertDBtitle('主分类号=')"><span class="label">主分类号</span>
						</a> <a href="javascript:insertDBtitle('分类号=')"><span class="label">分类号</span>
						</a> <a href="javascript:insertDBtitle('申请（专利权）人=')"><span class="label">申请（专利权）人</span>
						</a> <a href="javascript:insertDBtitle('发明（设计）人=')"><span class="label">发明（设计）人</span>						
						<!-- </a> <a href="javascript:insertDBtitle('优先权=')"><span class="label">优先权</span>
						</a> <a href="javascript:insertDBtitle('同族专利项=')"><span class="label">同族专利项</span>-->
						</a> 
					</div>
					<div style="padding-top: 15px;">
						<textarea style="width:95%;resize:none;" id="db-mult-text">aaaa</textarea>
					</div>
					<div class="btn-group pull-left">
					<!-- 
						<button class="btn" type="button" onclick="insertDBtitle(' AND ')">AND</button>
						<button class="btn" type="button" onclick="insertDBtitle(' OR ')">OR</button>
						<button class="btn" type="button" onclick="insertDBtitle(' ( ')">(</button>
						<button class="btn" type="button" onclick="insertDBtitle(' ) ')">)</button>
					 -->
					 <label style="width:105px;cursor:hand" class="checkbox">
						<input id="optionsRadios1" name="searchType" value="AND" checked="checked" type="radio">二次检索</label>
					<label style="width:105px;cursor:hand" class="checkbox">
						<input id="optionsRadios2" name="searchType" value="NOT" type="radio">过滤检索</label>
						
					</div>
					<div class="btn-group pull-right">
						<button class="btn btn-primary" type="button"
							onclick="dbSearchNodeData()">
							<i class="icon-search icon-white"></i>&nbsp;检索
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>