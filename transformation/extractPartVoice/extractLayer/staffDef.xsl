<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	

	<xsl:variable name="stafDefN" select="dme:findStaff('layer') (:the mode layer returns staves numbers where a layer will be extracted:)"/>
	<xd:doc>
		<xd:desc>
			<xd:p>Matches only the staves where a layer should be extracted.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="scoreDef[not(ancestor::app)]//staffDef[@n = $stafDefN]" name="staffDef">

		<xsl:copy>
			<xsl:apply-templates select="@*"/>

			<xsl:variable name="layerN" select="map:get(dme:staff-layer_map(), current()/@n)"/>

			<label xmlns="http://www.music-encoding.org/ns/mei">
				<xsl:attribute name="xml:id" select="label/@xml:id"/>

				<xsl:call-template name="label">
					<xsl:with-param name="layerDef" select="layerDef[@n = $layerN]"/>
				</xsl:call-template>
			</label>
		</xsl:copy>

	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Returns a new label, e.g. 'Clarinetto I'</xd:p>
		</xd:desc>
		<xd:param name="layerDef"/>
	</xd:doc>
	<xsl:template name="label">
		<xsl:param name="layerDef"/>

		<xsl:variable name="codedval" select="id(substring-after($layerDef/@decls, '#'))/@codedval"/>
		<xsl:variable name="name" select="doc('../lib/lists.xml')/id($codedval)/dme:name[@xml:lang = 'IT']/data()"/>
		<xsl:value-of select="concat($name, ' ', dme:voiceNumber($layerDef/@n))"/>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Returns the number of the instrument, e.g. 'I' in 'Clarinetto I'.</xd:p>
		</xd:desc>
		<xd:param name="n"/>
	</xd:doc>
	<xsl:function name="dme:voiceNumber">
		<xsl:param name="n"/>
		<xsl:variable as="map(xs:string, xs:string)?" name="RomanIntegers">
			<xsl:map>
				<xsl:map-entry key="'1'" select="'I'"/>
				<xsl:map-entry key="'2'" select="'II'"/>
				<xsl:map-entry key="'3'" select="'III'"/>
				<xsl:map-entry key="'4'" select="'IV'"/>
			</xsl:map>
		</xsl:variable>

		<xsl:value-of select="map:get($RomanIntegers, $n)"/>
	</xsl:function>


</xsl:stylesheet>
