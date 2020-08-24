<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs math xd mei uuid dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>Checks if the sum of the durations for the elements with @tstamp in a &lt;layer&gt; is correct.</i>
			</p>
			<p>The stylesheet outputs the file <i>wrong_durations.txt</i> which contains a list of the &lt;layer&gt;s/@xml:ids where the durations are possibly wrong.</p>
			<p>The events in the following &lt;layer&gt;s are not considered:<ul>
					<li>Descendants of uncomplete measures (@metcon='false')</li>
					<li>&lt;layer&gt;s which have &lt;mRest&gt;, &lt;app&gt;, &lt;choice&gt; or &lt;tuplet&gt; as descendants</li>
					<li>&lt;layer&gt;[@sameas]</li>
				</ul>
			</p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.0.1</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov, Johannes Kepper. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>
	<include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
	<import href="changeLog.xsl"/>

	<variable name="exceptions" select="'beatRpt', 'halfmRpt'"/>
	<variable name="break" select="'&#xA;'"/>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">

		<variable as="text()*" name="wrong_durations">
			<call-template name="layers">
				<with-param name="layers" select="//layer[not(@sameas)][not(ancestor::measure[@metcon = 'false'])][not(descendant::mRest | descendant::app | descendant::choice)][not(descendant::tuplet)]"/>
			</call-template>
		</variable>

		<result-document href="wrong_durations.txt">
			<copy-of select="string-join($wrong_durations, $break)"/>
		</result-document>
	</template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template name="layers">
		<param name="layers"/>

		<for-each select="$layers">
			<call-template name="durations"/>
		</for-each>
	</template>


	<template match="layer" name="durations">

		<variable as="xs:integer" name="meter.count" select="preceding::scoreDef[@meter.count][1]/@meter.count cast as xs:integer"/>
		<variable as="xs:integer" name="meter.unit" select="preceding::scoreDef[@meter.unit][1]/@meter.unit cast as xs:integer"/>
		<!--<variable name="events" select=".//*[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]"/>-->
		<variable as="element()*" name="events">
			<call-template name="vEvents"/>
		</variable>
		<variable as="xs:double*" name="durations" select="dme:durations($events, $meter.count, $meter.unit)"/>

		<variable name="expectedCount" select="(1 div $meter.unit) * $meter.count"/>

		<if test="not(sum($durations) = $expectedCount)">
			<value-of select="@xml:id"/>
		</if>

	</template>


	<xd:doc>
		<xd:desc>
			<xd:p>Returns sequence of the elements which fulfill the following constraints: <xd:ul>
					<xd:li>have @dur</xd:li>
					<xd:li>are not descendant of a &lt;chord&gt;</xd:li>
					<xd:li>belong to the $exceptions</xd:li>
				</xd:ul></xd:p>
		</xd:desc>
	</xd:doc>
	<template name="vEvents">
		<for-each select=".//*">
			<choose>
				<when test="@sameas">
					<variable name="reference" select="substring-after(@sameas, '#') => id()"/>
					<if test="$reference[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]">
						<sequence select="functx:add-attributes(., QName('http://www.music-encoding.org/ns/mei', 'mei:dur'), $reference/@dur)"/>
					</if>
				</when>
				<when test="@copyof">
					<variable name="reference" select="substring-after(@copyof, '#') => id()"/>
					<if test="$reference[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]">
						<sequence select="functx:add-attributes(., QName('http://www.music-encoding.org/ns/mei', 'mei:dur'), $reference/@dur)"/>
					</if>
				</when>
				<otherwise>
					<if test=".[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]">
						<sequence select="."/>
					</if>
				</otherwise>
			</choose>
		</for-each>
	</template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="events"/>
		<xd:param name="meter.count"/>
		<xd:param name="meter.unit"/>
	</xd:doc>
	<function as="xs:double*" name="dme:durations">
		<param name="events"/>
		<param name="meter.count"/>
		<param name="meter.unit"/>

		<for-each select="$events">
			<variable as="attribute()?" name="dur_attr" select="@*[local-name() = 'dur']"/>
			<variable as="xs:double" name="dur">
				<choose>
					<when test="$dur_attr">
						<value-of select="1 div number($dur_attr)"/>
					</when>
					<when test="local-name() = 'beatRpt'">
						<value-of select="1 div $meter.unit"/>
					</when>
					<when test="local-name() = 'halfmRpt'">
						<value-of select="($meter.count div 2) div $meter.unit"/>
					</when>
				</choose>
			</variable>
			<variable as="xs:double" name="tupletFactor">
				<choose>
					<when test="ancestor::tuplet">
						<value-of select="(ancestor::tuplet)[1]/number(@numbase) div (ancestor::tuplet)[1]/number(@num)"/>
					</when>
					<otherwise>
						<value-of select="1"/>
					</otherwise>
				</choose>
			</variable>
			<variable as="xs:double" name="dots">
				<choose>
					<when test="@dots">
						<value-of select="number(@dots)"/>
					</when>
					<otherwise>
						<value-of select="0"/>
					</otherwise>
				</choose>
			</variable>
			<value-of select="(2 * $dur - ($dur div math:pow(2, $dots))) * $tupletFactor"/>
		</for-each>
	</function>

	<output indent="yes" method="text"/>
</stylesheet>
