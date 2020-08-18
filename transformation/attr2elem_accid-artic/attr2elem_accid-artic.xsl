<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description:</xd:b>
				<xd:i>Converts @artic, @accid, @accid.ges to the elements &lt;artic&gt; and &lt;accid&gt;</xd:i>
			</xd:p>
			<xd:p><xd:b>Note</xd:b>: <xd:i>@xml:id</xd:i>s need to be created separately with <xd:i>create-IDs.xsl</xd:i></xd:p>
			<xd:p><xd:i>Current version</xd:i>: <xd:b id="version">2.0.0</xd:b>. For more info see the <xd:b>changeLog</xd:b> below.</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
		</xd:desc>
	</xd:doc>

	<include href="../lib/basic.xsl"/>
	<import href="changeLog.xsl"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">

		<variable name="addEls">
			<apply-templates mode="addEls" select="."/>
		</variable>

		<copy-of select="$addEls"/>
	</template>

	<variable name="attributes" select="'artic', 'accid', 'accid.ges'"/>
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="note[@*[local-name() = $attributes]]" mode="addEls">

		<copy>
			<apply-templates mode="#current" select="@* except (@artic, @accid, @accid.ges), node()"/>
			<if test="@artic">
				<artic xmlns="http://www.music-encoding.org/ns/mei">
					<xsl:attribute name="artic">
						<xsl:value-of select="@artic"/>
					</xsl:attribute>
				</artic>
			</if>
			<if test="@accid | @accid.ges">
				<accid xmlns="http://www.music-encoding.org/ns/mei">
					<xsl:choose>
						<xsl:when test="@accid">
							<xsl:attribute name="accid">
								<xsl:value-of select="@accid"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="accid.ges">
								<xsl:value-of select="@accid.ges"/>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
				</accid>
			</if>
		</copy>
	</template>

</stylesheet>
