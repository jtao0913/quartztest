function TrimSpace(x)
{
	while((x.length>0) && (x.charAt(0)==' '))
    		x = x.substring(1,x.length);
 	while((x.length>0) && (x.lastIndexOf(' ') == (x.length - 1)))
    		x = x.substring(0,x.length-1);
  	return x;
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

arrInputName = new Array;

if(vCountry == "0")
{
	arrInputName[0] = new Array();
	arrInputName[0][0]="txtA";
	arrInputName[0][1]="A";
	arrInputName[0][2]="AN";
	arrInputName[0][3]="�����";
	arrInputName[0][4]="";
	
	arrInputName[1] = new Array();
	arrInputName[1][0]="txtB";
	arrInputName[1][1]="B";
	arrInputName[1][2]="AD";
	arrInputName[1][3]="������";
	arrInputName[1][4]="";
	
	arrInputName[2] = new Array();
	arrInputName[2][0]="txtC";
	arrInputName[2][1]="C";
	arrInputName[2][2]="PNM";
	arrInputName[2][3]="���������棩��";
	arrInputName[2][4]="";
	
	arrInputName[3] = new Array();
	arrInputName[3][0]="txtD";
	arrInputName[3][1]="D";
	arrInputName[3][2]="PD";
	arrInputName[3][3]="���������棩��";
	arrInputName[3][4]="";
	
	arrInputName[4] = new Array();
	arrInputName[4][0]="txtE";
	arrInputName[4][1]="E";
	arrInputName[4][2]="TI";
	arrInputName[4][3]="����";
	arrInputName[4][4]="";
	
	arrInputName[5] = new Array();
	arrInputName[5][0]="txtF";
	arrInputName[5][1]="F";
	arrInputName[5][2]="AB";
	arrInputName[5][3]="ժҪ";
	arrInputName[5][4]="";
	
	arrInputName[6] = new Array();
	arrInputName[6][0]="txtG";
	arrInputName[6][1]="G";
	arrInputName[6][2]="PIC";
	arrInputName[6][3]="�������";
	arrInputName[6][4]="";
	
	arrInputName[7] = new Array();
	arrInputName[7][0]="txtH";
	arrInputName[7][1]="H";
	arrInputName[7][2]="SIC";
	arrInputName[7][3]="�����";
	arrInputName[7][4]="";
	
	arrInputName[8] = new Array();
	arrInputName[8][0]="txtI";
	arrInputName[8][1]="I";
	arrInputName[8][2]="PA";
	arrInputName[8][3]="���루ר��Ȩ����";
	arrInputName[8][4]="";
	
	arrInputName[9] = new Array();
	arrInputName[9][0]="txtJ";
	arrInputName[9][1]="J";
	arrInputName[9][2]="IN";
	arrInputName[9][3]="��������ƣ���";
	arrInputName[9][4]="";
	
	arrInputName[10] = new Array();
	arrInputName[10][0]="txtK";
	arrInputName[10][1]="K";
	arrInputName[10][2]="CL";
	arrInputName[10][3]="��Ȩ��";
	arrInputName[10][4]="";
	
	arrInputName[11] = new Array();
	arrInputName[11][0]="txtL";
	arrInputName[11][1]="L";
	arrInputName[11][2]="AR";
	arrInputName[11][3]="��ַ";
	arrInputName[11][4]="";
	
	arrInputName[12] = new Array();
	arrInputName[12][0]="txtM";
	arrInputName[12][1]="M";
	arrInputName[12][2]="AGC";
	arrInputName[12][3]="ר���������";
	arrInputName[12][4]="";
	
	arrInputName[13] = new Array();
	arrInputName[13][0]="txtN";
	arrInputName[13][1]="N";
	arrInputName[13][2]="AGT";
	arrInputName[13][3]="������";
	arrInputName[13][4]="";
	
	arrInputName[14] = new Array();
	arrInputName[14][0]="txtP";
	arrInputName[14][1]="P";
	arrInputName[14][2]="PR";
	arrInputName[14][3]="����Ȩ";
	arrInputName[14][4]="";
	
	arrInputName[15] = new Array();
	arrInputName[15][0]="txtQ";
	arrInputName[15][1]="Q";
	arrInputName[15][2]="CO";
	arrInputName[15][3]="��ʡ����";
	arrInputName[15][4]="";
}
else
{
	arrInputName[0] = new Array();
	arrInputName[0][0]="txtA";
	arrInputName[0][1]="A";
	arrInputName[0][2]="PN";
	arrInputName[0][3]="ר����";
	arrInputName[0][4]="";
	
	arrInputName[1] = new Array();
	arrInputName[1][0]="txtB";
	arrInputName[1][1]="B";
	arrInputName[1][2]="AN";
	arrInputName[1][3]="�����";
	arrInputName[1][4]="";
	
	arrInputName[2] = new Array();
	arrInputName[2][0]="txtC";
	arrInputName[2][1]="C";
	arrInputName[2][2]="AD";
	arrInputName[2][3]="������";
	arrInputName[2][4]="";
	
	arrInputName[3] = new Array();
	arrInputName[3][0]="txtD";
	arrInputName[3][1]="D";
	arrInputName[3][2]="PD";
	arrInputName[3][3]="���������棩��";
	arrInputName[3][4]="";
	
	arrInputName[4] = new Array();
	arrInputName[4][0]="txtE";
	arrInputName[4][1]="E";
	arrInputName[4][2]="TI";
	arrInputName[4][3]="����";
	arrInputName[4][4]="";
	
	arrInputName[5] = new Array();
	arrInputName[5][0]="txtF";
	arrInputName[5][1]="F";
	arrInputName[5][2]="AB";
	arrInputName[5][3]="ժҪ";
	arrInputName[5][4]="";
	
	arrInputName[6] = new Array();
	arrInputName[6][0]="txtG";
	arrInputName[6][1]="G";
	arrInputName[6][2]="PIC";
	arrInputName[6][3]="�������";
	arrInputName[6][4]="";
	
	arrInputName[7] = new Array();
	arrInputName[7][0]="txtH";
	arrInputName[7][1]="H";
	arrInputName[7][2]="SIC";
	arrInputName[7][3]="�����";
	arrInputName[7][4]="";
	
	arrInputName[8] = new Array();
	arrInputName[8][0]="txtI";
	arrInputName[8][1]="I";
	arrInputName[8][2]="PA";
	arrInputName[8][3]="���루ר��Ȩ����";
	arrInputName[8][4]="";
	
	arrInputName[9] = new Array();
	arrInputName[9][0]="txtJ";
	arrInputName[9][1]="J";
	arrInputName[9][2]="IN";
	arrInputName[9][3]="��������ƣ���";
	arrInputName[9][4]="";
	
	arrInputName[10] = new Array();
	arrInputName[10][0]="txtK";
	arrInputName[10][1]="K";
	arrInputName[10][2]="PR";
	arrInputName[10][3]="����Ȩ";
	arrInputName[10][4]="";
	
	arrInputName[11] = new Array();
	arrInputName[11][0]="txtL";
	arrInputName[11][1]="L";
	arrInputName[11][2]="FA";
	arrInputName[11][3]="ͬ��ר����";
	arrInputName[11][4]="";
	
}

function SetDefaultButton(id)
{
//onKeyDown="SetDefaultButton(1)"
/*
	if(event.keyCode == 13)   
	{   
		if(id == '1')
		{
			//document.forms[0].TableSubmit.focus(); 
			document.forms[0].TableSubmit.click();   
		}
		else
		{
			//document.forms[0].LogicSubmit.focus(); 
			document.forms[0].LogicSubmit.click();   
		}
	}
*/
}

function TableFormClear(){
//document.all.txtComb.value="";
	var eles=document.getElementsByTagName("input");   
	for(var i=0;i<eles.length;i++)   
	{
		if((eles[i].name).indexOf("txt")==0)
		{
			eles[i].value="";
		}
	}
}
function LogicFormClear(){
	document.all.txtSearchWord.value="";
}

function FormSubmit(SearchForm,act){
	var logicSearchWord = document.all.txtSearchWord.value;
	logicSearchWord=logicSearchWord.replace(/(^\s*)|(\s*$)/g, "");

	if(logicSearchWord!=''){
		return LogicFormSubmit();
	}else{
		return TableFormSubmit(SearchForm,act);
	}
}

function TableFormSubmit(SearchForm,act)
{
//alert("TableFormSubmit.........");
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
		alert("��ѡ��Ƶ��");
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
			//����������/ר����/������,�ж��Ƿ��CN�����û�ӣ��ͼ���
        		if(vCountry == "0")	//��������д˲���
        		{
	        		if(arrInputName[i][2] == "AN")
	        		{
	        			if(strValue.indexOf('or') != -1 || strValue.indexOf('and') != -1)
	        			{
	        				alert('����������ֶε����룬���ֶβ�֧���ڲ��߼�����');
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
	        				alert('���鹫�������棩���ֶε����룬���ֶβ�֧���ڲ��߼�����');
	        				return false;
	        			}
	        			else
	        			{
	        				if(strValue.length > 1 && strValue.substring(0,2).toLowerCase() != "cn")
	        					strValue = "CN" + strValue;
	        			}
	        		}
	        	}
        		arrInputName[i][4] = arrInputName[i][2].toLowerCase() + "=(" + strValue + ")";
        	}
        }

        for(var i = 0; i < arrInputName.length; i++)
        {
        	if(arrInputName[i][4] != null && arrInputName[i][4] != "")
        	{
        		arrInputName[i][4] = arrInputName[i][4].replace(' * ',' and ');
        		arrInputName[i][4] = arrInputName[i][4].replace(' + ',' or ');
						arrInputName[i][4] = arrInputName[i][4].replace(' - ',' not ');
        		//if(arrInputName[i][2] == "FT")
        			//document.loginform.FTS.value = "1";
        		if(strSearchWord != null && strSearchWord != "")
        			strSearchWord += " and " + arrInputName[i][4];
        		else
        			strSearchWord = arrInputName[i][4];
        	}
        }
		//alert("������:   "+strSearchWord);


	if(strSearchWord == "" ||(strSearchWord.indexOf(' or ') != -1 && strSearchWord.indexOf(' or ') < strSearchWord.indexOf('=')) || (strSearchWord.indexOf(' and ') != -1 && strSearchWord.indexOf(' and ') < strSearchWord.indexOf('=')))
	{
       	alert('���ʽΪ�ջ������д���');
       	return false;
	}
	//strSearchWord = "(" + strSearchWord + ")";
	//strSearchWord = AnalyseChar("("+strSearchWord+ ")");
	strSearchWord = AnalyseChar(strSearchWord);

	if(document.loginform.secondsearch.checked)
	{
		strSearchWord += " and (" + document.loginform.presearchword.value + ")";
	}

