<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xd:doc>
		<xd:desc>
			<xd:p>Updates the @startid and @endid.</xd:p>
			<xd:p>If there are multiple new references, clones the current element respectively.</xd:p>
		</xd:desc>
		<xd:param name="refs"/>
	</xd:doc>
	<xsl:template name="startidEndid">
		<xsl:param name="refs" tunnel="yes"/>

		<xsl:variable name="countValsStartid" select="
				let $t := tokenize(map:get($refs, 'startid'), ',')
				return
					count($t)"/>
		<xsl:variable name="countValsEndid" select="
				let $t := tokenize(map:get($refs, 'endid'), ',')
				return
					count($t)"/>

		<xsl:choose>
			<!--if more than one new reference for at least one pointer exists-->
			<xsl:when test="
					let $countVals := sum(($countValsStartid, $countValsEndid))
					return
						$countVals > 2">

				<xsl:variable name="El" select="."/>				
				<xsl:variable as="xs:string*" name="startidEndidPairs">
					<xsl:call-template name="vStartidEndidPairs"/>
				</xsl:variable>
				
				<xsl:for-each select="1 to ($countValsStartid * $countValsEndid)">
					<xsl:call-template name="cloneNode_startidEndid">
						<xsl:with-param name="El" select="$El"/>
						<xsl:with-param name="counter" select="."/>
						<xsl:with-param  name="startidEndidPairs" select="$startidEndidPairs" tunnel="yes"/>
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
			<xd:p>Zipps each new reference of the @startid with each new reference of the @endid</xd:p>
			<xd:p>Return value: sequence of strings. Example: ("note_123,note_456,", "note_123,note_789")</xd:p>
		</xd:desc>
		<xd:param name="startidEndidNewRefs"/>
	</xd:doc>
	<xsl:template name="vStartidEndidPairs">
		<xsl:param as="map(xs:string, xs:string)*" name="refs" tunnel="yes"/>
		<xsl:for-each select="
				let $a := map:get($refs, 'startid')
				return
					tokenize($a, ',')">
			<xsl:variable name="currStartid" select="."/>
			<xsl:for-each select="
					let $a := map:get($refs, 'endid')
					return
						tokenize($a, ',')">
				<xsl:sequence select="string-join(($currStartid, .), ',')"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>



	<xd:doc>
		<xd:desc>
			<xd:p>It is a recursive template. Current node ($El) is copied. The @xml:id is updated with suffix derived from $counter. The values for @startid, @endid are updated. Other attributes are processed with the template copyWithoutNodeUpdateID. If the $El has child nodes they will be processed in the same way</xd:p>
		</xd:desc>
		<xd:param name="startEndIDsPairs"/>
		<xd:param name="El"/>
		<xd:param name="counter"/>
		<xd:param name="startidEndidPairs"/>
	</xd:doc>
	<xsl:template name="cloneNode_startidEndid">
		<xsl:param name="El"/>
		<xsl:param name="counter"/>
		<xsl:param name="startidEndidPairs" tunnel="yes"/>

		<xsl:for-each select="$El">
			<xsl:copy>
				<!--copy all atributes except @startid, @endid, update the @xml:id-->
				<xsl:call-template name="copyWithoutNodeUpdateID">
					<xsl:with-param name="counter" select="$counter"/>
				</xsl:call-template>
				<!--update the pointers-->
				<xsl:variable name="entry" select="$startidEndidPairs[$counter]"/>
				<xsl:variable name="vals" select="tokenize($entry, ',')"/>
				<xsl:if test="@startid">
					<xsl:attribute name="startid" select="'#' || $vals[1]"/>
				</xsl:if>
				<xsl:if test="@endid">
					<xsl:attribute name="endid" select="'#' || $vals[2]"/>
				</xsl:if>

				<xsl:if test="node()">
					<xsl:call-template name="cloneNode_startidEndid">
						<xsl:with-param name="El" select="node()"/>
						<xsl:with-param name="counter" select="$counter"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:copy>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
