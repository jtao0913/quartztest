<?xml version="1.0" encoding="UTF-8"?>
<!--<http://www.w3.org/1999/XSL/Formatxsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl">-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<xsl:apply-templates select="cn-patent-document"/>
		</html>
	</xsl:template>
	<xsl:template match="cn-patent-document">
		<head>
			<title>
			</title>
		</head>
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
		<xsl:if test=".!=''">
			<td>
				<xsl:attribute name="valign"><xsl:value-of select="@valign"/></xsl:attribute>
				<xsl:attribute name="width"><!--<xsl:value-of select=""/>--></xsl:attribute>
				<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
				<xsl:attribute name="rowspan"><xsl:value-of select="@morerows"/></xsl:attribute>
				<xsl:attribute name="colspan"><xsl:value-of select="number(@nameend)-number(@namest)+1"/></xsl:attribute>
				<!--				<xsl:if test="//tables[@num='01']/table/tgroup/colspec/@colname=./@colname">
				<xsl:value-of select="//tables[@num='01']/table/tgroup/colspec[@colname=./@colname]/@colwidth"/>=
				<xsl:value-of select="./@colname"/>
				</xsl:if>
-->
				<xsl:apply-templates/>
			</td>
		</xsl:if>
		<xsl:if test=".='' or .='	'">
			<td>
				<xsl:attribute name="valign"><xsl:value-of select="@valign"/></xsl:attribute>
				<xsl:attribute name="width"><!--<xsl:value-of select="ancestor::entry//copspec/@colwidth"/>--></xsl:attribute>
				<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
				<xsl:attribute name="rowspan"><xsl:value-of select="@morerows"/></xsl:attribute>
				<xsl:attribute name="colspan"><xsl:value-of select="number(@nameend)-number(@namest)+1"/></xsl:attribute>
				<table>
					<tr>
						<td height="30">
							<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
							<!--&#xA0;-->
							<xsl:apply-templates/>
						</td>
					</tr>
				</table>
			</td>
		</xsl:if>
	</xsl:template>
	<xsl:template match="p//br | br">
		<br/>
	</xsl:template>
	<xsl:template match="chem">
		<iframe src="{@file}" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" height="30" width="400"/>
	</xsl:template>
	<xsl:template match="maths">
		<applet code="webeq3.ViewerControl.class" archive="../../../../../applet/WebEQApplet.jar" height="100" width="600">
			<PARAM NAME="eq">
				<xsl:attribute name="VALUE"><xsl:value-of select="."/></xsl:attribute>
			</PARAM>
		</applet>
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
 
			<xsl:when test="contains(.,'no marking')">
 
						<font face="宋体" size="9" color="red">

								&lt;标记未做五项标引&gt; 
						</font>	
			</xsl:when>	
			<xsl:when test="contains(.,'part marking')">
 
						<font face="宋体" size="9" color="blue">

								&lt;部分五项标引&gt; 
						</font>	
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
</xsl:stylesheet>
