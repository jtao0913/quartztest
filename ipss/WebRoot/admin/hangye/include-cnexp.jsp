<%@ page language="java" pageEncoding="UTF-8"%>

<style type="text/css">
input[type=text]{width:120px;height:20px;margin:0;}
</style>

<div style="width: 880px; height: 620px;overflow:scroll;" class="modal hide fade"
	id="cnexpModal" tabindex="1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="false">
	<div class="modal-dialog">
		<div class="modal-content" >
			<div class="modal-header mycolor" style="padding: 0px 15px;margin-top:20px;background-color: #fff;color:#666666">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">
					<%=website_title%>
				</h4>
			</div>

		<ol class="inline long" style="padding:8px;">
		<c:forEach var="channel" items="${requestScope.channel_cn}">			
			<li><label style="width:105px;cursor:hand" class="checkbox">
			<input type="checkbox" type="checkbox" tag="${channel.chrChannelName}" value1="${channel.intChannelID}" value="${channel.chrTRSTable}" name="strdb" ${channel.chrCheck}
			 style="cursor:hand">${channel.chrChannelName}</label></li>			
		</c:forEach>
		</ol>

<base target="_self"/>

		<div class="row-fluid">
				<div style="background-color: #ffffff;margin: auto;padding:0px 8px;">

			<table class="table table-condensed" style="font-size:12px;border: 2px solid #ffffff;">
				<tr >
					<td class="table_10"><label class="control-label" for="txt_A">申请号：</label></td>
					<td class="table_40"><input  type="text" field="申请号" id="txt_A" name="txt_A" class="input-medium"  /><span class="muted"> 例如:CN201580063671.5</span></td>
					<td class="table_10"><label class="control-label"  for="txt_B">申请日：</label></td>
					<td class="table_40"><input type="text" field="申请日" class="form_datetime" id="txt_B" name="txt_B" /><span class="muted"> 例如:20101010</span></td>
				</tr>
				<tr>
					<td class="table_10" nowrap><label class="control-label" for="txt_C">公开（公告）号：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）号" id="txt_C" name="txt_C" class="input-medium" /><span class="muted"> 例如:CN1387751</span></td>
					<td class="table_10" nowrap><label class="control-label" for="txt_D">公开（公告）日：</label></td>
					<td class="table_40"><input type="text" field="公开（公告）日" class="form_datetime" id="txt_D" name="txt_D" /><span class="muted"> 例如:20110105</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_E">名称：</label></td>
					<td class="table_40"><input type="text" field="名称" id="txt_E" name="txt_E" class="input-m edium"/><span class="muted"> 例如:计算机</span></td>
					<td class="table_10"><label class="control-label" for="txt_F">摘要：</label></td>
					<td class="table_40"><input type="text" field="摘要" id="txt_F" name="txt_F" class="input-medium"/><span class="muted"> 例如:计算机</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_K">主权项：</label></td>
					<td class="table_40"><input type="text" field="主权项" id="txt_K" name="txt_K" class="input-m edium"/><span class="muted"> 例如:计算机</span></td>
					<td class="table_10"><label class="control-label" for="txt_P">优先权：</label></td>
					<td class="table_40"><input type="text" field="优先权" id="txt_P" name="txt_P" class="input-medium"/><span class="muted"> 例如:02112242</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_S">最新法律状态：</label></td>
					<td class="table_40"><input type="text" field="最新法律状态" id="txt_S" name="txt_S" class="input-m edium"/><span class="muted"> 例如:有效、无效、在审</span></td>
					<td class="table_10"><label class="control-label" for="txt_T">国民经济代码：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="国民经济代码" id="txt_T" name="txt_T" class="input-medium"/>
					
					<a><i class="icon-search"  id="gmjj_button"></i></a>

					</span><span class="muted"> 例如:0111、3053</span></td>
				</tr>				
				<tr>
					<td class="table_10">
					
					
					
					<label class="control-label" for="txt_G">主分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="主分类号" id="txt_G" name="txt_G"/>
					<a><i class="icon-search"  id="mainipc_button"></i></a>
<!-- 
<a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_G&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent"
											title="主分类号" class="thickbox btn" style="height:10px;"><i class="icon-search"></i></a> -->
											
											
											
											</span><span class="muted"> 例如:G06F15/16 </span></td>						
					
					<td class="table_10"><label class="control-label" for="txt_H"> 分类号：</label></td>
					<td class="table_40"><span class="input-append"><input type="text" field="分类号" id="txt_H" name="txt_H"/>
					<a><i class="icon-search"  id="ipc_button"></i></a>
					
