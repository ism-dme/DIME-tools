<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei math uuid dme os" extension-element-prefixes="exsl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:exsl="http://exslt.org/common" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:os="namespace_OleksiiSapov" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description:</xd:b>
				<xd:i>This stylesheet prepares a 'dmeref'-file for the editing:</xd:i>
				<xd:ul>
					<xd:li>
						<xd:b>Extracts</xd:b>
						<xd:ul>
							<xd:li>The values from &lt;corr>, &lt;lem>, &lt;supplied>, &lt;body>//&lt;rend>, &lt;body>//&lt;ref></xd:li>
						</xd:ul>
					</xd:li>
					<xd:li><xd:b>Deletes</xd:b>: <xd:ul>
							<xd:li>All &lt;pb>, &lt;sb>, &lt;surface>, &lt;body>//&lt;annot></xd:li>
							<xd:li>All @doxml.id, &lt;measure>/@facs</xd:li>
							<xd:li>Elements which point to an element in &lt;orig&gt;/&lt;rdg&gt;, e.g. &lt;slur&gt;</xd:li>
						</xd:ul>
					</xd:li>
					<xd:li>&lt;meiHead&gt; is replaced by a minimal one</xd:li>
					<xd:li><xd:b>Adds</xd:b>:<xd:ul>
							<xd:li>A suffix to all @xml:id's and its references in &lt;body&gt;, e.g. xml:id='note_123' becomes 'note_123-B1'</xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:i>Notes for applying the transformation:</xd:i>
				<xd:ul>
					<xd:li>The stylesheet is meant to be applied on a 'dmeref'-file, the output will be a 'dmeedt' file in the same repository</xd:li>
					<xd:li>@xml:id's in 'dmeref' should not contain '-'. If any exist, a message will prompt and these @xml:id's as well as their references should be checked manually.</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>13.07.2018, version 1.0<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>17.08.2018: <xd:i>1.0.1</xd:i></xd:li>
							<xd:li>22.10.2018: <xd:i>1.0.2</xd:i></xd:li>
							<xd:li>12.04.2019: <xd:i>1.0.3</xd:i></xd:li>
							<xd:li>26.08.2019: <xd:i>1.0.4</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:param name="fileName"/>
	<xsl:param name="editionType"/>

	<xsl:variable name="newFileName" select="replace($fileName, 'dmeref', concat('dmeedt', $editionType))"/>

	<xsl:include href="included/del_NMA-spirit.xsl"/>
	<xsl:include href="included/add_suffixes.xsl"/>


	<xd:doc>
		<xd:desc>Processes the current document-node() with various modes.</xd:desc>
	</xd:doc>
	<xsl:template match="/">

		<xsl:variable name="del_NMA-spirit">
			<xsl:apply-templates mode="del_NMA-spirit" select="."/>
		</xsl:variable>

		<xsl:variable name="output">
			<xsl:apply-templates mode="add_suffixes" select="$del_NMA-spirit"/>
		</xsl:variable>

		<xsl:variable name="outputFIle" select="$newFileName"/>
		<xsl:result-document href="{$outputFIle}" indent="yes">
			<xsl:copy-of select="$output"/>
		</xsl:result-document>

	</xsl:template>


	<xd:doc>
		<xd:desc>Identity transform</xd:desc>
	</xd:doc>
	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="node() | @*"/>
		</xsl:copy>
	</xsl:template>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:strip-space elements="*"/>
</xsl:stylesheet>
