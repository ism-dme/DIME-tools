<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<variable as="xs:string*" name="checkAccidentalsVisibility">
		<variable name="extractMainVersion">
			<apply-templates mode="extractMainVersion" select="."/>
		</variable>
		<apply-templates mode="checkAccidentalsVisibility" select="$extractMainVersion//@accid"/>
	</variable>
	


	<xd:doc>
		<xd:desc>Changes @accid to @accid.ges in the elements which were calculated in the variable checkAccidentalsVisibility.</xd:desc>
	</xd:doc>
	<template match="id($checkAccidentalsVisibility)" mode="changeAccid">		
		<copy>
			<attribute name="accid.ges" select="@accid"/>
			<apply-templates mode="#current" select="@* except @accid, node()"/>
		</copy>
	</template>
</stylesheet>
