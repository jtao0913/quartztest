<%@ page contentType="text/html; charset=GBK" errorPage="jsp/error.jsp"%>
<%
if((String)session.getAttribute("adminName")==null||((String)session.getAttribute("adminName")).equals(""))
{
   response.sendRedirect("login.htm");
}
 String strAdminName=(String)session.getAttribute("adminName");
%>
<html>
<head>
<title>检索服务平台后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" href="css/cds_style.css" type="text/css">
<style type="text/css">
	.exheading {font-weight: bold; cursor: hand}
	.Arraw {color:#FFFFFF; cursor:hand; font-family:Webdings; font-size:16pt}
</style>
<script>
<!--
function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}

function mouseOver(obj)
{
	obj.className = "mOver";
}

function mouseOut(obj)
{
	obj.className = "mNull";
	MM_showHideLayers(obj.id + '_S','','hidden');
}

function mouseDown(obj)
{
	MM_showHideLayers(obj.id + '_S','','show');
}

function mouseOverDiv(obj)
{
	mouseDown(document.all[obj.id.substring(0,(obj.id.length - 2))]);
}

function mouseOutDiv(obj)
{
	mouseOut(document.all[obj.id.substring(0,(obj.id.length - 2))]);
}

function menuOver(obj)
{
	obj.className = "menu_mouseOver";
}

function menuOut(obj)
{
	obj.className = "menu_mouseOut";
}

function showMenu(id)
{
	for (var i = 0 ; i <= 100 ; i ++)
	{
		document.all[id].style.filter = "alpha(Opacity=" + i + ")";
		for(var j = 0 ; j < 80000 ; j ++){}
	}
}
function hidework()
{
	document.all.showwork.style.visibility='visible'	
	document.all.hidework.style.visibility='hidden'	
	document.all.navi_td.style.display = 'none'
}
function showwork()
{
	document.all.hidework.style.visibility='visible'	
	document.all.showwork.style.visibility='hidden'	
	document.all.navi_td.style.display = 'block'
}
function switchMenu(){
	if (SwitchArraw.innerText==3){
		SwitchArraw.innerText=4
		document.all("navi_td").style.display="none"
	}
	else{
		SwitchArraw.innerText=3
		document.all("navi_td").style.display=""
	}
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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

function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
self.moveTo(0,0);
self.resizeTo(screen.availWidth,screen.availHeight);
</script>
</head>
<%
	double per = 1.0,per1=1.0,per2 = 1.0;
	
	int wid=1024,tr1 = 0,tr2 = 0;
	String	strWidth="1024";
	String  strPath = "/800";
	if(strWidth!=null)
	{
		wid = Integer.parseInt(strWidth);
		if(wid>900)
		{
			per = 1.38;
			per1= 1.27;
			per2= 1.33;
			strPath = "";
		}
		tr1 = 75;
		tr1 = new Float(tr1*per).intValue();
	}
%>
<body topmargin="0"  leftmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('images/exit2.gif','images/wizard2.gif','images/help2.gif','images/jbgn_2.gif','images/yhgl_2.gif','images/fwsq_2.gif','images/tjjf_2.gif','images/xtgl_2.gif','images/qtgj_2.gif','images/button/xmgl_2.gif','images/button/pdgl_2.gif')">
<table width="100%" height="64" border="0" cellpadding="0" cellspacing="0" background="images/topbg.jpg">
  <tr> 
    <td width="51%"><img src="images/logo.jpg" width="461" height="64"></td>
  	<td width="49%" align="right">
  		<table width="232" height="64" border="0" cellpadding="0" cellspacing="0">
        <tr> 
        	<td colspan="2" width="355" height="32" align="right" valign="top"> 
          		<table width="277" border="0" cellspacing="0" cellpadding="0">
              	<tr>
              		<td width="88" height="32"><a href="a" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','images/exit2.gif',1)" onClick="javaScript:event.returnValue=false;if(confirm('是否重新登录？')){window.open('logout.jsp','','width=100,height=100');parent.location='login.htm';}else{window.open('logout.jsp','','width=100,height=100');parent.close();}"><img src="images/exit1.gif" name="Image2" border="0"></a></td><td align="right"><a href="help_gd/newfunction.htm"><img src="images/help1.gif" width="63" height="32" border="0"></a></td>
              	</tr>
            	</table>
            </td>
        </tr>
        <tr> 
        	<td>&nbsp;</td>
        	<td valign="top" width="232" background="images/user.gif">
	          	<table width="196" height="22" border="0" cellpadding="0" cellspacing="0" class="12h">
	            <tr> 
	                <td width="232" height="22" align="right" valign="bottom"><%out.print(strAdminName);%> 您好 
	                </td>
	            </tr>
	            </table>
            </td>
        </tr>
      </table>
	</td>
  </tr>
</table>

<table width="100%" height="92%" border="0" cellpadding="0" cellspacing="0">
  <tr valign="top"> 
    <td width="14%" height="100%" id="navi_td" style="display:block;"> 
      <table width="141" height="100%" border="0" cellpadding="0" cellspacing="0" background="images/lbg.gif">
        <tr valign="top"> 
          <td width="141" height="100%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="100%"><img src="images/ltop.gif" width="141" height="34"></td>
              </tr>
            </table>
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="100%" height="100%" valign="top"><iframe frameBorder=0 id="navigate" name="frmLeft" scrolling=auto marginheight=0 marginwidth=0 src="jsp/navi_bar.jsp?width=<%=strWidth%>" style="height: 100%; visibility: inherit; width: 100%; z-index: 2;display:block"></iframe></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr valign="top"> 
          <td valign="bottom"><img src="images/lbk.gif" width="100%" height="39"></td>
        </tr>
      </table>
    </td>
    <td width="1%" background="images/line_2.gif">
	<table width="25" height="100%" border="0" cellpadding="0" cellspacing="0" onclick="javaScript:switchMenu();" style="cursor:hand">
        <tr> 
          <td width="25" valign="top" height="30%"><img src="images/line_1.gif" width="25" height="34"></td>
        </tr>
        <tr> 
          <td valign="bottom" height="15%"><span class=Arraw id=SwitchArraw title=关闭/打开左栏>3</span></td>
        </tr>
        <tr> 
          <td valign="bottom" height="55%"><img src="images/line_4.gif" width="25" height="39"></td>
        </tr>
      </table>
    </td>
    <td width="82%">
      <table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/cn.gif">
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" valign="middle">
	          <iframe frameBorder=0 id="content" name="frameDown" src="html/content.htm" style="height: 100%; visibility: inherit; width: 100%; z-index: 1">
			  </iframe>
		  </td>
        </tr>
      </table>
    </td>
    <td width="2%" align="right" valign="top"> 
      <table width="19" height="100%" border="0" cellpadding="0" cellspacing="0" background="images/rcen.gif">
        <tr>
          <td width="32" align="right" valign="top"><img src="images/rtop.gif" width="19" height="34"></td>
        </tr>
        <tr>
          <td align="right" valign="bottom"><img src="images/rbk.gif" width="19" height="48"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
                       
