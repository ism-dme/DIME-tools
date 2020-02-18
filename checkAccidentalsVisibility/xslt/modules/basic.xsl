<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xsl:character-map name="entities">
		<xsl:output-character character="&#8198;" string="&amp;#8198;"/>
		<xsl:output-character character="&#8194;" string="&amp;#8194;"/>
		<xsl:output-character character="&#8195;" string="&amp;#8195;"/>
		<xsl:output-character character="&#8211;" string="&amp;#8211;"/>
		<xsl:output-character character="&#160;" string="&amp;#160;"/>
		<xsl:output-character character="&#xea5c;" string="&amp;#xea5c;"/>
		<xsl:output-character character="&#xe263;" string="&amp;#xe263;"/>
		<xsl:output-character character="&#xea56;" string="&amp;#xea56;"/>
		<!--<xsl:output-character character="&amp;" string="abs" />-->

		<!--		needed to replace &amp; to & -->
		<xsl:output-character character="«" string="&amp;"/>
	</xsl:character-map>

	<xsl:output encoding="UTF-8" indent="yes" method="xml" use-character-maps="entities"/>
	<xsl:strip-space elements="*"/>


	<xsl:template match="node() | @*" mode="extractMainVersion changeAccid">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="node() | @*"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
