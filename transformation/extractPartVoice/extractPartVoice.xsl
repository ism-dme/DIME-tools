<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p id="description">
				<xd:i>Extracts part or voice (i.e. &lt;staff&gt; or &lt;layer&gt;): e.g. 'Clarinetti' or 'Clarinet I'. Different combinations are possible: e.g. 'Oboi' + 'Clarinet I' + 'Viola II'.</xd:i>
			</xd:p>
			<xd:p>For both extractions:<xd:ul>
					<xd:li>&lt;tempo&gt;/@staff is adjusted.</xd:li>
					<xd:li>&lt;fermata&gt;/@staff is adjusted.</xd:li>
					<xd:li>&lt;pb&gt;and &lt;sb&gt; are deleted (except the case when all parts are chosen = no extraction).</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>For the mode <xd:i>extractStaff</xd:i>: all staves and their respective &lt;staffDef>s which do not match the requested part number are deleted. The content of the preserved staves is not modified.</xd:p>
			<xd:p>For the mode <xd:i>extractLayer</xd:i>: Besides the processing which is used for the mode <xd:i>extractStaff</xd:i>, additional modification of the content of the extracted &lt;layer&gt; is performed: <xd:ul>
					<xd:li>A new layer[@n='1'] is created.</xd:li>
					<xd:li>@sameas-references are resolved: <xd:ul>
							<xd:li>The <xd:i>pointer</xd:i> is replaced by its <xd:i>reference</xd:i>; <xd:i>@stem.dir</xd:i>, <xd:i>@stem.sameas</xd:i>, <xd:i>@ploc</xd:i> and <xd:i>@oloc</xd:i> are deleted, <xd:i>@xml:id</xd:i>, <xd:i>@doxml:id</xd:i> are preserved</xd:li>
						</xd:ul>
					</xd:li>
					<xd:li>Control events (&lt;slur&gt;, &lt;dir&gt;, etc.): <xd:ul>
							<xd:li>Only those which point to the requested &lt;staff&gt;/staves and/or &lt;layer&gt;s are preserved</xd:li>
							<xd:li><xd:i>@place</xd:i> is deleted for all except &lt;dir&gt;<xd:ul> </xd:ul>
							</xd:li>
							<xd:li>For the pointer-attributes like @startid a new value is derived if needed. Special case is &lt;dynam&gt;: if there exist no <xd:i>@xml:id</xd:i> as a new value (i.e. there is a rest), a <xd:i>@tstamp</xd:i> is inserted instead of the <xd:i>@startid</xd:i></xd:li>
							<xd:li>If there exist more then one of the new reference for <xd:i>@startid</xd:i> or <xd:i>@endid</xd:i> (e.g. there exist ann &lt;app&gt; or a &lt;choice&gt; in the new requested &lt;layer&gt;), the current element will be copied with modified pointers.</xd:li>
						</xd:ul>
					</xd:li>
					<xd:li>&lt;staffDef&gt;<xd:ul>
							<xd:li>is transformed to a form without &lt;layerDef&gt;s.</xd:li>
							<xd:li>the text in &lt;label&gt; is replaced by <xd:i>singular form</xd:i> + <xd:i>layer number</xd:i> of the instrument: e.g. <xd:i>Clarinetto I</xd:i> instead of <xd:i>Clarinetti</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>Special case: &lt;app&gt; with two versions (e.g. K 550). The &lt;app> will be preserved, it's &lt;rdg>s contain only the extracted &lt;layer>s. </xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>Oct, 24. 2019<xd:ul>
					<xd:li>
						<xd:i>Current Version</xd:i>: <xd:ul>
							<xd:li><xd:b>1.1.0</xd:b></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>For more info see changeLog.xsl.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:param name="voices"/>


	<xsl:include href="lib/functx-1.0-doc-2007-01.xsl"/>
	<xsl:include href="extractStaff.xsl"/>
	<xsl:include href="extractLayer/layer/matchStaff.xsl"/>
	<xsl:include href="extractLayer/controlEvents/controlEvents.xsl"/>
	<xsl:include href="extractLayer/staffDef.xsl"/>
	<xsl:include href="global/templates.xsl"/>
	<xsl:include href="global/functions.xsl"/>
	<xsl:import href="changeLog.xsl"/>




	<xsl:character-map name="entities">
		<xsl:output-character character="&#8198;" string="&amp;#8198;"/>
		<!--		needed to replace &amp; to & -->
		<xsl:output-character character="«" string="&amp;"/>
		<xsl:output-character character="&#8195;" string="&amp;#8195;"/>
	</xsl:character-map>

	<xsl:output encoding="UTF-8" indent="yes" method="xml" use-character-maps="entities"/>
	<xsl:strip-space elements="*"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*"/>
		</xsl:copy>
	</xsl:template>


</xsl:stylesheet>
