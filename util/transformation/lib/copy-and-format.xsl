<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b>05 Feb, 2019</xd:p>
			<xd:p><xd:b>Author:</xd:b>Oleksii Sapov</xd:p>
			<xd:p>includes identity transform, writes the formatted file (for comparison), strip-space, output</xd:p>
		</xd:desc>
	</xd:doc>
	
	
	
	
	<xsl:param as="xs:string" name="fileURI"/>
	<xsl:variable as="xs:string" name="file.name" select="tokenize($fileURI, '/')[last()]"/>
	<xsl:variable name="kvMovement" select="
		translate(substring-before(substring-after($file.name, '_'),
		'_'), '-', '')"/>
	
	<!--<xsl:variable as="document-node()" name="lists" select="doc('../lib/lists.xml')"/>-->
	
	<xd:doc>
		<xd:desc>Writes an intermediate file for better diff comparison.</xd:desc>
		<xd:param name="doc-node"/>
	</xd:doc>
	<xsl:template name="copy-and-format">		
		<xsl:param name="doc-node" select="." />					
		<xsl:result-document href="{concat($file.name, '_0', '.xml')}" indent="yes" method="xml">
			<xsl:copy-of select="$doc-node"/>
		</xsl:result-document>                                                                                                                     
	</xsl:template>
	

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*" mode="#current"/>
		</xsl:copy>		
	</xsl:template>
	
	<xsl:strip-space elements="*"/>
	<xsl:output indent="yes" encoding="UTF-8" method="xml"/>
</xsl:stylesheet>
	
