<%@ page language="java" pageEncoding="UTF-8"%>






 	 <!--表格检索-->
		<div class="row-fluid">
			<div style="background-color: #ffffff;margin: auto;">
			<table class="table table-condensed" style="font-size:12px;border: 2px solid #ffffff;">
				<tr>
					<td class="table_10"><label class="control-label" for="txt_A" onClick="insertItem(obj, 'A');">申请号：</label></td>
					<td class="table_40"><input type="text" field="申请号" id="txt_A" name="txt_A" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:US201113990034</span></td>
					<td class="table_10"><label class="control-label" onClick="insertItem(obj, 'B');">申请日：</label></td>
					<td class="table_40"><input type="text" field="申请日" class="form_datetime" id="txt_B" name="txt_B" style="width: 165px;height:18px;" /><span class="muted"> 例如:200201</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_C" onClick="insertItem(obj, 'C');">公开（公告）号：</label></td>
					<td class="table_40"><input type="text" field="专利号" id="txt_C" name="txt_C" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:US2014022727</span></td>
					<td class="table_10"><label class="control-label" onClick="insertItem(obj, 'D');">公开（公告）日：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）日" class="form_datetime" id="txt_D" name="txt_D" style="width: 165px;height:18px;" /><span class="muted"> 例如:200401</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_E" onClick="insertItem(obj, 'E');">名称：</label></td>
					<td class="table_40"><input type="text" field="名称" id="txt_E" name="txt_E" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:computer</span></td>
					<td class="table_10"><label class="control-label" for="txt_F" onClick="insertItem(obj, 'F');">摘要：</label></td>
					<td class="table_40"><input type="text" field="摘要" id="txt_F" name="txt_F" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:computer</span></td>
				</tr>
				<tr>
					<!--
					<td class="table_10"><label class="control-label" for="txt_G" onClick="insertItem(obj, 'G');">主分类号：</label></td>
					<td class="table_40"><input type="text" field="主分类号" id="txt_G" name="txt_G" style="width: 165px;height:18px;" /><span class="muted"> 例如:A43B5/04</span></td>
					-->
					<td class="table_10"><label class="control-label" for="txt_G" onClick="insertItem(obj, 'G');">主分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="主分类号" id="txt_G" name="txt_G"
											style="width: 125px;height:18px;" />
<a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_G&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent"
											title="主分类号" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a>

											</span><span class="muted"> 例如:G06F15/16 </span></td>
					
					<!-- 
					<td class="table_10"><label class="control-label" for="txt_H" onClick="insertItem(obj, 'H');">分类号：</label></td>
					<td class="table_40"><input type="text" field="分类号" id="txt_H" name="txt_H" style="width: 165px;height:18px;" /><span class="muted"> 例如:A43B5/04</span></td>
					 -->
					<td class="table_10"><label class="control-label" for="txt_H" onClick="insertItem(obj, 'H');"> 分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="分类号" id="txt_H" name="txt_H"
											style="width: 125px;height:18px;" />
<a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_H&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent" title="分类号" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a>
											 
											</span><span class="muted"> 例如:G06F15/16 </span>
											
											
											</td>
					
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_I" onClick="insertItem(obj, 'I');">申请（专利权）人：</label></td>
					<td class="table_40"><input type="text" field="申请（专利权）人" id="txt_I" name="txt_I" style="width: 165px;height:18px;" /> <span class="muted"> 例如:YEH HUNG-YAO</span></td>
					<td class="table_10"><label class="control-label" for="txt_J" onClick="insertItem(obj, 'J');">发明（设计）人：</label></td>
					<td class="table_40"><input type="text" field="发明（设计）人" id="txt_J" name="txt_J" class="input-medium" style="width: 165px;height:18px;"/><span class="muted"> 例如:BERTOTTO EZIO</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_U" onClick="insertItem(obj, 'U');">优先权：</label></td>
					<td class="table_40"><input type="text" field="优先权" id="txt_U" name="txt_U" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:20120719</span></td>
					<td class="table_10"><label class="control-label" for="txt_P" onClick="insertItem(obj, 'P');">同族专利项：</label></td>
					<td class="table_40"><input type="text" field="同族专利项" id="txt_P" name="txt_P" class="input-medium" style="width: 165px;height:18px;" /><span class="muted"> 例如:US6354470</span></td>
				</tr>
			</table>
					</div>
				</div>