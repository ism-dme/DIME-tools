<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>				
				<i>Converts @artic, @accid, @accid.ges to &lt;artic&gt;, &lt;accid&gt; respectively</i>
			</p>
			<p><b>Note</b>: <i>@xml:id</i>s need to be created separately</p>			
		<pre> </pre>
			<p><b>Current version</b>: <b id="version">2.0.0</b>. For the details see changeLog.</p>			
			<p><b>Contributors</b>: Oleksii Sapov. <pre/> <b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>						
		</desc>
	</doc>

	<include href="../lib/basic.xsl"/>
	<import href="changeLog.xsl"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">

		<variable name="addEls">
			<apply-templates mode="addEls" select="."/>
		</variable>

		<copy-of select="$addEls"/>
	</template>

	<variable name="attributes" select="'artic', 'accid', 'accid.ges'"/>
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="note[@*[local-name() = $attributes]]" mode="addEls">

		<copy>
			<apply-templates mode="#current" select="@* except (@artic, @accid, @accid.ges), node()"/>
			<if test="@artic">
				<artic xmlns="http://www.music-encoding.org/ns/mei">
					<xsl:attribute name="artic">
						<xsl:value-of select="@artic"/>
					</xsl:attribute>
				</artic>
			</if>
			<if test="@accid | @accid.ges">
				<accid xmlns="http://www.music-encoding.org/ns/mei">
					<xsl:choose>
						<xsl:when test="@accid">
							<xsl:attribute name="accid">
								<xsl:value-of select="@accid"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="accid.ges">
								<xsl:value-of select="@accid.ges"/>
							</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
				</accid>
			</if>
		</copy>
	</template>

</stylesheet>
