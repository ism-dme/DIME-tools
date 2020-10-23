<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>This is an extension of the DOX conversion process. Among other corrections, it enriches the encoding by the project specific features.</i>
			</p>
			<p><b>Usage notes </b>: <ul>
					<li>Check if &lt;perfRes&gt;/@codedval are set in the correct order and set test for vocalVoice (e.g. <i>Villanela</i>) if such available.</li>
					<li>Check if &lt;staffDef&gt;/@dme.parts point to the correct&lt;perfRes&gt;/@n</li>
					<li>Don't do any other modification either in &lt;perfResList&gt; or &lt;scoreDef&gt;</li>
				</ul>
			</p>
			<p>Note: In the intermediate steps, some features can be added for technical reasons, which are changed/deleted later, e.g. <i>@label.abbr</i> is added in step 2, but if the mode is 'chamber', it is deleted later. </p>
			<p>The changes which the stylesheet applies are grouped by the following modes:</p>
			<p>
				<b>meiHead</b>
				<ul>
					<li>A new &lt;meiHead&gt; from <i>Werk-header_{kVNumber}</i> is inserted instead of the &lt;meiHead&gt; of the transformed file (path for the Werk-header: <i>K:\PROJEKTE\DMEDME\Edition\Referenztexte\{kvNumber})</i>.</li>
					<li>The placeholders in the Werk-header/&lt;meiHead&gt; are replaced by the calculated values.</li>
					<li>Additionaly, for &lt;perfresList&gt;: @analog, @authority are added.<ul/>
					</li>
					<li>Following elements from the original file are preserved and processed: <ul>
							<li>&lt;application&gt;<ul>
									<li>add left and right trim for the first and last text nodes respectively</li>
									<li>&lt;persName&gt;[@xml:id="JoKep"]: add <ul>
											<li><i>@authURI</i>='https://d-nb.info/gnd/174032757'</li>
											<li><i>@authority</i>='GND'</li>
											<li><i>@codedval</i>='174032757'</li>
										</ul></li>
									<li>&lt;persName&gt;[@xml:id="FKel"]: replace @<i>xml:id</i>='FKel' => @<i>analog</i>='#FK'</li>
									<li>&lt;ref&gt; for 'mozarteum.at': replace text to <i>Salzburg Mozarteum Foundation</i></li>
									<li>&lt;ref&gt; for 'edirom.de':<ul>
											<li> add 'https' for <i>@target</i>
											</li>
											<li>add &lt;corpName&gt; with following attributes: <ul>
													<li><i>@authURI</i>='https://d-nb.info/gnd/1095564986'</li>
													<li><i>@authority</i>='GND'</li>
													<li><i>@codedval</i>='1095564986'</li>
													<li>text: 'ViFE'</li>
												</ul></li>
										</ul>
									</li>
								</ul>
							</li>
							<li>&lt;perfRes&gt;:<ul>
									<li>
										<i>Adds:</i>
										<ul>
											<li>new IDs, according to the number and type, e.g. 'instrVoice_1', 'vocalVoice_1'</li>
											<li>@label and text content: e.g. 'flute-1'.</li>
											<li>@authority is deleted</li>
											<li>all &lt;workDesc&gt;/&lt;key&gt; attributes from the ISM-database</li>
										</ul>
									</li>
									<li>
										<i>Deletes:</i>
										<ul>
											<li>@authority</li>
										</ul>
									</li>
								</ul>
							</li>
							<li>&lt;revisionDesc&gt;:<ul>
									<li>Replace value for <i>@resp</i>: '#FKel' => '#FK'</li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
			</p>
			<p>
				<b>scoreDef</b>
				<ul>
					<li>&lt;scoreDef&gt;: <ul>
							<li>adds @key.mode, @key.pname, (@key.accid) from ISM-database</li>
							<li>adds temporary <i>@xml:id</i> (technical purpose only, is changed later)</li>
							<li>adds @optimize="false" (for genre="orchestral" or "chamber" only)</li>
						</ul>
						<pre/>
					</li>
					<li>&lt;staffDef&gt;<ul>
							<li>
								<ul><i>Adds:</i>
									<li>@label.abbr (for genre='orchestral' only)</li>
									<li>&lt;layerDef&gt;s (only if there are more than one values in the @dme.parts, e.g. @dme.parts='1 2')</li>
									<li>@decls (the parent node depends on that if there are &lt;layerDef&gt;s or not)</li>
									<li>&lt;label&gt;. The value is taken from one of the sources in the following precedence order: <ul>
											<li>&lt;label&gt;</li>
											<li>@label</li>
											<li>respective &lt;perfRes&gt;/@codedval</li>
										</ul>
									</li>
									<li>@trans.semi, @trans.diat, @key.sig for transposing instruments</li>
								</ul>
							</li>
							<li>Deletes:</li><ul>
								<li>@key.sig (non-transposing instruments)</li>
							</ul>
						</ul>
					</li>
					<li>Deletes redundant &lt;staffGrp/&gt; (if it has only one &lt;staffGrp/&gt;as a child and it doesn't have any staffDef as a child) <pre/>
					</li>
				</ul>
			</p>
			<p>
				<b>various_1 ('DcX_1')</b>
				<ul>
					<li>
						<i>Adds:</i>
						<ul>
							<li>facsimile/@decls="#digital_image"</li>
							<li>&lt;dir&gt;: wraps the text: "rallentando, calando, tenuto, ten., simile, semplice, pizzicato, pizz., arco, staccato, stacc." in a &lt;rend&gt;. Additionaly, for text ('a2', 'a 2') is changed to a{unicode}2</li>
							<li>&lt;chord/>: <ul>
									<li>@dots (if any of the child notes has a @dots, the value is the hightest of all notes)</li>
									<li>@dur (if this not exist already or if it's value is not the hightest value of @dur of the chord note descendants)</li>
								</ul>
							</li>
							<li>'#' to @startid, @endid, @resp</li>
							<li>@n to &lt;pb&gt;</li>
							<li>@curvedir="below" or changes its value to "below" if it is a &lt;slur&gt; of a grace note</li>
							<li>bTrem/@form="meas" if bTrem has @unitdur</li>
							<li>@tstamp to the tempo in the first measure (@n=('0', '1'))</li>
							<li>temporary <i>@xml:id</i>s to &lt;mdiv>,&lt;section>, (technical purpose only)</li>
						</ul>
						<pre/>
					</li>
					<li>
						<i>Deletes:</i>
						<ul>
							<li>bTrem[child::bTrem]</li>
						</ul>
						<pre/>
					</li>
					<li>
						<i>Changes:</i>
						<ul>
							<li>@artic: "stacciss" =&gt; "spicc"</li>
							<li>bTrem: @unitdur =&gt; @measperf</li>
						</ul>
						<pre/>
					</li>
				</ul>
			</p>
			<p>
				<b>various_2 (mode 'DcX_2.xsl')</b>
				<ul>
					<li>
						<i>Adds</i>:<ul>
							<li>@resp="#NMA-editors" to all &lt;supplied&gt; with no @resp</li>
							<li>&lt;note/>: @dots (if any other &lt;note/> in the &lt;chord/> has @dots)</li>
							<li>@stem.dir='up' to a grace note</li>
						</ul>
					</li>
					<li>
						<i>Changes:</i>
						<ul>
							<li>&lt;note/&gt;[@enclose="brack"]: wrapps the @accid into &lt;supplied/>; @enclose is deleted</li>
							<li>&lt;dynam/&gt;: @startid =&gt; @tstamp if text is: 'crescendo', 'cresc.', 'cre', 'scendo', 'scen', 'sotto voce', 'decrescendo'</li>
						</ul>
					</li>
				</ul>
			</p>
			<p>
				<b>splitDynams</b>
				<p>
					<i>Processes split crescendo: ('cre', 'scendo'), ('cre', 'scen', 'do'), ('crescen', 'do'). <b>Note:</b> children of 'orig', 'rdg' are excluded</i>
					<ul>
						<li>
							<i>Adds:</i>
							<ul>
								<li>@vrgp, @next, @extender, @label to the first part</li>
								<ul>
									<li>@vrgp, @next, @prev, @extender, @label to the second part if it is intermediate</li>
									<li>@vrgp, @prev, @label to the second part if it is terminate</li>
								</ul>
								<li>@vrgp, @prev, @label to the third part, if exists</li>
							</ul>
						</li>
					</ul>
				</p>
			</p>
			<p>
				<b><b>deleteAttributes</b></b>
				<p>
					<ul>
						<li>
							<i>Deletes</i>
							<ul>
								<li>@func='caution'</li>
								<li>@ho</li>
								<li>@vo</li>
								<li>@evidence='analogy'</li>
								<li>&lt;lem&gt;/@resp</li>
								<li>@tuplet</li>
								<li>staff/@codedval</li>
								<li>staff/@position</li>
								<li>dynam/@plist</li>
								<li>&lt;space&gt;/@layer = '1 2'</li>
								<li>&lt;note&gt;/@layer = '1 2'</li>
								<li>@mm</li>
								<li>@enclose</li>
								<li>@subtype</li>
								<li>@right[.='rptboth']</li>
								<li>@type[.=('enclose', 'upbeat', 'Verlagsnummer', 'bartext', 'ce')]</li>
								<li>@dme.parts (for genre='chamber' only)</li>
								<li>@stem.dir in the second layer (for genre='orchestral' only)</li>
							</ul>
						</li>
					</ul>
				</p>
			</p>
			<p>
				<b>applicationChanges</b>
				<ul>
					<li>Adds update entries to the &lt;application&gt;, &lt;changes&gt;.</li>
				</ul>
			</p>
			<p>
				<b>checkAccidentalsVisibility </b>
				<ul>
					<li>See documentation for <i>checkAccidentalsVisibility</i> as standalone stylesheet</li>
				</ul>
			</p>
			<p><i>Current version</i>: <b id="version">2.4.0</b>. For more info see the <b>changeLog</b>.</p>
			<p>
				<b>Author: </b>Oleksii Sapov</p>
		</desc>
	</doc>

	<param as="xs:string" name="fileName"/>
	<param as="xs:string" name="fileURL"/>

	<include href="modules/meiHead/meiHead.xsl"/>
	<include href="modules/options.xsl"/>
	<include href="modules/scoreDef.xsl"/>
	<include href="modules/DcX_1.xsl"/>
	<include href="modules/DcX_2.xsl"/>
	<include href="modules/deleteAttributes.xsl"/>
	<include href="modules/splitDynams.xsl"/>
	<include href="../lib/applicationChanges.xsl"/>
	<include href="../lib/functions/functions_DIME.xsl"/>
	<include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
	<include href="../lib/basic.xsl"/>
	<import href="changeLog.xsl"/>

	<variable as="document-node()" name="lists" select="doc('../lib/lists/lists.xml')"/>

	<variable as="map(xs:string, item()*)" name="options">
		<call-template name="options"/>
	</variable>
	<variable as="map(xs:string, item()*)" name="optionsCalc">
		<call-template name="optionsCalc"/>
	</variable>
	<variable name="movementID" select="map:get($optionsCalc, 'movementID')"/>
	<variable as="xs:string" name="KV" select="map:get($optionsCalc, 'KV')"/>

	<variable as="document-node()" name="processedFile" select="/"/>

	<variable name="meiHead">
		<choose>
			<when test="map:get($options, 'meiHead') = '1'">
				<apply-templates mode="meiHead" select="$processedFile"/>
			</when>
			<when test="map:get($options, 'meiHead') = '0'">
				<apply-templates mode="perfRes" select="$processedFile"/>
			</when>
		</choose>
	</variable>

	<variable name="scoreDef">
		<apply-templates mode="scoreDef" select="$meiHead"/>
	</variable>

	<variable name="DcX_1">
		<apply-templates mode="DcX_1" select="$scoreDef"/>
	</variable>

	<variable name="DcX_2">
		<apply-templates mode="DcX_2" select="$DcX_1"/>
	</variable>

	<variable name="splitDynams">
		<apply-templates mode="splitDynams" select="$DcX_2"/>
	</variable>

	<variable name="deleteAttributes">
		<apply-templates mode="deleteAttributes" select="$splitDynams"/>
	</variable>

	<variable name="applicationChanges">
		<apply-templates mode="applicationChanges" select="$deleteAttributes"/>
	</variable>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">

		<call-template name="trackChanges"/>

		<copy-of select="$applicationChanges"/>
	</template>




	<xd:doc>
		<xd:desc>Creates intermediate files for comparison.</xd:desc>
	</xd:doc>
	<template name="trackChanges">
		<variable name="vars" select="$meiHead, $scoreDef, $DcX_1, $DcX_2, $splitDynams, $deleteAttributes, $applicationChanges"/>


		<variable name="folder" select="substring($fileName, 8, 7) || '_track-changes\'"/>

		<result-document href="{$folder || '0.xml'}" indent="yes" method="xml">
			<copy-of select="."/>
		</result-document>

		<variable name="modi" select="'meiHead', 'scoreDef', 'various_1', 'various_2', 'splitDynams', 'deleteAttributes', 'applicationChanges'"/>
		<for-each select="$modi">
			<variable name="pos" select="position()"/>
			<result-document href="{$folder || $pos || '_' || . || '.xml'}" indent="yes" method="xml">
				<sequence select="$vars[$pos]"/>
			</result-document>
		</for-each>
	</template>

	<variable name="currentStylesheet" select="doc('')"/>
</stylesheet>
