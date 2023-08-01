<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme map mei " version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Nov 13, 2018</xd:p>
			<xd:p><xd:b>Author:</xd:b> Oleksii Sapov</xd:p>
			<xd:p>Adds &lt;application> and &lt;change>. If the file was already proccessed by the stylesheet, an error message appears.</xd:p>
		</xd:desc>
	</xd:doc>

	<xsl:param as="xs:string" name="userHomeDirectory"/>

	<!-- TODO: 
        nothing
    -->

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="application[not(following-sibling::application)]" mode="applicationChanges">
		<xsl:choose>
			<xsl:when test="id(dme:applicationValues('applicationID'))">
				<xsl:message terminate="no">WARNING: This file has already been processed by <xsl:value-of select="dme:applicationValues('currentStylesheetName')"/>.</xsl:message>
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
				<application xmlns="http://www.music-encoding.org/ns/mei">
					<xsl:attribute name="xml:id" select="dme:applicationValues('applicationID')"/>
					<xsl:attribute name="version" select="dme:applicationValues('versionXSLT')"/>
					<name>
						<xsl:value-of select="dme:applicationValues('currentStylesheetName')"/>
					</name>
					<p><xsl:value-of select="dme:applicationValues('description')"/> Developed by <persName sameas="#OS">Oleksii Sapov</persName>.</p>
				</application>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="change[not(following-sibling::change)]" mode="applicationChanges">
		<xsl:copy-of select="."/>
		<change xmlns="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="n" select="number(@n) + 1"/>
			<xsl:attribute name="resp" select="concat('#', dme:respPerson('initials'))"/>
			<xsl:attribute name="isodate" select="substring(string(current-date()), 1, 10)"/>
			<changeDesc>
				<p>Processed with <ptr target="#{dme:applicationValues('applicationID')}"/>.</p>
			</changeDesc>
		</change>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="reqValue">E.g.: currentStylesheetName</xd:param>
	</xd:doc>
	<xsl:function name="dme:applicationValues">
		<xsl:param name="reqValue"/>

		<xsl:variable as="xs:string" name="currentStylesheetName" select="tokenize(document-uri($currentStylesheet), '/')[last()]"/>
		<xsl:variable as="xs:string" name="versionXSLT" select="$currentStylesheet//xd:doc//*[@id = 'version']/string(text())"/>
		<xsl:variable name="applicationID" select="concat($currentStylesheetName, '_v', $versionXSLT)"/>
		<xsl:variable name="description" select="($currentStylesheet//xd:doc[@scope = 'stylesheet']//xd:p)[1]//xd:i"/>

		<xsl:choose>
			<xsl:when test="$reqValue = 'currentStylesheetName'">
				<xsl:value-of select="$currentStylesheetName"/>
			</xsl:when>
			<xsl:when test="$reqValue = 'versionXSLT'">
				<xsl:value-of select="$versionXSLT"/>
			</xsl:when>
			<xsl:when test="$reqValue = 'applicationID'">
				<xsl:value-of select="$applicationID"/>
			</xsl:when>
			<xsl:when test="$reqValue = 'description'">
				<xsl:value-of select="$description"/>
			</xsl:when>
		</xsl:choose>

	</xsl:function>

	<xd:doc>
		<xd:desc>Param $nameType: 'fullName', 'initials'</xd:desc>
		<xd:param name="nameType"/>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:respPerson">
		<xsl:param name="nameType"/>
		<xsl:variable name="user" select="tokenize($userHomeDirectory, '/')[last() - 1]"/>

		<xsl:variable as="map(xs:string, xs:string)" name="namesMap">
			<xsl:choose>
			  <xsl:when test="$user = 'roland.mair-gruber'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Roland Mair-Gruber'"/>
						<xsl:map-entry key="'initials'" select="'RMG'"/>
					</xsl:map>
				</xsl:when>
			  <xsl:when test="$user = 'anna.bernroider'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Anna Bernroider'"/>
						<xsl:map-entry key="'initials'" select="'ABE'"/>
					</xsl:map>
				</xsl:when>
				<xsl:when test="$user = 'cividini'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Iacopo Cividini'"/>
						<xsl:map-entry key="'initials'" select="'IC'"/>
					</xsl:map>
				</xsl:when>			
				<xsl:when test="$user = 'sapov'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Oleksii Sapov'"/>
						<xsl:map-entry key="'initials'" select="'OS'"/>
					</xsl:map>
				</xsl:when>
				<xsl:when test="$user = 'kelnreiter'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Franz Kelnreiter'"/>
						<xsl:map-entry key="'initials'" select="'FK'"/>
					</xsl:map>
				</xsl:when>
				<xsl:when test="$user = 'gruender'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Felix Gründer'"/>
						<xsl:map-entry key="'initials'" select="'FG'"/>
					</xsl:map>
				</xsl:when>
				<xsl:otherwise>
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'NaN'"/>
						<xsl:map-entry key="'initials'" select="'NaN'"/>
					</xsl:map>
					<xsl:message>The name of the responsible person wasn't recognized. Please input it manually by replacing 'NaN'.</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="map:get($namesMap, $nameType)"/>
	</xsl:function>
</xsl:stylesheet>
