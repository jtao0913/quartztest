<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:doc="http://www.dcarlisle.demon.co.uk/xsldoc"
  xmlns:x="data:,x"
  exclude-result-prefixes="x h doc"
>

<xsl:output method="html" encoding="UTF-16"/>

<!--xsl:param name="XslHref">MathML_IE.xsl</xsl:param-->

	<xsl:template match="/">
		<html>
		<head>
			<title>
			</title>
			<script xmlns:m="http://www.w3.org/1998/Math/MathML">
			var strGlobalHref = "";
<xsl:text doc:id="malign">
function malign (l)
{
var m = 0;
for ( i = 0; i &lt; l.length ; i++)
{
 m = Math.max(m,l[i].offsetLeft);
}
for ( i = 0; i &lt; l.length ; i++)
{
 l[i].style.marginLeft=m - l[i].offsetLeft;
}
}
</xsl:text>

<xsl:text doc:id="mrowStretch">
function mrowStretch (opid,opt,ope,opm,opb){
opH = opid.offsetHeight;
var opH;
var i;
var es;
if (mrowH &gt; opH * 2) {
m= "&lt;font size='+1' face='symbol'>" + opm + "&lt;/font>&lt;br/>" ;
if ((mrowH &lt; opH * 3) &amp;&amp;(opm == ope) ) m="";
es="";
for ( i = 3; i &lt;= mrowH / (2*opH) ; i += 1) es += "&lt;font size='+1' face='symbol'>" + ope + "&lt;/font>&lt;br/>" ;
opid.innerHTML="&lt;table class='lr'>&lt;tr>&lt;td>&lt;font size='+1' face='symbol'>" +
          opt + "&lt;/font>&lt;br/>" +
       es +
       m +
       es +
 "&lt;font size='+1' face='symbol'>" + opb + "&lt;/font>&lt;/td>&lt;/tr>&lt;/table>";
}
}
</xsl:text>

<xsl:text doc:id="msubsup">
function msubsup (bs,bbs,x,b,p){
p.style.setExpression("top",bs +" .offsetTop -"  + (p.offsetHeight/2));
b.style.setExpression("top",bs + ".offsetTop + " + (bbs.offsetHeight - b.offsetHeight*.5));
x.style.setExpression("marginLeft",Math.max(p.offsetWidth,b.offsetWidth));
	document.recalc(true);
}
</xsl:text>

<xsl:text doc:id="msup">
function msup (bs,x,p){
p.style.setExpression("top",bs +" .offsetTop -"  + (p.offsetHeight/2));
x.style.setExpression("marginLeft", bs +"p.offsetWidth");
x.style.setExpression("height", bs + ".offsetHeight + " + p.offsetHeight);
document.recalc(true);
}
</xsl:text>

<xsl:text doc:id="msub">
function msub (bs,x,p){
p.style.setExpression("top",bs +" .offsetTop +"  + (p.offsetHeight/2));
x.style.setExpression("marginLeft", bs +"p.offsetWidth");
x.style.setExpression("height", bs + ".offsetHeight + " + p.offsetHeight);
document.recalc(true);
}
</xsl:text>

<xsl:text doc:id="toggle">
function toggle (x) {
for ( i = 0 ; i &lt; x.childNodes.length ; i++) {
if (x.childNodes.item(i).style.display=='inline') {
 x.childNodes.item(i).style.display='none';
if ( i+1 == x.childNodes.length) {
x.childNodes.item(0).style.display='inline';
} else {
x.childNodes.item(i+1).style.display='inline';
};
break;
}
}
}
</xsl:text>

<!-- 获取xml内的实体名称并返回实体名称列表 -->
<xsl:text doc:id="getentname">
function getentname( strXmlContent ) 
{
if( !strXmlContent )
	return null;

var arrayEnt = new Array();
var nPos, nStart = 0;
do
{
	nPos = strXmlContent.indexOf( "&amp;", nStart );
	if( nPos &gt;= 0 )
	{
		var nEntStart = nPos;
		nStart = nPos + 1;
		nPos = strXmlContent.indexOf( ";", nStart );
		if( nPos &gt;= 0 )
		{
			arrayEnt[arrayEnt.length] = strXmlContent.substring( nEntStart, nPos+1 );
			nStart = nPos + 1;
		}
	}
}
while( nPos &gt;= 0 )
	
return arrayEnt;
}
</xsl:text>

