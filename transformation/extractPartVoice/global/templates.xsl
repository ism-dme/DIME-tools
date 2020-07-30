<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staffDef[string-length($voices) > 0 and not(contains(dme:voicesTok(), concat('|', @n, '|')))]"/>

	<xsl:variable as="xs:boolean" name="allTrue">
		<xsl:variable name="voicesInput" select="
				for $n in
				tokenize($voices, '\|')
				return
					if ($n != '') then
						$n
					else
						()"/>

		<xsl:variable as="xs:integer*" name="maxStaffDef">
			<xsl:variable as="xs:integer*" name="temp">
				<xsl:sequence select="
						for $x in //scoreDef
						return
							count($x//staffDef)"/>
			</xsl:variable>
			<xsl:sequence select="max($temp)"/>
		</xsl:variable>
		<xsl:copy-of select="boolean(count($voicesInput) = $maxStaffDef)"/>
	</xsl:variable>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="sb[string-length($voices) > 0 and not(contains($voices, concat('|', @n, '|')))]">
		<xsl:if test="$allTrue">
			<xsl:copy>
				<xsl:apply-templates select="@*"/>
			</xsl:copy>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="pb[string-length($voices) > 0 and not(contains($voices, concat('|', @n, '|')))]">
		<xsl:if test="$allTrue">
			<xsl:copy>
				<xsl:apply-templates select="@*"/>
			</xsl:copy>
		</xsl:if>
	</xsl:template>


	<xd:doc>
		<xd:desc>Replaces the tempo/@staff value to the minimal of the current displayed.</xd:desc>
	</xd:doc>
	<xsl:template match="body//tempo">
		<xsl:copy>
			<xsl:attribute name="staff" select="min(dme:findStaff('all'))"/>
			<xsl:apply-templates select="@* except @staff, node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Enables the fermata to be displayed.</xd:p>
			<xd:p>There exist different encoding cases: <xd:ul>
					<xd:li><xd:b>1</xd:b>: There exist two fermatas, attached two the first and the last staves but they apply for all staves. If a voice inbetween is extracted, the @staff should be adjusted. It relies on that if @place is present and on its value. If there is only one voice, only one fermata is copied and adjusted, otherwise, there are two fermatas.</xd:li>
					<xd:li><xd:b>2</xd:b>: There exist fermatas for each voice explicitly. They should be just copied then.</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="body//fermata" priority="1">
		<xsl:variable name="allStaves" select="dme:findStaff('all')"/>

		<xsl:copy>
			<xsl:choose>
				<xsl:when test="@place[. = 'above']">
					<xsl:attribute name="staff" select="min($allStaves)"/>
					<xsl:apply-templates select="@* except @staff, node()"/>
				</xsl:when>
				<xsl:when test="@place[. = 'below'] and count($allStaves) > 1">
					<xsl:attribute name="staff" select="max($allStaves)"/>
					<xsl:apply-templates select="@* except @staff, node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>

	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staff[@n = dme:findStaff('layer')]//@ploc | staff[@n = dme:findStaff('layer')]//@oloc | staff[@n = dme:findStaff('layer')]//@stem.dir | staff[@n = dme:findStaff('layer')]//@stem.sameas"/>

	<xd:doc>
		<xd:desc/>
		<xd:param name="id"/>
	</xd:doc>
	<xsl:template name="getListItems">
		<xsl:param as="xs:string" name="id"/>
		<xsl:copy-of select="doc('../lib/lists.xml')/id($id)/dme:item/data()"/>
	</xsl:template>
</xsl:stylesheet>
