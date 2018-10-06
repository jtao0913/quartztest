function TrimSpace(x)
{
	while((x.length>0) && (x.charAt(0)==' '))
    		x = x.substring(1,x.length);
 	while((x.length>0) && (x.lastIndexOf(' ') == (x.length - 1)))
    		x = x.substring(0,x.length-1);
  	return x;
}

arrInputName = new Array;

if(vCountry == "0")
{
	arrInputName[0] = new Array();
	arrInputName[0][0]="txtA";
	arrInputName[0][1]="A";
	arrInputName[0][2]="AN";
	arrInputName[0][3]="";
	
	arrInputName[1] = new Array();
	arrInputName[1][0]="txtB";
	arrInputName[1][1]="B";
	arrInputName[1][2]="AP";
	arrInputName[1][3]="";
	
	arrInputName[2] = new Array();
	arrInputName[2][0]="txtC";
	arrInputName[2][1]="C";
	arrInputName[2][2]="PNM";
	arrInputName[2][3]="";
	
	arrInputName[3] = new Array();
	arrInputName[3][0]="txtD";
	arrInputName[3][1]="D";
	arrInputName[3][2]="PD";
	arrInputName[3][3]="";
	
	arrInputName[4] = new Array();
	arrInputName[4][0]="txtE";
	arrInputName[4][1]="E";
	arrInputName[4][2]="TI";
	arrInputName[4][3]="";
	
	arrInputName[5] = new Array();
	arrInputName[5][0]="txtF";
	arrInputName[5][1]="F";
	arrInputName[5][2]="AB";
	arrInputName[5][3]="";
	
	arrInputName[6] = new Array();
	arrInputName[6][0]="txtG";
	arrInputName[6][1]="G";
	arrInputName[6][2]="PIC";
	arrInputName[6][3]="";
	
	arrInputName[7] = new Array();
	arrInputName[7][0]="txtH";
	arrInputName[7][1]="H";
	arrInputName[7][2]="SIC";
	arrInputName[7][3]="";
	
	arrInputName[8] = new Array();
	arrInputName[8][0]="txtI";
	arrInputName[8][1]="I";
	arrInputName[8][2]="PA";
	arrInputName[8][3]="";
	
	arrInputName[9] = new Array();
	arrInputName[9][0]="txtJ";
	arrInputName[9][1]="J";
	arrInputName[9][2]="IN";
	arrInputName[9][3]="";
	
	arrInputName[10] = new Array();
	arrInputName[10][0]="txtK";
	arrInputName[10][1]="K";
	arrInputName[10][2]="CL";
	arrInputName[10][3]="";
	
	arrInputName[11] = new Array();
	arrInputName[11][0]="txtL";
	arrInputName[11][1]="L";
	arrInputName[11][2]="AR";
	arrInputName[11][3]="";
	
	arrInputName[12] = new Array();
	arrInputName[12][0]="txtM";
	arrInputName[12][1]="M";
	arrInputName[12][2]="AGC";
	arrInputName[12][3]="";
	
	arrInputName[13] = new Array();
	arrInputName[13][0]="txtN";
	arrInputName[13][1]="N";
	arrInputName[13][2]="AGT";
	arrInputName[13][3]="";
	
	arrInputName[14] = new Array();
	arrInputName[14][0]="txtP";
	arrInputName[14][1]="P";
	arrInputName[14][2]="PR";
	arrInputName[14][3]="";

}
else
{
	arrInputName[0] = new Array();
	arrInputName[0][0]="txtA";
	arrInputName[0][1]="A";
	arrInputName[0][2]="PN";
	arrInputName[0][3]="";
	
	arrInputName[1] = new Array();
	arrInputName[1][0]="txtB";
	arrInputName[1][1]="B";
	arrInputName[1][2]="AN";
	arrInputName[1][3]="";
	
	arrInputName[2] = new Array();
	arrInputName[2][0]="txtC";
	arrInputName[2][1]="C";
	arrInputName[2][2]="AP";
	arrInputName[2][3]="";
	
	arrInputName[3] = new Array();
	arrInputName[3][0]="txtD";
	arrInputName[3][1]="D";
	arrInputName[3][2]="PD";
	arrInputName[3][3]="";
	
	arrInputName[4] = new Array();
	arrInputName[4][0]="txtE";
	arrInputName[4][1]="E";
	arrInputName[4][2]="TI";
	arrInputName[4][3]="";
	
	arrInputName[5] = new Array();
	arrInputName[5][0]="txtF";
	arrInputName[5][1]="F";
	arrInputName[5][2]="AB";
	arrInputName[5][3]="";
	
	arrInputName[6] = new Array();
	arrInputName[6][0]="txtG";
	arrInputName[6][1]="G";
	arrInputName[6][2]="PIC";
	arrInputName[6][3]="";
	
	arrInputName[7] = new Array();
	arrInputName[7][0]="txtH";
	arrInputName[7][1]="H";
	arrInputName[7][2]="SIC";
	arrInputName[7][3]="";
	
	arrInputName[8] = new Array();
	arrInputName[8][0]="txtI";
	arrInputName[8][1]="I";
	arrInputName[8][2]="PA";
	arrInputName[8][3]="";
	
	arrInputName[9] = new Array();
	arrInputName[9][0]="txtJ";
	arrInputName[9][1]="J";
	arrInputName[9][2]="IN";
	arrInputName[9][3]="";
	
	arrInputName[10] = new Array();
	arrInputName[10][0]="txtK";
	arrInputName[10][1]="K";
	arrInputName[10][2]="CL";
	arrInputName[10][3]="";
	
	arrInputName[11] = new Array();
	arrInputName[11][0]="txtL";
	arrInputName[11][1]="L";
	arrInputName[11][2]="PR";
	arrInputName[11][3]="";
	
	arrInputName[12] = new Array();
	arrInputName[12][0]="txtM";
	arrInputName[12][1]="M";
	arrInputName[12][2]="FA";
	arrInputName[12][3]="";

}

