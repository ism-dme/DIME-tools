<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei math uuid dme" extension-element-prefixes="exsl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:exsl="http://exslt.org/common" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>Prepares a 'dmeref'-file for editing.</i>
				<ul>
					<li>
						<b>Extracts</b>
						<ul>
							<li>The values from &lt;corr>, &lt;lem>, &lt;supplied>, &lt;body>//&lt;rend>, &lt;body>//&lt;ref></li>
						</ul>
					</li>
					<li><b>Deletes</b>: <ul>
							<li>All &lt;pb>, &lt;sb>, &lt;surface>, &lt;body>//&lt;annot></li>
							<li>All @doxml.id, &lt;measure>/@facs</li>
							<li>Elements which point to an element in &lt;orig&gt;/&lt;rdg&gt;, e.g. &lt;slur&gt;</li>
						</ul>
					</li>
					<li>&lt;meiHead&gt; is replaced by a minimal one</li>
					<li><b>Adds</b>:<ul>
							<li>A suffix to all @xml:id's and its references in &lt;body&gt;, e.g. xml:id='note_123' becomes 'note_123-B1'</li>
						</ul>
					</li>
				</ul>
			</p>
			<p>
				<i>Notes for applying the transformation:</i>
				<ul>
					<li>The stylesheet is meant to be applied on a 'dmeref'-file, the output will be a 'dmeedt' file in the same repository</li>
					<li>@xml:id's in 'dmeref' should not contain '-'. If any exist, a message will prompt and these @xml:id's as well as their references should be checked manually.</li>
				</ul>
			</p>
			<pre> </pre>
			<p>
				<ul>
					<b>Versions</b>
					<li>
						<ul>
							<li>26.08.2019: <i>1.0.4</i></li>
							<li>12.04.2019: <i>1.0.3</i></li>
							<li>22.10.2018: <i>1.0.2</i></li>
							<li>17.08.2018: <i>1.0.1</i></li>
							<li>13.07.2018: <i>1.0.0</i></li>
						</ul>
					</li>
				</ul>
			</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>
	<xsl:param name="fileName"/>
	<xsl:param name="editionType"/>

	<xsl:variable name="newFileName" select="replace($fileName, 'dmeref', concat('dmeedt', $editionType))"/>

	<xsl:include href="included/del_NMA-spirit.xsl"/>
	<xsl:include href="included/add_suffixes.xsl"/>


	<xd:doc>
		<xd:desc>Processes the current document-node() with various modes.</xd:desc>
	</xd:doc>
	<xsl:template match="/">

		<xsl:variable name="del_NMA-spirit">
			<xsl:apply-templates mode="del_NMA-spirit" select="."/>
		</xsl:variable>

		<xsl:variable name="output">
			<xsl:apply-templates mode="add_suffixes" select="$del_NMA-spirit"/>
		</xsl:variable>

		<xsl:variable name="outputFIle" select="$newFileName"/>
		<xsl:result-document href="{$outputFIle}" indent="yes">
			<xsl:copy-of select="$output"/>
		</xsl:result-document>

	</xsl:template>


	<xd:doc>
		<xd:desc>Identity transform</xd:desc>
	</xd:doc>
	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="node() | @*"/>
		</xsl:copy>
	</xsl:template>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:strip-space elements="*"/>
</xsl:stylesheet>
