<%@ page language="java" pageEncoding="UTF-8"%>

	<div style="height:15px;"></div>
		<ol class="inline long">
		<c:forEach var="channel" items="${requestScope.channelTag}">			
			<li><label style="width:105px;cursor:hand" class="checkbox">
			<!--
			<img style="width:30px;margin-bottom:5px" class="img-responsive " src="images/cn/${channel.intChannelID}.png">
			-->
			<input type="checkbox" type="checkbox" onclick="channelChecked();" value1="${channel.intChannelID}" value="${channel.chrTRSTable}" name="strdb" ${channel.chrCheck}
			 style="cursor:hand">${channel.chrChannelName}</label></li>			
		</c:forEach>
		</ol>

<base target="_self"/>

		<div class="row-fluid">
					<div style="background-color: #ffffff;margin: auto;">

			<table class="table table-condensed" style="font-size:12px;border: 2px solid #ffffff;">
				<tr>
					<td class="table_10"><label class="control-label" for="txt_A" onClick="insertItem(obj, 'A');">申请号：</label></td>
					<td class="table_40"><input type="text" field="申请号" id="txt_A" name="txt_A" class="input-medium" /><span class="muted"> 例如:CN201580063671.5</span></td>
					<td class="table_10"><label class="control-label" onClick="insertItem(obj, 'B');">申请日：</label></td>
					<td class="table_40"><input type="text" field="申请日" class="form_datetime" id="txt_B" name="txt_B" /><span class="muted"> 例如:20101010</span></td>
				</tr>
				<tr>
					<td class="table_10" nowrap><label class="control-label" for="txt_C" onClick="insertItem(obj, 'C');">公开（公告）号：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）号" id="txt_C" name="txt_C" class="input-medium" /><span class="muted"> 例如:CN1387751</span></td>
					<td class="table_10" nowrap><label class="control-label" onClick="insertItem(obj, 'D');">公开（公 告）日：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）日" class="form_datetime" id="txt_D" name="txt_D" /><span class="muted"> 例如:20110105</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_E" onClick="insertItem(obj, 'E');">名称：</label></td>
					<td class="table_40"><input type="text" field="名称" id="txt_E" name="txt_E" class="input-m edium"/><span class="muted"> 例如:计算机</span></td>
					<td class="table_10"><label class="control-label" for="txt_F" onClick="insertItem(obj, 'F');">摘要：</label></td>
					<td class="table_40"><input type="text" field="摘要" id="txt_F" name="txt_F" class="input-medium"/><span class="muted"> 例如:计算机</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_K" onClick="insertItem(obj, 'K');">主权项：</label></td>
					<td class="table_40"><input type="text" field="主权项" id="txt_K" name="txt_K" class="input-m edium"/><span class="muted"> 例如:计算机</span></td>
					<td class="table_10"><label class="control-label" for="txt_P" onClick="insertItem(obj, 'P');">优先权：</label></td>
					<td class="table_40"><input type="text" field="优先权" id="txt_P" name="txt_P" class="input-medium"/><span class="muted"> 例如:02112242</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_S" onClick="insertItem(obj, 'S');">最新法律状态：</label></td>
					<td class="table_40"><input type="text" field="最新法律状态" id="txt_S" name="txt_S" class="input-m edium"/><span class="muted"> 例如:有效、无效、在审</span></td>
					<td class="table_10"><label class="control-label" for="txt_T" onClick="insertItem(obj, 'T');">国民经济代码：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="国民经济代码" id="txt_T" name="txt_T" class="input-medium" style="width: 125px;height:18px;"/>
					<a href="<%=basePath%>jsp/window/subWindowGMJJ.jsp?textId=txt_T&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent"
											title="国民经济代码" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a>
					</span><span class="muted"> 例如:0111、3053</span></td>
				</tr>				
				<tr>
					<td class="table_10"><label class="control-label" for="txt_G" onClick="insertItem(obj, 'G');">主分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="主分类号" id="txt_G" name="txt_G"
											style="width: 125px;height:18px;" />
<a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_G&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent"
											title="主分类号" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a>
											</span><span class="muted"> 例如:G06F15/16 </span></td>						
					
					<td class="table_10"><label class="control-label" for="txt_H"
									onClick="insertItem(obj, 'H');"> 分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="分类号" id="txt_H" name="txt_H"
											style="width: 125px;height:18px;" />
<a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_H&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent" title="分类号" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a>
											</span><span class="muted"> 例如:G06F15/16 </span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_I" onClick="insertItem(obj, 'I');">申请（专 利 权）人：</label></td>
					<td class="table_40"><input type="text" field="申请（专利权）人" id="txt_I" name="txt_I" /> <span class="muted"> 例如:顾学平</span></td>
					<td class="table_10"><label class="control-label" for="txt_J" onClick="insertItem(obj, 'J');">发明（设 计）人：</label></td>
					<td class="table_40"><input type="text" field="发明（设计）人" id="txt_J" name="txt_J" class="input-medium"/><span class="muted"> 例如:顾学平</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_L" onClick="insertItem(obj, 'L');">地址：</label></td>
					<td class="table_40"><input type="text" field="地址" id="txt_L" name="txt_L" class="input-medium"/><span class="muted"> 例如:鞍山市</span></td>
					<td class="table_10"><label class="control-label" for="txt_O" onClick="insertItem(obj, 'O');">国省代码：</label></td>
					<td class="table_40"><input type="text" field="国省代码" id="txt_O" name="txt_O" class="input-medium"/><span class="muted"> 例如:江苏% 或 %32%</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_M" onClick="insertItem(obj, 'M');">专利代理机构：</label></td>
					<td class="table_40"><input type="text" field="专利代理机构" id="txt_M" name="txt_M" class="input-medium"/><span class="muted"> 例如:柳沈</span></td>
					<td class="table_10"><label class="control-label" for="txt_N" onClick="insertItem(obj, 'N');">代理人：</label></td>
					<td class="table_40"><input type="text" field="代理人" id="txt_N" name="txt_N" class="input-medium"/><span class="muted"> 例如:李恩庆  </span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for=txt_Q onClick="insertItem(obj, 'Q');">权利要求书：</label></td>
					<td class="table_40"><input type="text" field="权利要求书" id="txt_Q" name="txt_Q" class="input-medium" /><span class="muted"> 例如:计算机 </span></td>
					<td class="table_10"><label class="control-label" for="txt_R" onClick="insertItem(obj, 'R');">说明书：</label></td>
					<td class="table_40"><input type="text" field="说明书" id="txt_R" name="txt_R" class="input-medium" /><span class="muted"> 例如:计算机</span></td>
				</tr>
			</table>
                  
            </div></div>
