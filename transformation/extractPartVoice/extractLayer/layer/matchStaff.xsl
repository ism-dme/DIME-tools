<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xsl:include href="layer.xsl"/>

	<xsl:variable name="staffN" select="dme:findStaff('layer')"/>
	<xd:doc>
		<xd:desc>Matches the staff, from which the layer should be extracted.</xd:desc>
	</xd:doc>
	<xsl:template match="staff[@n = $staffN]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>

			<!--the instruction is envoked only if there exist an app and vice versa the other apply-templates works only if layer is a child, which is not possible when app wraps a layer. Special case for K. 550-->

			<xsl:if test="app">
				<xsl:call-template name="versionsCase">
					<xsl:with-param name="staffN" select="@n"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:apply-templates mode="layer" select="layer[@n = map:get(dme:staff-layer_map(), current()/@n)]"/>
		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="staffN"/>
	</xd:doc>
	<xsl:template name="versionsCase">
		<xsl:param name="staffN"/>

		<xsl:variable name="IDsecondPart" select="substring-after(@xml:id, '_')"/>
		<app xmlns="http://www.music-encoding.org/ns/mei">
			<!--<xsl:attribute name="xml:id" select="'app_' || $IDsecondPart"/>-->
			<xsl:apply-templates select="app/@*"/>
			<xsl:variable name="currApp" select="app"/>

			<!--Just if app would have more variants-->
			<xsl:for-each select="1 to count($currApp/child::*)">
				<xsl:variable name="counter" select=". cast as xs:integer"/>
				<xsl:variable name="child" select="($currApp/child::*)[$counter]"/>
				<xsl:element name="{$child/name()}">
					<xsl:apply-templates select="$child/@*"/>
					<xsl:apply-templates mode="layer" select="$child/layer[@n = map:get(dme:staff-layer_map(), $staffN)]"/>
				</xsl:element>
			</xsl:for-each>
		</app>

	</xsl:template>


</xsl:stylesheet>