<!-- <a href="<%=basePath%>jsp/window/subWindowIPCAssort.jsp?textId=txt_H&TB_iframe=true&height=500&width=610&inlineId=myOnPageContent" title="分类号" class="thickbox btn" style="height:18px;"><i class="icon-search"></i></a> -->
											</span><span class="muted"> 例如:G06F15/16 </span></td>
				</tr>
				<tr>
					<td class="table_10" nowrap><label class="control-label" for="txt_I">申请（专利权）人：</label></td>
					<td class="table_40"><input type="text" field="申请（专利权）人" id="txt_I" name="txt_I" /> <span class="muted"> 例如:顾学平</span></td>
					<td class="table_10"><label class="control-label" for="txt_J">发明（设计）人：</label></td>
					<td class="table_40"><input type="text" field="发明（设计）人" id="txt_J" name="txt_J" class="input-medium"/><span class="muted"> 例如:顾学平</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_L">地址：</label></td>
					<td class="table_40"><input type="text" field="地址" id="txt_L" name="txt_L" class="input-medium"/><span class="muted"> 例如:鞍山市</span></td>
					<td class="table_10"><label class="control-label" for="txt_O">国省代码：</label></td>
					<td class="table_40"><input type="text" field="国省代码" id="txt_O" name="txt_O" class="input-medium"/><span class="muted"> 例如:江苏% 或 %32%</span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for="txt_M">专利代理机构：</label></td>
					<td class="table_40"><input type="text" field="专利代理机构" id="txt_M" name="txt_M" class="input-medium"/><span class="muted"> 例如:柳沈</span></td>
					<td class="table_10"><label class="control-label" for="txt_N">代理人：</label></td>
					<td class="table_40"><input type="text" field="代理人" id="txt_N" name="txt_N" class="input-medium"/><span class="muted"> 例如:李恩庆  </span></td>
				</tr>
				<tr>
					<td class="table_10"><label class="control-label" for=txt_Q>权利要求书：</label></td>
					<td class="table_40"><input type="text" field="权利要求书" id="txt_Q" name="txt_Q" class="input-medium" /><span class="muted"> 例如:计算机 </span></td>
					<td class="table_10"><label class="control-label" for="txt_R">说明书：</label></td>
					<td class="table_40"><input type="text" field="说明书" id="txt_R" name="txt_R" class="input-medium" /><span class="muted"> 例如:计算机</span></td>
				</tr>
			</table>
                  
            </div></div>
<div style="padding:8px;">
 <div>
<textarea id="txtComb" name="txtComb" rows="4" style="width: 750px; margin-bottom: 0px;"></textarea>
</div>
<div style="height:10px;"></div>
<center>
<input class="btn btn-info" type="button"  id="render" value="生成表达式">
</center>
</div>
		</div>
	</div>
</div>

<script>
$(function(){
	var ipctips = "<font style=\"color: #cc6600;\">提示:</font> 请使用“IPC分类表查询”或浏览“IPC分类”树的方式，选择您所要作为检索条件的IPC分类号，选中的IPC分类号将会自动填写到“专利检索”的“分类号”中，作为检索条件，进行专利信息查询。		可以多次选择不同的IPC分类号，所选的IPC分类号将以“或”的关系成为检索条件。";
	var gmjjtips = "<font style=\"color: #cc6600;\">提示:</font> 国民经济行业分类将国民经济行业划分为门类、大类、中类和小类四级，本分类参照关系表在国民经济行业小类层	级与国际专利分类构建了对照关系。涉及专利技术的国民经济行业小类共680个，分属于三次产业的7个门类产业。";
	
	
    $("#mainipc_button").click(function(){    	
    	$("#ipctype").val("mainipc");
    	$("#treeType").val(0);
    	init_tree();    	
    	$("#flhs").val("");
    	$("#tips").html(ipctips);
        $("#ipcgmjjModal").modal("toggle");
    });
    
    $("#ipc_button").click(function(){    	
    	$("#ipctype").val("ipc");
    	$("#treeType").val(0);
    	init_tree();
    	$("#flhs").val("");
    	$("#tips").html(ipctips);
        $("#ipcgmjjModal").modal("toggle");
    });
    
    
    $("#gmjj_button").click(function(){    	
//   	$("#ipctype").val("ipc");
		$("#treeType").val(4);
		init_tree();
		$("#flhs").val("");
		$("#tips").html(gmjjtips);
        //$("#gmjjModal").modal("toggle");
        $("#ipcgmjjModal").modal("toggle");
    });
    
})

//$("label").attr("for");
//document.querySelector(`label[for="${forValue}"]`).innerHTML;
$("#cnexpModal label[class=control-label]").click(function(){
	//control-label
	
	//alert(label[for="${forValue}"].html());
	//alert(this.attr("for"));
	//alert(this.attr("for"));
	var label_for = this.getAttribute("for");

//alert(this.innerText);	
//alert($("#"+label_for).val());
	if($.trim($("#cnexpModal #"+label_for).val())===''){
		alert("请输入“"+$.trim(this.innerText.replace("：",""))+"”的值");
		return;
	}
	
	var searchword = $("#txtComb").val();
	searchword = $.trim(searchword);
	if(searchword!=''){
		searchword += " and ";
	}
//alert(searchword);	
	
	searchword += "(" + $.trim(this.innerText.replace("：","")) +"="+ $.trim($("#cnexpModal #"+label_for).val())+")";
	$("#txtComb").val(searchword);
});

function renderdb(){
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
	$('#cnexpModal [name=strdb]:checkbox:checked').each(function() {
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
	
	$("#CNChannels").val(s_db);	
	$("#CNChannelsName").html(s_db_name);	
//alert(s_db_name);
//alert(s_db);
}

$("#render").click(function(){
	renderdb();
//alert($("#txtComb").val());
	  $("#chrExpression").val($("#txtComb").val());
	  
	  countnum();
	  var resultcount = parseInt($("#cnresultcount").html());
	  
	  if(resultcount==0){
		  alert("此表达式检索结果为空，请重新编辑");
	  }else{		  
		  $('#cnexpModal').modal('hide');
	  }	  
	  
});

function countnum(){
	var left_bracket=0;
	var right_bracket=0;
	
	var _txtComb = $("#txtComb").val();
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
	
	var searchword = $.trim($("#txtComb").val());
	var channels = $("#CNChannels").val();

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
				'area' : 'cn',
				'language' : 'cn',
				'totalPages' : 0
			},
//			data : $("#loginform").serialize(),
			contentType : "application/json;charset=UTF-8",
			success : function(jsonresult) {
$("body").unmask();
				//alert(jsonresult);
				
				$("#cnresultcount").html(jsonresult);
			}
		})
}
</script>