<%@ page contentType="text/html;charset=UTF-8"%>

<%String path = request.getContextPath(); %>

<%
String showType = request.getParameter("showType");
if(showType == null || showType.equals("")){
	showType = "outline";
}
%>

<Script language="JavaScript">
var content = "";
var contentNum = "";

function jieguoTranslate(){
	contents = "";
	var arr_patent_name_en;
	
	if('<%=showType%>'=="detail"){
		arr_patent_name_en = window.parent.document.getElementsByTagName("span");
	}else{
		arr_patent_name_en = window.parent.sOutline.document.getElementsByTagName("span");
	}
	//alert(arr_patent_name_en.length);
	
	for(var i=0;i<arr_patent_name_en.length;i++){
		var en_span = arr_patent_name_en[i];
//alert(i+"......>"+arr_patent_name_en[i].id);
		if(en_span.id.indexOf("patent_name_en_")==0){
			var innertext = en_span.innerText;
			innertext = innertext.replace(/(^\s*)|(\s*$)/g, "");
			//innertext = innertext.replaceAll(" ","%23%23");
			//innertext = UrlEncode(innertext);
			//alert(innertext);
			//content+="param"+i+"="+innertext+"&";
			//var  = en_span.id.substring(en_span.id.lastIndexOf("_"));
			contents += en_span.id.substring(en_span.id.lastIndexOf("_")+1) +"==="+innertext;
			if(i<arr_patent_name_en.length-1){
				contents += "!!!";
			}
		}
	}
//alert(contents);
	//writelog("<br><br><br>");
	//writelog(content);
	//writelog("<br><br><br>");

	//content+="paramnum="+arr_patent_name_en.length;
	
	//alert(contents);
	//alert(contentNum);
	
	var contentArray = contents.split("");
	content = "";
	for (var i = 0 ; i < contentArray.length ; i++){
		content += "A" + contentArray[i].charCodeAt();
	}
}

String.prototype.replaceAll  = function(s1,s2){
	return this.replace(new RegExp(s1,"gm"),s2);    
} 

jieguoTranslate();
</Script>

<form name="translate_param_form" action="machine-translate-start.jsp" method="post">
<input type="hidden" name="content">
<input type="hidden" name="showType">
</form>

<script>
//alert(content);
document.translate_param_form.content.value = content;
document.translate_param_form.showType.value = '<%=showType%>';
document.translate_param_form.submit();
</script>