<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme"  xmlns:mei="http://www.music-encoding.org/ns/mei"  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:p>
					<xd:b>Description: </xd:b>
					<xd:i>Replaces @startid of a &lt;dir&gt; with @tstamp which value is derived from the referenced note.</xd:i>
				</xd:p>
			</xd:p>
			<xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>Sep, 23 2019, version 1.0.0<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>23.09.2019: <xd:i>1.0.0</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:include href="../lib/basic.xsl"/>
	<xsl:include href="../lib/applicationChanges.xsl"/>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="dir[@startid]" name="tstamp">
		<xsl:variable name="tstampValue" select="id(substring-after(@startid, '#'))/@tstamp"/>
		<xsl:copy>
			<xsl:attribute name="tstamp" select="$tstampValue"/>
			<xsl:apply-templates select="@* except @startid, node()"/>
		</xsl:copy>
		<xsl:message>Added @tstamp="<xsl:value-of select="$tstampValue"/>" on the "<xsl:value-of select="@startid"/>" and deleted its @startid.</xsl:message>
	</xsl:template>

	<xsl:variable name="currentStylesheet" select="doc('')"/>
</xsl:stylesheet>
