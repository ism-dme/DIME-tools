<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<template name="options">
		<variable name="optionsGUI" select="doc('../../options/options.xml')//id('create-IDs')/dme:parameters"/>

		<map>
			<map-entry key="'recount_measures'" select="$optionsGUI/id('recount_measures')/string(text())"/>
			<map-entry key="'all'" select="$optionsGUI/id('all')/string(text())"/>
			<map-entry key="'els2apply'" select="dme:tokValues($optionsGUI, 'els2apply')"/>
			<map-entry key="'els2exclude'" select="dme:tokValues($optionsGUI, 'els2exclude')"/>
		</map>
	</template>

	<template name="optionsCalc">
		<if test="$DIME-FileNaming">
			<variable name="kvMovement" select="
					translate(substring-before(substring-after($fileName, '_'),
					'_'), '-', '')"/>
			<map>
				<map-entry key="'fileName'" select="$fileName"/>
				<map-entry key="'movementID'" select="substring($fileName, 16, 4)"/>
				<map-entry key="'kvMovement'" select="$kvMovement (:example value '458001':)"/>
				<map-entry key="'KV'" select="substring($kvMovement, 1, 3)"/>
				<map-entry key="'movementInteger'" select="functx:chars($kvMovement)[last()] cast as xs:string"/>
				<map-entry key="'movementN'" select="substring($kvMovement, 4, 3)"/>
			</map>
		</if>
	</template>


</stylesheet>
