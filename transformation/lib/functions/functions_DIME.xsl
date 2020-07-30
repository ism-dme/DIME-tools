<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Oct 22, 2018</xd:p>
			<xd:p><xd:b>Author:</xd:b>Oleksii Sapov</xd:p>
			<xd:p>Functions library for DIME.</xd:p>
		</xd:desc>
	</xd:doc>



	<xd:doc>
		<xd:desc>Outputs a sequence of strings.</xd:desc>
		<xd:param name="arg1">Input element which contains the string.</xd:param>
		<xd:param name="arg2">ID of the input field (DIME-tools, optional)</xd:param>
	</xd:doc>
	<xsl:function name="dme:tokValues">
		<xsl:param as="element()" name="arg1"/>
		<xsl:param as="xs:string" name="arg2"/>

		<xsl:variable name="textNode " select="$arg1/id($arg2)/string(text())"/>

		<xsl:sequence select="
				for $n in tokenize($textNode, ',')
				return
					normalize-space($n)"/>

	</xsl:function>

</xsl:stylesheet>
