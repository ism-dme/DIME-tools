<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt3" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--<pattern>
		<rule context="tbody//entry[5]">
			<!-\-<xsl:for-each select="li">-\->
				
				<let name="extender1" value="normalize-space(preceding-sibling::entry[1]//li[1]/string())"/>

				<report test="(descendant::li[1] ='') and ($extender1 = 'true')">The element which has an extender msut have tstamp2. </report>

			<!-\-</xsl:for-each>-\->

		</rule>
	</pattern>-->

	<pattern>
		<rule context="tbody//entry[6]/text()">

			<let name="f1" value="ancestor::row//entry[3]//li[1]"/>
			<let name="f2" value="ancestor::row//entry[3]//li[2]"/>
			<let name="f3" value="ancestor::row//entry[3]//li[3]"/>

			<report test="($f1 = '') and (contains(., 'f1'))">The value for f1 is not defined.</report>

			<report test="($f2 = '') and (contains(., 'f2'))">The value for f2 is not defined.</report>

			<report test="($f3 = '') and (contains(., 'f3'))">The value for f3 is not defined.</report>

		</rule>
	</pattern>
</schema>
