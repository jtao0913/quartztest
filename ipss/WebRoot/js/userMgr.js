function formsmt(type){
   //$("#overTime").val(document.userFrm.SDate.value);
   //if(check());
   //alert(document.forms[0].SDate.value);
   //alert($("#overTime").val());
   if(type==0){
     if(check())
       $("#userFrm").submit();
   }else{
     if($("#overTime").val()==""){
	  alert("请设置过期时间！");
	}
    $("#userFrm").submit();
   }
}

function check(){
	var account = $("#account").val();
	if(account === ""){
	  alert("用户名不能为空！");
	  $("#account").focus();
	  return false;
	}
	var pwd = $("#pwd").val();
	if(pwd === ""){
	  alert("密码不能为空！");
	  $("#pwd").focus();
	  return false;
	}
	if(pwd != $("#repwd").val()){
	  alert("两次密码不一致，请重新输入");
	  $("#pwd").select();
	  return false;
	}
	if($("#overTime").val()==""){
	  alert("请设置过期时间！");
	}
	return true;
	  
}