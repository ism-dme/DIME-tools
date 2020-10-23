<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xd:doc>
		<xd:desc>deletes attributes</xd:desc>
	</xd:doc>
	<xsl:template match="@dme.parts" mode="chamber"/>

	<xsl:template match="@label.abbr" mode="chamber"/>
	<xsl:template match="scoreDef" mode="chamber orchestral">
		<xsl:copy>
			<xsl:attribute name="optimize" select="'false'"/>
			<xsl:apply-templates select="@*, node()"/>
		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc>deletes second layer/@stem.dir bcs it is in the second layer and this is not a grace note.</xd:desc>
	</xd:doc>
	<xsl:template match="layer[(@n = '2') and not(.//note[@grace])]//@stem.dir" mode="orchestral"/>


</xsl:stylesheet>