<!-- 获取实体声明定义内容 -->
<xsl:text doc:id="getentdef">
function getentdef( )
{
	var strContent = "&amp;acd;:&amp;#x0223F;!&amp;aleph;:&amp;#x02135;!&amp;and;:&amp;#x02227;!&amp;And;:&amp;#x02A53;!&amp;andand;:&amp;#x02A55;!&amp;andd;:&amp;#x02A5C;!&amp;andslope;:&amp;#x02A58;!&amp;andv;:&amp;#x02A5A;!&amp;angrt;:&amp;#x0221F;!&amp;angsph;:&amp;#x02222;!&amp;angst;:&amp;#x0212B;!&amp;ap;:&amp;#x02248;!&amp;apacir;:&amp;#x02A6F;!&amp;awconint;:&amp;#x02233;!&amp;awint;:&amp;#x02A11;!&amp;becaus;:&amp;#x02235;!&amp;bernou;:&amp;#x0212C;!&amp;bne;:&amp;#x0003D;&amp;#x020E5;!&amp;bnequiv;:&amp;#x02261;&amp;#x020E5;!&amp;bnot;:&amp;#x02310;!&amp;bNot;:&amp;#x02AED;!&amp;bottom;:&amp;#x022A5;!&amp;cap;:&amp;#x02229;!&amp;Cconint;:&amp;#x02230;!&amp;cirfnint;:&amp;#x02A10;!&amp;compfn;:&amp;#x02218;!&amp;cong;:&amp;#x02245;!&amp;conint;:&amp;#x0222E;!&amp;Conint;:&amp;#x0222F;!&amp;ctdot;:&amp;#x022EF;!&amp;cup;:&amp;#x0222A;!&amp;cwconint;:&amp;#x02232;!&amp;cwint;:&amp;#x02231;!&amp;cylcty;:&amp;#x0232D;!&amp;disin;:&amp;#x022F2;!&amp;Dot;:&amp;#x000A8;!&amp;DotDot;:&amp;#x020DC;!&amp;dsol;:&amp;#x029F6;!&amp;dtdot;:&amp;#x022F1;!&amp;dwangle;:&amp;#x029A6;!&amp;epar;:&amp;#x022D5;!&amp;eparsl;:&amp;#x029E3;!&amp;equiv;:&amp;#x02261;!&amp;eqvparsl;:&amp;#x029E5;!&amp;exist;:&amp;#x02203;!&amp;fnof;:&amp;#x00192;!&amp;forall;:&amp;#x02200;!&amp;fpartint;:&amp;#x02A0D;!&amp;ge;:&amp;#x02265;!&amp;hamilt;:&amp;#x0210B;!&amp;iff;:&amp;#x021D4;!&amp;iinfin;:&amp;#x029DC;!&amp;imped;:&amp;#x1D543;!&amp;infin;:&amp;#x0221E;!&amp;int;:&amp;#x0222B;!&amp;Int;:&amp;#x0222C;!&amp;intlarhk;:&amp;#x02A17;!&amp;isin;:&amp;#x02208;!&amp;isindot;:&amp;#x022F5;!&amp;isinE;:&amp;#x022F9;!&amp;isins;:&amp;#x022F4;!&amp;isinsv;:&amp;#x022F3;!&amp;isinv;:&amp;#x02208;!&amp;lagran;:&amp;#x02112;!&amp;lang;:&amp;#x02329;!&amp;Lang;:&amp;#x0300A;!&amp;lArr;:&amp;#x021D0;!&amp;lbbrk;:&amp;#x03014;!&amp;le;:&amp;#x02264;!&amp;loang;:&amp;#x0F558;!&amp;lobrk;:&amp;#x0301A;!&amp;lopar;:&amp;#x03018;!&amp;lowast;:&amp;#x02217;!&amp;minus;:&amp;#x02212;!&amp;mnplus;:&amp;#x02213;!&amp;nabla;:&amp;#x02207;!&amp;ne;:&amp;#x02260;!&amp;nedot;:&amp;#x02260;&amp;#x0FE00;!&amp;nhpar;:&amp;#x02AF2;!&amp;ni;:&amp;#x0220B;!&amp;nis;:&amp;#x022FC;!&amp;nisd;:&amp;#x022FA;!&amp;niv;:&amp;#x0220B;!&amp;Not;:&amp;#x02AEC;!&amp;notin;:&amp;#x02209;!&amp;notindot;:&amp;#x022F6;&amp;#x0FE00;!&amp;notinva;:&amp;#x02209;&amp;#x00338;!&amp;notinvb;:&amp;#x022F7;!&amp;notinvc;:&amp;#x022F6;!&amp;notni;:&amp;#x0220C;!&amp;notniva;:&amp;#x0220C;!&amp;notnivb;:&amp;#x022FE;!&amp;notnivc;:&amp;#x022FD;!&amp;nparsl;:&amp;#x02225;&amp;#x0FE00;&amp;#x020E5;!&amp;npart;:&amp;#x02202;&amp;#x00338;!&amp;npolint;:&amp;#x02A14;!&amp;nvinfin;:&amp;#x029DE;!&amp;olcross;:&amp;#x029BB;!&amp;or;:&amp;#x02228;!&amp;Or;:&amp;#x02A54;!&amp;ord;:&amp;#x02A5D;!&amp;order;:&amp;#x02134;!&amp;oror;:&amp;#x02A56;!&amp;orslope;:&amp;#x02A57;!&amp;orv;:&amp;#x02A5B;!&amp;par;:&amp;#x02225;!&amp;parsl;:&amp;#x02225;&amp;#x0FE00;!&amp;part;:&amp;#x02202;!&amp;permil;:&amp;#x02030;!&amp;perp;:&amp;#x022A5;!&amp;pertenk;:&amp;#x02031;!&amp;phmmat;:&amp;#x02133;!&amp;pointint;:&amp;#x02A15;!&amp;prime;:&amp;#x02032;!&amp;Prime;:&amp;#x02033;!&amp;profalar;:&amp;#x0232E;!&amp;profline;:&amp;#x02312;!&amp;profsurf;:&amp;#x02313;!&amp;prop;:&amp;#x0221D;!&amp;qint;:&amp;#x02A0C;!&amp;qprime;:&amp;#x02057;!&amp;quatint;:&amp;#x02A16;!&amp;radic;:&amp;#x0221A;!&amp;rang;:&amp;#x0232A;!&amp;Rang;:&amp;#x0300B;!&amp;rArr;:&amp;#x021D2;!&amp;rbbrk;:&amp;#x03015;!&amp;roang;:&amp;#x0F559;!&amp;robrk;:&amp;#x0301B;!&amp;ropar;:&amp;#x03019;!&amp;rppolint;:&amp;#x02A12;!&amp;scpolint;:&amp;#x02A13;!&amp;sim;:&amp;#x0223C;!&amp;simdot;:&amp;#x02A6A;!&amp;sime;:&amp;#x02243;!&amp;smeparsl;:&amp;#x029E4;!&amp;square;:&amp;#x025A1;!&amp;squarf;:&amp;#x025AA;!&amp;sub;:&amp;#x02282;!&amp;sube;:&amp;#x02286;!&amp;sup;:&amp;#x02283;!&amp;supe;:&amp;#x02287;!&amp;tdot;:&amp;#x020DB;!&amp;there4;:&amp;#x02234;!&amp;tint;:&amp;#x0222D;!&amp;top;:&amp;#x022A4;!&amp;topbot;:&amp;#x02336;!&amp;topcir;:&amp;#x02AF1;!&amp;tprime;:&amp;#x02034;!&amp;utdot;:&amp;#x022F0;!&amp;uwangle;:&amp;#x029A7;!&amp;vangrt;:&amp;#x022BE;!&amp;veeeq;:&amp;#x0225A;!&amp;Verbar;:&amp;#x02016;!&amp;wedgeq;:&amp;#x02259;!&amp;xnis;:&amp;#x022FB;!&amp;angle;:&amp;#x02220;!&amp;ApplyFunction;:&amp;#x02061;!&amp;approx;:&amp;#x02248;!&amp;approxeq;:&amp;#x0224A;!&amp;Assign;:&amp;#x02254;!&amp;backcong;:&amp;#x0224C;!&amp;backepsilon;:&amp;#x003F6;!&amp;backprime;:&amp;#x02035;!&amp;backsim;:&amp;#x0223D;!&amp;backsimeq;:&amp;#x022CD;!&amp;Backslash;:&amp;#x02216;!&amp;barwedge;:&amp;#x022BC;!&amp;because;:&amp;#x02235;!&amp;Because;:&amp;#x02235;!&amp;Bernoullis;:&amp;#x0212C;!&amp;between;:&amp;#x0226C;!&amp;bigcap;:&amp;#x022C2;!&amp;bigcirc;:&amp;#x025EF;!&amp;bigcup;:&amp;#x022C3;!&amp;bigodot;:&amp;#x02299;!&amp;bigoplus;:&amp;#x02295;!&amp;bigotimes;:&amp;#x02297;!&amp;bigsqcup;:&amp;#x02294;!&amp;bigstar;:&amp;#x02605;!&amp;bigtriangledown;:&amp;#x025BD;!&amp;bigtriangleup;:&amp;#x025B3;!&amp;biguplus;:&amp;#x0228E;!&amp;bigvee;:&amp;#x022C1;!&amp;bigwedge;:&amp;#x022C0;!&amp;bkarow;:&amp;#x0290D;!&amp;blacklozenge;:&amp;#x029EB;!&amp;blacksquare;:&amp;#x025AA;!&amp;blacktriangle;:&amp;#x025B4;!&amp;blacktriangledown;:&amp;#x025BE;!&amp;blacktriangleleft;:&amp;#x025C2;!&amp;blacktriangleright;:&amp;#x025B8;!&amp;bot;:&amp;#x022A5;!&amp;boxminus;:&amp;#x0229F;!&amp;boxplus;:&amp;#x0229E;!&amp;boxtimes;:&amp;#x022A0;!&amp;Breve;:&amp;#x002D8;!&amp;bullet;:&amp;#x02022;!&amp;bumpeq;:&amp;#x0224F;!&amp;Bumpeq;:&amp;#x0224E;!&amp;CapitalDifferentialD;:&amp;#x02145;!&amp;Cayleys;:&amp;#x0212D;!&amp;Cedilla;:&amp;#x000B8;!&amp;centerdot;:&amp;#x000B7;!&amp;CenterDot;:&amp;#x000B7;!&amp;checkmark;:&amp;#x02713;!&amp;circeq;:&amp;#x02257;!&amp;circlearrowleft;:&amp;#x021BA;!&amp;circlearrowright;:&amp;#x021BB;!&amp;circledast;:&amp;#x0229B;!&amp;circledcirc;:&amp;#x0229A;!&amp;circleddash;:&amp;#x0229D;!&amp;CircleDot;:&amp;#x02299;!&amp;circledR;:&amp;#x000AE;!&amp;circledS;:&amp;#x024C8;!&amp;CircleMinus;:&amp;#x02296;!&amp;CirclePlus;:&amp;#x02295;!&amp;CircleTimes;:&amp;#x02297;!&amp;ClockwiseContourIntegral;:&amp;#x02232;!&amp;CloseCurlyDoubleQuote;:&amp;#x0201D;!&amp;CloseCurlyQuote;:&amp;#x02019;!&amp;clubsuit;:&amp;#x02663;!&amp;coloneq;:&amp;#x02254;!&amp;complement;:&amp;#x02201;!&amp;complexes;:&amp;#x02102;!&amp;Congruent;:&amp;#x02261;!&amp;ContourIntegral;:&amp;#x0222E;!&amp;Coproduct;:&amp;#x02210;!&amp;CounterClockwiseContourIntegral;:&amp;#x02233;!&amp;CupCap;:&amp;#x0224D;!&amp;curlyeqprec;:&amp;#x022DE;!&amp;curlyeqsucc;:&amp;#x022DF;!&amp;curlyvee;:&amp;#x022CE;!&amp;curlywedge;:&amp;#x022CF;!&amp;curvearrowleft;:&amp;#x021B6;!&amp;curvearrowright;:&amp;#x021B7;!&amp;dbkarow;:&amp;#x0290F;!&amp;ddagger;:&amp;#x02021;!&amp;ddotseq;:&amp;#x02A77;!&amp;Del;:&amp;#x02207;!&amp;DiacriticalAcute;:&amp;#x000B4;!&amp;DiacriticalDot;:&amp;#x002D9;!&amp;DiacriticalDoubleAcute;:&amp;#x002DD;!&amp;DiacriticalGrave;:&amp;#x00060;!&amp;DiacriticalTilde;:&amp;#x002DC;!&amp;diamond;:&amp;#x022C4;!&amp;Diamond;:&amp;#x022C4;!&amp;diamondsuit;:&amp;#x02666;!&amp;DifferentialD;:&amp;#x02146;!&amp;digamma;:&amp;#x003DC;!&amp;div;:&amp;#x000F7;!&amp;divideontimes;:&amp;#x022C7;!&amp;doteq;:&amp;#x02250;!&amp;doteqdot;:&amp;#x02251;!&amp;DotEqual;:&amp;#x02250;!&amp;dotminus;:&amp;#x02238;!&amp;dotplus;:&amp;#x02214;!&amp;dotsquare;:&amp;#x022A1;!&amp;doublebarwedge;:&amp;#x02306;!&amp;DoubleContourIntegral;:&amp;#x0222F;!&amp;DoubleDot;:&amp;#x000A8;!&amp;DoubleDownArrow;:&amp;#x021D3;!&amp;DoubleLeftArrow;:&amp;#x021D0;!&amp;DoubleLeftRightArrow;:&amp;#x021D4;!&amp;DoubleLeftTee;:&amp;#x02AE4;!&amp;DoubleLongLeftArrow;:&amp;#x0F579;!&amp;DoubleLongLeftRightArrow;:&amp;#x0F57B;!&amp;DoubleLongRightArrow;:&amp;#x0F57A;!&amp;DoubleRightArrow;:&amp;#x021D2;!&amp;DoubleRightTee;:&amp;#x022A8;!&amp;DoubleUpArrow;:&amp;#x021D1;!&amp;DoubleUpDownArrow;:&amp;#x021D5;!&amp;DoubleVerticalBar;:&amp;#x02225;!&amp;downarrow;:&amp;#x02193;!&amp;Downarrow;:&amp;#x021D3;!&amp;DownArrow;:&amp;#x02193;!&amp;DownArrowUpArrow;:&amp;#x021F5;!&amp;downdownarrows;:&amp;#x021CA;!&amp;downharpoonleft;:&amp;#x021C3;!&amp;downharpoonright;:&amp;#x021C2;!&amp;DownLeftVector;:&amp;#x021BD;!&amp;DownRightVector;:&amp;#x021C1;!&amp;DownTee;:&amp;#x022A4;!&amp;DownTeeArrow;:&amp;#x021A7;!&amp;drbkarow;:&amp;#x02910;!&amp;Element;:&amp;#x02208;!&amp;emptyset;:&amp;#x02205;&amp;#x0FE00;!&amp;eqcirc;:&amp;#x02256;!&amp;eqcolon;:&amp;#x02255;!&amp;eqsim;:&amp;#x02242;!&amp;eqslantgtr;:&amp;#x022DD;!&amp;eqslantless;:&amp;#x022DC;!&amp;EqualTilde;:&amp;#x02242;!&amp;Equilibrium;:&amp;#x021CC;!&amp;Exists;:&amp;#x02203;!&amp;expectation;:&amp;#x02130;!&amp;exponentiale;:&amp;#x02147;!&amp;ExponentialE;:&amp;#x02147;!&amp;fallingdotseq;:&amp;#x02252;!&amp;ForAll;:&amp;#x02200;!&amp;Fouriertrf;:&amp;#x02131;!&amp;geq;:&amp;#x02265;!&amp;geqq;:&amp;#x02267;!&amp;geqslant;:&amp;#x02A7E;!&amp;gg;:&amp;#x0226B;!&amp;ggg;:&amp;#x022D9;!&amp;gnapprox;:&amp;#x02A8A;!&amp;gneq;:&amp;#x02269;!&amp;gneqq;:&amp;#x02269;!&amp;GreaterEqual;:&amp;#x02265;!&amp;GreaterEqualLess;:&amp;#x022DB;!&amp;GreaterFullEqual;:&amp;#x02267;!&amp;GreaterLess;:&amp;#x02277;!&amp;GreaterSlantEqual;:&amp;#x02A7E;!&amp;GreaterTilde;:&amp;#x02273;!&amp;gtrapprox;:&amp;#x02273;!&amp;gtrdot;:&amp;#x022D7;!&amp;gtreqless;:&amp;#x022DB;!&amp;gtreqqless;:&amp;#x022DB;!&amp;gtrless;:&amp;#x02277;!&amp;gtrsim;:&amp;#x02273;!&amp;gvertneqq;:&amp;#x02269;&amp;#x0FE00;!&amp;Hacek;:&amp;#x002C7;!&amp;Hat;:&amp;#x00302;!&amp;hbar;:&amp;#x0210F;&amp;#x0FE00;!&amp;heartsuit;:&amp;#x02661;!&amp;HilbertSpace;:&amp;#x0210B;!&amp;hksearow;:&amp;#x02925;!&amp;hkswarow;:&amp;#x02926;!&amp;hookleftarrow;:&amp;#x021A9;!&amp;hookrightarrow;:&amp;#x021AA;!&amp;hslash;:&amp;#x0210F;!&amp;HumpDownHump;:&amp;#x0224E;!&amp;HumpEqual;:&amp;#x0224F;!&amp;iiiint;:&amp;#x02A0C;!&amp;iiint;:&amp;#x0222D;!&amp;Im;:&amp;#x02111;!&amp;ImaginaryI;:&amp;#x02148;!&amp;imagline;:&amp;#x02110;!&amp;imagpart;:&amp;#x02111;!&amp;Implies;:&amp;#x021D2;!&amp;in;:&amp;#x02208;!&amp;integers;:&amp;#x02124;!&amp;Integral;:&amp;#x0222B;!&amp;intercal;:&amp;#x022BA;!&amp;Intersection;:&amp;#x022C2;!&amp;intprod;:&amp;#x02A3C;!&amp;InvisibleComma;:&amp;#x0200B;!&amp;InvisibleTimes;:&amp;#x02062;!&amp;langle;:&amp;#x02329;!&amp;Laplacetrf;:&amp;#x02112;!&amp;lbrace;:&amp;#x0007B;!&amp;lbrack;:&amp;#x0005B;!&amp;LeftAngleBracket;:&amp;#x02329;!&amp;leftarrow;:&amp;#x02190;!&amp;Leftarrow;:&amp;#x021D0;!&amp;LeftArrow;:&amp;#x02190;!&amp;LeftArrowBar;:&amp;#x021E4;!&amp;LeftArrowRightArrow;:&amp;#x021C6;!&amp;leftarrowtail;:&amp;#x021A2;!&amp;LeftCeiling;:&amp;#x02308;!&amp;LeftDoubleBracket;:&amp;#x0301A;!&amp;LeftDownVector;:&amp;#x021C3;!&amp;LeftFloor;:&amp;#x0230A;!&amp;leftharpoondown;:&amp;#x021BD;!&amp;leftharpoonup;:&amp;#x021BC;!&amp;leftleftarrows;:&amp;#x021C7;!&amp;leftrightarrow;:&amp;#x02194;!&amp;Leftrightarrow;:&amp;#x021D4;!&amp;LeftRightArrow;:&amp;#x02194;!&amp;leftrightarrows;:&amp;#x021C6;!&amp;leftrightharpoons;:&amp;#x021CB;!&amp;leftrightsquigarrow;:&amp;#x021AD;!&amp;LeftTee;:&amp;#x022A3;!&amp;LeftTeeArrow;:&amp;#x021A4;!&amp;leftthreetimes;:&amp;#x022CB;!&amp;LeftTriangle;:&amp;#x022B2;!&amp;LeftTriangleEqual;:&amp;#x022B4;!&amp;LeftUpVector;:&amp;#x021BF;!&amp;LeftVector;:&amp;#x021BC;!&amp;leq;:&amp;#x02264;!&amp;leqq;:&amp;#x02266;!&amp;leqslant;:&amp;#x02A7D;!&amp;lessapprox;:&amp;#x02272;!&amp;lessdot;:&amp;#x022D6;!&amp;lesseqgtr;:&amp;#x022DA;!&amp;lesseqqgtr;:&amp;#x022DA;!&amp;LessEqualGreater;:&amp;#x022DA;!&amp;LessFullEqual;:&amp;#x02266;!&amp;LessGreater;:&amp;#x02276;!&amp;lessgtr;:&amp;#x02276;!&amp;lesssim;:&amp;#x02272;!&amp;LessSlantEqual;:&amp;#x02A7D;!&amp;LessTilde;:&amp;#x02272;!&amp;ll;:&amp;#x0226A;!&amp;llcorner;:&amp;#x0231E;!&amp;Lleftarrow;:&amp;#x021DA;!&amp;lmoustache;:&amp;#x023B0;!&amp;lnapprox;:&amp;#x02A89;!&amp;lneq;:&amp;#x02268;!&amp;lneqq;:&amp;#x02268;!&amp;longleftarrow;:&amp;#x0F576;!&amp;Longleftarrow;:&amp;#x0F579;!&amp;LongLeftArrow;:&amp;#x0F576;!&amp;longleftrightarrow;:&amp;#x0F578;!&amp;Longleftrightarrow;:&amp;#x0F57B;!&amp;LongLeftRightArrow;:&amp;#x0F578;!&amp;longmapsto;:&amp;#x0F57D;!&amp;longrightarrow;:&amp;#x0F577;!&amp;Longrightarrow;:&amp;#x0F57A;!&amp;LongRightArrow;:&amp;#x0F577;!&amp;looparrowleft;:&amp;#x021AB;!&amp;looparrowright;:&amp;#x021AC;!&amp;LowerLeftArrow;:&amp;#x02199;!&amp;LowerRightArrow;:&amp;#x02198;!&amp;lozenge;:&amp;#x025CA;!&amp;lrcorner;:&amp;#x0231F;!&amp;Lsh;:&amp;#x021B0;!&amp;lvertneqq;:&amp;#x02268;&amp;#x0FE00;!&amp;maltese;:&amp;#x02720;!&amp;mapsto;:&amp;#x021A6;!&amp;measuredangle;:&amp;#x02221;!&amp;Mellintrf;:&amp;#x02133;!&amp;MinusPlus;:&amp;#x02213;!&amp;mp;:&amp;#x02213;!&amp;multimap;:&amp;#x022B8;!&amp;napprox;:&amp;#x02249;!&amp;natural;:&amp;#x0266E;!&amp;naturals;:&amp;#x02115;!&amp;nearrow;:&amp;#x02197;!&amp;NestedGreaterGreater;:&amp;#x0226B;!&amp;NestedLessLess;:&amp;#x0226A;!&amp;nexists;:&amp;#x02204;!&amp;ngeq;:&amp;#x02271;&amp;#x020E5;!&amp;ngeqq;:&amp;#x02271;!&amp;ngeqslant;:&amp;#x02271;!&amp;ngtr;:&amp;#x0226F;!&amp;nleftarrow;:&amp;#x0219A;!&amp;nLeftarrow;:&amp;#x021CD;!&amp;nleftrightarrow;:&amp;#x021AE;!&amp;nLeftrightarrow;:&amp;#x021CE;!&amp;nleq;:&amp;#x02270;&amp;#x020E5;!&amp;nleqq;:&amp;#x02270;!&amp;nleqslant;:&amp;#x02270;!&amp;nless;:&amp;#x0226E;!&amp;NonBreakingSpace;:&amp;#x000A0;!&amp;NotCongruent;:&amp;#x02262;!&amp;NotDoubleVerticalBar;:&amp;#x02226;!&amp;NotElement;:&amp;#x02209;!&amp;NotEqual;:&amp;#x02260;!&amp;NotEqualTilde;:&amp;#x02242;&amp;#x00338;!&amp;NotExists;:&amp;#x02204;!&amp;NotGreater;:&amp;#x0226F;!&amp;NotGreaterEqual;:&amp;#x02271;&amp;#x020E5;!&amp;NotGreaterFullEqual;:&amp;#x02270;!&amp;NotGreaterGreater;:&amp;#x0226B;&amp;#x00338;&amp;#x0FE00;!&amp;NotGreaterLess;:&amp;#x02279;!&amp;NotGreaterSlantEqual;:&amp;#x02271;!&amp;NotGreaterTilde;:&amp;#x02275;!&amp;NotHumpDownHump;:&amp;#x0224E;&amp;#x00338;!&amp;NotLeftTriangle;:&amp;#x022EA;!&amp;NotLeftTriangleEqual;:&amp;#x022EC;!&amp;NotLess;:&amp;#x0226E;!&amp;NotLessEqual;:&amp;#x02270;&amp;#x020E5;!&amp;NotLessGreater;:&amp;#x02278;!&amp;NotLessLess;:&amp;#x0226A;&amp;#x00338;&amp;#x0FE00;!&amp;NotLessSlantEqual;:&amp;#x02270;!&amp;NotLessTilde;:&amp;#x02274;!&amp;NotPrecedes;:&amp;#x02280;!&amp;NotPrecedesEqual;:&amp;#x02AAF;&amp;#x00338;!&amp;NotPrecedesSlantEqual;:&amp;#x022E0;!&amp;NotReverseElement;:&amp;#x0220C;!&amp;NotRightTriangle;:&amp;#x022EB;!&amp;NotRightTriangleEqual;:&amp;#x022ED;!&amp;NotSquareSubsetEqual;:&amp;#x022E2;!&amp;NotSquareSupersetEqual;:&amp;#x022E3;!&amp;NotSubset;:&amp;#x02284;!&amp;NotSubsetEqual;:&amp;#x02288;!&amp;NotSucceeds;:&amp;#x02281;!&amp;NotSucceedsEqual;:&amp;#x02AB0;&amp;#x00338;!&amp;NotSucceedsSlantEqual;:&amp;#x022E1;!&amp;NotSuperset;:&amp;#x02285;!&amp;NotSupersetEqual;:&amp;#x02289;!&amp;NotTilde;:&amp;#x02241;!&amp;NotTildeEqual;:&amp;#x02244;!&amp;NotTildeFullEqual;:&amp;#x02247;!&amp;NotTildeTilde;:&amp;#x02249;!&amp;NotVerticalBar;:&amp;#x02224;!&amp;nparallel;:&amp;#x02226;!&amp;nprec;:&amp;#x02280;!&amp;npreceq;:&amp;#x02AAF;&amp;#x00338;!&amp;nrightarrow;:&amp;#x0219B;!&amp;nRightarrow;:&amp;#x021CF;!&amp;nshortmid;:&amp;#x02224;&amp;#x0FE00;!&amp;nshortparallel;:&amp;#x02226;&amp;#x0FE00;!&amp;nsimeq;:&amp;#x02244;!&amp;nsubset;:&amp;#x02284;!&amp;nsubseteq;:&amp;#x02288;!&amp;nsubseteqq;:&amp;#x02288;!&amp;nsucc;:&amp;#x02281;!&amp;nsucceq;:&amp;#x02AB0;&amp;#x00338;!&amp;nsupset;:&amp;#x02285;!&amp;nsupseteq;:&amp;#x02289;!&amp;nsupseteqq;:&amp;#x02289;!&amp;ntriangleleft;:&amp;#x022EA;!&amp;ntrianglelefteq;:&amp;#x022EC;!&amp;ntriangleright;:&amp;#x022EB;!&amp;ntrianglerighteq;:&amp;#x022ED;!&amp;nwarrow;:&amp;#x02196;!&amp;oint;:&amp;#x0222E;!&amp;OpenCurlyDoubleQuote;:&amp;#x0201C;!&amp;OpenCurlyQuote;:&amp;#x02018;!&amp;orderof;:&amp;#x02134;!&amp;parallel;:&amp;#x02225;!&amp;PartialD;:&amp;#x02202;!&amp;pitchfork;:&amp;#x022D4;!&amp;PlusMinus;:&amp;#x000B1;!&amp;pm;:&amp;#x000B1;!&amp;Poincareplane;:&amp;#x0210C;!&amp;prec;:&amp;#x0227A;!&amp;precapprox;:&amp;#x0227E;!&amp;preccurlyeq;:&amp;#x0227C;!&amp;Precedes;:&amp;#x0227A;!&amp;PrecedesEqual;:&amp;#x02AAF;!&amp;PrecedesSlantEqual;:&amp;#x0227C;!&amp;PrecedesTilde;:&amp;#x0227E;!&amp;preceq;:&amp;#x02AAF;!&amp;precnapprox;:&amp;#x022E8;!&amp;precneqq;:&amp;#x02AB5;!&amp;precnsim;:&amp;#x022E8;!&amp;precsim;:&amp;#x0227E;!&amp;primes;:&amp;#x02119;!&amp;Proportion;:&amp;#x02237;!&amp;Proportional;:&amp;#x0221D;!&amp;propto;:&amp;#x0221D;!&amp;quaternions;:&amp;#x0210D;!&amp;questeq;:&amp;#x0225F;!&amp;rangle;:&amp;#x0232A;!&amp;rationals;:&amp;#x0211A;!&amp;rbrace;:&amp;#x0007D;!&amp;rbrack;:&amp;#x0005D;!&amp;Re;:&amp;#x0211C;!&amp;realine;:&amp;#x0211B;!&amp;realpart;:&amp;#x0211C;!&amp;reals;:&amp;#x0211D;!&amp;ReverseElement;:&amp;#x0220B;!&amp;ReverseEquilibrium;:&amp;#x021CB;!&amp;ReverseUpEquilibrium;:&amp;#x0296F;!&amp;RightAngleBracket;:&amp;#x0232A;!&amp;rightarrow;:&amp;#x02192;!&amp;Rightarrow;:&amp;#x021D2;!&amp;RightArrow;:&amp;#x02192;!&amp;RightArrowBar;:&amp;#x021E5;!&amp;RightArrowLeftArrow;:&amp;#x021C4;!&amp;rightarrowtail;:&amp;#x021A3;!&amp;RightCeiling;:&amp;#x02309;!&amp;RightDoubleBracket;:&amp;#x0301B;!&amp;RightDownVector;:&amp;#x021C2;!&amp;RightFloor;:&amp;#x0230B;!&amp;rightharpoondown;:&amp;#x021C1;!&amp;rightharpoonup;:&amp;#x021C0;!&amp;rightleftarrows;:&amp;#x021C4;!&amp;rightleftharpoons;:&amp;#x021CC;!&amp;rightrightarrows;:&amp;#x021C9;!&amp;rightsquigarrow;:&amp;#x0219D;!&amp;RightTee;:&amp;#x022A2;!&amp;RightTeeArrow;:&amp;#x021A6;!&amp;rightthreetimes;:&amp;#x022CC;!&amp;RightTriangle;:&amp;#x022B3;!&amp;RightTriangleEqual;:&amp;#x022B5;!&amp;RightUpVector;:&amp;#x021BE;!&amp;RightVector;:&amp;#x021C0;!&amp;risingdotseq;:&amp;#x02253;!&amp;rmoustache;:&amp;#x023B1;!&amp;Rrightarrow;:&amp;#x021DB;!&amp;Rsh;:&amp;#x021B1;!&amp;searrow;:&amp;#x02198;!&amp;setminus;:&amp;#x02216;!&amp;ShortLeftArrow;:&amp;#x02190;&amp;#x0FE00;!&amp;shortmid;:&amp;#x02223;&amp;#x0FE00;!&amp;shortparallel;:&amp;#x02225;&amp;#x0FE00;!&amp;ShortRightArrow;:&amp;#x02192;&amp;#x0FE00;!&amp;simeq;:&amp;#x02243;!&amp;SmallCircle;:&amp;#x02218;!&amp;smallsetminus;:&amp;#x02216;&amp;#x0FE00;!&amp;spadesuit;:&amp;#x02660;!&amp;Sqrt;:&amp;#x0221A;!&amp;sqsubset;:&amp;#x0228F;!&amp;sqsubseteq;:&amp;#x02291;!&amp;sqsupset;:&amp;#x02290;!&amp;sqsupseteq;:&amp;#x02292;!&amp;Square;:&amp;#x025A1;!&amp;SquareIntersection;:&amp;#x02293;!&amp;SquareSubset;:&amp;#x0228F;!&amp;SquareSubsetEqual;:&amp;#x02291;!&amp;SquareSuperset;:&amp;#x02290;!&amp;SquareSupersetEqual;:&amp;#x02292;!&amp;SquareUnion;:&amp;#x02294;!&amp;Star;:&amp;#x022C6;!&amp;straightepsilon;:&amp;#x003B5;!&amp;straightphi;:&amp;#x003C6;!&amp;subset;:&amp;#x02282;!&amp;Subset;:&amp;#x022D0;!&amp;subseteq;:&amp;#x02286;!&amp;subseteqq;:&amp;#x02286;!&amp;SubsetEqual;:&amp;#x02286;!&amp;subsetneq;:&amp;#x0228A;!&amp;subsetneqq;:&amp;#x0228A;!&amp;succ;:&amp;#x0227B;!&amp;succapprox;:&amp;#x0227F;!&amp;succcurlyeq;:&amp;#x0227D;!&amp;Succeeds;:&amp;#x0227B;!&amp;SucceedsEqual;:&amp;#x0227D;!&amp;SucceedsSlantEqual;:&amp;#x0227D;!&amp;SucceedsTilde;:&amp;#x0227F;!&amp;succeq;:&amp;#x0227D;!&amp;succnapprox;:&amp;#x022E9;!&amp;succneqq;:&amp;#x02AB6;!&amp;succnsim;:&amp;#x022E9;!&amp;succsim;:&amp;#x0227F;!&amp;SuchThat;:&amp;#x0220B;!&amp;Sum;:&amp;#x02211;!&amp;Superset;:&amp;#x02283;!&amp;SupersetEqual;:&amp;#x02287;!&amp;supset;:&amp;#x02283;!&amp;Supset;:&amp;#x022D1;!&amp;supseteq;:&amp;#x02287;!&amp;supseteqq;:&amp;#x02287;!&amp;supsetneq;:&amp;#x0228B;!&amp;supsetneqq;:&amp;#x0228B;!&amp;swarrow;:&amp;#x02199;!&amp;therefore;:&amp;#x02234;!&amp;Therefore;:&amp;#x02234;!&amp;thickapprox;:&amp;#x02248;&amp;#x0FE00;!&amp;thicksim;:&amp;#x0223C;&amp;#x0FE00;!&amp;ThinSpace;:&amp;#x02009;!&amp;Tilde;:&amp;#x0223C;!&amp;TildeEqual;:&amp;#x02243;!&amp;TildeFullEqual;:&amp;#x02245;!&amp;TildeTilde;:&amp;#x02248;!&amp;toea;:&amp;#x02928;!&amp;tosa;:&amp;#x02929;!&amp;triangle;:&amp;#x025B5;!&amp;triangledown;:&amp;#x025BF;!&amp;triangleleft;:&amp;#x025C3;!&amp;trianglelefteq;:&amp;#x022B4;!&amp;triangleq;:&amp;#x0225C;!&amp;triangleright;:&amp;#x025B9;!&amp;trianglerighteq;:&amp;#x022B5;!&amp;TripleDot;:&amp;#x020DB;!&amp;twoheadleftarrow;:&amp;#x0219E;!&amp;twoheadrightarrow;:&amp;#x021A0;!&amp;ulcorner;:&amp;#x0231C;!&amp;Union;:&amp;#x022C3;!&amp;UnionPlus;:&amp;#x0228E;!&amp;uparrow;:&amp;#x02191;!&amp;Uparrow;:&amp;#x021D1;!&amp;UpArrow;:&amp;#x02191;!&amp;UpArrowDownArrow;:&amp;#x021C5;!&amp;updownarrow;:&amp;#x02195;!&amp;Updownarrow;:&amp;#x021D5;!&amp;UpDownArrow;:&amp;#x02195;!&amp;UpEquilibrium;:&amp;#x0296E;!&amp;upharpoonleft;:&amp;#x021BF;!&amp;upharpoonright;:&amp;#x021BE;!&amp;UpperLeftArrow;:&amp;#x02196;!&amp;UpperRightArrow;:&amp;#x02197;!&amp;upsilon;:&amp;#x003C5;!&amp;Upsilon;:&amp;#x003D2;!&amp;UpTee;:&amp;#x022A5;!&amp;UpTeeArrow;:&amp;#x021A5;!&amp;upuparrows;:&amp;#x021C8;!&amp;urcorner;:&amp;#x0231D;!&amp;varepsilon;:&amp;#x0025B;!&amp;varkappa;:&amp;#x003F0;!&amp;varnothing;:&amp;#x02205;!&amp;varphi;:&amp;#x003D5;!&amp;varpi;:&amp;#x003D6;!&amp;varpropto;:&amp;#x0221D;!&amp;varrho;:&amp;#x003F1;!&amp;varsigma;:&amp;#x003C2;!&amp;varsubsetneq;:&amp;#x0228A;&amp;#x0FE00;!&amp;varsubsetneqq;:&amp;#x0228A;&amp;#x0FE00;!&amp;varsupsetneq;:&amp;#x0228B;&amp;#x0FE00;!&amp;varsupsetneqq;:&amp;#x0228B;&amp;#x0FE00;!&amp;vartheta;:&amp;#x003D1;!&amp;vartriangleleft;:&amp;#x022B2;!&amp;vartriangleright;:&amp;#x022B3;!&amp;vee;:&amp;#x02228;!&amp;Vee;:&amp;#x022C1;!&amp;vert;:&amp;#x0007C;!&amp;Vert;:&amp;#x02016;!&amp;VerticalBar;:&amp;#x02223;!&amp;VerticalTilde;:&amp;#x02240;!&amp;VeryThinSpace;:&amp;#x0200A;!&amp;wedge;:&amp;#x02227;!&amp;Wedge;:&amp;#x022C0;!&amp;wp;:&amp;#x02118;!&amp;wr;:&amp;#x02240;!&amp;zeetrf;:&amp;#x02128;!&amp;ZeroWidthSpace;:&amp;#x0200B;!&amp;af;:&amp;#x02061;!&amp;aopf;:&amp;#x1D552;!&amp;bopf;:&amp;#x1D553;!&amp;copf;:&amp;#x1D554;!&amp;Cross;:&amp;#x02A2F;!&amp;dd;:&amp;#x02146;!&amp;DD;:&amp;#x02145;!&amp;dopf;:&amp;#x1D555;!&amp;DownArrowBar;:&amp;#x02913;!&amp;DownBreve;:&amp;#x00311;!&amp;DownLeftRightVector;:&amp;#x02950;!&amp;DownLeftTeeVector;:&amp;#x0295E;!&amp;DownLeftVectorBar;:&amp;#x02956;!&amp;DownRightTeeVector;:&amp;#x0295F;!&amp;DownRightVectorBar;:&amp;#x02957;!&amp;ee;:&amp;#x02147;!&amp;EmptySmallSquare;:&amp;#x025FD;!&amp;EmptyVerySmallSquare;:&amp;#x0F59C;!&amp;eopf;:&amp;#x1D556;!&amp;Equal;:&amp;#x02A75;!&amp;FilledSmallSquare;:&amp;#x025FE;!&amp;FilledVerySmallSquare;:&amp;#x0F59B;!&amp;fopf;:&amp;#x1D557;!&amp;gopf;:&amp;#x1D558;!&amp;GreaterGreater;:&amp;#x02AA2;!&amp;hopf;:&amp;#x1D559;!&amp;HorizontalLine;:&amp;#x02500;!&amp;ic;:&amp;#x0200B;!&amp;ii;:&amp;#x02148;!&amp;iopf;:&amp;#x1D55A;!&amp;it;:&amp;#x02062;!&amp;jopf;:&amp;#x1D55B;!&amp;kopf;:&amp;#x1D55C;!&amp;larrb;:&amp;#x021E4;!&amp;LeftDownTeeVector;:&amp;#x02961;!&amp;LeftDownVectorBar;:&amp;#x02959;!&amp;LeftRightVector;:&amp;#x0294E;!&amp;LeftTeeVector;:&amp;#x0295A;!&amp;LeftTriangleBar;:&amp;#x029CF;!&amp;LeftUpDownVector;:&amp;#x02951;!&amp;LeftUpTeeVector;:&amp;#x02960;!&amp;LeftUpVectorBar;:&amp;#x02958;!&amp;LeftVectorBar;:&amp;#x02952;!&amp;LessLess;:&amp;#x02AA1;!&amp;lopf;:&amp;#x1D55D;!&amp;mapstodown;:&amp;#x021A7;!&amp;mapstoleft;:&amp;#x021A4;!&amp;mapstoup;:&amp;#x021A5;!&amp;MediumSpace;:&amp;#x0205F;!&amp;mopf;:&amp;#x1D55E;!&amp;nbump;:&amp;#x0224E;&amp;#x00338;!&amp;nbumpe;:&amp;#x0224F;&amp;#x00338;!&amp;NegativeMediumSpace;:&amp;#x0205F;&amp;#x0FE00;!&amp;NegativeThickSpace;:&amp;#x02005;&amp;#x0FE00;!&amp;NegativeThinSpace;:&amp;#x02009;&amp;#x0FE00;!&amp;NegativeVeryThinSpace;:&amp;#x0200A;&amp;#x0FE00;!&amp;nesim;:&amp;#x02242;&amp;#x00338;!&amp;NewLine;:&amp;#x0000A;!&amp;NoBreak;:&amp;#x0FEFF;!&amp;nopf;:&amp;#x1D55F;!&amp;NotCupCap;:&amp;#x0226D;!&amp;NotHumpEqual;:&amp;#x0224F;&amp;#x00338;!&amp;NotLeftTriangleBar;:&amp;#x029CF;&amp;#x00338;!&amp;NotNestedGreaterGreater;:&amp;#x024A2;&amp;#x00338;!&amp;NotNestedLessLess;:&amp;#x024A1;&amp;#x00338;!&amp;NotRightTriangleBar;:&amp;#x029D0;&amp;#x00338;!&amp;NotSquareSubset;:&amp;#x0228F;&amp;#x00338;!&amp;NotSquareSuperset;:&amp;#x02290;&amp;#x00338;!&amp;NotSucceedsTilde;:&amp;#x0227F;&amp;#x00338;!&amp;oopf;:&amp;#x1D560;!&amp;OverBar;:&amp;#x000AF;!&amp;OverBrace;:&amp;#x0FE37;!&amp;OverBracket;:&amp;#x023B4;!&amp;OverParenthesis;:&amp;#x0FE35;!&amp;planckh;:&amp;#x0210E;!&amp;popf;:&amp;#x1D561;!&amp;Product;:&amp;#x0220F;!&amp;qopf;:&amp;#x1D562;!&amp;rarrb;:&amp;#x021E5;!&amp;RightDownTeeVector;:&amp;#x0295D;!&amp;RightDownVectorBar;:&amp;#x02955;!&amp;RightTeeVector;:&amp;#x0295B;!&amp;RightTriangleBar;:&amp;#x029D0;!&amp;RightUpDownVector;:&amp;#x0294F;!&amp;RightUpTeeVector;:&amp;#x0295C;!&amp;RightUpVectorBar;:&amp;#x02954;!&amp;RightVectorBar;:&amp;#x02953;!&amp;ropf;:&amp;#x1D563;!&amp;RoundImplies;:&amp;#x02970;!&amp;RuleDelayed;:&amp;#x029F4;!&amp;ShortDownArrow;:&amp;#x02304;&amp;#x0FE00;!&amp;ShortUpArrow;:&amp;#x02303;&amp;#x0FE00;!&amp;sopf;:&amp;#x1D564;!&amp;Tab;:&amp;#x00009;!&amp;ThickSpace;:&amp;#x02009;&amp;#x0200A;&amp;#x0200A;!&amp;topf;:&amp;#x1D565;!&amp;UnderBar;:&amp;#x00332;!&amp;UnderBrace;:&amp;#x0FE38;!&amp;UnderBracket;:&amp;#x023B5;!&amp;UnderParenthesis;:&amp;#x0FE36;!&amp;uopf;:&amp;#x1D566;!&amp;UpArrowBar;:&amp;#x02912;!&amp;VerticalLine;:&amp;#x0007C;!&amp;VerticalSeparator;:&amp;#x02758;!&amp;vopf;:&amp;#x1D567;!&amp;wopf;:&amp;#x1D568;!&amp;xopf;:&amp;#x1D569;!&amp;yopf;:&amp;#x1D56A;!&amp;zopf;:&amp;#x1D56B;!&amp;angzarr;:&amp;#x0237C;!&amp;cirmid;:&amp;#x02AEF;!&amp;cudarrl;:&amp;#x02938;!&amp;cudarrr;:&amp;#x02935;!&amp;cularr;:&amp;#x021B6;!&amp;cularrp;:&amp;#x0293D;!&amp;curarr;:&amp;#x021B7;!&amp;curarrm;:&amp;#x0293C;!&amp;dArr;:&amp;#x021D3;!&amp;Darr;:&amp;#x021A1;!&amp;ddarr;:&amp;#x021CA;!&amp;DDotrahd;:&amp;#x02911;!&amp;dfisht;:&amp;#x0297F;!&amp;dHar;:&amp;#x02965;!&amp;dharl;:&amp;#x021C3;!&amp;dharr;:&amp;#x021C2;!&amp;duarr;:&amp;#x021F5;!&amp;duhar;:&amp;#x0296F;!&amp;dzigrarr;:&amp;#x0F5A2;!&amp;erarr;:&amp;#x02971;!&amp;harr;:&amp;#x02194;!&amp;hArr;:&amp;#x021D4;!&amp;harrcir;:&amp;#x02948;!&amp;harrw;:&amp;#x021AD;!&amp;hoarr;:&amp;#x021FF;!&amp;imof;:&amp;#x022B7;!&amp;lAarr;:&amp;#x021DA;!&amp;Larr;:&amp;#x0219E;!&amp;larrbfs;:&amp;#x0291F;!&amp;larrfs;:&amp;#x0291D;!&amp;larrhk;:&amp;#x021A9;!&amp;larrlp;:&amp;#x021AB;!&amp;larrpl;:&amp;#x02939;!&amp;larrsim;:&amp;#x02973;!&amp;larrtl;:&amp;#x021A2;!&amp;latail;:&amp;#x02919;!&amp;lAtail;:&amp;#x0291B;!&amp;lbarr;:&amp;#x0290C;!&amp;lBarr;:&amp;#x0290E;!&amp;ldca;:&amp;#x02936;!&amp;ldrdhar;:&amp;#x02967;!&amp;ldrushar;:&amp;#x0294B;!&amp;ldsh;:&amp;#x021B2;!&amp;lfisht;:&amp;#x0297C;!&amp;lHar;:&amp;#x02962;!&amp;lhard;:&amp;#x021BD;!&amp;lharu;:&amp;#x021BC;!&amp;lharul;:&amp;#x0296A;!&amp;llarr;:&amp;#x021C7;!&amp;llhard;:&amp;#x0296B;!&amp;loarr;:&amp;#x021FD;!&amp;lrarr;:&amp;#x021C6;!&amp;lrhar;:&amp;#x021CB;!&amp;lrhard;:&amp;#x0296D;!&amp;lsh;:&amp;#x021B0;!&amp;lurdshar;:&amp;#x0294A;!&amp;luruhar;:&amp;#x02966;!&amp;map;:&amp;#x021A6;!&amp;Map;:&amp;#x02905;!&amp;midcir;:&amp;#x02AF0;!&amp;mumap;:&amp;#x022B8;!&amp;nearhk;:&amp;#x02924;!&amp;nearr;:&amp;#x02197;!&amp;neArr;:&amp;#x021D7;!&amp;nesear;:&amp;#x02928;!&amp;nharr;:&amp;#x021AE;!&amp;nhArr;:&amp;#x021CE;!&amp;nlarr;:&amp;#x0219A;!&amp;nlArr;:&amp;#x021CD;!&amp;nrarr;:&amp;#x0219B;!&amp;nrArr;:&amp;#x021CF;!&amp;nrarrc;:&amp;#x02933;&amp;#x00338;!&amp;nrarrw;:&amp;#x0219D;&amp;#x00338;!&amp;nvHarr;:&amp;#x021CE;!&amp;nvlArr;:&amp;#x021CD;!&amp;nvrArr;:&amp;#x021CF;!&amp;nwarhk;:&amp;#x02923;!&amp;nwarr;:&amp;#x02196;!&amp;nwArr;:&amp;#x021D6;!&amp;nwnear;:&amp;#x02927;!&amp;olarr;:&amp;#x021BA;!&amp;orarr;:&amp;#x021BB;!&amp;origof;:&amp;#x022B6;!&amp;rAarr;:&amp;#x021DB;!&amp;Rarr;:&amp;#x021A0;!&amp;rarrap;:&amp;#x02975;!&amp;rarrbfs;:&amp;#x02920;!&amp;rarrc;:&amp;#x02933;!&amp;rarrfs;:&amp;#x0291E;!&amp;rarrhk;:&amp;#x021AA;!&amp;rarrlp;:&amp;#x021AC;!&amp;rarrpl;:&amp;#x02945;!&amp;rarrsim;:&amp;#x02974;!&amp;rarrtl;:&amp;#x021A3;!&amp;Rarrtl;:&amp;#x02916;!&amp;rarrw;:&amp;#x0219D;!&amp;ratail;:&amp;#x021A3;!&amp;rAtail;:&amp;#x0291C;!&amp;rbarr;:&amp;#x0290D;!&amp;rBarr;:&amp;#x0290F;!&amp;RBarr;:&amp;#x02910;!&amp;rdca;:&amp;#x02937;!&amp;rdldhar;:&amp;#x02969;!&amp;rdsh;:&amp;#x021B3;!&amp;rfisht;:&amp;#x0297D;!&amp;rHar;:&amp;#x02964;!&amp;rhard;:&amp;#x021C1;!&amp;rharu;:&amp;#x021C0;!&amp;rharul;:&amp;#x0296C;!&amp;rlarr;:&amp;#x021C4;!&amp;rlhar;:&amp;#x021CC;!&amp;roarr;:&amp;#x021FE;!&amp;rrarr;:&amp;#x021C9;!&amp;rsh;:&amp;#x021B1;!&amp;ruluhar;:&amp;#x02968;!&amp;searhk;:&amp;#x02925;!&amp;searr;:&amp;#x02198;!&amp;seArr;:&amp;#x021D8;!&amp;seswar;:&amp;#x02929;!&amp;simrarr;:&amp;#x02972;!&amp;slarr;:&amp;#x02190;&amp;#x0FE00;!&amp;srarr;:&amp;#x02192;&amp;#x0FE00;!&amp;swarhk;:&amp;#x02926;!&amp;swarr;:&amp;#x02199;!&amp;swArr;:&amp;#x021D9;!&amp;swnwar;:&amp;#x0292A;!&amp;uArr;:&amp;#x021D1;!&amp;Uarr;:&amp;#x0219F;!&amp;Uarrocir;:&amp;#x02949;!&amp;udarr;:&amp;#x021C5;!&amp;udhar;:&amp;#x0296E;!&amp;ufisht;:&amp;#x0297E;!&amp;uHar;:&amp;#x02963;!&amp;uharl;:&amp;#x021BF;!&amp;uharr;:&amp;#x021BE;!&amp;uuarr;:&amp;#x021C8;!&amp;varr;:&amp;#x02195;!&amp;vArr;:&amp;#x021D5;!&amp;xharr;:&amp;#x0F578;!&amp;xhArr;:&amp;#x0F57B;!&amp;xlarr;:&amp;#x0F576;!&amp;xlArr;:&amp;#x0F579;!&amp;xmap;:&amp;#x0F57D;!&amp;xrarr;:&amp;#x0F577;!&amp;xrArr;:&amp;#x0F57A;!&amp;zigrarr;:&amp;#x021DD;!&amp;ac;:&amp;#x0290F;!&amp;acE;:&amp;#x029DB;!&amp;amalg;:&amp;#x02A3F;!&amp;barvee;:&amp;#x022BD;!&amp;barwed;:&amp;#x022BC;!&amp;Barwed;:&amp;#x02306;!&amp;bsolb;:&amp;#x029C5;!&amp;Cap;:&amp;#x022D2;!&amp;capand;:&amp;#x02A44;!&amp;capbrcup;:&amp;#x02A49;!&amp;capcap;:&amp;#x02A4B;!&amp;capcup;:&amp;#x02A47;!&amp;capdot;:&amp;#x02A40;!&amp;caps;:&amp;#x02229;&amp;#x0FE00;!&amp;ccaps;:&amp;#x02A4D;!&amp;ccups;:&amp;#x02A4C;!&amp;ccupssm;:&amp;#x02A50;!&amp;coprod;:&amp;#x02210;!&amp;Cup;:&amp;#x022D3;!&amp;cupbrcap;:&amp;#x02A48;!&amp;cupcap;:&amp;#x02A46;!&amp;cupcup;:&amp;#x02A4A;!&amp;cupdot;:&amp;#x0228D;!&amp;cupor;:&amp;#x02A45;!&amp;cups;:&amp;#x0222A;&amp;#x0FE00;!&amp;cuvee;:&amp;#x022CE;!&amp;cuwed;:&amp;#x022CF;!&amp;dagger;:&amp;#x02020;!&amp;Dagger;:&amp;#x02021;!&amp;diam;:&amp;#x022C4;!&amp;divonx;:&amp;#x022C7;!&amp;eplus;:&amp;#x02A71;!&amp;hercon;:&amp;#x022B9;!&amp;intcal;:&amp;#x022BA;!&amp;iprod;:&amp;#x02A3C;!&amp;loplus;:&amp;#x02A2D;!&amp;lotimes;:&amp;#x02A34;!&amp;lthree;:&amp;#x022CB;!&amp;ltimes;:&amp;#x022C9;!&amp;midast;:&amp;#x0002A;!&amp;minusb;:&amp;#x0229F;!&amp;minusd;:&amp;#x02238;!&amp;minusdu;:&amp;#x02A2A;!&amp;ncap;:&amp;#x02A43;!&amp;ncup;:&amp;#x02A42;!&amp;oast;:&amp;#x0229B;!&amp;ocir;:&amp;#x0229A;!&amp;odash;:&amp;#x0229D;!&amp;odiv;:&amp;#x02A38;!&amp;odot;:&amp;#x02299;!&amp;odsold;:&amp;#x029BC;!&amp;ofcir;:&amp;#x029BF;!&amp;ogt;:&amp;#x029C1;!&amp;ohbar;:&amp;#x029B5;!&amp;olcir;:&amp;#x029BE;!&amp;olt;:&amp;#x029C0;!&amp;omid;:&amp;#x029B6;!&amp;ominus;:&amp;#x02296;!&amp;opar;:&amp;#x029B7;!&amp;operp;:&amp;#x029B9;!&amp;oplus;:&amp;#x02295;!&amp;osol;:&amp;#x02298;!&amp;otimes;:&amp;#x02297;!&amp;Otimes;:&amp;#x02A37;!&amp;otimesas;:&amp;#x02A36;!&amp;ovbar;:&amp;#x0233D;!&amp;plusacir;:&amp;#x02A23;!&amp;plusb;:&amp;#x0229E;!&amp;pluscir;:&amp;#x02A22;!&amp;plusdo;:&amp;#x02214;!&amp;plusdu;:&amp;#x02A25;!&amp;pluse;:&amp;#x02A72;!&amp;plussim;:&amp;#x02A26;!&amp;plustwo;:&amp;#x02A27;!&amp;prod;:&amp;#x0220F;!&amp;race;:&amp;#x029DA;!&amp;roplus;:&amp;#x02A2E;!&amp;rotimes;:&amp;#x02A35;!&amp;rthree;:&amp;#x022CC;!&amp;rtimes;:&amp;#x022CA;!&amp;sdot;:&amp;#x022C5;!&amp;sdotb;:&amp;#x022A1;!&amp;setmn;:&amp;#x02216;!&amp;simplus;:&amp;#x02A24;!&amp;smashp;:&amp;#x02A33;!&amp;solb;:&amp;#x029C4;!&amp;sqcap;:&amp;#x02293;!&amp;sqcaps;:&amp;#x02293;&amp;#x0FE00;!&amp;sqcup;:&amp;#x02294;!&amp;sqcups;:&amp;#x02294;&amp;#x0FE00;!&amp;ssetmn;:&amp;#x02216;&amp;#x0FE00;!&amp;sstarf;:&amp;#x022C6;!&amp;subdot;:&amp;#x02ABD;!&amp;sum;:&amp;#x02211;!&amp;supdot;:&amp;#x02ABE;!&amp;timesb;:&amp;#x022A0;!&amp;timesbar;:&amp;#x02A31;!&amp;timesd;:&amp;#x02A30;!&amp;tridot;:&amp;#x025EC;!&amp;triminus;:&amp;#x02A3A;!&amp;triplus;:&amp;#x02A39;!&amp;trisb;:&amp;#x029CD;!&amp;tritime;:&amp;#x02A3B;!&amp;uplus;:&amp;#x0228E;!&amp;veebar;:&amp;#x022BB;!&amp;wedbar;:&amp;#x02A5F;!&amp;wreath;:&amp;#x02240;!&amp;xcap;:&amp;#x022C2;!&amp;xcirc;:&amp;#x025EF;!&amp;xcup;:&amp;#x022C3;!&amp;xdtri;:&amp;#x025BD;!&amp;xodot;:&amp;#x02299;!&amp;xoplus;:&amp;#x02295;!&amp;xotime;:&amp;#x02297;!&amp;xsqcup;:&amp;#x02294;!&amp;xuplus;:&amp;#x0228E;!&amp;xutri;:&amp;#x025B3;!&amp;xvee;:&amp;#x022C1;!&amp;xwedge;:&amp;#x022C0;!&amp;dlcorn;:&amp;#x0231E;!&amp;drcorn;:&amp;#x0231F;!&amp;gtlPar;:&amp;#x02995;!&amp;langd;:&amp;#x02991;!&amp;lbrke;:&amp;#x0298B;!&amp;lbrksld;:&amp;#x0298F;!&amp;lbrkslu;:&amp;#x0298D;!&amp;lceil;:&amp;#x02308;!&amp;lfloor;:&amp;#x0230A;!&amp;lmoust;:&amp;#x023B0;!&amp;lparlt;:&amp;#x02993;!&amp;ltrPar;:&amp;#x02996;!&amp;rangd;:&amp;#x02992;!&amp;rbrke;:&amp;#x0298C;!&amp;rbrksld;:&amp;#x0298E;!&amp;rbrkslu;:&amp;#x02990;!&amp;rceil;:&amp;#x02309;!&amp;rfloor;:&amp;#x0230B;!&amp;rmoust;:&amp;#x023B1;!&amp;rpargt;:&amp;#x02994;!&amp;ulcorn;:&amp;#x0231C;!&amp;urcorn;:&amp;#x0231D;!&amp;gnap;:&amp;#x02A8A;!&amp;gne;:&amp;#x02269;!&amp;gnE;:&amp;#x02269;!&amp;gnsim;:&amp;#x022E7;!&amp;gvnE;:&amp;#x02269;&amp;#x0FE00;!&amp;lnap;:&amp;#x02A89;!&amp;lne;:&amp;#x02268;!&amp;lnE;:&amp;#x02268;!&amp;lnsim;:&amp;#x022E6;!&amp;lvnE;:&amp;#x02268;&amp;#x0FE00;!&amp;nap;:&amp;#x02249;!&amp;napE;:&amp;#x02A70;&amp;#x00338;!&amp;napid;:&amp;#x0224B;&amp;#x00338;!&amp;ncong;:&amp;#x02247;!&amp;ncongdot;:&amp;#x02A6D;&amp;#x00338;!&amp;nequiv;:&amp;#x02262;!&amp;nge;:&amp;#x02271;&amp;#x020E5;!&amp;ngE;:&amp;#x02271;!&amp;nges;:&amp;#x02271;!&amp;nGg;:&amp;#x022D9;&amp;#x00338;!&amp;ngsim;:&amp;#x02275;!&amp;ngt;:&amp;#x0226F;!&amp;nGt;:&amp;#x0226B;&amp;#x00338;!&amp;nGtv;:&amp;#x0226B;&amp;#x00338;&amp;#x0FE00;!&amp;nle;:&amp;#x02270;&amp;#x020E5;!&amp;nlE;:&amp;#x02270;!&amp;nles;:&amp;#x02270;!&amp;nLl;:&amp;#x022D8;&amp;#x00338;!&amp;nlsim;:&amp;#x02274;!&amp;nlt;:&amp;#x0226E;!&amp;nLt;:&amp;#x0226A;&amp;#x00338;!&amp;nltri;:&amp;#x022EA;!&amp;nltrie;:&amp;#x022EC;!&amp;nLtv;:&amp;#x0226A;&amp;#x00338;&amp;#x0FE00;!&amp;nmid;:&amp;#x02224;!&amp;npar;:&amp;#x02226;!&amp;npr;:&amp;#x02280;!&amp;nprcue;:&amp;#x022E0;!&amp;npre;:&amp;#x02AAF;&amp;#x00338;!&amp;nrtri;:&amp;#x022EB;!&amp;nrtrie;:&amp;#x022ED;!&amp;nsc;:&amp;#x02281;!&amp;nsccue;:&amp;#x022E1;!&amp;nsce;:&amp;#x02AB0;&amp;#x00338;!&amp;nsim;:&amp;#x02241;!&amp;nsime;:&amp;#x02244;!&amp;nsmid;:&amp;#x02224;&amp;#x0FE00;!&amp;nspar;:&amp;#x02226;&amp;#x0FE00;!&amp;nsqsube;:&amp;#x022E2;!&amp;nsqsupe;:&amp;#x022E3;!&amp;nsub;:&amp;#x02284;!&amp;nsube;:&amp;#x02288;!&amp;nsubE;:&amp;#x02288;!&amp;nsup;:&amp;#x02285;!&amp;nsupe;:&amp;#x02289;!&amp;nsupE;:&amp;#x02289;!&amp;ntgl;:&amp;#x02279;!&amp;ntlg;:&amp;#x02278;!&amp;nvap;:&amp;#x02249;&amp;#x00338;!&amp;nvdash;:&amp;#x022AC;!&amp;nvDash;:&amp;#x022AD;!&amp;nVdash;:&amp;#x022AE;!&amp;nVDash;:&amp;#x022AF;!&amp;nvge;:&amp;#x02271;!&amp;nvgt;:&amp;#x0226F;!&amp;nvle;:&amp;#x02270;!&amp;nvlt;:&amp;#x0226E;!&amp;nvltrie;:&amp;#x022EC;&amp;#x00338;!&amp;nvrtrie;:&amp;#x022ED;&amp;#x00338;!&amp;nvsim;:&amp;#x02241;&amp;#x00338;!&amp;parsim;:&amp;#x02AF3;!&amp;prnap;:&amp;#x022E8;!&amp;prnE;:&amp;#x02AB5;!&amp;prnsim;:&amp;#x022E8;!&amp;rnmid;:&amp;#x02AEE;!&amp;scnap;:&amp;#x022E9;!&amp;scnE;:&amp;#x02AB6;!&amp;scnsim;:&amp;#x022E9;!&amp;simne;:&amp;#x02246;!&amp;solbar;:&amp;#x0233F;!&amp;subne;:&amp;#x0228A;!&amp;subnE;:&amp;#x0228A;!&amp;supne;:&amp;#x0228B;!&amp;supnE;:&amp;#x0228B;!&amp;vnsub;:&amp;#x02284;!&amp;vnsup;:&amp;#x02285;!&amp;vsubne;:&amp;#x0228A;&amp;#x0FE00;!&amp;vsubnE;:&amp;#x0228A;&amp;#x0FE00;!&amp;vsupne;:&amp;#x0228B;&amp;#x0FE00;!&amp;vsupnE;:&amp;#x0228B;&amp;#x0FE00;!&amp;ang;:&amp;#x02220;!&amp;ange;:&amp;#x029A4;!&amp;angmsd;:&amp;#x02221;!&amp;angmsdaa;:&amp;#x029A8;!&amp;angmsdab;:&amp;#x029A9;!&amp;angmsdac;:&amp;#x029AA;!&amp;angmsdad;:&amp;#x029AB;!&amp;angmsdae;:&amp;#x029AC;!&amp;angmsdaf;:&amp;#x029AD;!&amp;angmsdag;:&amp;#x029AE;!&amp;angmsdah;:&amp;#x029AF;!&amp;angrtvb;:&amp;#x0299D;&amp;#x0FE00;!&amp;angrtvbd;:&amp;#x0299D;!&amp;bbrk;:&amp;#x023B5;!&amp;bemptyv;:&amp;#x029B0;!&amp;beth;:&amp;#x02136;!&amp;boxbox;:&amp;#x029C9;!&amp;bprime;:&amp;#x02035;!&amp;bsemi;:&amp;#x0204F;!&amp;cemptyv;:&amp;#x029B2;!&amp;cirE;:&amp;#x029C3;!&amp;cirscir;:&amp;#x029C2;!&amp;comp;:&amp;#x02201;!&amp;daleth;:&amp;#x02138;!&amp;demptyv;:&amp;#x029B1;!&amp;ell;:&amp;#x02113;!&amp;empty;:&amp;#x02205;&amp;#x0FE00;!&amp;emptyv;:&amp;#x02205;!&amp;gimel;:&amp;#x02137;!&amp;iiota;:&amp;#x02129;!&amp;image;:&amp;#x02111;!&amp;imath;:&amp;#x00131;!&amp;jmath;:&amp;#x0006A;&amp;#x0FE00;!&amp;laemptyv;:&amp;#x029B4;!&amp;lltri;:&amp;#x025FA;!&amp;lrtri;:&amp;#x022BF;!&amp;mho;:&amp;#x02127;!&amp;nang;:&amp;#x02220;&amp;#x00338;!&amp;nexist;:&amp;#x02204;!&amp;oS;:&amp;#x024C8;!&amp;planck;:&amp;#x0210F;&amp;#x0FE00;!&amp;plankv;:&amp;#x0210F;!&amp;raemptyv;:&amp;#x029B3;!&amp;range;:&amp;#x029A5;!&amp;real;:&amp;#x0211C;!&amp;tbrk;:&amp;#x023B4;!&amp;ultri;:&amp;#x025F8;!&amp;urtri;:&amp;#x025F9;!&amp;vzigzag;:&amp;#x0299A;!&amp;weierp;:&amp;#x02118;!&amp;ape;:&amp;#x0224A;!&amp;apE;:&amp;#x0224A;!&amp;apid;:&amp;#x0224B;!&amp;asymp;:&amp;#x0224D;!&amp;Barv;:&amp;#x02AE7;!&amp;bcong;:&amp;#x0224C;!&amp;bepsi;:&amp;#x003F6;!&amp;bowtie;:&amp;#x022C8;!&amp;bsim;:&amp;#x0223D;!&amp;bsime;:&amp;#x022CD;!&amp;bsolhsub;:&amp;#x0005C;&amp;#x02282;!&amp;bump;:&amp;#x0224E;!&amp;bumpe;:&amp;#x0224F;!&amp;bumpE;:&amp;#x02AAE;!&amp;cire;:&amp;#x02257;!&amp;Colon;:&amp;#x02237;!&amp;colone;:&amp;#x02254;!&amp;Colone;:&amp;#x02A74;!&amp;congdot;:&amp;#x02A6D;!&amp;csub;:&amp;#x02ACF;!&amp;csube;:&amp;#x02AD1;!&amp;csup;:&amp;#x02AD0;!&amp;csupe;:&amp;#x02AD2;!&amp;cuepr;:&amp;#x022DE;!&amp;cuesc;:&amp;#x022DF;!&amp;dashv;:&amp;#x022A3;!&amp;Dashv;:&amp;#x02AE4;!&amp;easter;:&amp;#x0225B;!&amp;ecir;:&amp;#x02256;!&amp;ecolon;:&amp;#x02255;!&amp;eDDot;:&amp;#x02A77;!&amp;eDot;:&amp;#x02251;!&amp;efDot;:&amp;#x02252;!&amp;eg;:&amp;#x02A9A;!&amp;egs;:&amp;#x022DD;!&amp;egsdot;:&amp;#x02A98;!&amp;el;:&amp;#x02A99;!&amp;els;:&amp;#x022DC;!&amp;elsdot;:&amp;#x02A97;!&amp;equest;:&amp;#x0225F;!&amp;equivDD;:&amp;#x02A78;!&amp;erDot;:&amp;#x02253;!&amp;esdot;:&amp;#x02250;!&amp;esim;:&amp;#x02242;!&amp;Esim;:&amp;#x02A73;!&amp;fork;:&amp;#x022D4;!&amp;forkv;:&amp;#x02AD9;!&amp;frown;:&amp;#x02322;!&amp;gap;:&amp;#x02273;!&amp;gE;:&amp;#x02267;!&amp;gel;:&amp;#x022DB;!&amp;gEl;:&amp;#x022DB;!&amp;ges;:&amp;#x02A7E;!&amp;gescc;:&amp;#x02AA9;!&amp;gesdot;:&amp;#x02A80;!&amp;gesdoto;:&amp;#x02A82;!&amp;gesdotol;:&amp;#x02A84;!&amp;gesl;:&amp;#x022DB;&amp;#x0FE00;!&amp;gesles;:&amp;#x02A94;!&amp;Gg;:&amp;#x022D9;!&amp;gl;:&amp;#x02277;!&amp;gla;:&amp;#x02AA5;!&amp;glE;:&amp;#x02A92;!&amp;glj;:&amp;#x02AA4;!&amp;gsim;:&amp;#x02273;!&amp;gsime;:&amp;#x02A8E;!&amp;gsiml;:&amp;#x02A90;!&amp;Gt;:&amp;#x0226B;!&amp;gtcc;:&amp;#x02AA7;!&amp;gtcir;:&amp;#x02A7A;!&amp;gtdot;:&amp;#x022D7;!&amp;gtquest;:&amp;#x02A7C;!&amp;gtrarr;:&amp;#x02978;!&amp;homtht;:&amp;#x0223B;!&amp;lap;:&amp;#x02272;!&amp;lat;:&amp;#x02AAB;!&amp;late;:&amp;#x02AAD;!&amp;lates;:&amp;#x02AAD;&amp;#x0FE00;!&amp;lE;:&amp;#x02266;!&amp;leg;:&amp;#x022DA;!&amp;lEg;:&amp;#x022DA;!&amp;les;:&amp;#x02A7D;!&amp;lescc;:&amp;#x02AA8;!&amp;lesdot;:&amp;#x02A7F;!&amp;lesdoto;:&amp;#x02A81;!&amp;lesdotor;:&amp;#x02A83;!&amp;lesg;:&amp;#x022DA;&amp;#x0FE00;!&amp;lesges;:&amp;#x02A93;!&amp;lg;:&amp;#x02276;!&amp;lgE;:&amp;#x02A91;!&amp;Ll;:&amp;#x022D8;!&amp;lsim;:&amp;#x02272;!&amp;lsime;:&amp;#x02A8D;!&amp;lsimg;:&amp;#x02A8F;!&amp;Lt;:&amp;#x0226A;!&amp;ltcc;:&amp;#x02AA6;!&amp;ltcir;:&amp;#x02A79;!&amp;ltdot;:&amp;#x022D6;!&amp;ltlarr;:&amp;#x02976;!&amp;ltquest;:&amp;#x02A7B;!&amp;ltrie;:&amp;#x022B4;!&amp;mcomma;:&amp;#x02A29;!&amp;mDDot;:&amp;#x0223A;!&amp;mid;:&amp;#x02223;!&amp;mlcp;:&amp;#x02ADB;!&amp;models;:&amp;#x022A7;!&amp;mstpos;:&amp;#x0223E;!&amp;pr;:&amp;#x0227A;!&amp;Pr;:&amp;#x02ABB;!&amp;prap;:&amp;#x0227E;!&amp;prcue;:&amp;#x0227C;!&amp;pre;:&amp;#x02AAF;!&amp;prE;:&amp;#x02AAF;!&amp;prsim;:&amp;#x0227E;!&amp;prurel;:&amp;#x022B0;!&amp;ratio;:&amp;#x02236;!&amp;rtrie;:&amp;#x022B5;!&amp;rtriltri;:&amp;#x029CE;!&amp;sc;:&amp;#x0227B;!&amp;Sc;:&amp;#x02ABC;!&amp;scap;:&amp;#x0227F;!&amp;sccue;:&amp;#x0227D;!&amp;sce;:&amp;#x0227D;!&amp;scE;:&amp;#x0227E;!&amp;scsim;:&amp;#x0227F;!&amp;sdote;:&amp;#x02A66;!&amp;simg;:&amp;#x02A9E;!&amp;simgE;:&amp;#x02AA0;!&amp;siml;:&amp;#x02A9D;!&amp;simlE;:&amp;#x02A9F;!&amp;smid;:&amp;#x02223;&amp;#x0FE00;!&amp;smile;:&amp;#x02323;!&amp;smt;:&amp;#x02AAA;!&amp;smte;:&amp;#x02AAC;!&amp;smtes;:&amp;#x02AAC;&amp;#x0FE00;!&amp;spar;:&amp;#x02225;&amp;#x0FE00;!&amp;sqsub;:&amp;#x0228F;!&amp;sqsube;:&amp;#x02291;!&amp;sqsup;:&amp;#x02290;!&amp;sqsupe;:&amp;#x02292;!&amp;Sub;:&amp;#x022D0;!&amp;subE;:&amp;#x02286;!&amp;subedot;:&amp;#x02AC3;!&amp;submult;:&amp;#x02AC1;!&amp;subplus;:&amp;#x02ABF;!&amp;subrarr;:&amp;#x02979;!&amp;subsim;:&amp;#x02AC7;!&amp;subsub;:&amp;#x02AD5;!&amp;subsup;:&amp;#x02AD3;!&amp;Sup;:&amp;#x022D1;!&amp;supdsub;:&amp;#x02AD8;!&amp;supE;:&amp;#x02287;!&amp;supedot;:&amp;#x02AC4;!&amp;suphsol;:&amp;#x02283;&amp;#x0002F;!&amp;suphsub;:&amp;#x02AD7;!&amp;suplarr;:&amp;#x0297B;!&amp;supmult;:&amp;#x02AC2;!&amp;supplus;:&amp;#x02AC0;!&amp;supsim;:&amp;#x02AC8;!&amp;supsub;:&amp;#x02AD4;!&amp;supsup;:&amp;#x02AD6;!&amp;thkap;:&amp;#x02248;&amp;#x0FE00;!&amp;thksim;:&amp;#x0223C;&amp;#x0FE00;!&amp;topfork;:&amp;#x02ADA;!&amp;trie;:&amp;#x0225C;!&amp;twixt;:&amp;#x0226C;!&amp;vBar;:&amp;#x02AE8;!&amp;Vbar;:&amp;#x02AEB;!&amp;vBarv;:&amp;#x02AE9;!&amp;vdash;:&amp;#x022A2;!&amp;vDash;:&amp;#x022A8;!&amp;Vdash;:&amp;#x022A9;!&amp;VDash;:&amp;#x022AB;!&amp;Vdashl;:&amp;#x02AE6;!&amp;vltri;:&amp;#x022B2;!&amp;vprop;:&amp;#x0221D;!&amp;vrtri;:&amp;#x022B3;!&amp;Vvdash;:&amp;#x022AA;!&amp;boxdl;:&amp;#x02510;!&amp;boxdL;:&amp;#x02555;!&amp;boxDl;:&amp;#x02556;!&amp;boxDL;:&amp;#x02557;!&amp;boxdr;:&amp;#x0250C;!&amp;boxdR;:&amp;#x02552;!&amp;boxDr;:&amp;#x02553;!&amp;boxDR;:&amp;#x02554;!&amp;boxh;:&amp;#x02500;!&amp;boxH;:&amp;#x02550;!&amp;boxhd;:&amp;#x0252C;!&amp;boxhD;:&amp;#x02565;!&amp;boxHd;:&amp;#x02564;!&amp;boxHD;:&amp;#x02566;!&amp;boxhu;:&amp;#x02534;!&amp;boxhU;:&amp;#x02568;!&amp;boxHu;:&amp;#x02567;!&amp;boxHU;:&amp;#x02569;!&amp;boxul;:&amp;#x02518;!&amp;boxuL;:&amp;#x0255B;!&amp;boxUl;:&amp;#x0255C;!&amp;boxUL;:&amp;#x0255D;!&amp;boxur;:&amp;#x02514;!&amp;boxuR;:&amp;#x02558;!&amp;boxUr;:&amp;#x02559;!&amp;boxUR;:&amp;#x0255A;!&amp;boxv;:&amp;#x02502;!&amp;boxV;:&amp;#x02551;!&amp;boxvh;:&amp;#x0253C;!&amp;boxvH;:&amp;#x0256A;!&amp;boxVh;:&amp;#x0256B;!&amp;boxVH;:&amp;#x0256C;!&amp;boxvl;:&amp;#x02524;!&amp;boxvL;:&amp;#x02561;!&amp;boxVl;:&amp;#x02562;!&amp;boxVL;:&amp;#x02563;!&amp;boxvr;:&amp;#x0251C;!&amp;boxvR;:&amp;#x0255E;!&amp;boxVr;:&amp;#x0255F;!&amp;boxVR;:&amp;#x02560;!&amp;acy;:&amp;#x00430;!&amp;Acy;:&amp;#x00410;!&amp;bcy;:&amp;#x00431;!&amp;Bcy;:&amp;#x00411;!&amp;chcy;:&amp;#x00447;!&amp;CHcy;:&amp;#x00427;!&amp;dcy;:&amp;#x00434;!&amp;Dcy;:&amp;#x00414;!&amp;ecy;:&amp;#x0044D;!&amp;Ecy;:&amp;#x0042D;!&amp;fcy;:&amp;#x00444;!&amp;Fcy;:&amp;#x00424;!&amp;gcy;:&amp;#x00433;!&amp;Gcy;:&amp;#x00413;!&amp;hardcy;:&amp;#x0044A;!&amp;HARDcy;:&amp;#x0042A;!&amp;icy;:&amp;#x00438;!&amp;Icy;:&amp;#x00418;!&amp;iecy;:&amp;#x00435;!&amp;IEcy;:&amp;#x00415;!&amp;iocy;:&amp;#x00451;!&amp;IOcy;:&amp;#x00401;!&amp;jcy;:&amp;#x00439;!&amp;Jcy;:&amp;#x00419;!&amp;kcy;:&amp;#x0043A;!&amp;Kcy;:&amp;#x0041A;!&amp;khcy;:&amp;#x00445;!&amp;KHcy;:&amp;#x00425;!&amp;lcy;:&amp;#x0043B;!&amp;Lcy;:&amp;#x0041B;!&amp;mcy;:&amp;#x0043C;!&amp;Mcy;:&amp;#x0041C;!&amp;ncy;:&amp;#x0043D;!&amp;Ncy;:&amp;#x0041D;!&amp;numero;:&amp;#x02116;!&amp;ocy;:&amp;#x0043E;!&amp;Ocy;:&amp;#x0041E;!&amp;pcy;:&amp;#x0043F;!&amp;Pcy;:&amp;#x0041F;!&amp;rcy;:&amp;#x00440;!&amp;Rcy;:&amp;#x00420;!&amp;scy;:&amp;#x00441;!&amp;Scy;:&amp;#x00421;!&amp;shchcy;:&amp;#x00449;!&amp;SHCHcy;:&amp;#x00429;!&amp;shcy;:&amp;#x00448;!&amp;SHcy;:&amp;#x00428;!&amp;softcy;:&amp;#x0044C;!&amp;SOFTcy;:&amp;#x0042C;!&amp;tcy;:&amp;#x00442;!&amp;Tcy;:&amp;#x00422;!&amp;tscy;:&amp;#x00446;!&amp;TScy;:&amp;#x00426;!&amp;ucy;:&amp;#x00443;!&amp;Ucy;:&amp;#x00423;!&amp;vcy;:&amp;#x00432;!&amp;Vcy;:&amp;#x00412;!&amp;yacy;:&amp;#x0044F;!&amp;YAcy;:&amp;#x0042F;!&amp;ycy;:&amp;#x0044B;!&amp;Ycy;:&amp;#x0042B;!&amp;yucy;:&amp;#x0044E;!&amp;YUcy;:&amp;#x0042E;!&amp;zcy;:&amp;#x00437;!&amp;Zcy;:&amp;#x00417;!&amp;zhcy;:&amp;#x00436;!&amp;ZHcy;:&amp;#x00416;!&amp;djcy;:&amp;#x00452;!&amp;DJcy;:&amp;#x00402;!&amp;dscy;:&amp;#x00455;!&amp;DScy;:&amp;#x00405;!&amp;dzcy;:&amp;#x0045F;!&amp;DZcy;:&amp;#x0040F;!&amp;gjcy;:&amp;#x00453;!&amp;GJcy;:&amp;#x00403;!&amp;iukcy;:&amp;#x00456;!&amp;Iukcy;:&amp;#x00406;!&amp;jsercy;:&amp;#x00458;!&amp;Jsercy;:&amp;#x00408;!&amp;jukcy;:&amp;#x00454;!&amp;Jukcy;:&amp;#x00404;!&amp;kjcy;:&amp;#x0045C;!&amp;KJcy;:&amp;#x0040C;!&amp;ljcy;:&amp;#x00459;!&amp;LJcy;:&amp;#x00409;!&amp;njcy;:&amp;#x0045A;!&amp;NJcy;:&amp;#x0040A;!&amp;tshcy;:&amp;#x0045B;!&amp;TSHcy;:&amp;#x0040B;!&amp;ubrcy;:&amp;#x0045E;!&amp;Ubrcy;:&amp;#x0040E;!&amp;yicy;:&amp;#x00457;!&amp;YIcy;:&amp;#x00407;!&amp;acute;:&amp;#x000B4;!&amp;breve;:&amp;#x002D8;!&amp;caron;:&amp;#x002C7;!&amp;cedil;:&amp;#x000B8;!&amp;circ;:&amp;#x0005E;!&amp;dblac;:&amp;#x002DD;!&amp;die;:&amp;#x000A8;!&amp;dot;:&amp;#x002D9;!&amp;grave;:&amp;#x00060;!&amp;macr;:&amp;#x000AF;!&amp;ogon;:&amp;#x002DB;!&amp;ring;:&amp;#x002DA;!&amp;tilde;:&amp;#x002DC;!&amp;uml;:&amp;#x000A8;!&amp;alpha;:&amp;#x003B1;!&amp;beta;:&amp;#x003B2;!&amp;chi;:&amp;#x003C7;!&amp;delta;:&amp;#x003B4;!&amp;Delta;:&amp;#x00394;!&amp;epsi;:&amp;#x003B5;!&amp;epsiv;:&amp;#x0025B;!&amp;eta;:&amp;#x003B7;!&amp;gamma;:&amp;#x003B3;!&amp;Gamma;:&amp;#x00393;!&amp;gammad;:&amp;#x003DC;!&amp;Gammad;:&amp;#x003DC;!&amp;iota;:&amp;#x003B9;!&amp;kappa;:&amp;#x003BA;!&amp;kappav;:&amp;#x003F0;!&amp;lambda;:&amp;#x003BB;!&amp;Lambda;:&amp;#x0039B;!&amp;mu;:&amp;#x003BC;!&amp;nu;:&amp;#x003BD;!&amp;omega;:&amp;#x003C9;!&amp;Omega;:&amp;#x003A9;!&amp;phi;:&amp;#x003C6;!&amp;Phi;:&amp;#x003A6;!&amp;phiv;:&amp;#x003D5;!&amp;pi;:&amp;#x003C0;!&amp;Pi;:&amp;#x003A0;!&amp;piv;:&amp;#x003D6;!&amp;psi;:&amp;#x003C8;!&amp;Psi;:&amp;#x003A8;!&amp;rho;:&amp;#x003C1;!&amp;rhov;:&amp;#x003F1;!&amp;sigma;:&amp;#x003C3;!&amp;Sigma;:&amp;#x003A3;!&amp;sigmav;:&amp;#x003C2;!&amp;tau;:&amp;#x003C4;!&amp;theta;:&amp;#x003B8;!&amp;Theta;:&amp;#x00398;!&amp;thetav;:&amp;#x003D1;!&amp;upsi;:&amp;#x003C5;!&amp;Upsi;:&amp;#x003D2;!&amp;xi;:&amp;#x003BE;!&amp;Xi;:&amp;#x0039E;!&amp;zeta;:&amp;#x003B6;!&amp;aacute;:&amp;#x000E1;!&amp;Aacute;:&amp;#x000C1;!&amp;acirc;:&amp;#x000E2;!&amp;Acirc;:&amp;#x000C2;!&amp;aelig;:&amp;#x000E6;!&amp;AElig;:&amp;#x000C6;!&amp;agrave;:&amp;#x000E0;!&amp;Agrave;:&amp;#x000C0;!&amp;aring;:&amp;#x000E5;!&amp;Aring;:&amp;#x000C5;!&amp;atilde;:&amp;#x000E3;!&amp;Atilde;:&amp;#x000C3;!&amp;auml;:&amp;#x000E4;!&amp;Auml;:&amp;#x000C4;!&amp;ccedil;:&amp;#x000E7;!&amp;Ccedil;:&amp;#x000C7;!&amp;eacute;:&amp;#x000E9;!&amp;Eacute;:&amp;#x000C9;!&amp;ecirc;:&amp;#x000EA;!&amp;Ecirc;:&amp;#x000CA;!&amp;egrave;:&amp;#x000E8;!&amp;Egrave;:&amp;#x000C8;!&amp;eth;:&amp;#x000F0;!&amp;ETH;:&amp;#x000D0;!&amp;euml;:&amp;#x000EB;!&amp;Euml;:&amp;#x000CB;!&amp;iacute;:&amp;#x000ED;!&amp;Iacute;:&amp;#x000CD;!&amp;icirc;:&amp;#x000EE;!&amp;Icirc;:&amp;#x000CE;!&amp;igrave;:&amp;#x000EC;!&amp;Igrave;:&amp;#x000CC;!&amp;iuml;:&amp;#x000EF;!&amp;Iuml;:&amp;#x000CF;!&amp;ntilde;:&amp;#x000F1;!&amp;Ntilde;:&amp;#x000D1;!&amp;oacute;:&amp;#x000F3;!&amp;Oacute;:&amp;#x000D3;!&amp;ocirc;:&amp;#x000F4;!&amp;Ocirc;:&amp;#x000D4;!&amp;ograve;:&amp;#x000F2;!&amp;Ograve;:&amp;#x000D2;!&amp;oslash;:&amp;#x000F8;!&amp;Oslash;:&amp;#x000D8;!&amp;otilde;:&amp;#x000F5;!&amp;Otilde;:&amp;#x000D5;!&amp;ouml;:&amp;#x000F6;!&amp;Ouml;:&amp;#x000D6;!&amp;szlig;:&amp;#x000DF;!&amp;thorn;:&amp;#x000FE;!&amp;THORN;:&amp;#x000DE;!&amp;uacute;:&amp;#x000FA;!&amp;Uacute;:&amp;#x000DA;!&amp;ucirc;:&amp;#x000FB;!&amp;Ucirc;:&amp;#x000DB;!&amp;ugrave;:&amp;#x000F9;!&amp;Ugrave;:&amp;#x000D9;!&amp;uuml;:&amp;#x000FC;!&amp;Uuml;:&amp;#x000DC;!&amp;yacute;:&amp;#x000FD;!&amp;Yacute;:&amp;#x000DD;!&amp;yuml;:&amp;#x000FF;!&amp;abreve;:&amp;#x00103;!&amp;Abreve;:&amp;#x00102;!&amp;amacr;:&amp;#x00101;!&amp;Amacr;:&amp;#x00100;!&amp;aogon;:&amp;#x00105;!&amp;Aogon;:&amp;#x00104;!&amp;cacute;:&amp;#x00107;!&amp;Cacute;:&amp;#x00106;!&amp;ccaron;:&amp;#x0010D;!&amp;Ccaron;:&amp;#x0010C;!&amp;ccirc;:&amp;#x00109;!&amp;Ccirc;:&amp;#x00108;!&amp;cdot;:&amp;#x0010B;!&amp;Cdot;:&amp;#x0010A;!&amp;dcaron;:&amp;#x0010F;!&amp;Dcaron;:&amp;#x0010E;!&amp;dstrok;:&amp;#x00111;!&amp;Dstrok;:&amp;#x00110;!&amp;ecaron;:&amp;#x0011B;!&amp;Ecaron;:&amp;#x0011A;!&amp;edot;:&amp;#x00117;!&amp;Edot;:&amp;#x00116;!&amp;emacr;:&amp;#x00113;!&amp;Emacr;:&amp;#x00112;!&amp;eng;:&amp;#x0014B;!&amp;ENG;:&amp;#x0014A;!&amp;eogon;:&amp;#x00119;!&amp;Eogon;:&amp;#x00118;!&amp;gacute;:&amp;#x001F5;!&amp;gbreve;:&amp;#x0011F;!&amp;Gbreve;:&amp;#x0011E;!&amp;Gcedil;:&amp;#x00122;!&amp;gcirc;:&amp;#x0011D;!&amp;Gcirc;:&amp;#x0011C;!&amp;gdot;:&amp;#x00121;!&amp;Gdot;:&amp;#x00120;!&amp;hcirc;:&amp;#x00125;!&amp;Hcirc;:&amp;#x00124;!&amp;hstrok;:&amp;#x00127;!&amp;Hstrok;:&amp;#x00126;!&amp;Idot;:&amp;#x00130;!&amp;ijlig;:&amp;#x00133;!&amp;IJlig;:&amp;#x00132;!&amp;imacr;:&amp;#x0012B;!&amp;Imacr;:&amp;#x0012A;!&amp;inodot;:&amp;#x00131;!&amp;iogon;:&amp;#x0012F;!&amp;Iogon;:&amp;#x0012E;!&amp;itilde;:&amp;#x00129;!&amp;Itilde;:&amp;#x00128;!&amp;jcirc;:&amp;#x00135;!&amp;Jcirc;:&amp;#x00134;!&amp;kcedil;:&amp;#x00137;!&amp;Kcedil;:&amp;#x00136;!&amp;kgreen;:&amp;#x00138;!&amp;lacute;:&amp;#x0013A;!&amp;Lacute;:&amp;#x00139;!&amp;lcaron;:&amp;#x0013E;!&amp;Lcaron;:&amp;#x0013D;!&amp;lcedil;:&amp;#x0013C;!&amp;Lcedil;:&amp;#x0013B;!&amp;lmidot;:&amp;#x00140;!&amp;Lmidot;:&amp;#x0013F;!&amp;lstrok;:&amp;#x00142;!&amp;Lstrok;:&amp;#x00141;!&amp;nacute;:&amp;#x00144;!&amp;Nacute;:&amp;#x00143;!&amp;napos;:&amp;#x00149;!&amp;ncaron;:&amp;#x00148;!&amp;Ncaron;:&amp;#x00147;!&amp;ncedil;:&amp;#x00146;!&amp;Ncedil;:&amp;#x00145;!&amp;odblac;:&amp;#x00151;!&amp;Odblac;:&amp;#x00150;!&amp;oelig;:&amp;#x00153;!&amp;OElig;:&amp;#x00152;!&amp;omacr;:&amp;#x0014D;!&amp;Omacr;:&amp;#x0014C;!&amp;racute;:&amp;#x00155;!&amp;Racute;:&amp;#x00154;!&amp;rcaron;:&amp;#x00159;!&amp;Rcaron;:&amp;#x00158;!&amp;rcedil;:&amp;#x00157;!&amp;Rcedil;:&amp;#x00156;!&amp;sacute;:&amp;#x0015B;!&amp;Sacute;:&amp;#x0015A;!&amp;scaron;:&amp;#x00161;!&amp;Scaron;:&amp;#x00160;!&amp;scedil;:&amp;#x0015F;!&amp;Scedil;:&amp;#x0015E;!&amp;scirc;:&amp;#x0015D;!&amp;Scirc;:&amp;#x0015C;!&amp;tcaron;:&amp;#x00165;!&amp;Tcaron;:&amp;#x00164;!&amp;tcedil;:&amp;#x00163;!&amp;Tcedil;:&amp;#x00162;!&amp;tstrok;:&amp;#x00167;!&amp;Tstrok;:&amp;#x00166;!&amp;ubreve;:&amp;#x0016D;!&amp;Ubreve;:&amp;#x0016C;!&amp;udblac;:&amp;#x00171;!&amp;Udblac;:&amp;#x00170;!&amp;umacr;:&amp;#x0016B;!&amp;Umacr;:&amp;#x0016A;!&amp;uogon;:&amp;#x00173;!&amp;Uogon;:&amp;#x00172;!&amp;uring;:&amp;#x0016F;!&amp;Uring;:&amp;#x0016E;!&amp;utilde;:&amp;#x00169;!&amp;Utilde;:&amp;#x00168;!&amp;wcirc;:&amp;#x00175;!&amp;Wcirc;:&amp;#x00174;!&amp;ycirc;:&amp;#x00177;!&amp;Ycirc;:&amp;#x00176;!&amp;Yuml;:&amp;#x00178;!&amp;zacute;:&amp;#x0017A;!&amp;Zacute;:&amp;#x00179;!&amp;zcaron;:&amp;#x0017E;!&amp;Zcaron;:&amp;#x0017D;!&amp;zdot;:&amp;#x0017C;!&amp;Zdot;:&amp;#x0017B;!&amp;afr;:&amp;#x1D51E;!&amp;Afr;:&amp;#x1D504;!&amp;bfr;:&amp;#x1D51F;!&amp;Bfr;:&amp;#x1D505;!&amp;cfr;:&amp;#x1D520;!&amp;Cfr;:&amp;#x0212D;!&amp;dfr;:&amp;#x1D521;!&amp;Dfr;:&amp;#x1D507;!&amp;efr;:&amp;#x1D522;!&amp;Efr;:&amp;#x1D508;!&amp;ffr;:&amp;#x1D523;!&amp;Ffr;:&amp;#x1D509;!&amp;gfr;:&amp;#x1D524;!&amp;Gfr;:&amp;#x1D50A;!&amp;hfr;:&amp;#x1D525;!&amp;Hfr;:&amp;#x0210C;!&amp;ifr;:&amp;#x1D526;!&amp;Ifr;:&amp;#x02111;!&amp;jfr;:&amp;#x1D527;!&amp;Jfr;:&amp;#x1D50D;!&amp;kfr;:&amp;#x1D528;!&amp;Kfr;:&amp;#x1D50E;!&amp;lfr;:&amp;#x1D529;!&amp;Lfr;:&amp;#x1D50F;!&amp;mfr;:&amp;#x1D52A;!&amp;Mfr;:&amp;#x1D510;!&amp;nfr;:&amp;#x1D52B;!&amp;Nfr;:&amp;#x1D511;!&amp;ofr;:&amp;#x1D52C;!&amp;Ofr;:&amp;#x1D512;!&amp;pfr;:&amp;#x1D52D;!&amp;Pfr;:&amp;#x1D513;!&amp;qfr;:&amp;#x1D52E;!&amp;Qfr;:&amp;#x1D514;!&amp;rfr;:&amp;#x1D52F;!&amp;Rfr;:&amp;#x0211C;!&amp;sfr;:&amp;#x1D530;!&amp;Sfr;:&amp;#x1D516;!&amp;tfr;:&amp;#x1D531;!&amp;Tfr;:&amp;#x1D517;!&amp;ufr;:&amp;#x1D532;!&amp;Ufr;:&amp;#x1D518;!&amp;vfr;:&amp;#x1D533;!&amp;Vfr;:&amp;#x1D519;!&amp;wfr;:&amp;#x1D534;!&amp;Wfr;:&amp;#x1D51A;!&amp;xfr;:&amp;#x1D535;!&amp;Xfr;:&amp;#x1D51B;!&amp;yfr;:&amp;#x1D536;!&amp;Yfr;:&amp;#x1D51C;!&amp;zfr;:&amp;#x1D537;!&amp;Zfr;:&amp;#x02128;!&amp;Aopf;:&amp;#x1D538;!&amp;Bopf;:&amp;#x1D539;!&amp;Copf;:&amp;#x02102;!&amp;Dopf;:&amp;#x1D53B;!&amp;Eopf;:&amp;#x1D53C;!&amp;Fopf;:&amp;#x1D53D;!&amp;Gopf;:&amp;#x1D53E;!&amp;Hopf;:&amp;#x0210D;!&amp;Iopf;:&amp;#x1D540;!&amp;Jopf;:&amp;#x1D541;!&amp;Kopf;:&amp;#x1D542;!&amp;Lopf;:&amp;#x1D543;!&amp;Mopf;:&amp;#x1D544;!&amp;Nopf;:&amp;#x02115;!&amp;Oopf;:&amp;#x1D546;!&amp;Popf;:&amp;#x02119;!&amp;Qopf;:&amp;#x0211A;!&amp;Ropf;:&amp;#x0211D;!&amp;Sopf;:&amp;#x1D54A;!&amp;Topf;:&amp;#x1D54B;!&amp;Uopf;:&amp;#x1D54C;!&amp;Vopf;:&amp;#x1D54D;!&amp;Wopf;:&amp;#x1D54E;!&amp;Xopf;:&amp;#x1D54F;!&amp;Yopf;:&amp;#x1D550;!&amp;Zopf;:&amp;#x02124;!&amp;ascr;:&amp;#x1D4B6;!&amp;Ascr;:&amp;#x1D49C;!&amp;bscr;:&amp;#x1D4B7;!&amp;Bscr;:&amp;#x0212C;!&amp;cscr;:&amp;#x1D4B8;!&amp;Cscr;:&amp;#x1D49E;!&amp;dscr;:&amp;#x1D4B9;!&amp;Dscr;:&amp;#x1D49F;!&amp;escr;:&amp;#x0212F;!&amp;Escr;:&amp;#x02130;!&amp;fscr;:&amp;#x1D4BB;!&amp;Fscr;:&amp;#x02131;!&amp;gscr;:&amp;#x0210A;!&amp;Gscr;:&amp;#x1D4A2;!&amp;hscr;:&amp;#x1D4BD;!&amp;Hscr;:&amp;#x0210B;!&amp;iscr;:&amp;#x1D4BE;!&amp;Iscr;:&amp;#x02110;!&amp;jscr;:&amp;#x1D4BF;!&amp;Jscr;:&amp;#x1D4A5;!&amp;kscr;:&amp;#x1D4C0;!&amp;Kscr;:&amp;#x1D4A6;!&amp;lscr;:&amp;#x02113;!&amp;Lscr;:&amp;#x02112;!&amp;mscr;:&amp;#x1D4C2;!&amp;Mscr;:&amp;#x02133;!&amp;nscr;:&amp;#x1D4C3;!&amp;Nscr;:&amp;#x1D4A9;!&amp;oscr;:&amp;#x02134;!&amp;Oscr;:&amp;#x1D4AA;!&amp;pscr;:&amp;#x1D4C5;!&amp;Pscr;:&amp;#x1D4AB;!&amp;qscr;:&amp;#x1D4C6;!&amp;Qscr;:&amp;#x1D4AC;!&amp;rscr;:&amp;#x1D4C7;!&amp;Rscr;:&amp;#x0211B;!&amp;sscr;:&amp;#x1D4C8;!&amp;Sscr;:&amp;#x1D4AE;!&amp;tscr;:&amp;#x1D4C9;!&amp;Tscr;:&amp;#x1D4AF;!&amp;uscr;:&amp;#x1D4CA;!&amp;Uscr;:&amp;#x1D4B0;!&amp;vscr;:&amp;#x1D4CB;!&amp;Vscr;:&amp;#x1D4B1;!&amp;wscr;:&amp;#x1D4CC;!&amp;Wscr;:&amp;#x1D4B2;!&amp;xscr;:&amp;#x1D4CD;!&amp;Xscr;:&amp;#x1D4B3;!&amp;yscr;:&amp;#x1D4CE;!&amp;Yscr;:&amp;#x1D4B4;!&amp;zscr;:&amp;#x1D4CF;!&amp;Zscr;:&amp;#x1D4B5;!&amp;apos;:&amp;#x00027;!&amp;ast;:&amp;#x0002A;!&amp;brvbar;:&amp;#x000A6;!&amp;bsol;:&amp;#x0005C;!&amp;cent;:&amp;#x000A2;!&amp;colon;:&amp;#x0003A;!&amp;comma;:&amp;#x0002C;!&amp;commat;:&amp;#x00040;!&amp;copy;:&amp;#x000A9;!&amp;curren;:&amp;#x000A4;!&amp;darr;:&amp;#x02193;!&amp;deg;:&amp;#x000B0;!&amp;divide;:&amp;#x000F7;!&amp;dollar;:&amp;#x00024;!&amp;equals;:&amp;#x0003D;!&amp;excl;:&amp;#x00021;!&amp;frac12;:&amp;#x000BD;!&amp;frac14;:&amp;#x000BC;!&amp;frac18;:&amp;#x0215B;!&amp;frac34;:&amp;#x000BE;!&amp;frac38;:&amp;#x0215C;!&amp;frac58;:&amp;#x0215D;!&amp;frac78;:&amp;#x0215E;!&amp;gt;:&amp;#x0003E;!&amp;half;:&amp;#x000BD;!&amp;horbar;:&amp;#x02015;!&amp;hyphen;:&amp;#x02010;!&amp;iexcl;:&amp;#x000A1;!&amp;iquest;:&amp;#x000BF;!&amp;laquo;:&amp;#x000AB;!&amp;larr;:&amp;#x02190;!&amp;lcub;:&amp;#x0007B;!&amp;ldquo;:&amp;#x0201C;!&amp;lowbar;:&amp;#x0005F;!&amp;lpar;:&amp;#x00028;!&amp;lsqb;:&amp;#x0005B;!&amp;lsquo;:&amp;#x02018;!&amp;micro;:&amp;#x000B5;!&amp;middot;:&amp;#x000B7;!&amp;nbsp;:&amp;#x000A0;!&amp;not;:&amp;#x000AC;!&amp;num;:&amp;#x00023;!&amp;ohm;:&amp;#x02126;!&amp;ordf;:&amp;#x000AA;!&amp;ordm;:&amp;#x000BA;!&amp;para;:&amp;#x000B6;!&amp;percnt;:&amp;#x00025;!&amp;period;:&amp;#x0002E;!&amp;plus;:&amp;#x0002B;!&amp;plusmn;:&amp;#x000B1;!&amp;pound;:&amp;#x000A3;!&amp;quest;:&amp;#x0003F;!&amp;quot;:&amp;#x00022;!&amp;raquo;:&amp;#x000BB;!&amp;rarr;:&amp;#x02192;!&amp;rcub;:&amp;#x0007D;!&amp;rdquo;:&amp;#x0201D;!&amp;reg;:&amp;#x000AE;!&amp;rpar;:&amp;#x00029;!&amp;rsqb;:&amp;#x0005D;!&amp;rsquo;:&amp;#x02019;!&amp;sect;:&amp;#x000A7;!&amp;semi;:&amp;#x0003B;!&amp;shy;:&amp;#x000AD;!&amp;sol;:&amp;#x0002F;!&amp;sung;:&amp;#x0266A;!&amp;sup1;:&amp;#x000B9;!&amp;sup2;:&amp;#x000B2;!&amp;sup3;:&amp;#x000B3;!&amp;times;:&amp;#x000D7;!&amp;trade;:&amp;#x02122;!&amp;uarr;:&amp;#x02191;!&amp;verbar;:&amp;#x0007C;!&amp;yen;:&amp;#x000A5;!&amp;blank;:&amp;#x02423;!&amp;blk12;:&amp;#x02592;!&amp;blk14;:&amp;#x02591;!&amp;blk34;:&amp;#x02593;!&amp;block;:&amp;#x02588;!&amp;bull;:&amp;#x02022;!&amp;caret;:&amp;#x02041;!&amp;check;:&amp;#x02713;!&amp;cir;:&amp;#x025CB;!&amp;clubs;:&amp;#x02663;!&amp;copysr;:&amp;#x02117;!&amp;cross;:&amp;#x02717;!&amp;dagger;:&amp;#x02020;!&amp;Dagger;:&amp;#x02021;!&amp;dash;:&amp;#x02010;!&amp;diams;:&amp;#x02666;!&amp;dlcrop;:&amp;#x0230D;!&amp;drcrop;:&amp;#x0230C;!&amp;dtri;:&amp;#x025BF;!&amp;dtrif;:&amp;#x025BE;!&amp;emsp;:&amp;#x02003;!&amp;emsp13;:&amp;#x02004;!&amp;emsp14;:&amp;#x02005;!&amp;ensp;:&amp;#x02002;!&amp;female;:&amp;#x02640;!&amp;ffilig;:&amp;#x0FB03;!&amp;fflig;:&amp;#x0FB00;!&amp;ffllig;:&amp;#x0FB04;!&amp;filig;:&amp;#x0FB01;!&amp;flat;:&amp;#x0266D;!&amp;fllig;:&amp;#x0FB02;!&amp;frac13;:&amp;#x02153;!&amp;frac15;:&amp;#x02155;!&amp;frac16;:&amp;#x02159;!&amp;frac23;:&amp;#x02154;!&amp;frac25;:&amp;#x02156;!&amp;frac35;:&amp;#x02157;!&amp;frac45;:&amp;#x02158;!&amp;frac56;:&amp;#x0215A;!&amp;hairsp;:&amp;#x0200A;!&amp;hellip;:&amp;#x02026;!&amp;hybull;:&amp;#x02043;!&amp;incare;:&amp;#x02105;!&amp;ldquor;:&amp;#x0201E;!&amp;lhblk;:&amp;#x02584;!&amp;loz;:&amp;#x025CA;!&amp;lozf;:&amp;#x029EB;!&amp;lsquor;:&amp;#x0201A;!&amp;ltri;:&amp;#x025C3;!&amp;ltrif;:&amp;#x025C2;!&amp;male;:&amp;#x02642;!&amp;malt;:&amp;#x02720;!&amp;marker;:&amp;#x025AE;!&amp;mdash;:&amp;#x02014;!&amp;mldr;:&amp;#x02026;!&amp;natur;:&amp;#x0266E;!&amp;ndash;:&amp;#x02013;!&amp;nldr;:&amp;#x02025;!&amp;numsp;:&amp;#x02007;!&amp;phone;:&amp;#x0260E;!&amp;puncsp;:&amp;#x02008;!&amp;rdquor;:&amp;#x0201D;!&amp;rect;:&amp;#x025AD;!&amp;rsquor;:&amp;#x02019;!&amp;rtri;:&amp;#x025B9;!&amp;rtrif;:&amp;#x025B8;!&amp;rx;:&amp;#x0211E;!&amp;sext;:&amp;#x02736;!&amp;sharp;:&amp;#x0266F;!&amp;spades;:&amp;#x02660;!&amp;squ;:&amp;#x025A1;!&amp;squf;:&amp;#x025AA;!&amp;star;:&amp;#x022C6;!&amp;starf;:&amp;#x02605;!&amp;target;:&amp;#x02316;!&amp;telrec;:&amp;#x02315;!&amp;thinsp;:&amp;#x02009;!&amp;uhblk;:&amp;#x02580;!&amp;ulcrop;:&amp;#x0230F;!&amp;urcrop;:&amp;#x0230E;!&amp;utri;:&amp;#x025B5;!&amp;utrif;:&amp;#x025B4;!&amp;vellip;:&amp;#x022EE;!&amp;amp;:&amp;#x00026;!&amp;lt;:&amp;#x0003C;!";
	
	return strContent;
}
</xsl:text>

