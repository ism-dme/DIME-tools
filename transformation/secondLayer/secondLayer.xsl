<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme  mei" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
		<desc>
			<p>				
				<i>Adds an empty second layer or a second layer with mRest depending on the mode. </i>
			</p>
			<p>
				<b>Modes:</b>
				<ul>
					<li><b>secondLayer</b>: Inserts a second layer in the defined staves. If the staff has already more than one layer, a warning message is raised and no additional layer is inserted. Example of an inserted layer: <![CDATA[<layer n="2" sameas="#layer_2886" xml:id="layer_2910"/>]]></li>
					<li><b>mRest</b>: Inserts a second layer with a mRest. xample of an inserted mRest: <![CDATA[<mRest sameas="#mRest_2226" xml:id="id" tstamp="1"/>]]></li>
				</ul>
			</p>
			<p/>
			<p>
				<b>Created on: </b>Sep, 4 2018<ul>
					<li>
						<i>Versions</i>: <ul>
							<li>04.09.2018: <i>1.0.0</i></li>
							<li>01.04.2019: <i>2.0.0</i></li>
							<li>17.04.2019: <i>2.1.0</i></li>
							<li id="version">01.10.2019: <i>2.1.1</i></li>
						</ul>
					</li>
				</ul>
			</p>			
			<p>
				<b>Author: </b>Oleksii Sapov</p>			
		</desc>
	</doc>

	<xsl:param as="xs:string" name="staves"/>
	<xsl:param as="xs:string" name="mode"/>

	<xsl:include href="../lib/applicationChanges.xsl"/>
	<xsl:include href="../lib/basic.xsl"/>

	<xsl:variable name="stavesTok" select="
			for $n in tokenize(normalize-space($staves), ',')
			return
				normalize-space($n)"/>
	<xsl:variable name="currentStylesheet" select="doc('')"/>


	<xd:doc scope="component">
		<xd:desc>Processes the current document-node() with various modes and writes it in an external file.</xd:desc>
	</xd:doc>
	<xsl:template match="/">

		<xsl:variable name="secondLayer">
			<xsl:choose>
				<xsl:when test="$mode = 'secondLayer'">
					<xsl:apply-templates mode="secondLayer" select="."/>
				</xsl:when>
				<xsl:when test="$mode = 'mRest'">
					<xsl:apply-templates mode="mRest" select="."/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="output">
			<xsl:apply-templates mode="applicationChanges" select="$secondLayer"/>
		</xsl:variable>

		<xsl:copy-of select="$output"/>
	</xsl:template>


	<xd:doc id="second.layer">
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staff[@n = $stavesTok]" mode="secondLayer">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="@*"/>
			<xsl:apply-templates mode="#current" select="layer"/>
			<xsl:variable name="pointer" select="concat('#', layer[@n = 1]/@xml:id)"/>
			<xsl:choose>
				<xsl:when test="count(layer) = 1">
					<layer xmlns="http://www.music-encoding.org/ns/mei">
						<xsl:attribute name="xml:id" select="concat(layer/@xml:id, 'b')"/>
						<xsl:attribute name="n" select="xs:integer(2)"/>
						<!--<xsl:attribute name="newLayer" select="'true'"/>-->
						<xsl:attribute name="sameas" select="$pointer"/>
					</layer>
				</xsl:when>
				<xsl:when test="count(layer) &gt; 1">
					<xsl:message>'<xsl:value-of select="@xml:id"/>' already has more then one layer!</xsl:message>
				</xsl:when>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staff[@n = $stavesTok]" mode="mRest">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="@*"/>
			<xsl:apply-templates mode="#current" select="layer"/>

			<xsl:if test="layer[@n = '1' and mRest and not(following-sibling::layer[@n = '2'])]">
				<layer xmlns="http://www.music-encoding.org/ns/mei">
					<xsl:attribute name="xml:id" select="concat(layer/@xml:id, 'b')"/>
					<xsl:attribute name="n" select="xs:integer(2)"/>

					<mRest sameas="#mRest_2226" tstamp="1" xml:id="id" xmlns="http://www.music-encoding.org/ns/mei">
						<xsl:attribute name="xml:id" select="concat(descendant::mRest/@xml:id, 'b')"/>
						<xsl:variable name="pointer" select="concat('#', descendant::mRest/@xml:id)"/>
						<xsl:attribute name="sameas" select="$pointer"/>
					</mRest>
				</layer>
			</xsl:if>

		</xsl:copy>
	</xsl:template>


</xsl:stylesheet>
