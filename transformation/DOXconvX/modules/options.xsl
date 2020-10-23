<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xsl:template name="options">
		<xsl:variable name="optionsGUI" select="doc('../../options/options.xml')//id('DOXconvX')/dme:parameters"/>

		<xsl:map>		
			<xsl:map-entry key="'meiHead'" select="$optionsGUI/id('meiHead')/string(text())"/>
			<xsl:map-entry key="'genre'" select="$optionsGUI/id('genre')/string(text())"/>
			<xsl:map-entry key="'movementPages'" select="$optionsGUI/id('pages')/string(text())"/>			
		</xsl:map>
	</xsl:template>
<!--	search map:get(.*'file')-->

	<xsl:template name="optionsCalc">		
		<xsl:variable name="kvMovement" select="
			translate(substring-before(substring-after($fileName, '_'),
			'_'), '-', '')"/>
		<xsl:map>			
			<xsl:map-entry key="'movementID'" select="substring($fileName, 16, 4)"/>
			<xsl:map-entry key="'kvMovement'" select="$kvMovement"/>
			<xsl:map-entry key="'KV'" select="substring($kvMovement, 1, 3)"/>
			<xsl:map-entry key="'movementInteger'" select="functx:chars($kvMovement)[last()] cast as xs:string"/>
			<xsl:map-entry key="'movementN'" select="substring($kvMovement, 4, 3)"/>
		</xsl:map>
	</xsl:template>


</xsl:stylesheet>
