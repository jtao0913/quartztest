<%@ page language="java" pageEncoding="UTF-8"%>

<script type="text/javascript">
function fun_collapse(no){
	if(no!=1){
	$('#collapse_1').html("");if($('#collapse1').hasClass('in')){$('#collapse1').collapse('hide');}
	}	
	if(no!=2){
	$('#collapse_2').html("");if($('#collapse2').hasClass('in')){$('#collapse2').collapse('hide');}	
	}
	if(no!=3){
	$('#collapse_3').html("");if($('#collapse3').hasClass('in')){$('#collapse3').collapse('hide');}
	}
	if(no!=4){
	$('#collapse_4').html("");if($('#collapse4').hasClass('in')){$('#collapse4').collapse('hide');}
	}
	if(no!=5){
	$('#collapse_5').html("");if($('#collapse5').hasClass('in')){$('#collapse5').collapse('hide');}
	}
	if(no!=6){
	$('#collapse_6').html("");if($('#collapse6').hasClass('in')){$('#collapse6').collapse('hide');}
	}
	if(no!=7){
	$('#collapse_7').html("");if($('#collapse7').hasClass('in')){$('#collapse7').collapse('hide');}
	}
	if(no!=8){
	$('#collapse_8').html("");if($('#collapse8').hasClass('in')){$('#collapse8').collapse('hide');}
	}
	if(no!=9){
	$('#collapse_9').html("");if($('#collapse9').hasClass('in')){$('#collapse9').collapse('hide');}
	}
	if(no!=10){
	$('#collapse_10').html("");if($('#collapse10').hasClass('in')){$('#collapse10').collapse('hide');}
	}
	if(no!=11){
	$('#collapse_11').html("");if($('#collapse11').hasClass('in')){$('#collapse11').collapse('hide');}
	}
	if(no!=12){
	$('#collapse_12').html("");if($('#collapse12').hasClass('in')){$('#collapse12').collapse('hide');}
	}
	if(no!=13){
	$('#collapse_13').html("");if($('#collapse13').hasClass('in')){$('#collapse13').collapse('hide');}
	}
	if(no!=14){
	$('#collapse_14').html("");if($('#collapse14').hasClass('in')){$('#collapse14').collapse('hide');}
	}
	if(no!=15){
	$('#collapse_15').html("");if($('#collapse15').hasClass('in')){$('#collapse15').collapse('hide');}
	}
	if(no!=16){
	$('#collapse_16').html("");if($('#collapse16').hasClass('in')){$('#collapse16').collapse('hide');}
	}
	if(no!=17){
	$('#collapse_17').html("");if($('#collapse17').hasClass('in')){$('#collapse17').collapse('hide');}
	}
}

function showleftmenu(params,map_data_single,searchType){

if(params.xAxis==='PATTYPE'){
	showOverviewSection(1,map_data_single);									
//	showOverviewPattypeSection(map_data_single);									
	if(searchType===1||searchType==="1"){
		fun_collapse(1);
	}
}else if(params.xAxis==='最新法律状态'){
	showOverviewSection(2,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(2);
	}
}else if(params.xAxis==='运营信息'){
	showOverviewSection(3,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(3);
	}
}else if(params.xAxis==='申请人'){
	showOverviewSection(4,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(4);
	}
}else if(params.xAxis==='第一申请人'){
	showOverviewSection(5,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(5);
	}
}else if(params.xAxis==='发明人'){
	showOverviewSection(6,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(6);
	}
}else if(params.xAxis==='公开年'){
	showOverviewSection(7,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(7);
	}
}else if(params.xAxis==='申请年'){
	showOverviewSection(8,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(8);
	}
}
/*
else if(params.xAxis==='IPC部'){
	showOverviewSection(9,map_data_single);
	//alert("searchType...."+searchType);
	if(searchType===1||searchType==="1"){
		fun_collapse(9);
	}
}else if(params.xAxis==='IPC大类'){
	showOverviewSection(10,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(10);
	}
}
*/
else if(params.xAxis==='IPC小类'){
	showOverviewSection(9,map_data_single);
	//alert("searchType...."+searchType);
	if(searchType===1||searchType==="1"){
		fun_collapse(9);
	}
}
/*
else if(params.xAxis==='IPC大组'){
	showOverviewSection(10,map_data_single);
	//alert("searchType...."+searchType);
	if(searchType===1||searchType==="1"){
		fun_collapse(10);
	}
}
else if(params.xAxis==='IPC分类号'){
	showOverviewSection(13,map_data_single);
	//alert("searchType...."+searchType);
	if(searchType===1||searchType==="1"){
		fun_collapse(13);
	}
}
*/
else if(params.xAxis==='外观分类号'){
	showOverviewSection(10,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(10);
	}
}
else if(params.xAxis==='专利代理机构分析'){
	showOverviewSection(11,map_data_single);
	//alert("searchType...."+searchType);
	if(searchType===1||searchType==="1"){
		fun_collapse(11);
	}
}else if(params.xAxis==='代理人分析'){
	showOverviewSection(12,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(12);
	}
}
else if(params.xAxis==='专利类型'){
	showOverviewSection(13,map_data_single);
	if(searchType===1||searchType==="1"){
		fun_collapse(13);
	}
}





}
</script>
