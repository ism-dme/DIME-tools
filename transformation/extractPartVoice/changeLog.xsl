<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>			
			<xd:p>
				<xd:b>1.1.0</xd:b>released on  March, 04., 2020
				<xd:ul>
					<xd:li>Changed the internal logic for the mode <xd:i>extractLayer</xd:i> due to the deprecated encoding convention for beamed notes.</xd:li>
					<xd:li>Original <xd:i>@doxml:id</xd:i> is preserved (except for child nodes of the element[@sameas]</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p><xd:i>Versions</xd:i>: <xd:ul>
					<xd:li>24.10.2019: <xd:i>1.0.0</xd:i></xd:li>
					<xd:li>22.11.2019: <xd:i>1.0.1</xd:i></xd:li>
					<xd:li>16.12.2019: <xd:i>1.0.2</xd:i></xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>

</xsl:stylesheet>