<!-- 替换xml内的实体名为实体值 -->
<xsl:text doc:id="replaceentvalue">
function replaceentvalue( strXmlContent ) 
{
	var strRes = strXmlContent;	
	var arrayEnt = getentname( strRes );
	var strEntContent = getentdef();		
	for( i = 0; i &lt; arrayEnt.length; i++ )
	{
		var nPos, nStart = 0;
		nPos = strEntContent.indexOf( arrayEnt[i], nStart );
		if( nPos &gt;= 0 )
		{
			nStart = nPos + arrayEnt[i].length + 1;
			nPos = strEntContent.indexOf( "!", nStart );
			if( nPos &gt;= 0 )
			{
				var strEntValue = strEntContent.substring( nStart, nPos );
				strRes = strRes.replace( arrayEnt[i], strEntValue );
			}
		}			
	}
	
	strRes = strRes.replace( "&lt;math&gt;", "&lt;math xmlns=\"http://www.w3.org/1998/Math/MathML\"&gt;" );
	var strMathMLHead = "&lt;?xml version=\"1.0\" encoding=\"UTF-8\" ?&gt;"; 
	strRes = strMathMLHead + strRes;

	return strRes;
}
</xsl:text>

<!-- 生成数学复杂单元样式 -->
<!--xsl:text doc:id="makemathmlxsl"-->
function makemathmlxsl( strXmlContent ) 
{
	var xmlDoc = new ActiveXObject("Microsoft.FreeThreadedXMLDOM");
	xmlDoc.async = false;
	xmlDoc.validateOnParse = false;
	xmlDoc.loadXML( strXmlContent );
	var xslDoc = new ActiveXObject("Microsoft.FreeThreadedXMLDOM");
	var xslTemplate = new ActiveXObject("MSXML2.XSLTemplate.3.0");
	xslDoc.async = false;
	xslDoc.validateOnParse = false;

	var strContent = strGlobalHref;
	var strXslPath = "MathML_IE.xsl";
	var nPos = strContent.indexOf( "href" );
	if( nPos &gt;= 0 )
	{
		nPos = strContent.indexOf( "\"", nPos );
		if( nPos &gt;= 0 )
		{
			var nStart = nPos + 1;
			nPos = strContent.indexOf( "\"", nStart );
			if( nPos &gt;= 0 )
			{
				var strHref = strContent.substring( nStart, nPos );
				strHref = strHref.replace( "\\", "/" );
				nPos = strHref.lastIndexOf( "/" );
				if( nPos &gt;= 0 )
				{
					strHref = strHref.substring( 0, nPos+1 );
					strHref += "MathML_IE.xsl";
					strXslPath = strHref;
				}
			}
		}
	}
			
	xslDoc.load( strXslPath );
	xslTemplate.stylesheet = xslDoc;
	xslProcessor = xslTemplate.createProcessor( );
	xslProcessor.input = xmlDoc;
	xslProcessor.transform( );
	var strHtml = xslProcessor.output;
		
	var nPos = strHtml.indexOf( "&lt;/head&gt;" );
	if( nPos &gt;= 0 )
	{
		strHtml = strHtml.substring( nPos + 7, strHtml.length );
		nPos = strHtml.indexOf( "&lt;/body&gt;" );
		if( nPos &gt;= 0 )
		{
			strHtml = strHtml.substring( 0, nPos );
		}
	}

	return strHtml;
}
<!--/xsl:text-->

				</script>
				<style xmlns:m="http://www.w3.org/1998/Math/MathML">
