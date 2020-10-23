<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<b>Description:</b>
				<i>Replaces &lt;rest&gt; with &lt;space&gt;</i>. </p>
			<p>Developed for the special case of piano music: after dox2mei there exist two rests in the the first and second &lt;layer&gt; with the same parameters.</p>
			<p>You may try the <i>mre_1.mei</i> example placed in the &lt;source&gt;/mre folder.</p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.0.0 (12.10.2020 )</b>. </p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>

	<include href="../lib/basic.xsl"/>


	<template match="layer[@n = 2]//rest">
		<variable name="respRest" select="ancestor::staff/layer[@n = 1]/rest"/>
		<choose>
			<when test="($respRest/@tstamp = @tstamp) and ($respRest/@dur = @dur)">
				<element name="space" namespace="http://www.music-encoding.org/ns/mei">
					<attribute name="xml:id" select="'space_' || substring-after(@xml:id, '_')"/>
					<apply-templates select="@* except @xml:id, node()"/>
				</element>
			</when>
			<otherwise>
				<copy>
					<apply-templates select="@*, node()"/>
				</copy>
			</otherwise>
		</choose>

	</template>

	<!--<variable name="currentStylesheet" select="doc('')"/>-->
</stylesheet>
