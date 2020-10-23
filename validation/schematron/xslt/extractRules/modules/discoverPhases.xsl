<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="iso map dme xs xd xsl schematron sqf" version="3.0" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:schematron="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable as="xs:string*" name="phases" select="dme:discover-phases(//*[@props = 'rules'])"/>

	<xsl:function as="xs:string*" name="dme:discover-phases">
		<xsl:param as="element()*" name="topicref"/>

		<xsl:variable as="xs:string*" name="allPhasesValues">
			<xsl:for-each select="$topicref">
				<xsl:for-each select="document(@href, .)//dlentry[dt/text() = 'phase']//dd/text()/normalize-space()">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable as="xs:string*" name="allPhasesTokenized" select="
				for $n in $allPhasesValues
				return
					tokenize($n, ',')"/>
		<xsl:variable as="xs:string*" name="allPhasesNormalized" select="
				for $n in $allPhasesTokenized
				return
					normalize-space($n)"/>

		<xsl:variable name="distinctPhases" select="distinct-values($allPhasesNormalized)"/>
		<xsl:copy-of select="$distinctPhases"/>
	</xsl:function>
</xsl:stylesheet>
