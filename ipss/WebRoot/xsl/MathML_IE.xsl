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
<x:x x="{" m="0em"  stretch="true" top="ì" middle="í" extend="ï" bottom="î">{</x:x>
<x:x x="}" m="0em"  stretch="true" top="ü" middle="ý" extend="ú" bottom="þ">{</x:x>
<x:x x="(" m="0em"  stretch="true" top="æ" middle="ç" extend="ç" bottom="è">(</x:x>
<x:x x=")" m="0em"  stretch="true" top="ö" middle="÷" extend="÷" bottom="ø">)</x:x>
<x:x x="[" m="0em"  stretch="true" top="é" middle="ê" extend="ê" bottom="ë">[</x:x>
<x:x x="]" m="0em"  stretch="true" top="ù" middle="ú" extend="ú" bottom="û">]</x:x>
<x:x x="&#x301A;" m="0em"  stretch="true" top="éé" middle="êê" extend="êê" bottom="ëë">[[</x:x>
<x:x x="&#x301B;" m="0em"  stretch="true" top="ùù" middle="úú" extend="úú" bottom="ûû">]]</x:x>
<x:x x="|" m="0em"  stretch="true" top="ç" middle="ç" extend="ç" bottom="ç">|</x:x>
<x:x x="||" m="0em"  stretch="true" top="çç" middle="çç" extend="çç" bottom="çç">||</x:x>
<x:x x="&#x2061;" m="0em">&#xFEFF;</x:x>
<x:x x="&#x2062;" m="0em">&#xFEFF;</x:x>
<x:x x="-">&#x2212;</x:x>
<x:x x="&#x2243;"><span style="position:
relative;  top: +.1em;">&#x2212;</span>&#xFEFF;<span style="position:
relative; left: -.55em; top: -.2em; margin: 0em;">~</span></x:x>
<x:x x="&#xFE38;" m="0em">_v_</x:x>
<xsl:variable name="opdict" select="document('')/*/x:x"/>
<xsl:template match="/">
	<html xml:lang="en">
		<body>
			<head>
				<script xmlns:m="http://www.w3.org/1998/Math/MathML">
				
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
			<xsl:apply-templates/>
		</body>
	</html>
</xsl:template>
<xsl:template match="m:*">
<span style="color: red;">&lt;<xsl:value-of select="local-name(.)"/>&gt;</span>
<xsl:apply-templates/>
<span style="color: red;">&lt;/<xsl:value-of select="local-name(.)"/>&gt;</span>
</xsl:template>
<xsl:template match="m:mi">
<span class="mi">
<xsl:if test="1=string-length(normalize-space(.))">
<xsl:attribute name="class">mi1</xsl:attribute>
</xsl:if>
<xsl:apply-templates select="@mathvariant"/>
 <xsl:variable name="x"  select="normalize-space(.)"/>
 <xsl:choose>
  <xsl:when test="$opdict[@x=$x and @v]">
   <xsl:attribute name="class"><xsl:value-of select="$opdict[@x=$x]/@v"/></xsl:attribute>
    <xsl:value-of select="$opdict[@x=$x and @v]"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$x"/>
   </xsl:otherwise>
  </xsl:choose>
</span>
</xsl:template>
<xsl:template match="@mathvariant[.='bold']">
<xsl:attribute name="style">font-weight: bold; font-style: upright</xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='bold-italic']">
<xsl:attribute name="style">font-style: upright; font-weight: bold; font-style: italic;</xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='italic']">
<xsl:attribute name="style">font-style: italic; </xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='monospace']">
<xsl:attribute name="style">font-family: monospace; </xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='sans-serif']">
<xsl:attribute name="style">font-family: sans-serif; </xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='bold-sans-serif']">
<xsl:attribute name="style">font-family: sans-serif; font-weight: bold; </xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='fraktur']">
<xsl:attribute name="style">font-family: old english text mt</xsl:attribute>
<xsl:attribute name="class"></xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='double-struck']">
<xsl:attribute name="class">doublestruck</xsl:attribute>
</xsl:template>
<xsl:template match="@mathvariant[.='script']">
<xsl:attribute name="style">font-family: brush script mt italic</xsl:attribute>
<xsl:attribute name="class"></xsl:attribute>
</xsl:template>
<xsl:template match="m:mo">
<span id="{generate-id()}" class="mo">
 <xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:mn">
<span class="mn">
 <xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:munder">
<span class="munder">
<xsl:if test="normalize-space(*[2])='&#x332;'">
  <xsl:attribute
  name="style">border-width: 0pt 0pt .1em 0pt; border-style: solid;"</xsl:attribute>
</xsl:if>
 <span><xsl:apply-templates select="*[1]"/></span>
