<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="iso map dme xs xd xsl schematron sqf" version="3.0" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:schematron="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable as="map(xs:string, xs:string)" name="config">
		<xsl:variable name="configXML" select="doc('config.xml')"/>
		<xsl:map>
			<xsl:map-entry key="'rulesFolderPath'" select="$configXML//dme:rulesFolderPath/string(text())"/>
			<xsl:map-entry key="'publishBaseURL'" select="$configXML//dme:publishBaseURL/string(text())"/>
		</xsl:map>
	</xsl:variable>


	<xsl:variable name="libraryPath" select="map:get($config, 'rulesFolderPath') || 'library.sch'"/>
	<xsl:variable name="quickFixLibPath" select="map:get($config, 'rulesFolderPath') || 'quickFix-library.xml'"/>
	<xsl:variable name="uniqueRulesPath" select="map:get($config, 'rulesFolderPath') || 'unique_rules.sch'"/>
	<xsl:variable name="mainPath" select="map:get($config, 'rulesFolderPath') || 'main.sch'"/>
	
	

	<xsl:variable name="base" select="resolve-uri('.', base-uri(/))"/>
</xsl:stylesheet>
