<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<p>
					<i>Replaces &lt;dir&gt;@startid with @tstamp which value is derived from the referenced note.</i>
				</p>
			</p>
			<pre> </pre>
			<p>
				<b>Created on: </b>Sep, 23 2019, version 1.0.0<ul>
					<li>
						<i>Versions</i>: <ul>
							<li>23.09.2019: <i>1.0.0</i></li>
						</ul>
					</li>
				</ul>
			</p>
			<p><b>Contributors</b>: Oleksii Sapov.<pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>

	<xsl:include href="../lib/basic.xsl"/>
	<xsl:include href="../lib/applicationChanges.xsl"/>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="dir[@startid]" name="tstamp">
		<xsl:variable name="tstampValue" select="id(substring-after(@startid, '#'))/@tstamp"/>
		<xsl:copy>
			<xsl:attribute name="tstamp" select="$tstampValue"/>
			<xsl:apply-templates select="@* except @startid, node()"/>
		</xsl:copy>
		<xsl:message>Added @tstamp="<xsl:value-of select="$tstampValue"/>" on the "<xsl:value-of select="@startid"/>" and deleted its @startid.</xsl:message>
	</xsl:template>

	<xsl:variable name="currentStylesheet" select="doc('')"/>
</xsl:stylesheet>
