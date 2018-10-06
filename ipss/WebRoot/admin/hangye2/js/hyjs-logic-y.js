function ShowMore()
{
	if(document.all.extend.style.display == "none")
	{
		document.all.extend.style.display="";
		document.all.btnMore.src="images/btnHide.gif";
		document.all.btnMore.title="点击隐藏运算符";
	}
	else
	{
		document.all.extend.style.display="none";
		document.all.btnMore.src="images/btnShow.gif";
		document.all.btnMore.title="点击显示更多运算符";
	}
}

function insertAtCaret (text) 
{
	var b1=document.forms[0].txtSearchWord.value;
	var str=text.value;
	
	while (str.indexOf("\\/")!= -1) {
		str=str.replace("\\/","/");
	}

	while (str.indexOf("？")!= -1) {
		str=str.replace("？","?");
	}

	while (str.indexOf("％")!= -1) {
		str=str.replace("％","%");
	}

//	if (b1.length>0) 
//	{
		//document.forms[0].txtSearchWord.value = document.forms[0].txtSearchWord.value + str; 
		document.forms[0].txtSearchWord.focus();
		//document.selection.createRange().text += str;
		
		document.loginform.txtSearchWord.value += str;
//	}
//	else
//	{
//		document.forms[0].txtSearchWord.value = str; 
//	}
	document.forms[0].txtSearchWord.focus();
}  

function confirm()              
{
//alert('a1');
 var key ; 
 key = window.event.keyCode ;
//alert(key);
 if(key != null && key==13)
 {
// alert('a2');
 document.loginform.submit1.click (); 
 window.event.returnValue=false; 
 }
// alert('a3');
}

function formsubmit()
{
        var strdb="";
        for(var e=0;e<document.loginform.strdb.length;e++)
       {
         if(document.loginform.strdb[e].checked)
         {
            strdb=strdb+document.loginform.strdb[e].value+",";
         }
        } 

        strdb=strdb.substring(0,strdb.length-1);
        document.forms[0].channelid.value=strdb;
        document.forms[0].searchChannel.value=strdb;

	
	var str=document.forms[0].txtSearchWord.value;
	var re

//使用数字代替表达式
//        for(var i=1;i<=(document.loginform.sRecordNumber.value);i++)
//        {
//	    var HItem = eval("HWindow.document.all.H"+i)
//            str=str.replace("@"+i,"("+HItem._value+")"); 
//	  }
	str = replaceIdWithExpression(str);

	while (str.indexOf("？")!= -1) {
		str=str.replace("？","?");
	}
	while (str.indexOf("％")!= -1) {
		str=str.replace("％","%");
	}
	while (str.indexOf("（")!= -1) {
		str=str.replace("（","(");
	}
	while (str.indexOf("）")!= -1) {
		str=str.replace("）",")");
	}
	while (str.indexOf("＜")!= -1) {
		str=str.replace("＜","<");
	}
	while (str.indexOf("＞")!= -1) {
		str=str.replace("＞",">");
	}
	while (str.indexOf("＝")!= -1) {
		str=str.replace("＝","=");
	}
	while (str.indexOf("′")!= -1) {
		str=str.replace("′","'");
	}
	while (str.indexOf("  ")!= -1) {
		str=str.replace("  "," ");
	}	
	while (str.indexOf(" )")!= -1) {
		str=str.replace(" )",")");
	}
	while (str.indexOf("( ")!= -1) {
		str=str.replace("( ","(");
	}	
	while (str.indexOf("( (")!= -1) {
		str=str.replace("( (","((");
	}	

		
	while (str.indexOf("申请(专利)号")!= -1) {
		str=str.replace("申请(专利)号","申请号");
	}
	while (str.indexOf("公开(公告)号")!= -1) {
		str=str.replace("公开(公告)号","公开（公告）号");
	}
	while (str.indexOf("公开(公告)日")!= -1) {
		str=str.replace("公开(公告)日","公开（公告）日");
	}
	while (str.indexOf("申请(专利权)人")!= -1) {
		str=str.replace("申请(专利权)人","申请（专利权）人");
	}
	while (str.indexOf("发明(设计)人")!= -1) {
		str=str.replace("发明(设计)人","发明（设计）人");
	}



var stemp = "#"+document.loginform.presearchword.value+"#"
	if(document.loginform.secondsearch.checked)
	{
		str += " and (" + document.loginform.presearchword.value + ")";
	}

//return false;

//过滤检索相关      如果是过滤检索在当前检索语句前加上 % not (检索语句)
  if(document.loginform.filtersearch.checked&&stemp!="##")
	{
			str = str + " and % not ("+ document.loginform.presearchword.value+")";
  }
			//alert(str);
		 document.loginform.searchword.value=str;

//排序方式相关  得到检索的排序方式
	if(document.loginform.sortcolumn.value!="RELEVANCE")
	{
		document.loginform.sortfield.value=document.loginform.R1.value+document.loginform.sortcolumn.value;
	}
	else
	{
		document.loginform.sortfield.value=document.loginform.sortcolumn.value;	
	}

//同义词检索
     if (document.loginform.synonymous.checked)	 
     {
       document.loginform.extension.value="all";
     }
}

function replaceIdWithExpression(s)
{
	var s1 = "";
        var s2 = "";
        var HItem = "";
        var i = 0;
        var b = false;
        while(parseInt(i) < s.length)
        {
        	s1 = s.substring(i,i+1);
        	if(s1 == "@")
        		b = true;
        	if(b)
        	{
        		s2 += s1;
        		if(s1 == " " || parseInt(i) + 1 == s.length)
        		{
			        HItem = eval("HWindow.document.all.H"+s2.substring(1));
       				s = s.replace(s2,"("+HItem._value+") ");
        			b = false;
        			s2 = "";
        		}
        	}
		i++;
        }
        return s;
}

var Flag = false;
function Select(obj, item) 
{
    for (var i=0;i<obj.elements.length;i++)
    {
        var e = obj.elements[i];
        if (e.name == item)
    	   e.checked=Flag;
    }
    Flag=!Flag;
    if(!Flag)
    	obj.btnSelect.value = "取消";
    else
    	obj.btnSelect.value = "全选";
}