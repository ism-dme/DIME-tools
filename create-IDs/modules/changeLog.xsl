<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:i>Versions</xd:i>: <xd:p>
				<xd:b>1.1.3</xd:b> (25.04.2020) <xd:ul>
					<xd:li>Change the &lt;mdiv&gt; counter: <xd:i>_1</xd:i> => <xd:i>_01</xd:i></xd:li>
					<xd:li>Add: &lt;zone&gt;/@xml:id are processed. Syntax: 'zoneOf_'{xml:id of the measure which corresponds via its @facs to the current ID}</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>1.1.2</xd:b> (10.03.2020) <xd:ul>
					<xd:li>change underscore to hyphen for the wrapper section, e.g.: “section_allegro-molto” >> “section_allegro_molto”</xd:li>
					<xd:li>deprecate the comparison file '_0.xml' option</xd:li>
					<xd:li>changed the input of the processed document</xd:li>
					<xd:li>add changeLog</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p><xd:ul>
					<xd:li>30.08.2019: <xd:i>1.1.1</xd:i></xd:li>
					<xd:li>24.07.2019: <xd:i>1.1.0</xd:i></xd:li>
					<xd:li>04.03.2019: <xd:i>1.0.0</xd:i></xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>

</xsl:stylesheet>