function formsubmit(SearchForm,act)
{

	var strSearchWord = "";
        var strdb="";
        for(var e=0;e<document.loginform.strdb.length;e++)
       {
         if(document.loginform.strdb[e].checked)
         {
            strdb=strdb+document.loginform.strdb[e].value+",";
         }
        } 
           strdb=strdb.substring(0,strdb.length-1);

	if(strdb=="")
	{
		alert("请选择频道");
		return false;
	}
        document.loginform.channelid.value=strdb;
        document.loginform.searchChannel.value=strdb;
        
        for(var i = 0; i < arrInputName.length; i++)
        {
        	var tmpInput = eval(SearchForm + "." + arrInputName[i][0]);
        	var strValue = TrimSpace(tmpInput.value);
        	if(strValue != null && strValue != "")
        	{
			//如果是申请号/专利号/公开号,判断是否加CN，如果没加，就加上
        		if(vCountry == "0")	//国内项才有此操作
        		{
	        		if(arrInputName[i][2] == "AN")
	        		{
	        			if(strValue.indexOf('or') != -1 || strValue.indexOf('and') != -1)
	        			{
	        				alert('请检查申请号字段的输入，此字段不支持内部逻辑检索');
	        				return false;
	        			}
	        			else
	        			{
	        				if(strValue.length > 1 && strValue.substring(0,2).toLowerCase() != "cn")
	        					strValue = "CN" + strValue;
	        			}
	        		}
	        		if(arrInputName[i][2] == "PNM")
	        		{
	        			if(strValue.indexOf('or') != -1 || strValue.indexOf('and') != -1)
	        			{
	        				alert('请检查公开（公告）号字段的输入，此字段不支持内部逻辑检索');
	        				return false;
	        			}
	        			else
	        			{
	        				if(strValue.length > 1 && strValue.substring(0,2).toLowerCase() != "cn")
	        					strValue = "CN" + strValue;
	        			}
	        		}
	        	}

        		arrInputName[i][3] = arrInputName[i][2].toLowerCase() + "=(" + strValue + ")";
        	}
        }        
	
	
	var strComb = TrimSpace(eval(SearchForm+".txtComb").value);
	if(strComb != null && strComb != "")
	{
		strComb = AnalyseChar(strComb.toUpperCase());
		
		//标准化组合逻辑表达式中的连接符
		while(strComb.indexOf('AND') != -1)
			strComb = strComb.replace('AND',' and ');
		while(strComb.indexOf('*') != -1)
			strComb = strComb.replace('*',' and ');
		while(strComb.indexOf('NOT') != -1)
			strComb = strComb.replace('NOT',' not ');
		while(strComb.indexOf('-') != -1)
			strComb = strComb.replace('-',' not ');
		while(strComb.indexOf('OR') != -1)
			strComb = strComb.replace('OR',' or ');
		while(strComb.indexOf('+') != -1)
			strComb = strComb.replace('+',' or ');

		
	        for(var i = 0; i < arrInputName.length; i++)
	        {
						if(strComb.indexOf(arrInputName[i][1]) != -1 && (arrInputName[i][3] == null || arrInputName[i][3] == ""))
	        		{
		        		//alert(strComb);
		        		alert('请检查组合逻辑表达式输入：\r\n\r\n[' + arrInputName[i][1] + '] 项表达式不存在');
		        		eval(SearchForm + ".txtComb").focus();
		        		return false;
	        		}	        	
	        }


		//将组合逻辑表达式中的字段代码替换为表达式
							arrTemp=new Array();
							var len=strComb.length;
							var str="";
							for(var i=0;i<len;i++)
							{
							 arrTemp[i]=strComb.charAt(i);							 
						   
							   for(var m = 0; m < arrInputName.length; m++){
							      if(arrInputName[m][1]==arrTemp[i]){
									arrInputName[m][3] = arrInputName[m][3].replace(' * ',' and ');  
					        		arrInputName[m][3] = arrInputName[m][3].replace(' + ',' or ');
					        		arrInputName[m][3] = arrInputName[m][3].replace(' - ',' not ');
					        		if(arrInputName[m][2] == "FT" && arrInputName[m][3] != "")
					        			document.loginform.FTS.value = "1";							      	
							 				arrTemp[i]=arrTemp[i].replace(arrTemp[i],arrInputName[m][3]);  
							 			}
							   }
							 str=str+arrTemp[i];  
							}
	strSearchWord = str;
	//alert("组合逻辑检索:   "+strSearchWord);
	}
	else
	{
	        for(var i = 0; i < arrInputName.length; i++)
	        {
	        	if(arrInputName[i][3] != null && arrInputName[i][3] != "")
	        	{
	        		arrInputName[i][3] = arrInputName[i][3].replace(' * ',' and ');
	        		arrInputName[i][3] = arrInputName[i][3].replace(' + ',' or ');
					arrInputName[i][3] = arrInputName[i][3].replace(' - ',' not ');
	        		if(arrInputName[i][2] == "FT")
	        			document.loginform.FTS.value = "1";
	        		if(strSearchWord != null && strSearchWord != "")
	        			strSearchWord += " and " + arrInputName[i][3];
	        		else
	        			strSearchWord = arrInputName[i][3];
	        	}
	        }
			//alert("表格检索:   "+strSearchWord);
	}

	if(strSearchWord == "" ||(strSearchWord.indexOf(' or ') != -1 && strSearchWord.indexOf(' or ') < strSearchWord.indexOf('=')) || (strSearchWord.indexOf(' and ') != -1 && strSearchWord.indexOf(' and ') < strSearchWord.indexOf('=')))
	{
		alert('表达式为空或输入有错误');
		return false;
	}

	strSearchWord = "(" + strSearchWord + ")";
	strSearchWord = AnalyseChar("("+strSearchWord+ ")");

//过滤检索相关,如果是过滤检索在当前检索语句前加上 % not (检索语句)
	if(!CheckInputFormat(strSearchWord))
	{
		alert('表达式输入有错误，请返回检查');
		return false;
	}
//替换检索词中的双引号为单引号
	strSearchWord = strSearchWord.replace('\"','\'');
//得到最后的检索语句
	document.loginform.searchword.value=strSearchWord;

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

	if(act == "0")
		alert(strSearchWord);

}


