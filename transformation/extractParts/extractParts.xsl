<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p id="description">
				<i>Extracts part or voice (i.e. &lt;staff&gt; or &lt;layer&gt;) (e.g. <i>Clarinetti</i> or <i>Clarinet I</i>) .</i>
			</p>
			<p>Note: Set options in <i>../options/options.xml</i></p>
			<pre> </pre>
			<p><b>Processing notes</b></p>
			<p>For both extractions:<ul>
					<li>&lt;tempo&gt;/@staff is adjusted.</li>
					<li>&lt;fermata&gt;/@staff is adjusted.</li>
					<li>&lt;pb&gt;and &lt;sb&gt; are deleted (except the case when all parts are chosen = no extraction).</li>
				</ul>
			</p>
			<p>For the mode <i>extractStaff</i>: all staves and their respective &lt;staffDef>s which do not match the requested part number are deleted. The content of the preserved staves is not modified.</p>
			<p>For the mode <i>extractLayer</i>: Besides the processing which is used for the mode <i>extractStaff</i>, additional modification of the content of the extracted &lt;layer&gt; is performed: <ul>
					<li>A new layer[@n='1'] is created.</li>
					<li>@sameas-references are resolved: <ul>
							<li>The <i>pointer</i> is replaced by its <i>reference</i>; <i>@stem.dir</i>, <i>@stem.sameas</i>, <i>@ploc</i> and <i>@oloc</i> are deleted, <i>@xml:id</i>, <i>@doxml:id</i> are preserved</li>
						</ul>
					</li>
					<li>Control events (&lt;slur&gt;, &lt;dir&gt;, etc.): <ul>
							<li>Only those which point to the requested &lt;staff&gt;/staves and/or &lt;layer&gt;s are preserved</li>
							<li><i>@place</i> is deleted for all except &lt;dir&gt;<ul> </ul>
							</li>
							<li>For the pointer-attributes like @startid a new value is derived if needed. Special case is &lt;dynam&gt;: if there exist no <i>@xml:id</i> as a new value (i.e. there is a rest), a <i>@tstamp</i> is inserted instead of the <i>@startid</i></li>
							<li>If there exist more then one of the new reference for <i>@startid</i> or <i>@endid</i> (e.g. there exist ann &lt;app&gt; or a &lt;choice&gt; in the new requested &lt;layer&gt;), the current element will be copied with modified pointers.</li>
						</ul>
					</li>
					<li>&lt;staffDef&gt;<ul>
							<li>is transformed to a form without &lt;layerDef&gt;s.</li>
							<li>the text in &lt;label&gt; is replaced by <i>singular form</i> + <i>layer number</i> of the instrument: e.g. <i>Clarinetto I</i> instead of <i>Clarinetti</i></li>
						</ul>
					</li>
				</ul>
			</p>
			<p>Special case: &lt;app&gt; with two versions (e.g. K 550). The &lt;app> will be preserved, it's &lt;rdg>s contain only the extracted &lt;layer>s. </p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.1.0</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov.<pre/><b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>					
		</desc>
	</doc>


	<include href="global/options.xsl"/>
	<include href="lib/functx-1.0-doc-2007-01.xsl"/>
	<include href="extractStaff.xsl"/>
	<include href="extractLayer/layer/matchStaff.xsl"/>
	<include href="extractLayer/controlEvents/controlEvents.xsl"/>
	<include href="extractLayer/staffDef.xsl"/>
	<include href="global/templates.xsl"/>
	<include href="global/functions.xsl"/>
	<import href="changeLog.xsl"/>

	<variable as="map(xs:string, item()*)" name="options">
		<call-template name="options"/>
	</variable>
	<variable name="voices" select="map:get($options, 'voices')"/>


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
		<output-character character="«" string="&amp;"/>
	</character-map>

	<output encoding="UTF-8" indent="yes" method="xml" use-character-maps="entities"/>
	<strip-space elements="*"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="node() | @*" mode="#all">
		<copy>
			<apply-templates select="node() | @*"/>
		</copy>
	</template>


</stylesheet>
