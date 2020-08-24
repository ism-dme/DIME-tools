<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xsl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<template name="options">
		<variable name="optionsGUI" select="doc('../../options/options.xml')//id('extractPartVoice')/dme:parameters"/>

		<map>
			<map-entry key="'voices'" select="
					let $entries := for $p in $optionsGUI/dme:parameter/data()
					return
						string($p)
					return
						'|' || string-join($entries, '|') || '|'"/>
		</map>
	</template>



</stylesheet>
