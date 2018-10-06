<%@ page language="java" pageEncoding="UTF-8"%>

<div style="width: 850px; height: 620px;overflow:scroll;" class="modal hide fade"
	id="frexpModal" tabindex="2" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header mycolor" style="padding: 0px 15px;margin-top:20px;background-color: #fff;color:#666666">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">
					<%=website_title%>
				</h4>
			</div>

		<ol class="inline long" style="padding:8px;">
		<c:forEach var="channel" items="${requestScope.channel_fr}">			
			<li><label style="width:105px;cursor:hand" class="checkbox">
			<input type="checkbox" type="checkbox" tag="${channel.chrChannelName}" value1="${channel.intChannelID}" value="${channel.chrTRSTable}" name="strdb" ${channel.chrIndexCheck} 
			 style="cursor:hand">${channel.chrChannelName}</label></li>			
		</c:forEach>
		</ol>

<base target="_self"/>

<div class="row-fluid">
			<div style="background-color: #ffffff;margin: auto;padding:0px 8px;">
			<table class="table table-condensed" style="font-size:12px;border: 2px solid #ffffff;">
				<tr>
					<td class="table_10"><label class="control-label" for="txt_A">申请号：</label></td>
					<td class="table_40"><input type="text" field="申请号" id="txt_A" class="input-medium" /><span class="muted"> 例如:US201113990034</span></td>
					<td class="table_10"><label class="control-label" for="txt_B">申请日：</label></td>
					<td class="table_40"><input type="text" field="申请日" class="form_datetime" id="txt_B" /><span class="muted"> 例如:200201</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_C">专利号：</label></td>
					<td class="table_40"><input type="text" field="专利号" id="txt_C" name="txt_C" class="input-medium"/><span class="muted"> 例如:US2014022727</span></td>
					<td class="table_10" nowrap><label class="control-label"  for="txt_D">公开（公告）日：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）日" class="form_datetime" id="txt_D"  /><span class="muted"> 例如:200401</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_E">名称：</label></td>
					<td class="table_40"><input type="text" field="名称" id="txt_E"  class="input-medium"/><span class="muted"> 例如:computer</span></td>
					<td class="table_10"><label class="control-label" for="txt_F">摘要：</label></td>
					<td class="table_40"><input type="text" field="摘要" id="txt_F"  class="input-medium" /><span class="muted"> 例如:computer</span></td>
				</tr>
				<tr>
					<!--
					<td class="table_10"><label class="control-label" for="txt_G" onClick="insertItem(obj, 'G');">主分类号：</label></td>
					<td class="table_40"><input type="text" field="主分类号" id="txt_G" name="txt_G" style="width: 165px;height:18px;" /><span class="muted"> 例如:A43B5/04</span></td>
					-->
					<td class="table_10"><label class="control-label" for="txt_G">主分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="主分类号" id="txt_G" />
<a><i class="icon-search"  id="fr_mainipc_button"></i></a>

											</span><span class="muted"> 例如:G06F15/16 </span></td>
					
					<!-- 
					<td class="table_10"><label class="control-label" for="txt_H" onClick="insertItem(obj, 'H');">分类号：</label></td>
					<td class="table_40"><input type="text" field="分类号" id="txt_H" name="txt_H" style="width: 165px;height:18px;" /><span class="muted"> 例如:A43B5/04</span></td>
					 -->
					<td class="table_10"><label class="control-label" for="txt_H"> 分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="分类号" id="txt_H" />
<a><i class="icon-search"  id="fr_ipc_button"></i></a>
											 
											</span><span class="muted"> 例如:G06F15/16 </span>
											
											
											</td>
					
				</tr>
				<tr>
					<td class="table_10" nowrap><label class="control-label" for="txt_I">申请（专利权）人：</label></td>
					<td class="table_40"><input type="text" field="申请（专利权）人" id="txt_I" /> <span class="muted"> 例如:YEH HUNG-YAO</span></td>
					<td class="table_10"><label class="control-label" for="txt_J">发明（设计）人：</label></td>
					<td class="table_40"><input type="text" field="发明（设计）人" id="txt_J" class="input-medium"/><span class="muted"> 例如:BERTOTTO EZIO</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_U">优先权：</label></td>
					<td class="table_40"><input type="text" field="优先权" id="txt_U" class="input-medium"/><span class="muted"> 例如:20120719</span></td>
					<td class="table_10"><label class="control-label" for="txt_P">同族专利项：</label></td>
					<td class="table_40"><input type="text" field="同族专利项" id="txt_P" class="input-medium"/><span class="muted"> 例如:US6354470</span></td>
				</tr>
			</table>
					</div>
				</div>
