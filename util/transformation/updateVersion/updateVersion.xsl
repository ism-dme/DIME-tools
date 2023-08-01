<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
		<desc>
			<p>				
				<i>Updates the file version in the &lt;meiHead&gt;.</i>
			</p>
			<p>Description and type can be set in options.xml</p>					
			<pre> </pre>
			<p>
				<b>Created on: </b>Feb., 27, 2020.<ul>
					<li>
						<i>Versions</i>: <ul>
							<li>Feb. 27, 2020: <i>1.0.0</i></li>
						</ul>
					</li>
				</ul>
			</p>
			<p><b>Contributors</b>: Oleksii Sapov.<pre/><b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>		
		</desc>
	</doc>
	
	<xsl:include href="../lib/basic.xsl"/>
	<xsl:include href="../lib/applicationChanges.xsl"/>

	<xsl:template match="/">
		<xsl:apply-templates mode="updateVersion"/>
	</xsl:template>


	<xsl:variable as="map(xs:string, xs:string)" name="parametersDIMEtools">
		<xsl:variable name="allParams" select="doc('../options/options.xml')//id('updateVersion')/dme:parameters"/>
		<xsl:call-template name="params">
			<xsl:with-param name="allParams" select="$allParams"/>
		</xsl:call-template>
	</xsl:variable>


	<xsl:variable name="version">

		<xsl:variable as="array(*)" name="currVersion">
			<xsl:call-template name="currVersion"/>
		</xsl:variable>

		<xsl:variable as="xs:integer" name="updateType">
			<xsl:call-template name="updateType"/>
		</xsl:variable>

		<xsl:variable as="xs:integer" name="updated" select="
				let $current := array:get($currVersion, $updateType)
				return
					xs:integer($current) + 1
				"/>

		<xsl:variable name="updatedArray" select="array:put($currVersion, $updateType, string($updated))"/>

		<xsl:sequence>
			<xsl:call-template name="varVersionReturn">
				<xsl:with-param name="updatedArray" select="$updatedArray"/>
			</xsl:call-template>
		</xsl:sequence>

	</xsl:variable>

	<xsl:template match="editionStmt/edition/identifier[@type = 'version']" mode="updateVersion">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:value-of select="$version"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="editionStmt/edition/date[@type = 'release']" mode="updateVersion">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
		</xsl:copy>
		<date type="update" xmlns="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="isodate" select="substring(string(current-date()), 1, 10)"/>
		</date>
	</xsl:template>

	<xsl:template match="editionStmt/edition/date[@type = 'update']" mode="updateVersion"/>

	<xsl:template name="currVersion">
		<xsl:if test="empty(//editionStmt//identifier[@type = 'version']/data())">
			<xsl:message>
				<xsl:value-of select="'No current version specified.'"/>
			</xsl:message>
		</xsl:if>
		
		<xsl:sequence select=" 
			let $input := //editionStmt//identifier[@type='version']/data(),
			$array := tokenize($input, '[.]')			
			return 
			array{$array}"/>
		
	</xsl:template>

	<xsl:template name="updateType">
		<xsl:variable as="map(xs:string, xs:integer)" name="updateTypesMap">
			<xsl:call-template name="updateTypesMap"/>
		</xsl:variable>
		<xsl:sequence select="
				let $userInput := map:get($parametersDIMEtools, 'updateType')
				return
					map:get($updateTypesMap, $userInput) cast as xs:integer
				"/>
	</xsl:template>

	<xsl:template name="params">
		<xsl:param name="allParams"/>
		<xsl:map>
			<xsl:map-entry key="'text'" select="$allParams/id('freeInput')/string(text())"/>
			<xsl:map-entry key="'updateType'" select="$allParams/id('update')/string(@type)"/>
		</xsl:map>
	</xsl:template>

	<xsl:template name="updateTypesMap">
		<xsl:map>
			<xsl:map-entry key="'major'" select="1"/>
			<xsl:map-entry key="'minor'" select="2"/>
			<xsl:map-entry key="'patch'" select="3"/>
		</xsl:map>
	</xsl:template>

	<xsl:template name="varVersionReturn">
		<xsl:param name="updatedArray"/>
		<xsl:variable as="xs:string*" name="vals">
			<xsl:for-each select="1 to array:size($updatedArray)">
				<xsl:sequence select="array:get($updatedArray, .)"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:value-of select="string-join($vals, '.')"/>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="change[not(following-sibling::change)]" mode="updateVersion">
		<xsl:copy-of select="."/>

		<change isodate="{current-date()}" xmlns="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="n" select="number(@n) + 1"/>
			<xsl:attribute name="resp" select="concat('#', dme:respPerson('initials'))"/>
			<xsl:attribute name="isodate" select="substring(string(current-date()), 1, 10)"/>
			<changeDesc>
				<p>
					<xsl:value-of select="map:get($parametersDIMEtools, 'text')"/>
				</p>
				<p>Update to version <xsl:value-of select="$version"/>.</p>
			</changeDesc>
		</change>

	</xsl:template>
	<xsl:variable name="currentStylesheet" select="doc('')"/>
</xsl:stylesheet>
