<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xsl:template match="appInfo" mode="copyFromOrig">
		<xsl:copy>
			<xsl:apply-templates mode="processOrig" select="$processedFile//meiHead//application"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="application//p" mode="processOrig">
		<xsl:variable name="nodes" select="node()"/>
		<xsl:copy>
			<xsl:for-each select="$nodes">
				<xsl:choose>
					<xsl:when test="(index-of($nodes, .) = 1) and (. instance of text())">
						<xsl:apply-templates mode="#current" select="functx:left-trim(.)"/>
					</xsl:when>
					<xsl:when test="(index-of($nodes, .) = last()) and (. instance of text())">
						<xsl:apply-templates mode="#current" select="functx:right-trim(.)"/>
					</xsl:when>
					<xsl:when test=". instance of element()">
						<xsl:apply-templates mode="applicationEls" select="."/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates mode="#current" select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="id('JoKep')" mode="applicationEls">
		<xsl:copy>
			<xsl:attribute name="authURI" select="'https://d-nb.info/gnd/174032757'"/>
			<xsl:attribute name="authority">GND</xsl:attribute>
			<xsl:attribute name="codedval">174032757</xsl:attribute>
			<xsl:apply-templates mode="#current" select="@xml:id, node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ref[contains(@target, 'edirom.de')]" mode="applicationEls">
		<xsl:copy>
			<xsl:attribute name="target" select="'https://edirom.de'"/>
			<xsl:element name="corpName" xmlns="http://www.music-encoding.org/ns/mei">
				<xsl:attribute name="authURI" select="'https://d-nb.info/gnd/1095564986'"></xsl:attribute>
				<xsl:attribute name="authority">GND</xsl:attribute>

				<xsl:attribute name="codedval">1095564986</xsl:attribute>
				<xsl:text>ViFE</xsl:text>
			</xsl:element>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ref[contains(@target, 'mozarteum.at')]" mode="applicationEls">
		<xsl:copy>
			<xsl:attribute name="target" select="'https://mozarteum.at'"/>
			<xsl:text>Salzburg Mozarteum Foundation</xsl:text>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="id('FKel')" mode="applicationEls">
		<xsl:copy>
			<xsl:attribute name="analog" select="'#FK'"/>
			<xsl:apply-templates mode="#current" select="node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