<div style="padding:8px;">
<div>
 <textarea id="frtxtComb" name="frtxtComb" rows="4" style="width: 750px; margin-bottom: 0px;"></textarea>
</div>
<div style="height:10px;"></div>
<center>
<input class="btn btn-info" type="button"  id="frrender" value="生成表达式">
</center>
</div>
</div>
		</div>
	</div>
</div>

<script>
$(function(){
	
	
	
    $("#fr_mainipc_button").click(function(){    	
    	$("#ipctype").val("frmainipc");
    	$("#treeType").val(0);
    	init_tree();    	
    	$("#flhs").val("");
        $("#ipcgmjjModal").modal("toggle");
    });
    
    $("#fr_ipc_button").click(function(){    	
    	$("#ipctype").val("fripc");
    	$("#treeType").val(0);
    	init_tree();
    	$("#flhs").val("");
        $("#ipcgmjjModal").modal("toggle");
    });
    
})

//$("label").attr("for");
//document.querySelector(`label[for="${forValue}"]`).innerHTML;
$("#frexpModal label[class=control-label]").click(function(){
	//control-label
	
	//alert(label[for="${forValue}"].html());
	//alert(this.attr("for"));
	//alert(this.attr("for"));
	var label_for = this.getAttribute("for");

//alert(this.innerText);	
//alert($("#"+label_for).val());
	if($.trim($("#frexpModal #"+label_for).val())===''){
		alert("请输入“"+$.trim(this.innerText.replace("：",""))+"”的值");
		return;
	}
	
	var searchword = $("#frtxtComb").val();
	searchword = $.trim(searchword);
	if(searchword!=''){
		searchword += " and ";
	}
//alert(searchword);	
	
	searchword += "(" + $.trim(this.innerText.replace("：","")) +"="+ $.trim($("#frexpModal #"+label_for).val())+")";
	$("#frtxtComb").val(searchword);
});

function frrenderdb(){
/*
	var checkedArray = new Array();//放已经选择的checkbox的value
	checkedArray.length=0;
//	count=0;
	$('[name=strdb]:checkbox:checked').each(function() {
		checkedArray.push($(this).val());
//		count++;
	});
	if (checkedArray.length==0) {
		alert("请选择检索库");
		return;
	}
*/
//$("#txt").attr("value")；
	var s_db_name = "";
	var s_db = "";
	$('#frexpModal [name=strdb]:checkbox:checked').each(function() {
//checkedArray.push($(this).val());
//s_db_name += ","+$(this).attr("tag");		
//s_db += ","+$(this).val();
		
		if(s_db_name!=''){
			s_db_name += ",";
		}
		s_db_name += $(this).attr("tag");
		
		if(s_db!=''){
			s_db += ",";
		}
		s_db += $(this).val();		
	});	
	
	$("#FRChannels").val(s_db);	
	$("#FRChannelsName").html(s_db_name);
	
//alert(s_db_name);
//alert(s_db);
}

$("#frrender").click(function(){
	frrenderdb();
//alert($("#txtComb").val());
	  $("#chrFRExpression").val($("#frtxtComb").val());
	  
	  frcountnum();
	  var resultcount = parseInt($("#frresultcount").html());
	  
	  if(resultcount==0){
		  alert("此表达式检索结果为空，请重新编辑");
	  }else{		  
		  $('#frexpModal').modal('hide');
	  }	  
	  
});

function frcountnum(){
	var left_bracket=0;
	var right_bracket=0;
	
	var _txtComb = $("#frtxtComb").val();
	for(i=0;i<_txtComb.length;i++){
//		 alert(str.charAt(i));
		var _char = _txtComb.charAt(i);
		if(_char==='('||_char==='（')
		{
			left_bracket++;
		}
		if(_char===')'||_char==='）')
		{
			right_bracket++;
		}    			 
	}
	
	if(left_bracket!=right_bracket){
		alert("您输入的表达式左右括号不匹配，请重新输入");
		return;
	}
	
	var searchword = $.trim($("#frtxtComb").val());
	var channels = $("#FRChannels").val();

$("body").mask("正在处理中，请稍候...");
		var text = "";
		$.ajax({
			type : "GET",
//			url : "/" + contextPath + "/logicSaveExpression.do?timeStamp=" + new Date(),
//			url : _url + "logicSaveExpression.do?timeStamp=" + new Date(),
			url : "logicSaveExpression.do?timeStamp=" + new Date(),
			
			data : {
				'strChannels' : channels,
				'strSources' : channels,
				'strWhere' : searchword,
				'area' : 'fr',
				'language' : 'fr',
				'totalPages' : 0
			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
$("body").unmask();
				//alert(jsonresult);				
				$("#frresultcount").html(jsonresult);
			}
		})
}
</script>