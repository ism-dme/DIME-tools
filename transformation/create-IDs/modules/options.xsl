<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xsl:template name="options">
		<xsl:variable name="optionsGUI" select="doc('../../lib/DIME-tools/DIME-tools.xml')//id('create-IDs')/dme:parameters"/>

		<xsl:map>	
			<xsl:map-entry key="'recount_measures'" select="$optionsGUI/id('recount_measures')/string(text())"/>
			<xsl:map-entry key="'all'" select="$optionsGUI/id('all')/string(text())"/>
			<xsl:map-entry key="'els2apply'" select="dme:tokValues($optionsGUI, 'els2apply')"/>
			<xsl:map-entry key="'els2exclude'" select="dme:tokValues($optionsGUI, 'els2exclude')"/>
		</xsl:map>
	</xsl:template>

	<xsl:template name="optionsCalc">		
		<xsl:variable name="kvMovement" select="
			translate(substring-before(substring-after($fileName, '_'),
			'_'), '-', '')"/>
		<xsl:map>
			<xsl:map-entry key="'fileName'" select="$fileName"/>
			<xsl:map-entry key="'movementID'" select="substring($fileName, 16, 4)"/>			
			<xsl:map-entry key="'kvMovement'" select="$kvMovement(:example value '458001':)"/>
			<xsl:map-entry key="'KV'" select="substring($kvMovement, 1, 3)"/>
			<xsl:map-entry key="'movementInteger'" select="functx:chars($kvMovement)[last()] cast as xs:string"/>
			<xsl:map-entry key="'movementN'" select="substring($kvMovement, 4, 3)"/>
		</xsl:map>
	</xsl:template>


</xsl:stylesheet>
