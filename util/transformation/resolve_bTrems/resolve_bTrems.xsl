<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>Resolves &lt;bTrem&gt; into &lt;note&gt;s or &lt;chord&gt;s</i>
			</p>
			<p>The transformation scenario includes <i>create-IDs</i> and <i>checkAccidentalsVisibiliy</i>. For <i>create-IDs</i> should be specified the option: <i>apply only to beam</i></p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.0.0</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>

	<include href="../lib/basic.xsl"/>
	<import href="changeLog.xsl"/>


	<template match="bTrem">
		<variable name="node" select="child::node()"/>

		<variable as="attribute()?" name="unit">
			<choose>
				<!--				MEI 3.0.0-->
				<when test="@measperf">
					<sequence select="@measperf"/>
				</when>
				<!--				MEI 4.0.0-->
				<when test="@unitdur">
					<sequence select="@unitdur"/>
				</when>
				<otherwise>
					<message><text>The unit on </text>
						<value-of select="@xml:id"/> is unrecognized!</message>
				</otherwise>
			</choose>
		</variable>

		<variable as="xs:integer" name="elsNumber" select="xs:integer($unit) div xs:integer($node/@dur)"/>

		<choose>
			<when test="child::chord or child::note">
				<call-template name="addBeam">
					<with-param as="xs:integer" name="elsNumber" select="$elsNumber" tunnel="yes"/>
					<with-param as="node()" name="node" select="$node" tunnel="yes"/>
					<with-param name="unit" select="$unit" tunnel="yes"/>
				</call-template>
			</when>
			<otherwise>
				<message>
					<text>Unusual input at </text>
					<xsl:value-of select="@xml:id"/>
				</message>
			</otherwise>
		</choose>
	</template>



	<template name="addBeam">
		<param name="unit" tunnel="yes"/>

		<choose>
			<when test="$unit = (8, 16, 32, 64)">
				<element name="beam" namespace="http://www.music-encoding.org/ns/mei">
					<call-template name="forEachElsElement"/>
				</element>
			</when>
			<otherwise>
				<call-template name="forEachElsElement"/>
			</otherwise>
		</choose>

	</template>



	<template name="forEachElsElement">
		<param name="elsNumber" tunnel="yes"/>
		<param name="node" tunnel="yes"/>

		<for-each select="1 to $elsNumber">
			<call-template name="copyNodes">
				<with-param name="nodes" select="$node"/>
				<with-param as="xs:integer" name="currCount" select="."/>
			</call-template>
		</for-each>
	</template>


	<template name="copyNodes">
		<param name="nodes"/>
		<param name="unit" tunnel="yes"/>
		<param name="currCount"/>


		<for-each select="$nodes">
			<copy>
				<apply-templates select="@* except (@dur, @stem.mod, @xml:id)"/>

				<if test="not(parent::chord)">
					<attribute name="dur" select="$unit"/>
				</if>

				<attribute name="xml:id" select="
						if ($currCount = 1) then
							@xml:id
						else
							@xml:id || '-' || $currCount"/>

				<if test="child::node()">
					<call-template name="copyNodes">
						<with-param name="nodes" select="child::node()"/>
						<with-param name="currCount" select="$currCount"/>
					</call-template>
				</if>
			</copy>
		</for-each>
	</template>

</stylesheet>
