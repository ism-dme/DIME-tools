<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>Adds <i>@xml:id</i>s to the descendants of &lt;body>.</p>
			<p><b>Rules</b>:<pre/>Normal case: <ul>
					<li>Example: <i>note_295</i></li>
					<li>Syntax: {local-name()}_{$newID}</li>
					<li>Note that the numeric value is incremented by <i>6</i>, e.g. the next &lt;note&gt; would have the ID: <i>note_301</i></li>
				</ul><pre/> Special cases:<pre/>			
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
				<b>&lt;zone&gt;</b>
				<ul>
					<li>Example: <i>zoneOf_m1_k556_001</i></li>
					<li>Syntax: <i>zoneOf_{xml:id of the measure which @facs corresponds to the current ID}</i></li>
				</ul>			
			</p>
			<p>Rely on DIME naming convention (otherwise, standard case is applied):<pre/>
				<b>&lt;mdiv&gt;</b>, <b>&lt;score&gt;</b>: <ul>
					<li>Example: <i>mdiv_581004</i> (&lt;mdiv&gt; of the K. 581, 4th movement)</li>
					<li>If there are 1+ &lt;mdiv&gt;s, a suffix is added: e.g. <i>mdiv_581004<b>_01</b></i> (first &lt;mdiv&gt;)</li>
				</ul><pre/>
				<b>&lt;measure&gt;</b>, <b>&lt;score&gt;</b>: <ul>
					<li>Example: <i>m1_k331_002_01</i> (first measure of the second movement of K. 331, first &lt;mdiv&gt;)</li>
					<li>If there are 1+ &lt;mdiv&gt;s, a suffix is added: e.g. <i>mdiv_581004<b>_01</b></i> (first &lt;mdiv&gt;)</li>
				</ul><pre/></p>
			<pre> </pre>
			<p><b>Notes:</b><pre/>Options should be configured in <i>../options/options.xml</i><pre/> Some <i>special cases</i> require the DIME file naming convention 'dmeref_{xxx-xxx}_{xxxx}.xml'.</p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.2.0</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>
	<xsl:param name="fileName"/>

	<xsl:include href="../lib/basic.xsl"/>
	<xsl:include href="../lib/functions/functions_DIME.xsl"/>
	<xsl:include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
	<xsl:include href="modules/options.xsl"/>
	<xsl:include href="modules/zone.xsl"/>
	<xsl:include href="../lib/shared_stylesheets/count_measures_shared.xsl"/>
	<xsl:include href="../lib/shared_stylesheets/create-IDs_shared.xsl"/>

	<xsl:import href="modules/changeLog.xsl"/>

	<xsl:variable as="xs:boolean" name="DIME-FileNaming" select="matches($fileName, '^[a-z]{6}_\d{3}-\d{3}_\d{4}$')"/>
	<xsl:variable as="map(xs:string, item()*)" name="options">
		<xsl:call-template name="options"/>
	</xsl:variable>
	<xsl:variable as="map(xs:string, item()*)?" name="optionsCalc">
		<xsl:call-template name="optionsCalc"/>
	</xsl:variable>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="/">
		<xsl:variable name="prepareIDs">
			<xsl:apply-templates mode="prepareIDs" select="."/>
		</xsl:variable>

		<xsl:variable name="countMeasures">
			<xsl:choose>
				<xsl:when test="map:get($options, 'recount_measures') = '1'">
					<xsl:variable name="output">
						<xsl:apply-templates mode="countMeasures" select="$prepareIDs"/>
					</xsl:variable>
					<xsl:copy-of select="$output"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$prepareIDs"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="all" select="map:get($options, 'all')"/>
		<xsl:variable name="els2apply" select="map:get($options, 'els2apply')"/>
		<xsl:variable name="els2exclude" select="map:get($options, 'els2exclude')"/>

		<xsl:variable name="main">
			<xsl:apply-templates mode="main" select="$countMeasures">
				<xsl:with-param name="arg1" select="$all" tunnel="yes"/>
				<xsl:with-param name="arg2" select="$els2apply" tunnel="yes"/>
				<xsl:with-param name="arg3" select="$els2exclude" tunnel="yes"/>
			</xsl:apply-templates>
		</xsl:variable>

		<xsl:variable name="zone">
			<xsl:apply-templates mode="zone" select="$main">
				<xsl:with-param name="arg1" select="$all" tunnel="yes"/>
				<xsl:with-param name="arg2" select="$els2apply" tunnel="yes"/>
				<xsl:with-param name="arg3" select="$els2exclude" tunnel="yes"/>
			</xsl:apply-templates>

		</xsl:variable>

		<xsl:variable name="output">
			<xsl:choose>
				<xsl:when test="
						($all = '1' or (some $n in $els2apply
							satisfies $n = 'section')) and not(some $n in $els2exclude
							satisfies ($n = 'section'))">
					<xsl:variable name="section">
						<xsl:apply-templates mode="section" select="$zone"/>
					</xsl:variable>
					<xsl:apply-templates mode="references" select="$section"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="references" select="$zone"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:copy-of select="$output"/>

	</xsl:template>


	<xd:doc>
		<xd:desc>Adds temporary IDs which are needed for further computation.</xd:desc>
	</xd:doc>
	<xsl:template match="mdiv | score | section | scoreDef" mode="prepareIDs">
		<xsl:copy>
			<xsl:attribute name="xml:id">
				<xsl:value-of select="generate-id()"/>
			</xsl:attribute>
			<xsl:apply-templates mode="#current" select="@*, node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
