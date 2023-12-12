<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:functx="http://www.functx.com" xmlns:dme="http://www.mozarteum.at/ns/dme" exclude-result-prefixes="xs xd mei dme functx" version="3.0">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b>05 Feb, 2019</xd:p>
			<xd:p><xd:b>Author:</xd:b>Oleksii Sapov</xd:p>
			<xd:p>Different messages for XSLT-converting</xd:p>
		</xd:desc>
	</xd:doc>
	

		
	<xd:doc>
		<xd:desc/>
		<xd:param name="value"/>
		<xd:param name="element"/>
		<xd:param name="attribute"/>
	</xd:doc>
	<xsl:template name="messageAttribute_1">
		<xsl:param name="value"/>
		<xsl:param name="element"/>
		<xsl:param name="attribute"/>

		<xsl:message terminate="no" xml:id="message">@<xsl:value-of select="$attribute"/> was added with value '<xsl:value-of select="$value"/>' to the element '<xsl:value-of select="$element/@xml:id"/>' [<xsl:value-of select="//mei:title[@xml:id = 'fd_tit_3']/text()"/>].</xsl:message>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<xsl:template name="messageElement">
		<xsl:param name="element" as="element()"/>
		<xsl:message terminate="no">Changed <xsl:value-of select="concat($element/name(), ' (xml:id=&quot;', $element/@xml:id, '&quot;)')"/> [<xsl:value-of select="//mei:title[@xml:id = 'fd_tit_3']/text()"/>].</xsl:message>
	</xsl:template>
	
	
	<xd:doc>
		<xd:desc/>
		<xd:param name="attribute"/>
	</xd:doc>
	<xsl:template name="messageAttribute_2" >
		<xsl:param name="attribute" as="attribute()"/>
		<xsl:message terminate="no">Changed the @<xsl:value-of select="$attribute/name()"/> of the element with xml:id="<xsl:value-of select="$attribute/../@xml:id"/>" [<xsl:value-of select="//mei:title[@xml:id = 'fd_tit_3']/text()"/>].</xsl:message>
	</xsl:template>

	


</xsl:stylesheet>
