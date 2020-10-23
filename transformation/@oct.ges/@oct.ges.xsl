<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description:</xd:b>
				<xd:i/>
			</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>Xxx, x 2019<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>xx.xx.xxxx : <xd:i>1.0.0</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:include href="../lib/basic.xsl"/>
	<xsl:param as="xs:string" name="mdivN"/>
	<xsl:param as="xs:string" name="measureRange"/>

	<xsl:variable name="RegEx" select="'(^' || $measureRange || '$)'"/>



	<xsl:template match="//mdiv[@n = $mdivN]//measure[matches(@n, $RegEx)]//staff[@n = 4]//note">
		<xsl:copy>
			<xsl:attribute name="oct.ges" select="number(@oct) - 1"/>
			<xsl:apply-templates select="@*, node()"/>

		</xsl:copy>
	</xsl:template>

	<xsl:variable name="currentStylesheet" select="doc('')"/>
</xsl:stylesheet>
