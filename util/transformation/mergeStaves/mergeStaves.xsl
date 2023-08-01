<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description:</xd:b>
				<xd:i>Used for the cases when e.g. cellos and contrabasses are sometimes on one staff and sometimes on two staves. The editor defines the numbers of the staves (called as staff_min and staff_max).</xd:i>
				<xd:ul>The transformation does: <xd:li>Merges the staff_max into trhe staff_min.</xd:li>
					<xd:li>Edits @dme.parts, e.g. @dme.parts="10" to @dme.parts="10,11".</xd:li>
					<xd:li>If there is mRest in both layers, adds @sameas for the second layer.</xd:li>
					<xd:li>If there is no staff_max in the measure, a second layer with @sameas is inserted.</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>06, June 2019<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>06.06.2019 : <xd:i>1.0.0</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>

	<xsl:include href="../lib/applicationChangesLog.xsl"/>

	<xsl:variable name="parameters" select="doc('../options/options.xml')//id('mergeStaves')/dme:parameters"/>
	<xsl:variable name="file" select="$parameters//dme:file/@file"/>
	<xsl:variable name="staff_min" select="$parameters//id('staff_min')/string(text())"/>
	<xsl:variable name="staff_max" select="$parameters//id('staff_max')/string(text())"/>


	<xsl:variable name="inputBaseURI" select="base-uri($file)"/>
	<xsl:variable name="processedFile" select="resolve-uri($file, $inputBaseURI)"/>
	<xsl:variable name="process">
		<xsl:apply-templates mode="process" select="doc($processedFile)"/>
	</xsl:variable>

	<xsl:variable name="output">
		<xsl:apply-templates mode="applicationChanges" select="$process"/>
	</xsl:variable>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="/">

		<xsl:call-template name="copy-and-format_DIME-tools"/>

		<!--<xsl:result-document href="{replace($processedFile, '.xml', '_1.xml')}" indent="yes" method="xml">-->
		<xsl:copy-of select="$output"/>
		<!--</xsl:result-document>-->
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staff[@n = $staff_min]" mode="process">
		<!--		tests if there is a staff to be merged in this measure-->
		<xsl:variable name="mergedStaff" select="ancestor::measure//staff[@n = $staff_max]"/>
		<xsl:choose>
			<xsl:when test="$mergedStaff">
				<xsl:call-template name="mergeStaves">
					<xsl:with-param name="arg1" select="$mergedStaff"/>
				</xsl:call-template>
			</xsl:when>
			<!--			if there is not staff_max and there is no second layer already-->
			<xsl:when test="not(layer[@n = 2])">
				<xsl:call-template name="secondLayer">
					<xsl:with-param name="arg1" select="@dme.parts (:native @dme.parts:)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="copy"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">mergedStaff</xd:param>
	</xd:doc>
	<xsl:template name="mergeStaves">
		<xsl:param name="arg1"/>

		<xsl:variable name="dmeParts" select="concat(@dme.parts, ',', $arg1/@dme.parts)"/>

		<xsl:choose>
			<xsl:when test="descendant::mRest and $arg1">
				<xsl:call-template name="secondLayer">
					<xsl:with-param name="arg1" select="$dmeParts"/>
				</xsl:call-template>
			</xsl:when>
			<!--			copies the current layer and inserts the layer from the staff_max-->
			<xsl:otherwise>
				<xsl:copy>
					<xsl:attribute name="dme.parts" select="$dmeParts"/>
					<xsl:apply-templates select="@* except @dme.parts, node()"/>
					<xsl:apply-templates select="$arg1/layer"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc>Changes @n of the second layer to 2.</xd:desc>
	</xd:doc>
	<xsl:template match="staff[@n = $staff_max]/layer">
		<xsl:copy>
			<xsl:attribute name="n" select="2"/>
			<xsl:apply-templates select="@* except @n, node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staff[@n = $staff_max]"/>

	<xd:doc>
		<xd:desc>Copies the current layer and adds second layer with @sameas</xd:desc>
		<xd:param name="arg1">dmeParts</xd:param>
	</xd:doc>
	<xsl:template name="secondLayer">
		<xsl:param name="arg1"/>

		<xsl:copy>
			<xsl:attribute name="dme.parts" select="$arg1"/>
			<xsl:apply-templates select="@* except @dme.parts, node()"/>
			<xsl:variable as="xs:string" name="ID" select="layer/@xml:id"/>
			<layer xmlns="http://www.music-encoding.org/ns/mei">
				<xsl:attribute name="xml:id" select="concat($ID, 'b')"/>
				<xsl:attribute name="n" select="xs:integer(2)"/>
				<xsl:attribute name="sameas" select="concat('#', $ID)"/>
			</layer>
		</xsl:copy>
	</xsl:template>

	<xsl:variable name="currentStylesheet" select="doc('')"/>
</xsl:stylesheet>