<xsl:text doc:id="css">

.msubsup {
font-size: 80%;
position: absolute;
}

.munderover {
display: inline;
vertical-align: middle;
}
	
.lr {
display: inline;
vertical-align: middle;
}

.mi {
font-style: serif;
}


.mspace{
display: inline;
}
.mtext {
font-style: serif;
}
.ms {
font-style: monospace;
}

.mi1 {
font-style: italic;
}

.doublestruck {
font-family:  castellar, algerian,niagara engraved;
}
.mo {
padding-right: .3em;
padding-left: .3em;
}

.mn {
}

.msqrt {
border-style: solid;
border-color: black;
border-width: .1em 0pt 0pt .1em;
padding-left: .2em;
margin-left: 0em;
margin-top: .2em;
display: inline;
}

.actuarial {
border-style: solid;
border-color: black;
border-width: .1em .1em 0pt 0pt ;
padding-right: .2em;
margin-right: 0em;
margin-top: .2em;
display: inline;
}

.ssa {
 position:relative; top:+0.5ex;  
width: 0pt;
color: red;
}


.mover {
margin: 0pt;
padding: 0pt;
display: inline;
vertical-align: middle;
text-align: center;
}

.mtable {
display: inline;
vertical-align: middle;
}


.mfrac {
text-align: center;
display:inline;
vertical-align: middle;
}

