<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>Adds <xd:i>@xml:id</xd:i>s to all elements in &lt;body> due to the following guidelines.</xd:p>
			<xd:p><xd:i>Normal case</xd:i>: <xd:i>{local-name()}_{$newIDs}</xd:i>, e.g. <xd:b>"note_295"</xd:b>. Note that the numeric value increments by <xd:i>6</xd:i>, e.g. the next element would have the ID: <xd:b>"layer_301"</xd:b></xd:p>
			<xd:p><xd:i>Special cases</xd:i>: <xd:ul>
					<xd:li>&lt;zone&gt; <xd:ul>
							<xd:li>Example: <xd:b>zoneOf_m1_k556_001</xd:b></xd:li>
							<xd:li>Syntax: 'zoneOf_'{xml:id of the measure which corresponds via its @facs to the current ID}</xd:li>
						</xd:ul> are processed. Syntax: 'zoneOf_'{xml:id of the measure which corresponds via its @facs to the current ID}</xd:li>
					<xd:li><xd:b>&lt;mdiv&gt;</xd:b>, <xd:b>&lt;score&gt;</xd:b>: <xd:ul>
							<xd:li>Example: <xd:b>"mdiv_581004"</xd:b></xd:li>
							<xd:li>Syntax: <xd:i>{local-name()}_{$Knumber *format:three-digit*}{$partsCounter *format:three-digit*}</xd:i></xd:li>
							<xd:li>If there are more then one &lt;mdiv&gt;, a suffix is added: <xd:i>_{$mdivCounter}</xd:i>, e.g. "mdiv_581004<xd:b>_01</xd:b>"</xd:li>
						</xd:ul>
					</xd:li>
					<xd:li><xd:b>&lt;scoreDef&gt;, &lt;staffGrp&gt;</xd:b>: <xd:ul>
							<xd:li>Example: <xd:b>"scoreDef_02"</xd:b> or <xd:b>"staffGrp_15"</xd:b></xd:li>
							<xd:li>Syntax:<xd:i>{local-name()}{$scoreDef_#Counter *format:two-digit*}</xd:i>
							</xd:li>
							<xd:li>Note that the elements are counted through the file incrementally.</xd:li>
						</xd:ul>
					</xd:li>
					<xd:li><xd:b>&lt;staffDef&gt;</xd:b>: <xd:ul>
							<xd:li>Example: <xd:b>"staffDef_P1"</xd:b></xd:li>
							<xd:li>Syntax: <xd:i>{local-name()}_P *abbreviation: <xd:i>parts</xd:i>*{$stafDefCounter *format:incremental digits*}</xd:i></xd:li>
							<xd:li>If thre are more then one &lt;scoreDef&gt;, a suffix is added <xd:i>_sc{$scoreDefCounter *format:two-digit*}, e.g. "staffDef_P1<xd:b>_sc02</xd:b>". </xd:i>The ID stands then for the first part in the second scoreDef.</xd:li>
						</xd:ul></xd:li>
					<xd:li><xd:b>&lt;label&gt;, &lt;lb&gt;</xd:b> (descendants of &lt;staffDef> only): <xd:ul>
							<xd:li>Example: <xd:b>"label_P1"</xd:b>, <xd:b>"lb_P1_sc01"</xd:b></xd:li>
							<xd:li>Syntax: <xd:i>{local-name()}_P *abbreviation: <xd:i>parts</xd:i>*{$stafDefCounter *format:incremental digits*}</xd:i></xd:li>
							<xd:li>If thre are more then one &lt;scoreDef&gt;, a suffix is added <xd:i>_sc{$scoreDefCounter *format:two-digit*}, e.g. "staffDef_P1<xd:b>_sc02</xd:b>".</xd:i> The ID stands then for the &lt;label>/&lt;lb> in first part in the second &lt;scoreDef&gt;.</xd:li>
						</xd:ul></xd:li>
					<xd:li><xd:b>&lt;layerDef&gt;</xd:b>: <xd:ul>
							<xd:li>Example: <xd:b>"layerDef_P1"</xd:b>, <xd:b>"layerDef_P1_sc01" </xd:b>(if there are more then one &lt;scoreDef&gt;s).</xd:li>
							<xd:li>Syntax: <xd:i>{local-name()}_P *abbreviation: <xd:i>parts</xd:i>*{$stafDefCounter *format:incremental digits*}</xd:i></xd:li>
							<xd:li>If thre are more then one &lt;scoreDef&gt;, a suffix is added <xd:i>_sc{$scoreDefCounter *format:two-digit*}</xd:i>, e.g. <xd:i>"layerDef_P1<xd:b>_sc02</xd:b>"</xd:i>. This ID stands for the &lt;layerDef&lt; of the first <xd:i>part</xd:i> in the second &lt;scoreDef&gt;.</xd:li>
						</xd:ul></xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>The companion of the stylesheet is DIME-tools.xml which provides a GUI for the input.</xd:p>
			<xd:p>Options: <xd:ul>
					<xd:li>(Re)count measures before</xd:li>
					<xd:li>Choose only particular elements to add the IDs</xd:li>
					<xd:li>Exclude particular elements</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p><xd:b>Note:</xd:b> Set the file name due to the DIME guidelines: 'dmeref_{xxx-xxx}_{xxxx}.xml'</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p><xd:i>Current Version</xd:i>: <xd:b>1.1.3</xd:b>. For more info see changeLog.</xd:p>
		</xd:desc>
	</xd:doc>
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
