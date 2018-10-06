
document.write("<DIV align=center id=floater style='HEIGHT: 98px; WIDTH: 500px;' style='display:none'>");
document.write("<TABLE width=\"100%\" border=1 align=center cellPadding=2 cellSpacing=0 borderColorLight=#cccccc borderColorDark=#ffffff class=\"t1\" bgcolor=\"#FFFFFF\">");
document.write("<TBODY>");
document.write("<tr><td colspan=\"3\" align=\"right\"><img src=\"../grant_check/login/spread/button-close-focus.gif\" onClick=\"showDIV()\"></td></tr>");
document.write("<TR>");
document.write("<TD align=\"center\"><span title=\"例：computer/TI\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); value=\"\\/TI\">名称/TI</span></TD>");
document.write("<TD align=\"center\"><span title=\"例：CH20010000254/AN\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/AN\">申请号/AN</span> </TD>");
document.write("<TD align=\"center\"><span title=\"例：20030103/AP\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); value=\"\\/AP\">申请日/AP</span> </TD>");
document.write("</TR>");
document.write("<TR>");
document.write("<TD align=\"center\"><span title=\"例：CH694421/PN\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); value=\"\\/PN\">专利号/PN</span> </TD>");
document.write("<TD align=\"center\"><span title=\"例：20040108/PD\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/PD\">公开（公告）日/PD</span> </TD>");
document.write("<TD align=\"center\"><span title=\"例：BONNY PHILIPPE/PA\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/PA\">申请（专利权）人/PA</span> </TD>");
document.write("</TR>");
document.write("<TR>"); 
document.write("<TD align=\"center\"><span title=\"例：BONNY PHILIPPE/IN\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/IN\">发明（设计）人/IN </TD>");
document.write("<TD align=\"center\"><span title=\"例：A43B5/04/PIC\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/PIC\">主分类号/PIC </TD>");
document.write("<TD align=\"center\"><span title=\"例：A43B5/04/SIC\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/SIC\">分类号/SIC </TD>");
document.write("</TR>");
document.write("<TR>"); 
document.write("<TD align=\"center\"><span title=\"例：computer/CL\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/CL\">主权项/CL </TD>");
document.write("<TD align=\"center\"><span title=\"例：computer/AB\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/AB\">摘要/AB </TD>");
document.write("<TD align=\"center\"><span title=\"例：19990428321/PR\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/PR\">优先权/PR </TD>");
document.write("</TR>");
document.write("<TR>"); 
document.write("<TD align=\"center\"><span title=\"例：DE102005029915/FA\" style=\"CURSOR: hand\" onclick=insertAtCaret(this); align=middle value=\"\\/FA\">同族专利/FA </TD>");
document.write("<TD align=\"center\">&nbsp;</TD>");
document.write("<TD align=\"center\">&nbsp;</TD>");
document.write("</TR>");
document.write("</TBODY>");
document.write("</TABLE>");
document.write("</DIV>");


arrInputName = new Array;
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


function insertItem(column, s) {
	if (eval("document.searchForm.txt" + s).value != null && eval("document.searchForm.txt" + s).value != "") {
		document.searchForm.txtSearchWord.focus();
		document.selection.createRange().text += column + "=(" + eval("document.searchForm.txt" + s).value + ")";
	} else {
		alert("\u8bf7\u5148\u8f93\u5165\u68c0\u7d22\u8bcd");
		return false;
	}
}
function insertAtCaret(text) {
	var str = text.value;
	while (str.indexOf("\\/") != -1) {
		str = str.replace("\\/", "/");
	}
	while (str.indexOf("\uff1f") != -1) {
		str = str.replace("\uff1f", "?");
	}
	while (str.indexOf("\uff05") != -1) {
		str = str.replace("\uff05", "%");
	}
	document.searchForm.txtSearchWord.focus();
	document.selection.createRange().text += str;
	document.searchForm.txtSearchWord.focus();
}
function ShowMore() {
	if (document.all.extend.style.display == "none") {
		document.all.extend.style.display = "";
		document.all.btnMore.src = "images/btnHide.gif";
		document.all.btnMore.title = "\u70b9\u51fb\u9690\u85cf\u8fd0\u7b97\u7b26";
	} else {
		document.all.extend.style.display = "none";
		document.all.btnMore.src = "images/btnShow.gif";
		document.all.btnMore.title = "\u70b9\u51fb\u663e\u793a\u66f4\u591a\u8fd0\u7b97\u7b26";
	}
}
function showDIV() {
	if (document.all.floater.style.display == "block") {
		document.all.floater.style.display = "none";
	} else {
		if (document.all.floater.style.display == "none") {
			document.all.floater.style.display = "block";
		}
	}
}
function TrimSpace(x) {
	while ((x.length > 0) && (x.charAt(0) == " ")) {
		x = x.substring(1, x.length);
	}
	while ((x.length > 0) && (x.lastIndexOf(" ") == (x.length - 1))) {
		x = x.substring(0, x.length - 1);
	}
	return x;
}

