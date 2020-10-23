<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc/>
		<xd:p>
			<xd:b>unsupplied-dir_@num-visible </xd:b> (as external stylesheet) <xd:ul>
				<xd:li>
					<xd:i>Changes:</xd:i>
					<xd:ul>
						<xd:li>@bracket.visible<xd:ul>
								<xd:li><xd:i>true</xd:i> if there is a rest in the tuplet</xd:li>
								<xd:li>Otherwise <xd:i>false</xd:i>.</xd:li>
							</xd:ul>
						</xd:li>
						<xd:li>@num.visible<xd:ul>
								<xd:li><xd:i>true</xd:i> if it is visible in NMA</xd:li>
								<xd:li>Otherwise <xd:i>false</xd:i>.</xd:li>
							</xd:ul></xd:li>
					</xd:ul>
				</xd:li>
				<xd:li><xd:i>Deletes</xd:i>
					<xd:ul>
						<xd:li>&lt;dir&gt; (if it points to a &lt;note&gt; inside a &lt;tuplet&gt; and is not supplied).</xd:li>
					</xd:ul>
				</xd:li>
			</xd:ul>
		</xd:p>
	</xd:doc>

	<xsl:include href="../lib/basic.xsl"/>
	<xsl:param as="xs:string" name="fileName"/>
	<!--<xsl:param as="xs:string?" name="type"/>-->


	<xsl:template match="/">

		<xsl:variable name="process">
			<xsl:apply-templates mode="process" select="."/>
		</xsl:variable>
		<!--<xsl:if test="$type = 'DOXconvX'">
			<xsl:variable name="folder" select="concat(substring($fileName, 8, 7), '_track-changes\')"/>
			<xsl:result-document href="{concat($folder, $fileName, '_12', '.xml')}" indent="yes" method="xml">
				<xsl:copy-of select="$process"/>
			</xsl:result-document>
		</xsl:if>-->
		<xsl:copy-of select="$process"/>

	</xsl:template>

	<!--@xml:id of any note in a tuplet-->
	<xsl:variable name="tupletNoteID" select="//tuplet//note/@xml:id"/>
	<!--an @xml:id of a <dir> which points to a note in tuplet-->
	<xsl:variable name="dirStartID" select="//dir[(not(parent::supplied)) and (matches(./text()/normalize-space(), '^[0-9]$'))]/substring(@startid, 2)"/>


	<xd:doc>
		<xd:desc>Sets @num.visible and @bracket.visible to TRUE or FALSE</xd:desc>
	</xd:doc>
	<xsl:template match="tuplet" mode="process">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test=".[descendant::rest]">
					<xsl:attribute name="bracket.visible">
						<xsl:value-of select="'true'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="bracket.visible">
						<xsl:value-of select="'false'"/>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test=".[descendant::note[@xml:id = $dirStartID]]">
					<xsl:attribute name="num.visible">
						<xsl:value-of select="'true'"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="num.visible">
						<xsl:value-of select="'false'"/>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates mode="#current" select="@* except (@bracket.visible, @num.visible), node()"/>
		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc>Deletes a &lt;dir&gt; which points to an @xml:id of a 'tuplet/note'</xd:desc>
	</xd:doc>
	<xsl:template match="dir[not(parent::supplied)]" mode="process">
		<xsl:variable name="start-id-local" select="substring(@startid, 2)"/>
		<xsl:choose>
			<xsl:when test=".[($start-id-local = $tupletNoteID) and (matches(./text()/normalize-space(), '^[0-9]$'))]"/>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates mode="#current" select="@* | node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
