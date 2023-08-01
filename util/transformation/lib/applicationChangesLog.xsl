<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme map mei " version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Nov 13, 2018</xd:p>
			<xd:p><xd:b>Author:</xd:b> Oleksii Sapov</xd:p>
			<xd:p>Adds &lt;application> and &lt;change>. If the file was already proccessed by the stylesheet, an error message appears.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:param as="xs:string" name="fileURI"/>
	<xsl:variable as="xs:string" name="file.name" select="tokenize($fileURI, '/')[last()]"/>
	<xsl:param as="xs:string" name="userHomeDirectory"/>

	<xsl:variable name="kvMovement" select="
			translate(substring-before(substring-after($file.name, '_'),
			'_'), '-', '')"/>

	<xsl:variable as="document-node()" name="lists" select="doc('./lists/lists.xml')"/>
	<xsl:variable as="xs:string" name="currentStylesheetName" select="tokenize(document-uri($currentStylesheet), '/')[last()]"/>
	<xsl:variable as="xs:string" name="versionXSLT" select="$currentStylesheet//xd:li[xd:i = 'Versions']/xd:ul/xd:li[last()]/xd:i/string()"/>
	<xsl:variable name="movementID" select="substring($file.name, 16, 4)"/>
	<xsl:variable name="applicationID" select="concat($currentStylesheetName, '_v', $versionXSLT)"/>
	<xsl:variable name="description" select="
			$currentStylesheet//xd:p[some $n in xd:b
				satisfies matches($n/text(), 'Description')]/xd:i[1]"/>
	<!-- TODO: 
        nothing
    -->

	<xd:doc>
		<xd:desc>Writes an intermediate file for better diff comparison. Add <![CDATA[
		<xsl:call-template name="copy-and-format"/>]]> to the main stylesheet.</xd:desc>

		<xd:param name="doc-node"/>
	</xd:doc>
	<xsl:template name="copy-and-format">
		<xsl:param name="doc-node" select="."/>
		<xsl:result-document href="{concat($file.name, '_0', '.xml')}" indent="yes" method="xml">
			<xsl:copy-of select="$doc-node"/>
		</xsl:result-document>
	</xsl:template>


	<xd:doc>
		<xd:desc>Writes an intermediate file for better diff comparison. Add <![CDATA[
		<xsl:call-template name="copy-and-format"/>]]> to the main stylesheet.</xd:desc>
		<xd:param name="arg1"/>

	</xd:doc>
	<xsl:template name="copy-and-format_DIME-tools">
		<xsl:param name="arg1" select="."/>

		<xsl:variable name="outputURI" select="resolve-uri($fileURI)"/>

		<xsl:result-document href="{replace($outputURI, '.xml', '_0.xml')}" indent="yes" method="xml">
			<xsl:copy-of select="$arg1"/>
		</xsl:result-document>
	</xsl:template>





	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="node() | @*" mode="#all">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="node() | @*"/>
		</xsl:copy>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="copy">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="@*, node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="application[not(following-sibling::application)]" mode="applicationChanges">
		<xsl:choose>
			<xsl:when test="id($applicationID)">
				<xsl:message terminate="no">WARNING: This file has already been processed by <xsl:value-of select="$currentStylesheetName"/>.xsl. In some cases it may lead to an eunexpected behavior. (You may check '//meiHead//changes)'.</xsl:message>
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
				<application xmlns="http://www.music-encoding.org/ns/mei">
					<xsl:attribute name="xml:id" select="$applicationID"/>
					<xsl:attribute name="version" select="$versionXSLT"/>
					<name>
						<xsl:value-of select="$currentStylesheetName"/>
					</name>
					<p><xsl:value-of select="$description"/>Developed by <persName analog="#OS">Oleksii Sapov</persName>.</p>
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
				<p>Processed with <ptr target="#{$applicationID}"/>.</p>
			</changeDesc>
		</change>
	</xsl:template>


	<xd:doc>
		<xd:desc>Param $nameType: 'fullName', 'initials'</xd:desc>
		<xd:param name="nameType"/>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:respPerson">
		<xsl:param name="nameType"/>
		<xsl:variable name="user" select="tokenize($userHomeDirectory, '/')[last() - 1]"/>

		<xsl:variable as="map(xs:string, xs:string)" name="namesMap">
			<xsl:choose>
				<xsl:when test="$user = 'dubowy'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Norbert Dubowy'"/>
						<xsl:map-entry key="'initials'" select="'ND'"/>
					</xsl:map>
				</xsl:when>
				<xsl:when test="$user = 'beier'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Mirijam Beier'"/>
						<xsl:map-entry key="'initials'" select="'MB'"/>
					</xsl:map>
				</xsl:when>
				<xsl:when test="$user = 'cividini'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Iacopo Cividini'"/>
						<xsl:map-entry key="'initials'" select="'IC'"/>
					</xsl:map>
				</xsl:when>
				<xsl:when test="$user = 'reininghaus'">
					<xsl:map>
						<xsl:map-entry key="'fullName'" select="'Till Reininghaus'"/>
						<xsl:map-entry key="'initials'" select="'TR'"/>
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
					<xsl:message>The name of the responsible person wasn't recognized. Please input it manually (replace 'NaN').</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="map:get($namesMap, $nameType)"/>
	</xsl:function>
</xsl:stylesheet>