function formsubmit() {

	var strSearchWord = "";
	
	var strSearchWord = TrimSpace(document.searchForm.txtSearchWord.value);
	
	if (strSearchWord == null || strSearchWord == "") {
		for (var i = 0; i < arrInputName.length; i++) {
			var tmpInput = eval("document.searchForm." + arrInputName[i][0]);
			var strValue = TrimSpace(tmpInput.value);
			if (strValue != null && strValue != "") {
				arrInputName[i][3] = arrInputName[i][2].toLowerCase() + "=(" + strValue + ")";
			}
		}
		for (var i = 0; i < arrInputName.length; i++) {
			if (arrInputName[i][3] != null && arrInputName[i][3] != "") {
				arrInputName[i][3] = arrInputName[i][3].replace(" + ", " and ");
				arrInputName[i][3] = arrInputName[i][3].replace(" - ", " or ");
				if (strSearchWord != null && strSearchWord != "") {
					strSearchWord += " and " + arrInputName[i][3];
				} else {
					strSearchWord = arrInputName[i][3];
				}
			}
		}
	}
	if (strSearchWord == "" || (strSearchWord.indexOf(" or ") != -1 && strSearchWord.indexOf(" or ") < strSearchWord.indexOf("=")) || (strSearchWord.indexOf(" and ") != -1 && strSearchWord.indexOf(" and ") < strSearchWord.indexOf("="))) {
		alert("表达式为空或输入有错误");
		return false;
	}
	strSearchWord = AnalyseChar(strSearchWord);
	
	var presearchword = document.searchForm.presearchword.value;
	
	if (document.searchForm.secondsearch.checked) {
		strSearchWord += " and (" + presearchword + ")";
	}

	//过滤检索相关      如果是过滤检索在当前检索语句前加上 % not (检索语句)
	if (document.searchForm.filtersearch.checked && presearchword != "") {
		strSearchWord = strSearchWord + " and % not (" + presearchword + ")";
	}

	if (!CheckInputFormat(strSearchWord)) {
		alert("表达式输入有错误，请返回检查");
		return false;
	}
	//得到最后的检索语句
	document.searchForm.strWhere.value = strSearchWord;

	//排序方式相关  得到检索的排序方式
	document.searchForm.strSortMethod.value = document.searchForm.R1.value + document.searchForm.sortcolumn.value;
	 
	//同义词检索
	if (document.searchForm.synonymous.checked) {
		document.searchForm.extension.value = "all";
	}
}

function AnalyseChar(s) {
	var str1 = s;
	while (str1.indexOf("\uff1f") != -1) {
		str1 = str1.replace("\uff1f", "?");
	}
	while (str1.indexOf("\uff05") != -1) {
		str1 = str1.replace("\uff05", "%");
	}
	while (str1.indexOf("\uff08") != -1) {
		str1 = str1.replace("\uff08", "(");
	}
	while (str1.indexOf("\uff09") != -1) {
		str1 = str1.replace("\uff09", ")");
	}
	while (str1.indexOf("\uff1c") != -1) {
		str1 = str1.replace("\uff1c", "<");
	}
	while (str1.indexOf("\uff1e") != -1) {
		str1 = str1.replace("\uff1e", ">");
	}
	while (str1.indexOf("\uff1d") != -1) {
		str1 = str1.replace("\uff1d", "=");
	}
	while (str1.indexOf("\u2032") != -1) {
		str1 = str1.replace("\u2032", "'");
	}
	return str1;
}

function CheckInputFormat(s) {
	var iLcount = 0;
	var iRcount = 0;
	var iCount = 0;
	var tmp = s;
	while (tmp.indexOf("(") != -1) {
		if (tmp.substring(0, 1) == "(") {
			iLcount++;
		}
		tmp = tmp.substring(1);
	}
	tmp = s;
	while (tmp.indexOf(")") != -1) {
		if (tmp.substring(0, 1) == ")") {
			iRcount++;
		}
		tmp = tmp.substring(1);
	}
	if (iLcount != iRcount) {
		alert(iLcount + " " + iRcount);
		return false;
	}
	tmp = s;
	while (tmp.indexOf("'") != -1) {
		iCount++;
		tmp = tmp.substring(1);
	}
	if (iCount % 2 != 0) {
		alert("2");
		return false;
	}
	return true;
}

function channelChecked(){
	document.getElementById("sxChannel").checked = false;   
}


function channelChecked_sx(obj){
      var o = document.all[obj.name];   
      for(var i=0; i<o.length; i++){   
           if(o[i] == obj){   
                obj.checked = true;   
           }else{   
                o[i].checked = false;   
           }   
      }   
}
