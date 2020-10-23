<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xd:doc>
		<xd:desc>
			<xd:p>If there are more than on new reference, the template cloneNode_startid is called. Otherwise, the current @startid is updated</xd:p>
		</xd:desc>
		<xd:param name="refs"/>
		<xd:param name="pointers"/>
	</xd:doc>
	<xsl:template name="startid">
		<xsl:param name="refs" tunnel="yes"/>
		<xsl:param name="pointers" tunnel="yes"/>

		<xsl:variable name="vals" select="
				let $entry := map:get($refs, $pointers)
				return
					tokenize($entry, ',')"/>
		<xsl:variable name="countVals" select="count($vals)"/>

		<xsl:choose>
			<xsl:when test="$countVals > 1 (:if more than one new reference for at least one pointer exists:)">
				<xsl:variable name="El" select="."/>
				<xsl:for-each select="1 to $countVals">
					<xsl:call-template name="cloneNode_startid">
						<xsl:with-param name="El" select="$El"/>
						<xsl:with-param name="counter" select="." tunnel="yes"/>
						<xsl:with-param name="countValsStartid" select="$countVals" tunnel="yes"/>
						<xsl:with-param name="vals" select="$vals"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<!--if only one value for each pointer exists-->
			<xsl:otherwise>
				<xsl:call-template name="oneNewRefVal"/>											
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
	
	

	<xd:doc>
		<xd:desc>
			<xd:p>It is a recursive template. Current node ($El) is copied. The @xml:id is updated with suffix derived from $counter. The values for @startid are updated. Other attributes are processed with the template copyWithoutNodeUpdateID. If the $El has child nodes they will be processed in the same way</xd:p>
		</xd:desc>
		<xd:param name="El"/>
		<xd:param name="counter"/>
		<xd:param name="refs"/>
		<xd:param name="vals"/>	
	</xd:doc>
	<xsl:template name="cloneNode_startid">
		<xsl:param name="El"/>
		<xsl:param name="vals"/>
		<xsl:param name="counter" tunnel="yes"/>
		<xsl:param name="refs" tunnel="yes"/>

		<xsl:for-each select="$El">
			<xsl:copy>

				<xsl:call-template name="copyWithoutNodeUpdateID">
					<xsl:with-param name="counter" select="$counter"/>
				</xsl:call-template>

				<xsl:choose>
					<xsl:when test="empty($vals) (:no referenced @xml:id is found:)">
						<xsl:attribute name="tstamp" select="
								let $currRefNode := substring-after(@startid, '#')
								return
									ancestor::music/id($currRefNode)/@tstamp"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="@startid">
							<xsl:attribute name="startid" select="'#' || $vals[$counter]"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="node()">
					<xsl:call-template name="cloneNode_startid">
						<xsl:with-param name="El" select="node()"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:copy>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
