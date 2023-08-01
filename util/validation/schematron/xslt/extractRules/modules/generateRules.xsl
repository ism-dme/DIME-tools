<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="iso map dme xs xd xsl schematron sqf" version="3.0" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:schematron="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="*[@props = 'rules']" mode="rules">
		<xsl:apply-templates mode="rules" select="document(@href, .)"/>
		<xsl:apply-templates mode="rules"/>
	</xsl:template>
	
	<xsl:template match="dl[ancestor-or-self::*[@audience = 'rules']]" mode="rules">
		<xsl:apply-templates mode="instantiate" select="."/>
	</xsl:template>
	
<!--	<xsl:template match="*" mode="rules">
		<xsl:apply-templates mode="rules"/>
	</xsl:template>-->
	
	<xsl:template match="text()" mode="rules"/>
	
	<xsl:template match="dl" mode="instantiate">
		<xsl:variable name="origin" select="substring-after(base-uri(.), $base)"/>
		<xsl:variable name="target">
			<xsl:value-of select="map:get($config, 'publishBaseURL')"/>
			<xsl:value-of select="replace($origin, '.dita', '.html')"/>
		</xsl:variable>
		
		<xsl:comment>Generated from <xsl:value-of select="$origin"/>.</xsl:comment>
		<pattern id="{dme:generate-patternID(., $origin)}" is-a="{dlhead/ddhd}" see="{$target}">
			<xsl:apply-templates mode="instantiate"/>
		</pattern>
	</xsl:template>
	
	<xsl:template match="dlentry" mode="instantiate">
		<!--<xsl:variable name="ap">'</xsl:variable>
		<xsl:variable name="doubleap">''</xsl:variable>-->
		<!--replace(dd, $ap, $doubleap)-->
		<param name="{dt}" value="{dme:generateValues(dd)}"/>
	</xsl:template>
	<xsl:template match="text()" mode="instantiate"/>
	
	<!-- generate include instuctions for all abstract patterns from the library -->
	<xsl:template match="text()" mode="generateIncludes"/>
	<xsl:template match="iso:pattern[@abstract = 'true']" mode="generateIncludes">
		<include href="library.sch#{@id}"/>
	</xsl:template>
	
	<xsl:function as="xs:string" name="dme:generateValues">
		<xsl:param as="node()" name="dd"/>
		<xsl:choose>
			<xsl:when test="$dd[not(ol)]">
				<xsl:value-of select="$dd"/>
			</xsl:when>
			<xsl:when test="$dd[ol]">
				<xsl:variable as="xs:string*" name="listItems">
					<xsl:for-each select="$dd//li">
						<xsl:choose>
							<xsl:when test="b/following-sibling::node()/normalize-space() != ''">
								<xsl:value-of select="concat(b, '[[', b/following-sibling::node()/normalize-space(), ']]')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(b, '[[', ']]')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:variable>
				<xsl:value-of select="string-join(($listItems), '---')"/>
			</xsl:when>
		</xsl:choose>
	</xsl:function>
</xsl:stylesheet>