.mfraca {
vertical-align: bottom;
}

.mfracaa {
border-width: 0em 0em .2ex 0em ; border-style: solid;
   border-color: black;
}


.mfracb {
vertical-align: top;
}

.merror{
background-color: white  ;
border-style: solid;
border-color: #FF0000;
color: #FF0000;
}
.mphantom{
visibility: hidden;
}
</xsl:text>
				</style>
		</head>
			<xsl:apply-templates select="processing-instruction('xml-stylesheet')"/>		
			<xsl:apply-templates select="cn-patent-document"/>
		</html>
	</xsl:template>
	<xsl:template match="cn-patent-document">
		
		<body width="800" font-size="5">
			<style>
				td.crowded{line-height:18pt;}
			</style>
			<p>
				<xsl:apply-templates select="cn-bibliographic-data"/>
				<xsl:apply-templates select="application-body"/>
			</p>
		</body>
	</xsl:template>
	<xsl:template match="cn-bibliographic-data">
		<table border="1" width="800">
			<!--公开公告信息-->
			<tr>
				<td>
					公开（公告）号：<br/>
					&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="cn-publication-reference/document-id/country"/>
					<xsl:apply-templates select="cn-publication-reference/document-id/doc-number"/>
					<xsl:apply-templates select="cn-publication-reference/document-id/kind"/>
				</td>
			</tr>
			<!--公开（公告）日-->
			<tr>
				<td>
					公开（公告）日：<br/>
					&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="cn-publication-reference/document-id/date"/>
				</td>
			</tr>
			<!--申请信息-->
			<!--申请（专利）号-->
			<tr>
				<td>
					申请（专利）号：<br/>
					&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="application-reference/document-id/country"/>
					<xsl:apply-templates select="application-reference/document-id/doc-number"/>
				</td>
			</tr>
			<!--申请日-->
			<tr>
				<td>
					申请日：<br/>
					&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="application-reference/document-id/date"/>
				</td>
			</tr>
			<!--国际优先权-->
			<xsl:if test="priority-claims/priority-claim!=''">
				<tr>
					<td>
						优先权：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:for-each select="priority-claims/priority-claim">
							[32]<xsl:apply-templates select="date"/>&#160;&#160;[33]<xsl:apply-templates select="country"/>&#160;&#160;[31]<xsl:apply-templates select="doc-number"/>
							<br/>
						</xsl:for-each>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:for-each select="//cn-domestic-priority-claim">
							[32]<xsl:apply-templates select="substitution/relation/parent-doc/document-id/date"/>&#160;&#160;[33]	<xsl:apply-templates select="substitution/relation/parent-doc/document-id//country"/>&#160;&#160;[31]<xsl:apply-templates select="substitution/relation/parent-doc/document-id//doc-number"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
			<!--分类号-->
			<tr>
				<td>
					<!--第七版以前的分类号-->
					分类号：<br/>
					<xsl:if test="classification-ipc!=''">
						&#160;&#160;&#160;&#160;&#160;&#160;Int.Cl.<sup>
							<xsl:apply-templates select="classification-ipc/ipc-version"/>
						</sup>
						<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="classification-ipc/main-classification"/>
						<br/>
						<xsl:for-each select="classification-ipc/further-classification">
							&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="."/>
							<br/>
						</xsl:for-each>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="classification-ipc/text"/>
					</xsl:if>
					<!--第八版分类号-->
					<xsl:if test="classifications-ipcr!=''">
						<xsl:for-each select="classifications-ipcr/classification-ipcr">
							&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="text"/>
							<br/>
						</xsl:for-each>
					</xsl:if>
				</td>
			</tr>
			<!--分案申请-->
			<xsl:if test="cn-related-documents/division!=''">
				<tr>
					<td>
						分案原申请号：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="cn-related-documents/division//country"/>
						<xsl:apply-templates select="cn-related-documents/division//doc-number"/>
					</td>
				</tr>
			</xsl:if>
			<!--申请人-->
			<xsl:if test="cn-parties/cn-applicants/cn-applicant[@sequence='1']">
				<tr>
					<td>
						申请人：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="cn-parties/cn-applicants/cn-applicant/addressbook/name"/>
					</td>
				</tr>
				<tr>
					<td>
						地址：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="cn-parties/cn-applicants/cn-applicant/addressbook/address/text"/>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="cn-parties/cn-applicants/cn-applicant[@sequence>'1']">
				<tr>
					<td>
						共同申请人：<br/>
						<xsl:for-each select="cn-parties/cn-applicants/cn-applicant[@sequence>'1']">
							&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="addressbook/name"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="assignees/assignee!=''">
				<xsl:for-each select="assignees/assignee[position() = 1]">
					<xsl:if test="addressbook/address/text!=''">
						<tr>
							<td>
								专利权人：<br/>
								&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="addressbook/name"/>
							</td>
						</tr>
						<tr>
							<td>
								地址：<br/>
								&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="addressbook/address/text"/>
							</td>
						</tr>
					</xsl:if>
				</xsl:for-each>
				<xsl:if test="assignees/assignee[position() != 1]">
					<!--如何嫛数-->
					<tr>
						<td>
							共同专利权人：<br/>
							<xsl:for-each select="assignees/assignee[position() != 1]">
								&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="addressbook/name"/>
								<br/>
							</xsl:for-each>
						</td>
					</tr>
				</xsl:if>
			</xsl:if>
			<!--发明（设计）人-->
			<xsl:if test="cn-parties/cn-inventors/cn-inventor/name!=''">
				<tr>
					<td>
						发明（设计）人：<br/>
						<xsl:for-each select="cn-parties/cn-inventors/cn-inventor">
							&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="name"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
			<!--代理机构-->
			<xsl:if test="cn-parties/cn-agents/cn-agent/cn-agency/name!=''">
				<tr>
					<td>
						专利代理机构：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="cn-parties/cn-agents/cn-agent/cn-agency/name"/>
					</td>
				</tr>
			</xsl:if>
			<!--代理人-->
			<xsl:if test="cn-parties/cn-agents/cn-agent!=''">
				<tr>
					<td>
						代理人：<br/>
						<xsl:for-each select="cn-parties/cn-agents/cn-agent">
							&#160;&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="name"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
			<!--进入国家阶段日期-->
			<xsl:if test="date-pct-article-22-39-fulfilled!=''">
				<tr>
					<td>
						进入国家阶段日期	：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="date-pct-article-22-39-fulfilled/date"/>
					</td>
				</tr>
			</xsl:if>
			<!--国际申请-->
			<xsl:if test="pct-or-regional-filing-data!=''">
				<tr>
					<td>
						国际申请：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="pct-or-regional-filing-data/document-id/country"/><br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="pct-or-regional-filing-data/document-id/doc-number"/><br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="pct-or-regional-filing-data/document-id/date"/>
					</td>
				</tr>
			</xsl:if>
			<!--国际公布-->
			<xsl:if test="pct-or-regional-publishing-data!=''">
				<tr>
					<td>
						国际公布：<br/>
						&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="pct-or-regional-publishing-data/document-id/country"/>
						<xsl:apply-templates select="pct-or-regional-publishing-data/document-id/doc-number"/>&#160;&#160;&#160;<xsl:value-of select="pct-or-regional-publishing-data/document-id/@lang"/>&#160;&#160;<xsl:apply-templates select="pct-or-regional-publishing-data/document-id/date"/>
					</td>
				</tr>
			</xsl:if>
			<!--名称invention-title-->
			<tr>
				<td>
					名称：<br/>
					&#160;&#160;&#160;&#160;&#160;&#160;<xsl:apply-templates select="invention-title"/>
				</td>
			</tr>
			<!--摘要-->
			<tr>
				<td>
					摘要：<br/>
					<xsl:apply-templates select="abstract/*"/>
				</td>
			</tr>
			<!--摘要附图-->
			<xsl:if test="cn-abstract-drawing/figure =''">
				<tr>
					<td>
						摘要附图：<br/>
						<xsl:apply-templates select="cn-abstract-drawing/*"/>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	<!--
	<xsl:template match="document-id">
		<table border="0" width="600"  >
			<tr>
				<td align="left" valign="top">
					<xsl:apply-templates select="country"/><xsl:apply-templates select="doc-number"/><xsl:apply-templates select="kind"/>
				</td>
			</tr>
		</table>
	</xsl:template>	
