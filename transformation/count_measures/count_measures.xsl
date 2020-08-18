<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
		<desc>
			<p><b>Description:</b> Adds @n to &lt;measure> according to the following prescriptions:</p>
			<p>
				<ul>
					<li>Counts &lt;measure>s within one &lt;mdiv> (if there are multiple &lt;mdiv>s it processes each separately)</li>
					<li>Special cases: <ul><b>&lt;ending></b>: <ul>
						<li>In the 1st: @n="nA"</li>
						<li>In the 2nd: @n="nB"</li>
					</ul>
						<ul>If &lt;measure>/@metcon="false": <li>In the 1st: @n="naA"</li>
							<li>In the 2nd: @n="nbA"</li>
						</ul>
					</ul>
						<ul>
							<ul><b>&lt;mdiv>/&lt;measure>/@metcon="false"</b>
								<li>
									<ul>
										<li>first position: @n="0"</li>
										<li>last position: @n="n" ('n' = any integer)</li>
									</ul>
								</li>
								<b>&lt;section>/&lt;measure>/@metcon="false"</b>
								<li>
									<ul>
										<li>last position: @n="na"</li>
										<li>first position: @n="nb" (excl. 'zeroMeasure')</li>
									</ul>
								</li>
							</ul>
						</ul>
					</li>
				</ul>
			</p>
			<p><b>Notes and user guide</b>: <ul>
				<li>&lt;measure>/@metcon="false" and &lt;endings> have to be in correct places</li>
				<li>A case if there are multiple &lt;measure>s within an &lt;ending> as well as these &lt;measure>s have @metcon="false" wasn't tested</li>
				<li>It doesn't work properly if a &lt;measure> is wrapped in &lt;app>/&lt;lem> or &lt;rdg></li>
			</ul></p>
			<p>
				<b>Author: </b>Oleksii Sapov</p>
			<p>
				<b>Created on: </b>August, 2 2018, version 1.0.0<ul>
					<li>
						<i>Versions</i>: <ul>
							<li>23.07.2019: <i>1.1.0</i></li>
						</ul>
					</li>
				</ul>
			</p>
		</desc>
	</doc>
	<xsl:include href="../lib/shared_stylesheets/count_measures_shared.xsl"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="/">

		<xsl:variable name="prepareIDs">
			<xsl:apply-templates mode="prepareIDs" select="."/>
		</xsl:variable>

		<xsl:variable name="output">
			<xsl:apply-templates mode="countMeasures" select="$prepareIDs"/>
		</xsl:variable>

		<xsl:copy-of select="$output"/>
	</xsl:template>

	<xd:doc>
		<xd:desc>temporary IDs.</xd:desc>
	</xd:doc>
	<xsl:template match="mdiv | section" mode="prepareIDs">
		<xsl:copy>
			<xsl:attribute name="xml:id">
				<xsl:value-of select="generate-id()"/>
			</xsl:attribute>
			<xsl:apply-templates mode="#current" select="@*, node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="node() | @*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:strip-space elements="*"/>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>


</xsl:stylesheet>
