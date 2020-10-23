<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xsl:template match="workDesc//key" mode="insertFromDatabase">

		<xsl:variable as="attribute()*" name="databaseAttrs" select="$databaseFileMovement//workDesc//key/@*"/>

		<xsl:element name="key" namespace="http://www.music-encoding.org/ns/mei">
			<xsl:for-each select="$databaseAttrs">
				<xsl:attribute name="{local-name()}" select="."/>
			</xsl:for-each>
		</xsl:element>

	</xsl:template>


</xsl:stylesheet>