//���˼������,����ǹ��˼����ڵ�ǰ�������ǰ���� % not (�������)
	var stemp = "#"+document.loginform.presearchword.value+"#"

	if(document.loginform.filtersearch.checked&&stemp!="##")
	{
		strSearchWord = strSearchWord + " and % not ("+ document.loginform.presearchword.value+")";
	}
			
	if(!CheckInputFormat(strSearchWord))
	{
		//alert('���ʽ�����д����뷵�ؼ��');
		return false;
	}
	//�滻�������е�˫����Ϊ������
	strSearchWord = strSearchWord.replace('\"','\'');
//�õ����ļ������
	document.loginform.searchword.value=strSearchWord;

//����ʽ���  �õ�����������ʽ
//alert(document.loginform.R1.value);
//alert(document.loginform.sortcolumn.value);

	if(document.loginform.sortcolumn.value!="RELEVANCE")
	{		
		document.loginform.sortfield.value=document.loginform.R1.value+document.loginform.sortcolumn.value;
	}
	else
	{
		document.loginform.sortfield.value=document.loginform.sortcolumn.value;	
	}

	var obj_cizi=document.getElementById("ciziID");
	
	//alert(strSearchWord);
	//alert(obj_cizi);
	if(obj_cizi!=null && obj_cizi!="null"){
	//alert("osdufoisdhfolsd");
		var cizi=document.loginform.cizi.value;
		var strCookieName = "cizi=";
		var tmpSaveDays = 1;
		var dtToday = new Date();
		var strSaveDays = dtToday.getTime() + ((parseInt(tmpSaveDays))*24*60*60*1000);
		dtToday.setTime(strSaveDays);
		document.cookie = strCookieName+cizi+" ; expires="+dtToday.toGMTString()+" ; path=/"; 
	}

