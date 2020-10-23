<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xd:doc>
		<xd:desc>Copies elements form the original file.</xd:desc>
	</xd:doc>
	<xsl:template match="revisionDesc" mode="copyFromOrig">
		<xsl:variable name="currName" select="local-name()"/>
		<xsl:apply-templates mode="revisionDesc" select="$processedFile//meiHead//*[local-name() = $currName]"/>
	</xsl:template>

	<xsl:template match="change" mode="revisionDesc">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="@*, node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="@resp[. = '#FKel']" mode="revisionDesc">
		<xsl:attribute name="resp" select="'#FK'"/>
	</xsl:template>

</xsl:stylesheet>
