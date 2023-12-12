<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="iso map dme xs xd xsl schematron sqf" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:schematron="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<template name="discoverPhases">

		<variable as="xs:string*" name="phases-from-unique_rules" select="$unique_rules//schematron:phase/@id/string()"/>

		<variable as="xs:string*" name="phases-from-topics">
			<for-each select="//*[@props = 'rules']">
				<for-each select="document(@href, .)//dlentry[dt/text() = 'phase']//dd/text()/normalize-space()">
					<value-of select="."/>
				</for-each>
			</for-each>
		</variable>

		<variable as="xs:string*" name="join">
			<sequence select="$phases-from-topics, $phases-from-unique_rules"/>
		</variable>

		<variable name="split-clean" select="
				for $n in $join
				return
					for $t in
					tokenize($n, ',')
					return
						normalize-space($t)"/>

		<!--checks if there were an empty entry, could happen if you have a standalone ','`-->
		<sequence select="
				let $distinct := distinct-values($split-clean),
					$pos := index-of($distinct, '')
				return
					remove($distinct, $pos)
				"/>
	</template>


</stylesheet>