//ͬ��ʼ���
	document.loginform.extension.value="";
	if(document.loginform.synonymous.checked)	 
	{
		document.loginform.extension.value="all";
	}

	if(act == "0")
	{
		alert(strSearchWord);
	}else{
		//alert(document.loginform.channelid.value);
		//alert(strSearchWord);
		//document.loginform.submit();
		return true;
	}	
	//alert(strSearchWord);
}

function LogicFormSubmit()
{
//alert("TableFormSubmit.........");
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
		alert("��ѡ��Ƶ��");
		return false;
	}
	document.loginform.channelid.value=strdb;
	document.loginform.searchChannel.value=strdb;
	strSearchWord = document.loginform.txtSearchWord.value;

	if(strSearchWord == "" ||(strSearchWord.indexOf(' or ') != -1 && strSearchWord.indexOf(' or ') < strSearchWord.indexOf('=')) || (strSearchWord.indexOf(' and ') != -1 && strSearchWord.indexOf(' and ') < strSearchWord.indexOf('=')))
	{
       	alert('���ʽΪ�ջ������д���');
       	return false;
	}
	
	strSearchWord = replaceIdWithExpression(strSearchWord);
		
	//strSearchWord = "(" + strSearchWord + ")";
	//strSearchWord = AnalyseChar("("+strSearchWord+ ")");
	strSearchWord = AnalyseChar(strSearchWord);

	if(document.loginform.secondsearch.checked)
	{
		strSearchWord = "(" + strSearchWord + ") and (" + document.loginform.presearchword.value + ")";
	}

