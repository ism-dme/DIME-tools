<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="iso map dme xs xd xsl schematron sqf" version="3.0" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:schematron="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="modules/config/config.xsl"/>
	<xsl:include href="modules/discoverPhases.xsl"/>
	<xsl:include href="modules/writeMain.xsl"/>
	<xsl:include href="modules/generatePhases.xsl"/>
	<xsl:include href="../../../../transformation/lib/functions/functx-1.0-doc-2007-01.xsl"/>

	<xsl:variable as="document-node()" name="unique_rules" select="doc($uniqueRulesPath)"/>


	<xsl:template match="/">

		<xsl:result-document indent="yes" href="rules/main.sch">
			<xsl:call-template name="writeMain"/>
		</xsl:result-document>

		<xsl:result-document indent="yes" href="rules/quickFix-library.xml">
			<xsl:copy-of select="doc($libraryPath)//sqf:fixes"/>
		</xsl:result-document>
		
	</xsl:template>


	
</xsl:stylesheet>
