<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description:</xd:b>
				<xd:i>Updates the version of DIME-files.</xd:i>
			</xd:p>
			<xd:p>The update description and update type are set in DIME-tools.xml</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>Feb., 27, 2020.<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>Feb. 27, 2020: <xd:i>1.0.0</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:include href="../lib/basic.xsl"/>	
	<xsl:include href="../lib/applicationChanges.xsl"/>	

	<xsl:template match="/">
		<xsl:apply-templates mode="updateVersion"/>
	</xsl:template>


	<xsl:variable as="map(xs:string, xs:string)" name="parametersDIMEtools">
		<xsl:variable name="allParams" select="doc('../lib/DIME-tools/DIME-tools.xml')//id('updateVersion')/dme:parameters"/>
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
