<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xsl:variable name="dynam_1">cre</xsl:variable>
	<xsl:variable name="dynam_2">scen</xsl:variable>
	<xsl:variable name="dynam_3">do</xsl:variable>
	<xsl:variable name="dynam_4">scendo</xsl:variable>
	<xsl:variable name="dynam_5">crescen</xsl:variable>
	<xsl:variable name="label">crescendo</xsl:variable>
	<xsl:variable name="extender">true</xsl:variable>
	<xsl:variable name="vgrp" select="xs:integer('1')"/>
	<xsl:variable name="excludeAncestors" select="'orig', 'rdg'"/>

	<xd:doc>
		<xd:desc>Matches all &lt;dynam>'s, checks its content and the content of next/previous &lt;dynam>'s</xd:desc>
	</xd:doc>
	<xsl:template match="
			dynam[not(some $n in ('orig', 'rdg')
				satisfies ancestor::node()/local-name() = $n)]" mode="splitDynams">
		<xsl:variable name="staff" select="@staff"/>
		<xsl:variable name="precDynam" select="
				preceding::dynam[@staff = $staff and @tstamp ][1]"/>
		<xsl:variable name="follDynam" select="
		  following::dynam[@staff = $staff and @tstamp][1]"/>

		<xsl:choose>
			<!--if current  is 'cre'-->
			<xsl:when test=".[(text() = $dynam_1) and ($follDynam/text() = $dynam_4) or ($follDynam/text() = $dynam_2)]">	
				<xsl:call-template name="copyAddAttr">
					<xsl:with-param name="extender" select="$extender"/>
					<xsl:with-param name="next" select="concat('#', $follDynam/@xml:id)"/>
				</xsl:call-template>
			</xsl:when>

			<!--if the current is 'scen' and next is  'do'-->
			<xsl:when test=".[(text() = $dynam_2) and ($follDynam/text() = $dynam_3)]">	
				<xsl:call-template name="copyAddAttr">
					<xsl:with-param name="extender" select="$extender"/>
					<xsl:with-param name="next" select="concat('#', $follDynam/@xml:id)"/>
					<xsl:with-param name="prev" select="concat('#', $precDynam/@xml:id)"/>
				</xsl:call-template>
			</xsl:when>

			<!-- if current is 'do' and previous text is 'scen' or 'crescen'-->
			<xsl:when test=".[(text() = $dynam_3) and (($precDynam/text() = $dynam_2) or ($precDynam/text() = $dynam_5))]">	
				<xsl:call-template name="copyAddAttr">
					<xsl:with-param name="prev" select="concat('#', $precDynam/@xml:id)"/>
				</xsl:call-template>
			</xsl:when>

			<!-- if current is 'scendo' and previous is  'cre'-->
			<xsl:when test=".[(text() = $dynam_4) and ($precDynam/text() = $dynam_1)]">
				<xsl:call-template name="copyAddAttr">
					<xsl:with-param name="prev" select="concat('#', $precDynam/@xml:id)"/>
				</xsl:call-template>
			</xsl:when>

			<!-- if current is 'crescen' and next is  'do'-->
			<xsl:when test=".[(text() = $dynam_5) and ($follDynam/text() = $dynam_3)]">
				<xsl:call-template name="copyAddAttr">
					<xsl:with-param name="extender" select="$extender"/>
					<xsl:with-param name="next" select="concat('#', $follDynam/@xml:id)"/>					
				</xsl:call-template>
			</xsl:when>
			<!--copies all others -->
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates mode="#current" select="node() | @*"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="prev"/>
		<xd:param name="next"/>
		<xd:param name="extender"/>
	</xd:doc>
	<xsl:template name="copyAddAttr">
		<xsl:param name="prev" select="'None'" as="xs:string"/>
		<xsl:param name="next" select="'None'" as="xs:string"/>
		<xsl:param name="extender" select="'None'" as="xs:string"/>
		
		<xsl:copy>			
			<xsl:if test="$extender != 'None'">
				<xsl:attribute name="extender" select="$extender"/>
			</xsl:if>
			<xsl:attribute name="label" select="$label"/>
			<xsl:if test="$next != 'None'">
				<xsl:attribute name="next" select="$next"/>
			</xsl:if>
			<xsl:if test="$prev != 'None'">
				<xsl:attribute name="prev" select="$prev"/>
			</xsl:if>
			<xsl:attribute name="vgrp" select="$vgrp"/>
			<xsl:apply-templates mode="#current" select="@* except (@extender, @vgrp, @next, @prev), node()"/>
		</xsl:copy>

	</xsl:template>
</xsl:stylesheet>
