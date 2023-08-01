<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei uuid dme" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc>Extracts the content of the main version. E.g. for &lt;app&gt; it would be the &lt;lem&gt;.</xd:desc>
	</xd:doc>
	<template match="body//*[local-name() = map:keys($variantsMap)]" mode="extractMainVersion">
		<variable name="definedVariant" select="map:get($variantsMap, local-name())"/>
		<variable name="containsDefinedVariant" select="descendant::*[local-name() = $definedVariant]"/>
		<choose>
			<when test="$containsDefinedVariant">
				<apply-templates mode="#current" select="$containsDefinedVariant/node()"/>
			</when>
			<otherwise>
				<apply-templates mode="#current" select="child::node()[1]"/>
			</otherwise>
		</choose>
	</template>

	<variable name="variantsMap" select="map{'app': 'lem', 'choice': 'corr'}"/>


</stylesheet>