</span>
</xsl:template>
<xsl:template match="m:mover">
<span class="munder">
<xsl:if test="normalize-space(*[2])='&#xAF;'">
  <xsl:attribute
  name="style">border-width: .1em 0pt 0pt 0pt; border-style: solid;"</xsl:attribute>
</xsl:if>
 <span><xsl:apply-templates select="*[1]"/></span>
</span>
</xsl:template>
<xsl:template match="m:munderover">
<table class="munderover">
<tr><td><xsl:apply-templates select="*[3]"/></td></tr>
<tr><td><xsl:apply-templates select="*[1]"/></td></tr>
<tr><td><xsl:apply-templates select="*[2]"/></td></tr>
</table>
</xsl:template>
<xsl:template match="m:mtext">
<span class="mtext">
 <xsl:value-of select="normalize-space(.)"/>
</span>
</xsl:template>
<xsl:template match="m:mstyle">
<span>
<xsl:attribute name="style">
 <xsl:if test="@color">color: <xsl:value-of select="@color"/>; </xsl:if>
 <xsl:if test="@background">background-color: <xsl:value-of select="@background"/>; </xsl:if>
</xsl:attribute>
 <xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:mglyph">
<font face="{@fontfamily}"><xsl:value-of
disable-output-escaping="yes" select="'&amp;#'"/>
<xsl:value-of select="@index"/>;<xsl:text/>
</font>
</xsl:template>
<xsl:template match="m:ms">
<span class="ms">
  <xsl:value-of select="@lquote"/><xsl:if test="not(@lquote)">"</xsl:if>
    <xsl:value-of select="normalize-space(.)"/>
  <xsl:value-of select="@rquote"/><xsl:if test="not(@rquote)">"</xsl:if>
</span>
</xsl:template>
<xsl:template match="m:math">
    <xsl:call-template name="mrow"/>
</xsl:template>
<xsl:template match="m:mfenced">
<xsl:variable name="l">
 <xsl:choose>
  <xsl:when test="@open"><xsl:value-of select="@open"/></xsl:when>
  <xsl:otherwise>(</xsl:otherwise>
 </xsl:choose>
</xsl:variable>
<xsl:variable name="r">
 <xsl:choose>
  <xsl:when test="@close"><xsl:value-of select="@close"/></xsl:when>
  <xsl:otherwise>)</xsl:otherwise>
 </xsl:choose>
</xsl:variable>
<xsl:variable name="s">
 <xsl:choose>
  <xsl:when test="@sep">
    <xsl:call-template name="text">
       <xsl:with-param name="x" select="@sep"/>
    </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>,</xsl:otherwise>
 </xsl:choose>
