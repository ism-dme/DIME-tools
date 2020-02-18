<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



	<xd:doc>
		<xd:desc>Changes @accid to @accid.ges in the elements which were calculated in the variable checkAccidentalsVisibility.</xd:desc>
	</xd:doc>
	<xsl:template match="id($checkAccidentalsVisibility)" mode="changeAccid">
		<xsl:message>Changed @accid to @accid.ges in: <xsl:value-of select="@xml:id"/>. </xsl:message>
		<xsl:copy>
			<xsl:attribute name="accid.ges" select="@accid"/>
			<xsl:apply-templates mode="#current" select="@* except @accid, node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
