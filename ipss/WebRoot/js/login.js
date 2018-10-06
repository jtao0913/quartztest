 
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadimages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadimages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function formsubmit()
{
	var UserName=document.loginform.userName.value;
	UserName=UserName.replace(/(^\s*)|(\s*$)/g, "");
	if(UserName=='')
	{
		alert("用户名不能为空");
		return false; 
	}
	var PassWord=document.loginform.password.value;
	PassWord=PassWord.replace(/(^\s*)|(\s*$)/g, "");
	if(PassWord=='')
	{
		alert("用户密码不能为空");
		return false; 
	}
	document.loginform.submit();
}

function loginByIP(){
		document.loginform.isCorpLogin.value="true";
		document.loginform.submit();
	}

function filterURL(pageType, id, url) {
	VisitDAO.logVisit(id, pageType);
	window.location.href=url;
}

// 全领域代码化数据库快速通道
function expresswayForAll(channelId) {
	window.location.href="expressway.do?method=quickShowChannelForm&pageType=all&channelId=" + channelId;
}

//
function expresswayForRight(right) {
	window.location.href="expressway.do?method=quickShowChannelForm&pageType=all&right="+right;
}

//法律状态快速通道
function expresswayForStat() {
	window.location.href="expressway.do?method=quickShowChannelForm&pageType=all&right=stat";
}

// 行业数据库快速通道
function expresswayForMajorIndustries(rootId, treeType , autosearch) { 
	window.location.href="expressway.do?method=quickIndustriesSearch&pageType=MajorIndustries&tabno=1&rootId=" + rootId + "&treeType=" + treeType + "&autosearch="+autosearch;
}

// 专题数据库快速通道
function expresswayForAreaIndustries(rootId, treeType , autosearch) {
	window.location.href="expressway.do?method=quickIndustriesSearch&pageType=areaIndustries&tabno=2&rootId=" + rootId + "&treeType=" + treeType + "&autosearch="+autosearch;
}

// 行业数据库快速通道
function expresswayForIPC(i) { 
	window.location.href="expressway.do?method=quickIndustriesSearch&pageType=MajorIndustries&tabno="+i+"&rootId=0&treeType=0&autosearch=0";
}
// 
function logFirstPageVisit() {
	VisitDAO.logVisit("0", "main");
}
 