</xsl:variable>
<span id="{generate-id()}L"><xsl:value-of select="$l"/></span>
<span id="{generate-id()}M">
<xsl:for-each select="*">
<xsl:apply-templates select="."/>
<xsl:if test="position() != last()"><span id="{generate-id()}X{position()}"><xsl:value-of select="$s"/></span></xsl:if>
</xsl:for-each>
</span>
<span id="{generate-id()}R"><xsl:value-of select="$r"/></span>
<script>
<xsl:if test="$s=$opdict[@stretch='true']/@x">
<xsl:for-each select="*[position()&lt;last()]">
<xsl:variable name="opdictentry" select="$opdict[@x=$s]"/>
mrowStretch(<xsl:value-of select="concat(generate-id(),'X',position())"/>,"<xsl:value-of
select="$opdictentry/@top"/>","<xsl:value-of
select="$opdictentry/@extend"/>","<xsl:value-of
select="$opdictentry/@middle"/>","<xsl:value-of
select="$opdictentry/@bottom"/>");</xsl:for-each>
</xsl:if>
<xsl:variable name="opdictentry" select="$opdict[@x=$l]"/>
var mrowH = <xsl:value-of select="generate-id()"/>M.offsetHeight;
mrowStretch(<xsl:value-of select="generate-id()"/>L,"<xsl:value-of
select="$opdictentry/@top"/>","<xsl:value-of
select="$opdictentry/@extend"/>","<xsl:value-of
select="$opdictentry/@middle"/>","<xsl:value-of
select="$opdictentry/@bottom"/>");<xsl:text/>
<xsl:variable name="opdictentry2" select="$opdict[@x=$r]"/>
mrowStretch(<xsl:value-of select="generate-id()"/>R,"<xsl:value-of
select="$opdictentry2/@top"/>","<xsl:value-of
select="$opdictentry2/@extend"/>","<xsl:value-of
select="$opdictentry2/@middle"/>","<xsl:value-of
select="$opdictentry2/@bottom"/>");<xsl:text/>
</script>
</xsl:template>
<xsl:template match="m:mmultiscripts">
<table style="display:inline; vertical-align: middle;">
<tr>
<xsl:for-each select="*[preceding-sibling::m:mprescripts and position() mod 2 = 0]">
<td><xsl:apply-templates select="."/></td>
</xsl:for-each>
<td rowspan="2"><xsl:apply-templates select="*[1]"/></td>
<xsl:for-each select="*[not(preceding-sibling::m:mprescripts) and position() !=1 and position() mod 2 = 1]">
<td><xsl:apply-templates select="."/></td>
</xsl:for-each>
</tr>
<tr>
<xsl:for-each select="*[preceding-sibling::m:mprescripts and position() mod 2 = 1]">
<td><xsl:apply-templates select="."/></td>
</xsl:for-each>
<xsl:for-each select="*[not(preceding-sibling::m:mprescripts) and
not(self::m:mprescripts) and position() mod 2 = 0]">
<td><xsl:apply-templates select="."/></td>
</xsl:for-each>
</tr>
</table>
</xsl:template>
<xsl:template match="m:none">&#xFEFF;</xsl:template>
<xsl:template match="m:merror">
<span class="merror"><xsl:call-template name="mrow"/></span>
</xsl:template>
<xsl:template match="m:mphantom">
<span class="mphantom"><xsl:apply-templates/></span>
</xsl:template>
<xsl:template match="m:maction[@type='tooltip']">
<span title="{*[2]}"><xsl:apply-templates select="*[1]"/></span>
</xsl:template>
<xsl:template match="m:maction[@type='toggle']">
<span  id="{generate-id()}" onclick="toggle({generate-id()})">
<span style="display:inline;"><xsl:apply-templates select="*[1]"/></span>
<xsl:for-each select="*[position() &gt; 1]">
<span style="display:none;"><xsl:apply-templates select="."/></span>
</xsl:for-each>
</span>
</xsl:template>
<xsl:template match="m:maction[@type='statusline']">
<span  id="{generate-id()}"
onmouseover="window.status='{*[2]}';"
onmouseout="window.status='';"
>
<xsl:apply-templates select="*[1]"/></span>
</xsl:template>
<xsl:template match="m:maction[@type='highlight']">
<span  id="{generate-id()}"
onmouseover="{generate-id()}.style.backgroundColor='yellow';"
onmouseout="{generate-id()}.style.backgroundColor='white';"><xsl:apply-templates/></span>
</xsl:template>
<xsl:template match="m:mrow" name="mrow">
<span id="{generate-id()}" class="mrow">
 <xsl:apply-templates select="*"/>
</span>
<xsl:if test="m:mo[@stretch='true' or normalize-space(.)=$opdict[@stretch='true']/@x]">
<script>
var mrowH = <xsl:value-of select="generate-id()"/>.offsetHeight;
<xsl:for-each select="m:mo[@stretch='true' or
                  normalize-space(.)=$opdict[@stretch='true']/@x]">
<xsl:variable name="o" select="normalize-space(.)"/>
<xsl:variable name="opdictentry" select="$opdict[@x=$o]"/>
mrowStretch(<xsl:value-of select="generate-id()"/>,"<xsl:value-of
select="$opdictentry/@top"/>","<xsl:value-of
select="$opdictentry/@extend"/>","<xsl:value-of
select="$opdictentry/@middle"/>","<xsl:value-of
select="$opdictentry/@bottom"/>");</xsl:for-each>
</script>
</xsl:if>
</xsl:template>
<xsl:template match="m:msubsup">
<span id="{generate-id()}" >
<xsl:apply-templates select="*[1]"/></span
><span id="{generate-id()}b" class="msubsup"><xsl:apply-templates
select="*[2]"/></span
><span id="{generate-id()}p" class="msubsup"><xsl:apply-templates
select="*[3]"/></span
><span id="{generate-id()}x">&#xFEFF;</span>
<script>
msubsup("<xsl:value-of select="concat(generate-id(),'&quot;,',generate-id(),',',generate-id(),'x,',generate-id(),'b,',generate-id())"/>p);
</script>
</xsl:template>
<xsl:template match="h:table//m:msubsup|m:mtable//m:msubsup|m:msubsup"
priority="2">
<span>
<xsl:apply-templates select="*[1]"/>
</span
><sub><xsl:apply-templates
select="*[2]"/></sub>
<sup><xsl:apply-templates
select="*[3]"/></sup>
</xsl:template>
<xsl:template match="m:msup
">
<span id="{generate-id()}">
<xsl:apply-templates select="*[1]"/>
</span
><span id="{generate-id()}p" class="msubsup"><xsl:apply-templates
select="*[2]"/></span
><span id="{generate-id()}x">&#xFEFF;</span>
<script>
msup("<xsl:value-of select="concat(generate-id(),'&quot;,',generate-id(),'x,',generate-id())"/>p);
</script>
</xsl:template>
<xsl:template match="h:table//m:msup|m:mtable//m:msup|m:msup"
priority="2">
<span>
<xsl:apply-templates select="*[1]"/>
</span
><sup><xsl:apply-templates
select="*[2]"/></sup>
</xsl:template>
<xsl:template match="m:msub
">
<span id="{generate-id()}">
<xsl:apply-templates select="*[1]"/>
</span
><span id="{generate-id()}p" class="msubsup"><xsl:apply-templates
select="*[2]"/></span
><span id="{generate-id()}x">&#xFEFF;</span>
<script>
msub("<xsl:value-of select="concat(generate-id(),'&quot;,',generate-id(),'x,',generate-id())"/>p);
</script>
</xsl:template>
<xsl:template match="h:table//m:msub|m:mtable//m:msub|m:msub"
priority="2">
<span>
<xsl:apply-templates select="*[1]"/>
</span
><sub><xsl:apply-templates
select="*[2]"/></sub>
</xsl:template>
<xsl:template match="m:*/text()" name="text">
<xsl:param name="x" select="normalize-space(.)"/>
<xsl:variable name="mo"  select="document('')/*/x:x[@x=$x]"/>
<xsl:choose>
  <xsl:when test="$mo"><xsl:copy-of select="$mo/node()"/></xsl:when>
  <xsl:otherwise><xsl:copy-of select="$x"/></xsl:otherwise>
</xsl:choose>
</xsl:template>
<xsl:template match="m:msqrt">
<span class="msqrtx">\&#xFEFF;</span><span class="msqrt">
<xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:menclose[@notation='radical']">
<span class="msqrtx">\&#xFEFF;</span><span class="msqrt">
<xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:menclose[@notation='actuarial']">
<span class="actuarial">
<xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:menclose">
<span class="msqrt">
<xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:mroot">
<span class="msqrtx"><sup><xsl:apply-templates select="*[2]"/></sup>\&#xFEFF;</span><span class="msqrt">
<xsl:apply-templates select="*[1]"/>
</span>
</xsl:template>
<xsl:template match="m:mfrac">
<xsl:param name="full" select="not(ancestor::m:mfrac)"/>
<table  class="mfrac">
<xsl:if test="$full">
  <xsl:attribute name="style">font-size: 75% ;</xsl:attribute>
</xsl:if>
<xsl:if test="not($full)">
  <xsl:attribute name="style">font-size: 100% ;</xsl:attribute>
</xsl:if>
<tr id="a{generate-id()}" class="mfraca"><td class="mfracaa">
<xsl:apply-templates select="*[1]"/>
</td></tr>
<tr id="b{generate-id()}" class="mfracb"><td>
<xsl:apply-templates select="*[2]"/>
</td></tr>
</table><xsl:if test="$full"><script>
if ( a<xsl:value-of select="generate-id()"
       />.offsetHeight >  b<xsl:value-of select="generate-id()"
         />.offsetHeight ) b<xsl:value-of select="generate-id()
            "/>.style.setExpression("height",a<xsl:value-of select="generate-id()"/>.offsetHeight );
else a<xsl:value-of
select="generate-id()"/>.style.setExpression("height",b<xsl:value-of
       select="generate-id()"/>.offsetHeight );
</script></xsl:if>
</xsl:template>
<xsl:template match="m:padded">
<span>
<xsl:attribute name="display">
</xsl:attribute>
<xsl:apply-templates/>
</span>
</xsl:template>
<xsl:template match="m:mspace">
<span style="padding-left: {@width};"></span>
</xsl:template>
<xsl:template match="m:mtable">
<table class="mtable">
<xsl:apply-templates/>
</table>
<script>
<xsl:variable name="t" select="."/>
<xsl:for-each select="m:mtr[1]/m:mtd">
<xsl:variable name="c" select="position()"/>
<xsl:for-each select="descendant::m:maligngroup">
<xsl:variable name="g" select="position()"/>
malign([<xsl:for-each
select="$t/m:mtr/m:mtd[$c]/descendant::m:maligngroup[$g]">
 <xsl:value-of select="generate-id()"/>
 <xsl:if test="position()&lt;last()">,</xsl:if>
</xsl:for-each>]);</xsl:for-each>
</xsl:for-each>
</script>
</xsl:template>
<xsl:template match="m:mtr">
<tr>
<xsl:apply-templates/>
</tr>
</xsl:template>
<xsl:template match="m:mtd">
<td>
<xsl:apply-templates/>
</td>
</xsl:template>
<xsl:template match="m:maligngroup">
<xsl:variable name="g">
<xsl:choose>
<xsl:when test="@groupalign">
</xsl:when>
<xsl:when test="ancestor::td/@groupalign">
</xsl:when>
<xsl:when test="ancestor::tr/@groupalign">
</xsl:when>
<xsl:when test="ancestor::table/@groupalign">
</xsl:when>
<xsl:otherwise>left</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<span id="{generate-id()}">&#xFEFF;</span>
</xsl:template>
</xsl:stylesheet>
