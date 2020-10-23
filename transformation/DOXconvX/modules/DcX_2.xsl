<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc>changes @startid to @tstamp in dynams</xd:desc>
	</xd:doc>
	<xsl:template match="
			dynam[@startid and not(@tstamp)]" mode="DcX_2">
		<xsl:variable as="xs:string*" name="dynams" select="$lists//id('dynams_2')/dme:item/text()"/>
		<xsl:choose>
			<xsl:when test="
					some $n in $dynams
						satisfies text() = $n">
				<xsl:variable name="startXmlID" select="substring(@startid, 2)"/>
				<xsl:variable name="newTstamp" select="(//note[@xml:id = $startXmlID]/@tstamp) | (//chord[@xml:id = $startXmlID]/@tstamp)"/>
				<xsl:copy>
					<xsl:attribute name="tstamp" select="$newTstamp"/>
					<xsl:apply-templates mode="#current" select="@* except @startid, node()"/>
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
		<xd:desc>adds @resp to supplied</xd:desc>
	</xd:doc>
	<xsl:template match="supplied[not(@resp)]" mode="DcX_2">
		<xsl:copy>
			<xsl:attribute name="resp">
				<xsl:value-of select="'#NMA-editors'"/>
			</xsl:attribute>
			<xsl:apply-templates mode="#current" select="@*, node()"/>
		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc>If the note has @enclose="brack" and @accid. The @accid will be supplied.</xd:desc>
	</xd:doc>
	<xsl:template match="note" mode="DcX_2">
		<xsl:copy>

			<xsl:if test="ancestor::chord">
				<xsl:call-template name="ancestorChord"/>
			</xsl:if>

			<xsl:if test="@grace and not(@stem.dir = 'up')">
				<xsl:attribute name="stem.dir" select="'up'"/>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="(@enclose = 'brack') and @accid">
					<xsl:apply-templates mode="#current" select="@* except (@enclose, @accid), node()"/>
					<xsl:element name="supplied" namespace="http://www.music-encoding.org/ns/mei">
						<xsl:attribute name="resp" select="'#NMA-editors'"/>
						<xsl:attribute name="xml:id" select="concat('supplied_', substring-after(@xml:id, '_'))"/>
						<xsl:element name="accid" namespace="http://www.music-encoding.org/ns/mei">
							<xsl:attribute name="accid" select="@accid"/>
							<xsl:attribute name="xml:id" select="concat('accid_', substring-after(@xml:id, '_'))"/>
						</xsl:element>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="#current" select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="rest[ancestor::chord]">
		<xsl:call-template name="ancestorChord"/>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<xsl:template name="ancestorChord">
		<xsl:param name="element" select="."/>
		<xsl:variable name="currentID" select="@xml:id"/>

		<xsl:if test="not(@dots)">
			<xsl:if test="ancestor::chord//note[@dots and @xml:id != $currentID] (:other notes in chord:)">
				<xsl:attribute name="dots" select="0"/>
			</xsl:if>
		</xsl:if>

	</xsl:template>

	<!--	<xd:doc>
		<xd:desc>adds @stem.dir='up' to a grace note</xd:desc>
	</xd:doc>
	<xsl:template match="note[@grace]" mode="DcX_2">
		<xsl:copy>

			<xsl:if test="not(@stem.dir = 'up')">
				<xsl:attribute name="stem.dir" select="'up'"/>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="(@enclose = 'brack') and @accid">
					<xsl:apply-templates mode="#current" select="@* except (@enclose, @accid), node()"/>
					<xsl:element name="supplied" namespace="http://www.music-encoding.org/ns/mei">
						<xsl:attribute name="resp" select="'#NMA-editors'"/>
						<xsl:attribute name="xml:id" select="concat('suppl_', substring-after(@xml:id, '_'))"/>
						<xsl:element name="accid" namespace="http://www.music-encoding.org/ns/mei">
							<xsl:attribute name="accid" select="@accid"/>
							<xsl:attribute name="xml:id" select="concat('accid_', substring-after(@xml:id, '_'))"/>
						</xsl:element>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="#current" select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>-->


</xsl:stylesheet>
