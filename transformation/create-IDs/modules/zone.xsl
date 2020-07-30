<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">$all</xd:param>
		<xd:param name="arg2">$els2apply</xd:param>
		<xd:param name="arg3">$els2exclude</xd:param>
	</xd:doc>
	<xsl:template match="zone" mode="zone" >
		<xsl:param name="arg1" tunnel="yes"/>
		<xsl:param name="arg2" tunnel="yes"/>
		<xsl:param name="arg3" tunnel="yes"/>
		
		<xsl:copy>
			<xsl:choose>
				
				<xsl:when test="($arg1 = '1' or local-name() = $arg2) and not(local-name() = $arg3)">
					<xsl:variable as="xs:string" name="newID">
						<xsl:call-template name="newID"/>
					</xsl:variable>
					
					<xsl:attribute name="xml:id">
						<xsl:value-of select="$newID"/>
					</xsl:attribute>					
					<xsl:call-template name="oldID"/>							
					<xsl:apply-templates mode="#current" select="@* except (@xml:id, node())"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="#current" select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:copy>
	</xsl:template>


</xsl:stylesheet>
