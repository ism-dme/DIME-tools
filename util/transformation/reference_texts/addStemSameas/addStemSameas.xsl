<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description</xd:b>: <xd:i>Adds @stem.sameas to the elements defined in the addStemSameas.dita</xd:i>
			</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>June, 19 2019, version 1.0.0<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>19.06.2019: <xd:i>1.0.0</xd:i></xd:li> </xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<!--v1.2.0: bugfix-->
	<xsl:include href="../../lib/basic.xsl"/>
	<!--<xsl:variable as="document-node()" name="config" select="doc(concat('fb_', $kvMovement, '.dita'))"/>-->
	<xsl:variable as="document-node()" name="config" select="doc('addStemSameas.dita')"/>

	<!--	positions of the entries in the table-->
	<xsl:variable as="xs:integer" name="IDpos" select="$config//colspec[@colname = 'ID']/xs:integer(@colnum)"/>
	<xsl:variable as="xs:integer" name="stemSameasPos" select="$config//colspec[@colname = 'stemSameas']/xs:integer(@colnum)"/>


	<!--	choose only rows with the data-->
	<xsl:variable name="filledRows" select="$config//tbody/row[entry/pre[text() != '']]"/>

	<!--a map with data-->
	<xsl:variable name="data" select="
			for $n in $filledRows
			return
				map {
					'ID':
					normalize-space($n/entry[position() = $IDpos]/pre/string()),
					'stemSameas':
					normalize-space($n/entry[position() = $stemSameasPos]/pre/string())
				}
			"/>

	<!--get the IDs of the elements to be changed-->
	<xsl:variable name="IDs" select="
			for $n in $data
			return
				map:get($n, 'ID')"/>


	<xd:doc>
		<xd:desc>main template</xd:desc>
	</xd:doc>
	<xsl:template match="/">

		<!--<xsl:call-template name="copy-and-format"/>-->

		<xsl:variable name="output">
			<xsl:apply-templates mode="addStemSameas" select="."/>
		</xsl:variable>

		<xsl:copy-of select="$output"/>
	</xsl:template>



	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="id($IDs)" mode="addStemSameas" name="addStemSameas">
		<xsl:copy>
			<xsl:variable name="a" select="dme:getValue(@xml:id)"/>
			<xsl:if test="not(@stem.sameas)">
				<xsl:attribute name="stem.sameas" select="dme:getValue(@xml:id)"/>
			</xsl:if>
			<xsl:apply-templates select="@*, node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="currID"/>
	</xd:doc>
	<xsl:function name="dme:getValue">
		<xsl:param as="xs:string" name="currID"/>
		<xsl:variable name="value">
			<xsl:for-each select="$data">
				<xsl:if test="map:get(., 'ID') = $currID">
					<xsl:value-of select="map:get(., 'stemSameas')"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:sequence select="concat('#', $value)"/>
	</xsl:function>


	<xsl:variable name="currentStylesheet" select="doc('')"/>
</xsl:stylesheet>
