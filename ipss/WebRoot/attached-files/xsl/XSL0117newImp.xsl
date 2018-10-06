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
				<td width="200">公开（公告）号</td>
				<td>
					<xsl:apply-templates select="cn-publication-reference/document-id/country"/>
					<xsl:apply-templates select="cn-publication-reference/document-id/doc-number"/>
					<xsl:apply-templates select="cn-publication-reference/document-id/kind"/>
				</td>
			</tr>
			<!--公开（公告）日-->
			<tr>
				<td width="200">公开（公告）日</td>
				<td>
					<xsl:apply-templates select="cn-publication-reference/document-id/date"/>
				</td>
			</tr>
			<!--申请信息-->
			<!--申请（专利）号-->
			<tr>
				<td width="200">申请（专利）号</td>
				<td>
					<xsl:apply-templates select="application-reference/document-id/country"/>
					<xsl:apply-templates select="application-reference/document-id/doc-number"/>
				</td>
			</tr>
			<!--申请日-->
			<tr>
				<td width="200">申请日</td>
				<td>
					<xsl:apply-templates select="application-reference/document-id/date"/>
				</td>
			</tr>
			<!--国际优先权-->
			<xsl:if test="priority-claims/priority-claim!=''">
				<tr>
					<td width="200">优先权</td>
					<td>
						<xsl:for-each select="priority-claims/priority-claim">
							[32]<xsl:apply-templates select="date"/>&#160;&#160;[33]<xsl:apply-templates select="country"/>&#160;&#160;[31]<xsl:apply-templates select="doc-number"/>
							<br/>
						</xsl:for-each>
						<xsl:for-each select="//cn-domestic-priority-claim">
							[32]<xsl:apply-templates select="substitution/relation/parent-doc/document-id/date"/>&#160;&#160;[33]	<xsl:apply-templates select="substitution/relation/parent-doc/document-id//country"/>&#160;&#160;[31]<xsl:apply-templates select="substitution/relation/parent-doc/document-id//doc-number"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:if>
			</table>
			
			</xsl:template>
	</xsl:stylesheet>
			
