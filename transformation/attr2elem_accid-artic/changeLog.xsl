<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>2.0.0</xd:b> (01.07.2020) <xd:ul>
					<xd:li>deleted the functionality for the automatically adding the @xml:ids as this is currently better to do with <xd:i>create-IDs.xsl</xd:i> separately</xd:li> </xd:ul>
			</xd:p>
			<xd:p>
				<xd:li>internal: <xd:ul><xd:li>changed the defalut namespace to <xd:i>xsl</xd:i></xd:li><xd:li>included basic.xsl instead of copy-and-format.xsl</xd:li></xd:ul></xd:li>
			</xd:p>
			<xd:p>
				<xd:ul>
					<xd:li>01.07.2020: <xd:i>2.0.0</xd:i></xd:li>
					<xd:li>08.05.2018: <xd:i>1.0.0</xd:i></xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>

</xsl:stylesheet>