//���˼������,����ǹ��˼����ڵ�ǰ�������ǰ���� % not (�������)
	var stemp = "#"+document.loginform.presearchword.value+"#"

	if(document.loginform.filtersearch.checked&&stemp!="##")
	{
		strSearchWord = "(" + strSearchWord + ") and % not ("+ document.loginform.presearchword.value+")";
	}
			
	if(!CheckInputFormat(strSearchWord))
	{
		//alert('���ʽ�����д����뷵�ؼ��');
		return false;
	}
	//�滻�������е�˫����Ϊ������
	strSearchWord = strSearchWord.replace('\"','\'');
//�õ����ļ������
	document.loginform.searchword.value=strSearchWord;

//����ʽ���  �õ�����������ʽ
//alert(document.loginform.R1.value);
//alert(document.loginform.sortcolumn.value);

	if(document.loginform.sortcolumn.value!="RELEVANCE")
	{		
		document.loginform.sortfield.value=document.loginform.R1.value+document.loginform.sortcolumn.value;
	}
	else
	{
		document.loginform.sortfield.value=document.loginform.sortcolumn.value;	
	}

	var obj_cizi=document.getElementById("ciziID");
	
	//alert(strSearchWord);
	//alert(obj_cizi);
	if(obj_cizi!=null && obj_cizi!="null"){
	//alert("osdufoisdhfolsd");
		var cizi=document.loginform.cizi.value;
		var strCookieName = "cizi=";
		var tmpSaveDays = 1;
		var dtToday = new Date();
		var strSaveDays = dtToday.getTime() + ((parseInt(tmpSaveDays))*24*60*60*1000);
		dtToday.setTime(strSaveDays);
		document.cookie = strCookieName+cizi+" ; expires="+dtToday.toGMTString()+" ; path=/"; 
	}

//ͬ��ʼ���
	document.loginform.extension.value="";
	if(document.loginform.synonymous.checked)	 
	{
		document.loginform.extension.value="all";
	}

	return true;
}


function AnalyseChar(s)
{
	var str1 = s;
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��","?");
	}
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��","%");
	}
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��","(");
	}
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��",")");
	}
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��","<");
	}
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��",">");
	}
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��","=");
	}
	while (str1.indexOf("��")!= -1)
	{
		str1=str1.replace("��","'");
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
		alert('���ʽ�����Ų�ƥ��');
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
		alert('���ʽ�е����Ų�ƥ��');
		return false;
	}
	return true;

}

//arrInputName[15][3]="Ȩ��Ҫ����";
function insertItem(obj1,s)
{
	if(eval("document.loginform.txt"+s).value != null && eval("document.loginform.txt"+s).value != "")
	{
		//insertItem1(obj1,eval("document.loginform.txt"+s).value);
		for(var i = 0; i < arrInputName.length; i++)
        {
        	var tmpInput = arrInputName[i][1];
        	//var strValue = TrimSpace(tmpInput.value);
        	if(tmpInput==s)
        	{
				insertItem1(obj1,arrInputName[i][3]+"=("+eval("document.loginform.txt"+s).value+")");
			}
		}
//obj1.focus();
//document.selection.createRange().text += eval("document.loginform.txt"+s).value;
//document.selection.createRange().text += s;
//obj1.value += s;
//obj1.focus();
	}
	else
	{
		alert('�������������');
		return false;
	}
}

function insertItem1(obj1,s)
{
	//obj1.focus();
	//document.selection.createRange().text += s;
	
		document.loginform.txtSearchWord.focus();
		//document.loginform.txtSearchWord.value += str;
		document.loginform.txtSearchWord.value += s;

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
    	obj.btnSelect.value = "ȡ��";
    else
    	obj.btnSelect.value = "ȫѡ";
}