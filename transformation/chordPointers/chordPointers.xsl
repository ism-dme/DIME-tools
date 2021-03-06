<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>If &lt;slur&gt; or &lt;dynam&gt; points to a &lt;note&gt; which is a &lt;chord&gt; descendant, the value of @startid/@endid is replaced by the &lt;chord&gt;@xml:id .</i>
			</p>
			<p><b>Note</b>: If there exist more than one &lt;slur&gt; which starts/ends from/at &lt;chord&gt; the &lt;note&gt;-reference will be preserved.</p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.1.0</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>

	<include href="../lib/basic.xsl"/>
	<import href="changeLog.xsl"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="slur | dynam[@startid]">
		<copy>
			<iterate select="@startid, @endid">
				<call-template name="replacePointer">
					<with-param name="pointer" select="."/>
				</call-template>
			</iterate>
			<apply-templates select="@* except (@endid, @startid), node()"/>
		</copy>
	</template>


	<xd:doc>
		<xd:desc>Replaces the value of @startid or @endid</xd:desc>
		<xd:param name="pointer"/>
	</xd:doc>
	<template name="replacePointer">
		<param as="attribute()" name="pointer"/>

		<variable name="reference" select="id(substring-after($pointer, '#'))"/>

		<variable as="xs:boolean" name="testChord">
			<call-template name="testChord">
				<with-param name="IDref" select="$reference"/>
			</call-template>
		</variable>

		<attribute name="{local-name($pointer)}" select="
				if ($testChord) then
					'#' || string($reference/ancestor::chord/@xml:id)
				else
					string($pointer)"/>
	</template>

	<xd:doc>
		<xd:desc>Checks if there exists a chord. If yes, checks if there are more then one slur which starts/ends from/at this chord. If yes, the note reference should be preserved.</xd:desc>
		<xd:param name="IDref"/>
	</xd:doc>
	<template name="testChord">
		<param name="IDref"/>

		<choose>
			<when test="$IDref/ancestor::chord">
				<choose>

					<when test="parent::node()/local-name() = 'slur'">
						<call-template name="slurCase">
							<with-param name="IDref" select="$IDref"/>
						</call-template>
					</when>
					<when test="parent::node()/local-name() = 'dynam'">
						<value-of select="true()"/>
					</when>
				</choose>
			</when>
			<otherwise>
				<value-of select="false()"/>
			</otherwise>
		</choose>

	</template>

	<xd:doc>
		<xd:desc>Additional check for the slur: when a chord has more then one slur, the note pointers should be preserved.</xd:desc>
		<xd:param name="IDref"/>
	</xd:doc>
	<template name="slurCase">
		<param name="IDref"/>

		<variable name="chordDescendants" select="
				for $ID in $IDref/ancestor::chord//@xml:id
				return
					'#' || $ID"/>

		<variable name="slursRefs" select="
				let $currName := local-name(.)
				return
					$IDref/ancestor::mdiv//slur[@*[local-name() = $currName] = $chordDescendants]"/>

		<value-of select="
				if (count($slursRefs) > 1) then
					false()
				else
					true()"/>
	</template>


</stylesheet>
