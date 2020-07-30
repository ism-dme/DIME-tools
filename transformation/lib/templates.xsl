<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b>05 Feb, 2019</xd:p>
			<xd:p><xd:b>Author:</xd:b>Oleksii Sapov</xd:p>
			<xd:p>Templates library.</xd:p>
		</xd:desc>
	</xd:doc>


	<xd:doc>
		<xd:desc/>
		<xd:param name="id"/>
	</xd:doc>
	<xsl:template name="getListItems">
		<xsl:param as="xs:string" name="id"/>
		<xsl:copy-of select="doc('lists/lists.xml')/id($id)/dme:item/data()"/>
	</xsl:template>


	<xd:doc>
		<xd:desc>Writes an intermediate file for better diff comparison.</xd:desc>
		<xd:param name="doc-node"/>
		<xd:param name="fileName"/>
	</xd:doc>
	<xsl:template name="copy-and-format">
		<xsl:param name="doc-node" select="."/>
		<xsl:param name="fileName" select="."/>
		<xsl:result-document href="{concat($fileName, '_0', '.xml')}" indent="yes" method="xml">
			<xsl:copy-of select="$doc-node"/>
		</xsl:result-document>
	</xsl:template>



	<xd:doc>
		<xd:desc><![CDATA[
			<xsl:variable name="id">
			<xsl:call-template name="id"/>
		</xsl:variable>
		]]>
		</xd:desc>
	</xd:doc>
	<xsl:template name="id">
		<xsl:variable as="xs:string" name="uniqueID">
			<xsl:value-of select="xs:integer(substring-after(generate-id(), 'e')) * 6"/>
		</xsl:variable>
		<xsl:value-of select="concat(local-name(), '_', $uniqueID)"/>
	</xsl:template>

	<!--	<xd:doc>
		<xd:desc>slur, tie, etc. with no supplied, app etc.</xd:desc>
	</xd:doc>
	<xsl:template match="measure//*[not(ancestor::node()[ancestor::measure])]" name="controlEventsNoAncestorsBeforeMeasure" >
		
	</xsl:template>
	
	<xd:doc>
		<xd:desc>supplied, app, etc. which do have slur etc.</xd:desc>
	</xd:doc>
	<xsl:template match="measure/*[descendant::node()[@staff]]" name="controlEventsWithAncestorsBeforeMeasure">
		
	</xsl:template>
	-->



</xsl:stylesheet>
