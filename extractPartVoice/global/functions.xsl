<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xd:doc>
		<xd:desc>
			<xd:p>Used only in the context of the layer extraction</xd:p>
			<xd:p>Expected syntax for $voices is |{staffNumber}.{layerNumber}|. Multiple entries are possible.</xd:p>
		</xd:desc>
		<xd:param name="mode">Values: <xd:ul>
			<xd:li>staff: returns staff number(s) where the whole staff is required, e.g. |5|</xd:li>
			<xd:li>layer: returns staff number(s) where a layer is required, e. g. {|5.1| => '5'}</xd:li>
			<xd:li>all: both cases</xd:li>
		</xd:ul></xd:param>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:findStaff">
		<xsl:param name="mode"/>
		
		<!--example value: "1", "2.2"-->
		<xsl:variable name="voicesInput" select="
			for $n in
			tokenize($voices, '\|')
			return
			if ($n != '') then
			$n
			else
			()"/>
		
		<xsl:for-each select="$voicesInput">
			<xsl:choose>
				<xsl:when test="$mode = 'staff'">
					<!-- only those which do not have dot: e.g. |5| not |5.1|-->
					<xsl:if test="not(contains(., '.'))">
						<xsl:sequence select="."/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$mode = 'layer'">
					<!-- only those which do have dot: e.g. |5.1| and not |5| -->
					<xsl:if test="contains(., '.')">
						<xsl:sequence select="substring-before(., '.')"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$mode = 'all'">
					<xsl:sequence select="functx:substring-before-if-contains(., '.')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		
	</xsl:function>
	
	<!--<xsl:function name="dme:voicesInput">

		<xsl:sequence select="
				for $n in
				tokenize($voices, '\|')
				return
					if ($n != '') then
						$n
					else
						()"> </xsl:sequence>

	</xsl:function>-->
	<xd:doc>
		<xd:desc>
			<xd:p>Maps the @n-attribute of staves and their respective layer which are required in the input. </xd:p>
			<xd:p>Let's consider the input |2.1|3|. The map will contain then the key '2' (staff/@n) and the value '1' (layer/@n), the value '3' is omitted as no layer is required to be extracted. </xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:function name="dme:staff-layer_map">
		<xsl:variable as="map(xs:string, xs:string)?" name="staff-layer_map">
			<xsl:map>
				<xsl:choose>
					<xsl:when test="contains($voices, '.')">
						<xsl:for-each select="
							for $n in
							tokenize($voices, '\|')
							return
							if ($n != '') then
							$n
							else
							()">
							<xsl:if test="contains(., '.')">
								<xsl:map-entry key="substring-before(., '.')" select="substring-after(., '.')"/>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:map>
		</xsl:variable>
		<xsl:copy-of select="$staff-layer_map"/>
	</xsl:function>
	
	
	<xd:doc>
		<xd:desc>Processes the input: {'|2.1|3|4.2|' => '|2|3|4|'}. Needed to exclude staves from deletion</xd:desc>
	</xd:doc>
	<xsl:function name="dme:voicesTok">
		<xsl:choose>
			<xsl:when test="contains($voices, '.')">
				<xsl:value-of select="concat('|', string-join(dme:findStaff('all'), '|'), '|')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$voices"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	
</xsl:stylesheet>
