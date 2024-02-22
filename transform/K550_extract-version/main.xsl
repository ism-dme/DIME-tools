<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:saxon="http://saxon.sf.net/" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>Extracts symphony version from the K. 550.</i>
			</p>
			<p>Matches all &lt;app&gt;s which have &lt;rdg&gt; with the @label=('version-2_6309', 'version-1_6318') and extracts the content of the &lt;rdg&gt; with the @label defined by the user input.</p>
			<p>Note: staff numbering is preserved</p>
			<p>
				<p><i>Current version</i>: <b id="version">0.0.1</b>. (22.07.2020)</p>
				<b>Author: </b>Oleksii Sapov</p>
		</desc>
	</doc>


	<param as="xs:string" name="version"/>
	<param as="xs:string" name="fileName"/>



	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">

		<variable name="extractedVersion">
			<apply-templates mode="extractVersion" select="."/>
		</variable>

		<!--	<variable name="recountStaves">
			<apply-templates mode="recountStaves" select="$extractedVersion"/>
		</variable>-->


		<variable name="outputFile" select="$fileName || '_v' || $version || '.xml'"/>
		<result-document href="{$outputFile}" indent="yes" method="xml">
			<copy-of select="$extractedVersion"/>
		</result-document>

	</template>



	<xd:doc>
		<xd:desc>Extracts the content of the main version. E.g. for &lt;app&gt; it would be the &lt;lem&gt;.</xd:desc>
	</xd:doc>
	<template match="body//app[child::rdg[@label=('version-2_6309', 'version-1_6318')]]" mode="extractVersion">
		<apply-templates mode="#current" select="descendant::rdg[@n = $version]/node()"/>
	</template>



	<character-map name="entities">
		<output-character character="&#8198;" string="&amp;#8198;"/>
		<output-character character="&#8194;" string="&amp;#8194;"/>
		<output-character character="&#8195;" string="&amp;#8195;"/>
		<output-character character="&#8211;" string="&amp;#8211;"/>
		<output-character character="&#160;" string="&amp;#160;"/>
		<output-character character="&#xea5c;" string="&amp;#xea5c;"/>
		<output-character character="&#xe263;" string="&amp;#xe263;"/>
		<output-character character="&#xea56;" string="&amp;#xea56;"/>
		<output-character character="&#x1D10B;" string="&amp;#x1D10B;"/>
		<output-character character="&#324;" string="&amp;#324;"/>
		<!--		try RegEx to match all characters -->
		<!--<output-character character="&amp;" string="abs" />-->

		<!--		needed to replace &amp; to & -->
		<output-character character="«" string="&amp;"/>
	</character-map>

	<output encoding="UTF-8" indent="yes" method="xml" saxon:indent-spaces="2" saxon:expandAttributeDefaults="true" use-character-maps="entities"/>
	<strip-space elements="*"/>


	<template match="node() | @*" mode="extractVersion">
		<copy>
			<apply-templates mode="#current" select="node() | @*"/>
		</copy>
	</template>

	<!--	<template match="node() | @*" mode="recountStaves">
		<copy>
			<apply-templates mode="#current" select="node() | @*"/>
		</copy>
	</template>

DEPRECATED 	AS @STAFF IN SLUR, TIE, ETC. SHOULD BE ADJUSTED THEN
	<template match="staff/@n" mode="recountStaves">
		<attribute name="n" select="count(../preceding-sibling::staff) + 1"/>
	</template>-->

</stylesheet>
