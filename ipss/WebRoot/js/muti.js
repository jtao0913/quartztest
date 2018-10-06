<!--
var allSupport = document.all!=null
tPopWait=1000;
tPopShow=50000;
showPopStep=10;
popOpacity=100;

sPop=null;
curShow=null;
tFadeOut=null;
tFadeIn=null;
tFadeWaiting=null;
var srcobj = null;

document.write("<style type='text/css'id='defaultPopStyle'>");
document.write(".cPopText { background-color: #FFFFE1; border: 1px #000000 solid; font-size: 12px; padding-right: 4px; padding-left: 4px; height: 20px; padding-top: 2px; padding-bottom: 2px; filter: Alpha(Opacity=0)}");
document.write("</style>");
document.write("<div id='dypopLayer' style='position:absolute;z-index:1000;' class='cPopText'></div>");

function showPopupText(){
var o=event.srcElement;
srcobj = o;
//MouseX=event.x;
//MouseY=event.y;
MouseX = o["offsetLeft"] + 60;
MouseY = o["offsetHeight"] + 100;

if(o.alt!=null && o.alt!=""){o.dypop=o.alt;o.alt=""};
if(o.dypop!=sPop) {
sPop=o.dypop;
clearTimeout(curShow);
clearTimeout(tFadeOut);
clearTimeout(tFadeIn);
clearTimeout(tFadeWaiting); 
if(sPop==null || sPop=="") {
dypopLayer.innerHTML="";
dypopLayer.style.filter="Alpha()";
dypopLayer.filters.Alpha.opacity=0; 
}
else {
if(o.dyclass!=null) popStyle=o.dyclass 
else popStyle="cPopText";
curShow=setTimeout("showIt()",tPopWait);
}

}
}

function showIt(){
dypopLayer.className=popStyle;
dypopLayer.innerHTML=sPop;
popWidth=dypopLayer.clientWidth;
popHeight=dypopLayer.clientHeight;
if(MouseX+12+popWidth>document.body.clientWidth) popLeftAdjust=-popWidth-24
else popLeftAdjust=0;
if(MouseY+12+popHeight>document.body.clientHeight) popTopAdjust=-popHeight-24
else popTopAdjust=0;
dypopLayer.style.left=MouseX+12+document.body.scrollLeft+popLeftAdjust;
dypopLayer.style.top=MouseY+12+document.body.scrollTop+popTopAdjust;
dypopLayer.style.filter="Alpha(Opacity=0)";

setPosition(dypopLayer);

fadeOut();
}

function fadeOut(){
if(dypopLayer.filters.Alpha.opacity<popOpacity) {
dypopLayer.filters.Alpha.opacity+=showPopStep;
tFadeOut=setTimeout("fadeOut()",1);
}
else {
dypopLayer.filters.Alpha.opacity=popOpacity;
tFadeWaiting=setTimeout("fadeIn()",tPopShow);
}
}

function fadeIn(){
if(dypopLayer.filters.Alpha.opacity>0) {
dypopLayer.filters.Alpha.opacity-=1;
tFadeIn=setTimeout("fadeIn()",1);
}
}
document.onmouseover=showPopupText;

function getOffset(el, which) {
var amount = el["offset"+which]
if (which=="Top")
amount+=el.offsetHeight
el = el.offsetParent
while (el!=null) {
amount+=el["offset"+which]
el = el.offsetParent
}
return amount
}

function setPosition(el) {

if (allSupport)
{
	el.style.pixelTop = getOffset(srcobj, "Top") + 12
	if(getOffset(srcobj, "Left") < 200)
		el.style.pixelLeft = getOffset(srcobj, "Left") - 100;
	else
		el.style.pixelLeft = getOffset(srcobj, "Left") - 300;
}
else
{
	el.top = srcobj.y + 60
	el.left = srcobj.x + 60
}
}

//-->
