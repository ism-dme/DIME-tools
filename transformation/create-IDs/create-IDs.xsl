<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>Adds <i>@xml:id</i>s to the descendants of &lt;body>.</p>
			<p><b>Rules</b>:<pre/>Default: <ul>
					<li>Example: <i>note_295</i></li>
					<li>Syntax: {local-name()}_{$newID}</li>
					<li>Note that the numeric value is incremented by <i>6</i>, e.g. the next &lt;note&gt; would have the ID: <i>note_301</i></li>
				</ul><pre/> Special cases:<pre/>
				<b>&lt;zone&gt;</b>
				<ul>
					<li>Example: <i>zoneOf_m1_k556_001</i></li>
					<li>Syntax: <i>zoneOf_{xml:id of the measure which @facs corresponds to the current ID}</i></li>
				</ul><pre/>
				<b>&lt;scoreDef&gt;, &lt;staffGrp&gt;</b>: <ul>
					<li>Example: <i>scoreDef_02</i> (second &lt;scoreDef&gt; in the file)</li>
					<li>Note that the elements are counted through the file, not for each &lt;mdiv&gt;</li>
				</ul><pre/>
				<b>&lt;staffDef&gt;</b>: <ul>
					<li>Example: <i>staffDef_P1</i> (<i>P1</i> means first part, e.g. flute)</li>
					<li>If there are 1+ &lt;scoreDef&gt;s, a suffix is added, e.g. <i>staffDef_P1<b>_sc02</b></i>. (second &lt;scoreDef&gt;)</li>
				</ul><pre/>
				<b>&lt;label&gt;, &lt;lb&gt;</b> (descendants of &lt;staffDef> only): <ul>
					<li>Example: <i>label_P1</i></li>
					<li>If there are 1+ &lt;scoreDef&gt;s, a suffix is added:, e.g. <i>label_P1<b>_sc02</b></i></li>
				</ul><pre/>
				<b>&lt;layerDef&gt;</b>: <ul>
					<li>Example: <i>layerDef_P1</i></li>
					<li>If there are 1+ &lt;scoreDef&gt;s, a suffix is added:, e.g. <i>layerDef_P1<b>_sc02</b></i></li>
				</ul><pre/>
				<b>&lt;section&gt;</b>: <ul>
					<li>Examples: <i>section_allegro_moderato</i> (outer section which wraps all others), <i>section_A_m1-15</i> (all other sections)</li>
					<li>If there are 1+ &lt;mdivs&gt;s, a suffix is added (&lt;mdiv&gt;-counter)</li>
				</ul><pre/>
			</p>
			<p>Rely on DIME naming convention (otherwise, standard case is applied):<pre/>
				<b>&lt;mdiv&gt;</b>, <b>&lt;score&gt;</b>: <ul>
					<li>Example: <i>mdiv_581004</i> (&lt;mdiv&gt; of the K. 581, 4th movement)</li>
					<li>If there are 1+ &lt;mdiv&gt;s, a suffix is added: e.g. <i>mdiv_581004<b>_01</b></i> (first &lt;mdiv&gt;)</li>
					<li>Adds @n to &lt;mdiv&gt; which is the integer of the current movement, otherwise it is equal to the count of the &lt;mdiv&gt;s in the file.</li>
				</ul><pre/>
				<b>&lt;measure&gt;</b>, <b>&lt;score&gt;</b>: <ul>
					<li>Example: <i>m1_k331_002_01</i> (first measure of the second movement of K. 331, first &lt;mdiv&gt;)</li>
					<li>If there are 1+ &lt;mdiv&gt;s, a suffix is added: e.g. <i>mdiv_581004<b>_01</b></i> (first &lt;mdiv&gt;)</li>
				</ul><pre/></p>
			<pre> </pre>
			<p><b>Notes:</b><pre/>Options should be configured in <i>../options/options.xml</i><pre/> Some <i>special cases</i> require the DIME file naming convention '{xxxxxx}_{xxx-xxx}_'.</p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.3.1</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>

	<param as="xs:string" name="fileName"/>
	<include href="main.xsl"/>
	<import href="changeLog.xsl"/>

</stylesheet>
