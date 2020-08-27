<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="iso map dme xs xd xsl schematron sqf" version="3.0" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:schematron="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


	<xd:doc>
		<xd:desc>Generates the &lt;phase&gt; with child elements &lt;active&gt;. Which contains links to the rules instances.</xd:desc>
		<xd:param name="phases"/>
		<xd:param name="docNode"/>
		<xd:param name="unique_rules"/>
	</xd:doc>
	<xsl:template name="generatePhases">
		<xsl:param name="phases"/>
		<xsl:param as="document-node()" name="docNode"/>
		<xsl:param name="unique_rules"/>

		<xsl:for-each select="$phases">
			<phase id="{.}">
				<xsl:apply-templates mode="generateActives" select="$docNode">
					<xsl:with-param name="currentPhase" select="." tunnel="yes"/>
				</xsl:apply-templates>
				<xsl:variable name="currPhase" select="."/>
				<xsl:copy-of copy-namespaces="no" select="$unique_rules//schematron:phase[@id = $currPhase]/child::node()"/>
			</phase>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="*[@props = 'rules']" mode="generateActives" name="generateActives">
		<xsl:variable as="element()*" name="matchedElem" select="."/>
		<xsl:apply-templates mode="generateActives" select="document(@href, $matchedElem)"/>
	</xsl:template>

	<xsl:template match="*" mode="generateActives">
		<xsl:apply-templates mode="generateActives"/>
	</xsl:template>

	<xd:doc>
		<xd:desc>Deletes redundant text in the output.</xd:desc>
	</xd:doc>
	<xsl:template match="text()" mode="generateActives"/>


	<xsl:template match="dl" mode="generateActives">
		<xsl:param name="currentPhase" tunnel="yes"/>		
		<xsl:variable as="xs:string" name="referencedPhases" select="dlentry[dt/text() = 'phase']/dd/text()"/>

		<xsl:if test="contains($referencedPhases, $currentPhase)">
			<active pattern="{dme:generate-patternID(.)}"/>
		</xsl:if>
	</xsl:template>


	<xsl:function as="xs:string" name="dme:generate-patternID">
		<xsl:param as="node()" name="node"/>
		<xsl:variable name="topic" select="$node/ancestor::topic/title/text()"/>
		<xsl:variable name="counter" select="count($node/preceding::dl[@audience = 'rules']) + 1"/>
		<xsl:value-of select="concat($topic, '_', $counter)"/>
	</xsl:function>

</xsl:stylesheet>
