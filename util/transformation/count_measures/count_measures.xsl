<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>Adds @n to &lt;measure></p>
			<p><b>Rules</b>:<pre/>Counts &lt;measure>s within each &lt;mdiv> separately.<pre/> Special cases:<pre/>
				<ul><b>&lt;ending></b>: <ul>
						<li>1st (ending): @n="nA"</li>
						<li>2nd: @n="nB"</li> for &lt;measure>/@metcon="false" inside the &lt;ending&gt; <li>1st: @n="naA"</li>
						<li>2nd: @n="nbA"</li> Note: <i>n</i> means <i>any integer</i>
					</ul>
				</ul>
				<pre/>
				<b>&lt;mdiv>/&lt;measure>/@metcon="false"</b>
				<ul>
					<li>first position: @n="0"</li>
					<li>last position: @n="n"</li>
				</ul>
				<pre/>
				<b>&lt;section>/&lt;measure>/@metcon="false"</b>
				<ul>
					<li>last position: @n="na"</li>
					<li>first position: @n="nb" (excl. 'zeroMeasure')</li>
				</ul>
			</p>
			<p><b>Notes</b>: <ul>
					<li>&lt;measure>/@metcon="false" and &lt;endings> have to be set correctly</li>
					<li>Following cases are not implemented<ul>
							<li>there are multiple &lt;measure>s within an &lt;ending> as well as the this combintation with @metcon="false"</li>
							<li>The &lt;measure> is wrapped in an &lt;app></li>
						</ul></li>
				</ul>
			</p>
			<pre> </pre>
			<p>
				<b>Created on: </b>August, 2 2018, version 1.0.0<ul>
					<li>
						<i>Versions</i>: <ul>
							<li>23.07.2019: <i>1.1.0</i></li>
						</ul>
					</li>
				</ul>
			</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/> <b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>					
		</desc>
	</doc>
	
	<include href="../lib/shared_stylesheets/count_measures_shared.xsl"/>
	<include href="../lib/basic.xsl"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">

		<variable name="prepareIDs">
			<apply-templates mode="prepareIDs" select="."/>
		</variable>

		<variable name="output">
			<apply-templates mode="countMeasures" select="$prepareIDs"/>
		</variable>

		<copy-of select="$output"/>
	</template>

	<xd:doc>
		<xd:desc>temporary IDs.</xd:desc>
	</xd:doc>
	<template match="mdiv | section" mode="prepareIDs">
		<copy>
			<attribute name="xml:id">
				<value-of select="generate-id()"/>
			</attribute>
			<apply-templates mode="#current" select="@*, node()"/>
		</copy>
	</template>


</stylesheet>
