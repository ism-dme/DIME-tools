<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc>
		<xd:desc>Adds temporary IDs which are needed for further computation.</xd:desc>
	</xd:doc>
	<template match="mdiv | score | section | scoreDef" mode="prepareIDs">
		<copy>
			<attribute name="xml:id">
				<value-of select="generate-id()"/>
			</attribute>
			<apply-templates mode="#current" select="@*, node()"/>
		</copy>
	</template>
</stylesheet>