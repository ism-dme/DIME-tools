<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xd:doc>
		<xd:desc>adds @curvedir="below" or just changes its value to "below" if it is a &lt;slur> of a grace note</xd:desc>
	</xd:doc>
	<xsl:template match="slur[not(@curvedir) or @curvedir[. != 'below']]" mode="DcX_1">
		<xsl:variable name="startID" select="substring(@startid, 2)"/>
		<xsl:variable name="ID_graceNote" select="ancestor::measure//note[@grace = 'unknown']/@xml:id"/>
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="$startID = $ID_graceNote">
					<xsl:attribute name="curvedir" select="'below'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@curvedir"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="@* except (@curvedir), node()"/>
		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc>adds @n to pb</xd:desc>
	</xd:doc>
	<xsl:template match="pb" mode="DcX_1">
		<xsl:copy>
			<xsl:if test=".[@facs]">
				<xsl:attribute name="n" select="substring-after(@facs, '_')"/>
			</xsl:if>
			<xsl:apply-templates mode="#current" select="@* except (@n), node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc>adds @tstamp to the first tempo</xd:desc>
	</xd:doc>
	<xsl:template match="tempo[ancestor::measure[@n = ('0', '1')]]" mode="DcX_1">
		<xsl:copy>
			<xsl:if test=".[not(@tstamp)]">
				<xsl:attribute name="tstamp" select="1"/>
			</xsl:if>
			<xsl:apply-templates mode="#current" select="@*, node()"/>
		</xsl:copy>
	</xsl:template>

	

	<xd:doc>
		<xd:desc>adds @decls to facimile</xd:desc>
	</xd:doc>
	<xsl:template match="facsimile" mode="DcX_1">
		<xsl:copy>
			<xsl:attribute name="decls" select="'#digital_image'"/>
			<xsl:apply-templates mode="#current" select="@*, node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc>Adds #</xd:desc>
	</xd:doc>
	<xsl:template match="@startid[not(starts-with(., '#'))] | @endid[not(starts-with(., '#'))] | @resp[not(starts-with(., '#'))]" mode="DcX_1">
		<xsl:copy>
			<xsl:attribute name="{local-name()}" select="concat('#', .)"/>
		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc>Adds @form, @measperf. Deletes @unitdur</xd:desc>
	</xd:doc>
	<xsl:template match="bTrem" mode="DcX_1">
		<xsl:choose>
			<xsl:when test="child::bTrem"/>
			<xsl:when test="@unitdur">
				<xsl:copy>
					<xsl:attribute name="measperf">
						<xsl:value-of select="@unitdur"/>
					</xsl:attribute>
					<xsl:attribute name="form">
						<xsl:value-of select="'meas'"/>
					</xsl:attribute>
					<xsl:apply-templates mode="#current" select="@* except @unitdur, node()"/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates mode="#current" select="@*, node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="chord[descendant::note[@dots]]" mode="DcX_1">
		<xsl:copy>
			<!--			adds the highest value of @dots of the descendant notes-->
			<xsl:if test=".[not(@dots)]">
				<xsl:variable name="maxDots" select="max(descendant::note/@dots)"/>
				<xsl:attribute name="dots" select="$maxDots"/>
			</xsl:if>

			<!--		Tests if the chord already has @dur and if it's value is the highest value of @dur of the note descendandts of this chord-->
			<xsl:variable name="maxDur" select="max(descendant::note/@dur)"/>
			<xsl:if test="not(@dur) or ($maxDur != @dur)">
				<xsl:attribute name="dur" select="$maxDur"/>
			</xsl:if>
			<!--			if the @dur is added it should not be overwritten by the original @dur-->
			<xsl:choose>
				<xsl:when test="not(@dur)">
					<xsl:apply-templates select="@* except @dur, node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:variable name="dirs" select="$lists//id('dirs')/dme:item/text()"/>
	<xd:doc>
		<xd:desc>Wraps the text of a dir in a 'rend'. The text value is defined in lists.xml</xd:desc>
	</xd:doc>
	<xsl:template match="dir[text() = $dirs and not(rend)]/text()" mode="DcX_1">

		<xsl:element name="rend" xmlns="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="fontstyle" select="'normal'"/>
			<xsl:choose>
				<xsl:when test=". = ('a2', 'a 2')">
					<xsl:value-of select="'a&#8198;2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>


	</xsl:template>

	<xd:doc>
		<xd:desc>changes 'spicc' to 'stacciss'</xd:desc>
	</xd:doc>
	<xsl:template match="@artic[. = 'stacciss']" mode="DcX_1">
		<xsl:attribute name="artic">
			<xsl:value-of select="'spicc'"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