function AnalyseChar(s)
{
	var str1 = s;
	while (str1.indexOf("？")!= -1)
	{
		str1=str1.replace("？","?");
	}
	while (str1.indexOf("％")!= -1)
	{
		str1=str1.replace("％","%");
	}
	while (str1.indexOf("（")!= -1)
	{
		str1=str1.replace("（","(");
	}
	while (str1.indexOf("）")!= -1)
	{
		str1=str1.replace("）",")");
	}
	while (str1.indexOf("＜")!= -1)
	{
		str1=str1.replace("＜","<");
	}
	while (str1.indexOf("＞")!= -1)
	{
		str1=str1.replace("＞",">");
	}
	while (str1.indexOf("＝")!= -1)
	{
		str1=str1.replace("＝","=");
	}
	while (str1.indexOf("′")!= -1)
	{
		str1=str1.replace("′","'");
	}
	return str1;
}

function CheckInputFormat(s)
{
	var iLcount = 0;
	var iRcount = 0;
	var iCount = 0;
	var tmp = s;
	while(tmp.indexOf("(") != -1)
	{
		if(tmp.substring(0,1) == "(")
			iLcount++;
		tmp = tmp.substring(1);
	}
	tmp = s;
	while(tmp.indexOf(")") != -1)
	{
		if(tmp.substring(0,1) == ")")
			iRcount++;
		tmp = tmp.substring(1);
	}
	if(iLcount != iRcount)
	{
		//alert(iLcount + ' ' + iRcount);
		return false;
	}

	tmp = s;
	
var count00=0;
var strtemp="";

if(tmp.indexOf("'") != -1)
{
	for(iCount=0;iCount<=s.length;iCount++)	
	{	
		strtemp=tmp.substr(iCount,1);
		if(strtemp=="'")
		{
			count00++
		}
	}
}

	if(count00 % 2 != 0)
	{
		//alert('2');
		return false;
	}
	return true;

}

function insertItem(obj1,s)
{
	if(eval("document.loginform.txt"+s).value != null && eval("document.loginform.txt"+s).value != "")
	{
		obj1.focus();
		document.selection.createRange().text += s;
//		obj1.value += s;
//		obj1.focus();
	}
	else
	{
		alert('请先输入检索词');
		return false;
	}
}

function insertItem1(obj1,s)
{
	obj1.focus();
	document.selection.createRange().text += s;
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
