<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:fo="http://www.w3.org/1999/XSL/Format"
xmlns:doc="http://www.dcarlisle.demon.co.uk/xsldoc"
>
	<xsl:output method="html" encoding="UTF-16"/>
	<xsl:template match="/">
		<html>
			<head>
				<title></title>
				<script>
					var strGlobalPath = "";
					var strCurArrowType = "single";
				</script>
				<style>
					<xsl:text doc:id="css">
.chem {
text-align: center;
display:inline;
vertical-align: middle;
}
.MsoNormal {
mso-style-parent:"";
margin:0cm;
margin-bottom:.0001pt;
text-align:justify;
text-justify:inter-ideograph;
mso-pagination:none;
font-size:10.5pt;
mso-bidi-font-size:12.0pt;
font-family:"Times New Roman";
mso-fareast-font-family:宋体;
mso-font-kerning:1.0pt;
}
					</xsl:text>
				</style>
			</head>
			<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
				<xsl:apply-templates select="processing-instruction('xml-stylesheet')"/>
				<table class="chem">
					<tr>
						<td><xsl:apply-templates select="cml//chem"/></td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="chem">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="text()">
		<xsl:value-of select="."/>	
	</xsl:template>
	
	<xsl:template match="chf">
		<script language="JavaScript">
			strCurArrowType = '<xsl:value-of select="@arrowtype"/>';
			strCurArrowType = strCurArrowType.toLowerCase();
			document.write(" &lt;/td&gt;");
		</script>
		<td>
		<table class="chem">
			<tr>
				<td>
					<p class="MsoNormal" align="center" style='text-align:center;font-size: 75% ;'>
						<xsl:if test="./upper">
							<xsl:apply-templates select="upper"/>
						</xsl:if>
					</p>
					<div class="MsoNormal" align="center" style='text-align:center;width:100%'>
						<script language="JavaScript">
							var strFile = "single.gif";
							if( strCurArrowType == "single" )
							{
								strFile = '&lt;img src="' + strGlobalPath + 'single.gif" /&gt;'; 	
							}
							if( strCurArrowType == "double" )
							{
								strFile = '&lt;img src="' + strGlobalPath + 'double.gif" /&gt;';
							}
							if( strCurArrowType == "reverse" )
							{
								strFile = '&lt;img src="' + strGlobalPath + 'reverse.gif" /&gt;';
							}
							document.write( strFile );
						</script>
					</div>
					<p class="MsoNormal" align="center" style='text-align:center;font-size: 75% ;'>
						<xsl:if test="./lower">
							<xsl:apply-templates select="lower"/>
						</xsl:if>
					</p>
				</td>
			</tr>
		</table>
		</td>
		<script language="JavaScript">
			document.write("&lt;td&gt; ");
		</script>	
	</xsl:template>
	<xsl:template match="upper">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="lower">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="br">
		<br/>
	</xsl:template>
	<xsl:template match="sup">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="sub">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="b">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="i">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="u">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="dp">
		<br/>
		<br/>
		<center>--&#160;<xsl:value-of select="@n"/>&#160;--</center>
		<br/>
		<br/>
	</xsl:template>
	
	<!-- 处理XML中的xml-stylesheet声明 -->
	<xsl:template match="processing-instruction('xml-stylesheet')">
		<script language="JavaScript">
			strGlobalPath = '<xsl:value-of select="."/>';
			var strPath = "";
			var nPos = strGlobalPath.indexOf( "href" );
			if( nPos &gt;= 0 )
			{
				nPos = strGlobalPath.indexOf( "\"", nPos );
				if( nPos &gt;= 0 )
				{
					var nStart = nPos + 1;
					nPos = strGlobalPath.indexOf( "\"", nStart );
					if( nPos &gt;= 0 )
					{
						var strHref = strGlobalPath.substring( nStart, nPos );
						strHref = strHref.replace( "\\", "/" );
						nPos = strHref.lastIndexOf( "/" );
						if( nPos &gt;= 0 )
						{
							strPath = strHref.substring( 0, nPos+1 );
						}
					}
				}
			}
			strGlobalPath = strPath;
		</script>
	</xsl:template>
	
</xsl:stylesheet>
