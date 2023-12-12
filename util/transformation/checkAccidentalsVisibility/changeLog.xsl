<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>1.1.2</xd:b> (18.03.2020) <xd:ul>
					<xd:li>When applied as externals stylesheet of <xd:i>DOXconvX</xd:i>, a file for comparison is written into the <xd:i>track_changes</xd:i> folder.</xd:li> </xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>1.1.1</xd:b> (18.02.2020) <xd:ul>
					<xd:li>Improved handling of naturals.</xd:li>
					<xd:li>Elements with @sameas are taken into account.</xd:li>
					<xd:li>Excluded second tied note which first tied note is in the same measure.</xd:li>
					<xd:li>Handle the case when two &lt;accid&gt;s are present.</xd:li>
					<xd:li>Reorganized stylesheet(s).</xd:li>
					<xd:li>Added changeLog.</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:ul>
					<xd:li>20.09.2019: <xd:i>1.1.0</xd:i></xd:li>
					<xd:li>19.10.2018: <xd:i>1.0.1</xd:i></xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>

</xsl:stylesheet>
