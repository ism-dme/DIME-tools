<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>Adds <i>@xml:id</i>s to the elements in &lt;body> according to the following guidelines.</p>
			<p><i>Normal case</i>: <i>{local-name()}_{$newID}</i>, e.g. <b>note_295</b>. Note that the numeric value increments by <i>6</i>, e.g. the next element would have the ID: <b>layer_301</b></p>
			<p><i>Special cases</i>: <ul>
					<li><b>&lt;zone&gt;</b> <ul>
							<li>Example: <b>zoneOf_m1_k556_001</b></li>
							<li>Syntax: 'zoneOf_'{xml:id of the measure which corresponds via its @facs to the current ID}</li>
						</ul> are processed. Syntax: 'zoneOf_'{xml:id of the measure which corresponds via its @facs to the current ID}</li>
					<li><b>&lt;mdiv&gt;</b>, <b>&lt;score&gt;</b>: <ul>
							<li>Example: <b>"mdiv_581004"</b></li>
							<li>Syntax: <i>{local-name()}_{$Knumber *format:three-digit*}{$partsCounter *format:three-digit*}</i></li>
							<li>If there are more than one &lt;mdiv&gt;, a suffix is added: <i>_{$mdivCounter}</i>, e.g. "mdiv_581004<b>_01</b>"</li>
						</ul>
					</li>
					<li><b>&lt;scoreDef&gt;, &lt;staffGrp&gt;</b>: <ul>
							<li>Example: <b>"scoreDef_02"</b> or <b>"staffGrp_15"</b></li>
							<li>Syntax:<i>{local-name()}{$scoreDef_#Counter *format:two-digit*}</i>
							</li>
							<li>Note that the elements are counted through the file incrementally.</li>
						</ul>
					</li>
					<li><b>&lt;staffDef&gt;</b>: <ul>
							<li>Example: <b>"staffDef_P1"</b></li>
							<li>Syntax: <i>{local-name()}_P *abbreviation: <i>parts</i>*{$stafDefCounter *format:incremental digits*}</i></li>
							<li>If thre are more than one &lt;scoreDef&gt;, a suffix is added <i>_sc{$scoreDefCounter *format:two-digit*}, e.g. "staffDef_P1<b>_sc02</b>". </i>The ID stands then for the first part in the second scoreDef.</li>
						</ul></li>
					<li><b>&lt;label&gt;, &lt;lb&gt;</b> (descendants of &lt;staffDef> only): <ul>
							<li>Example: <b>"label_P1"</b>, <b>"lb_P1_sc01"</b></li>
							<li>Syntax: <i>{local-name()}_P *abbreviation: <i>parts</i>*{$stafDefCounter *format:incremental digits*}</i></li>
							<li>If thre are more than one &lt;scoreDef&gt;, a suffix is added <i>_sc{$scoreDefCounter *format:two-digit*}, e.g. "staffDef_P1<b>_sc02</b>".</i> The ID stands then for the &lt;label>/&lt;lb> in first part in the second &lt;scoreDef&gt;.</li>
						</ul></li>
					<li><b>&lt;layerDef&gt;</b>: <ul>
							<li>Example: <b>"layerDef_P1"</b>, <b>"layerDef_P1_sc01" </b>(if there are more than one &lt;scoreDef&gt;s).</li>
							<li>Syntax: <i>{local-name()}_P *abbreviation: <i>parts</i>*{$stafDefCounter *format:incremental digits*}</i></li>
							<li>If there are more than one &lt;scoreDef&gt;, a suffix is added <i>_sc{$scoreDefCounter *format:two-digit*}</i>, e.g. <i>"layerDef_P1<b>_sc02</b>"</i>. This ID stands for the &lt;layerDef&gt; of the first <i>part</i> in the second &lt;scoreDef&gt;.</li>
						</ul></li>
				</ul>
			</p>
			<p>Options (should be configured in options.xml): <ul>
					<li>Recount measures</li>
					<li>Include or exclude particular elements</li>					
				</ul>
			</p>
			<p><b>Note:</b> Some <i>special cases</i> described abot require file naming of the DIME 'dmeref_{xxx-xxx}_{xxxx}.xml'. You may exclude these elements or change the behaviour.</p>
			<p><i>Current Version</i>: <b>1.1.3</b>. For more info see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov<p/></p>
			<p><b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.</p>
			<p>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.osedu.org/licenses/ECL-2.0</p>
			<p>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
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

	<xsl:variable as="map(xs:string, item()*)" name="options">
		<xsl:call-template name="options"/>
	</xsl:variable>
	<xsl:variable as="map(xs:string, item()*)" name="optionsCalc">
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