-->
	<!--////////////////////////////////////////////////-->
	<xsl:template match="application-body">
		<table border="0" width="800">
			<tr>
				<td align="left" valign="top">
					<xsl:apply-templates select=" claims"/>
					<xsl:apply-templates select="description"/>
					<xsl:apply-templates select=" drawings"/>
<script language="JavaScript">
  	document.execCommand("print");
	window.close();
</script>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="description">
		<tr>
			<td>
				<xsl:apply-templates select="invention-title | technical-field | background-art | description-of-drawings | disclosure | mode-for-invention | best-mode | p | dp | img | comment() "/>
			</td>
		</tr>
		<!--<xsl:apply-templates select="p | description/dp"/>-->
	</xsl:template>
	<xsl:template match="technical-field ">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="technical-field/p">
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4" color="red">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="background-art">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="background-art/p">
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4" color="blue">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="description-of-drawings">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="description-of-drawings/p">
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4" color="green">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="disclosure ">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="disclosure /p">
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4" color="gray">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="best-mode">
		<xsl:apply-templates/>
	</xsl:template>
  
	<xsl:template match="mode-for-invention">
		<xsl:apply-templates/>
	</xsl:template>
  
		<xsl:template match="mode-for-invention/p">
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4" color="Purple">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>

		<xsl:template match="best-mode/p">
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4" color="Purple">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="claims">
		<table cellpadding="0" cellspacing="0" border="0" width="800">
			<tr>
				<td align="center">
					<font face="仿宋" size="5">
						权利要求书
					</font>
				</td>
			</tr>
			<tr>
				<xsl:apply-templates select="claim/claim-text|claim/dp|claim/comment()|comment()"/>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="drawings">
		<br/>
		<table width="800" border="0">
			<tr>
				<td align="left">
					<xsl:apply-templates select=" p | figure/img  | dp | maths | comment()"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="invention-title">
		<table width="520">
			<tr>
				<td align="center">
					<font face="仿宋" size="5" color="Purple">
						<xsl:copy>
							<xsl:apply-templates select="* | text() | br | sub | sup "/>
						</xsl:copy>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="description/invention-title">
		<table width="520">
			<tr>
				<td align="center">
					<font face="仿宋" size="5" color="Purple">
						<xsl:copy>
							<xsl:apply-templates select="* | text() | br | sub | sup "/>
						</xsl:copy>
					</font>
				</td>
			</tr>
		</table>
		<br/>
		<br/>
	</xsl:template>
	<xsl:template match="p">
		<xsl:apply-templates select="maths"/>
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates select="text() | b | i | u | sup | sub | smallcaps | br | dl | ul | ol | figref | patcit | nplcit | crossref | img | chemistry | tables | table-external-doc | pre | bio-deposit"/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="pre">
		<pre>
			<copy>
				<xsl:value-of select="."/>
			</copy>
		</pre>
	</xsl:template>
	<xsl:template match="claim-text">
		<table width="800" border="0">
			<tr>
				<td>
					<font face="仿宋" size="4">
						<script language="JavaScript">
 							document.write("&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;");
						</script>
						<xsl:apply-templates/>
					</font>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="tables">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="table">
		<table face="仿宋" size="4">
			<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="@pgwide"/></xsl:attribute>
			<xsl:attribute name="cellspacing"><xsl:value-of select="@cellspacing"/></xsl:attribute>
			<xsl:attribute name="border"><xsl:value-of select="@border"/></xsl:attribute>
			<xsl:attribute name="frame"><xsl:value-of select="@frame"/></xsl:attribute>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="tgroup">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="colspec">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="thead">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tbody">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="row">
		<tr>
			<xsl:attribute name="valign"><xsl:value-of select="@valign"/></xsl:attribute>
			<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="entry">
		<script language="JavaScript" type="text/javascript">
			var morerows = <xsl:value-of select="@morerows"/>;
			var namest = "<xsl:value-of select="@namest"/>";
			var nameend = "<xsl:value-of select="@nameend"/>";
			
			var rowspan = "";
			var colspan = "";
			
			if(morerows > 1)
			{
				rowspan = "rowspan="+morerows;
			}
			
			if(namest != null &amp;&amp; nameend != null)
			{
				var start = namest.substring(1);
				var end = nameend.substring(1);
				var gap = end - start + 1;
				colspan = "colspan="+gap;
			}
			var td = "&lt;td" + " " + rowspan + " " + colspan + "&gt;";
			document.write(td);
		</script>
		<xsl:attribute name="valign"><xsl:value-of select="@valign"/></xsl:attribute>
		<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
		<xsl:apply-templates/>
		<script language="JavaScript" type="text/javascript">
			<xsl:if test="not(text())">
				document.write("&amp;nbsp;");
			</xsl:if>
			document.write("&lt;/td&gt;");
		</script>
	</xsl:template>
	<xsl:template match="p//br | br">
		<br/>
	</xsl:template>
	<xsl:template match="chem">
		<iframe src="{@file}" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" height="30" width="400"/>
	</xsl:template>
	<xsl:template match="maths">
	<script language="JavaScript">
		var strMathML = "<xsl:value-of select="."/>";
		strMathML = replaceentvalue( strMathML );
		
		strMathML = makemathmlxsl( strMathML );
		document.write( strMathML );	
	</script>
					
	<!--	<applet code="webeq3.ViewerControl.class" archive="../../../../../applet/WebEQApplet.jar" height="100" width="600">
			<PARAM NAME="eq">
				<xsl:attribute name="VALUE"><xsl:value-of select="."/></xsl:attribute>
			</PARAM>
		</applet>-->
	</xsl:template>
	<xsl:template match="cml">
		<xsl:apply-templates select="reaction|formula|molecule"/>
	</xsl:template>
	<xsl:template match="reaction|formula|molecule">
		<font face="仿宋" size="2">
			<xsl:apply-templates select="text()|sb|sp|img|chf"/>
		</font>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="subscript">
		<sub>
			<font face="仿宋" size="-1">
				<copy>
					<xsl:apply-templates select="* |text()|subscript|superscript"/>
				</copy>
			</font>
		</sub>
	</xsl:template>
	<xsl:template match="superscript">
		<sup>
			<font face="仿宋" size="-1">
				<copy>
					<xsl:apply-templates select="* |text()|subscript|superscript"/>
				</copy>
			</font>
		</sup>
	</xsl:template>
	<xsl:template match="b">
		<b>
			<copy>
				<xsl:apply-templates select="* |text()"/>
			</copy>
		</b>
	</xsl:template>
	<xsl:template match="i">
		<i>
			<copy>
				<xsl:apply-templates select="* |text()"/>
			</copy>
		</i>
	</xsl:template>
	<xsl:template match="u">
		<u>
			<copy>
				<xsl:apply-templates select="* |text()"/>
			</copy>
		</u>
	</xsl:template>
	<!--<xsl:template match="overscore">
		<span style="text-decoration : overline">
			<copy>
				<xsl:apply-templates select="* |text()"/>
			</copy>
		</span>
	</xsl:template>
	-->
	<xsl:template match="comment()">
 
	  <xsl:choose>
	  	<xsl:when test="contains(.,'SIPO')">
			<br/>
			<br/>
			<center>--&#160;
		<script language="JavaScript" type="text/javascript">
			var pageinfo = '<xsl:value-of select="substring(.,14)"/>';
			var end = pageinfo.indexOf('"');
			var num = pageinfo.substring(0,end);
			document.write(num);
		</script>
		&#160;--</center>
			<br/>
			<br/>
		</xsl:when>

		</xsl:choose>
	</xsl:template>
	<xsl:template match="dp">
		<table width="550">
			<tr>
				<td>
					<br/>
				</td>
			</tr>
			<tr>
				<td valign="bottom">
					<center>- 
					<script language="JavaScript">
						var nstr="<xsl:value-of select="@n"/>";
						nstr=nstr.substr(1);
						document.write(nstr);
					</script>
				-</center>
				</td>
			</tr>
			<tr>
				<td>
					<hr/>
					<hr/>
					<br/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="figure/img">
		<object classid="CLSID:106E49CF-797A-11D2-81A2-00E02C015623">
			<xsl:attribute name="width"><xsl:value-of select="@wi"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="@he"/></xsl:attribute>
			<param name="src">
				<xsl:attribute name="value"><xsl:value-of select="@file"/></xsl:attribute>
			</param>
			<param name="negative" value="no"/>
			<embed type="image/tiff" negative="no">
				<xsl:attribute name="width"><xsl:value-of select="@wi"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="@he"/></xsl:attribute>
				<xsl:attribute name="src"><xsl:value-of select="@file"/></xsl:attribute>
			</embed>
		</object>
		<br/>
 
		<xsl:value-of select="../@figure-labels"/>
		<br/> 
 	</xsl:template>
	<!--xsl:template match="img">
		<image>
			<xsl:attribute name="width">
				<xsl:value-of select="@wi"/>
			</xsl:attribute>
			<xsl:attribute name="height">
				<xsl:value-of select="@he"/>
			</xsl:attribute>
			<xsl:attribute name="src">
				<xsl:value-of select="@file"/>
			</xsl:attribute>
		</image>
	</xsl:template-->
	<xsl:template match="img">
		<object classid="CLSID:106E49CF-797A-11D2-81A2-00E02C015623">
			<xsl:attribute name="width"><xsl:value-of select="@wi"/></xsl:attribute>
			<xsl:attribute name="height"><xsl:value-of select="@he"/></xsl:attribute>
			<param name="src">
				<xsl:attribute name="value"><xsl:value-of select="@file"/></xsl:attribute>
			</param>
			<param name="negative" value="no"/>
			<embed type="image/tiff" negative="no">
				<xsl:attribute name="width"><xsl:value-of select="@wi"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="@he"/></xsl:attribute>
				<xsl:attribute name="src"><xsl:value-of select="@file"/></xsl:attribute>
			</embed>
		</object>
	</xsl:template>
	<xsl:template match="sb">
		<sub>
			<copy>
				<xsl:apply-templates select="* |text()"/>
			</copy>
		</sub>
	</xsl:template>
	<xsl:template match="sub">
		<sub>
			<copy>
				<xsl:apply-templates select="* |text()"/>
			</copy>
		</sub>
	</xsl:template>
	<xsl:template match="sp">
		<sup>
			<font face="宋体" size="-1">
				<xsl:apply-templates select="* |text()"/>
			</font>
		</sup>
	</xsl:template>
	<xsl:template match="sup">
		<sup>
			<font face="宋体" size="-1">
				<xsl:apply-templates select="* |text()"/>
			</font>
		</sup>
	</xsl:template>
	<xsl:template match="chf">
		<APPLET>
			<xsl:attribute name="CODEBASE">"."</xsl:attribute>
			<xsl:attribute name="CODE">cml.class</xsl:attribute>
			<xsl:attribute name="name">"testApplet"</xsl:attribute>
			<xsl:attribute name="HSPACE">0</xsl:attribute>
			<xsl:attribute name="VSPACE">0</xsl:attribute>
			<xsl:attribute name="HEIGHT"><xsl:value-of select="@height"/></xsl:attribute>
			<xsl:attribute name="WIDTH"><xsl:value-of select="@width"/></xsl:attribute>
			<xsl:attribute name="ALIGN"><xsl:value-of select="@align"/></xsl:attribute>
			<PARAM NAME="HEIGHT">
				<xsl:attribute name="VALUE"><xsl:value-of select="@height"/></xsl:attribute>
			</PARAM>
			<PARAM NAME="WIDTH">
				<xsl:attribute name="VALUE"><xsl:value-of select="@width"/></xsl:attribute>
			</PARAM>
			<PARAM NAME="ARROWTYPE">
				<xsl:attribute name="VALUE"><xsl:value-of select="@arrowtype"/></xsl:attribute>
			</PARAM>
			<PARAM NAME="UPPER">
				<xsl:attribute name="VALUE"><xsl:value-of select="upper"/></xsl:attribute>
			</PARAM>
			<PARAM NAME="LOWER">
				<xsl:attribute name="VALUE"><xsl:value-of select="lower"/></xsl:attribute>
			</PARAM>
			<PARAM NAME="ALIGN">
				<xsl:attribute name="VALUE"><xsl:value-of select="align"/></xsl:attribute>
			</PARAM>
		</APPLET>
	</xsl:template>
	
	<!-- 处理XML中的xml-stylesheet声明 -->
	<xsl:template match="processing-instruction('xml-stylesheet')">
		<script language="JavaScript">
			strGlobalHref = '<xsl:value-of select="."/>';
		</script>
	</xsl:template>
	
</xsl:stylesheet>
