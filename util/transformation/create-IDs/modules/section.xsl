<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="section" mode="section">

		<variable name="frstM" select="measure[1]/@n"/>
		<variable name="lstM" select="measure[last()]/@n"/>
		<variable name="letter">
			<variable name="sectCounter" select="count(preceding-sibling::section)"/>
			<value-of select="$lists.create-IDs//id('capitalLetters')/dme:item[$sectCounter + 1]"/>
		</variable>

		<copy>
			<variable as="xs:string" name="newID">

				<choose>
					<when test="parent::score and child::section">
						<call-template name="outerSection"/>
					</when>
					<!--if there are endings -->
					<when test=".[ending]">
						<variable name="lastM-ending" select=".//ending[last()]//measure[last()]/substring-before(@n, '_')"/>
						<value-of select="concat(local-name(), '_', $letter, '_m', $frstM, '-', $lastM-ending, dme:mdiv(.))"/>
					</when>
					<!--normal case-->
					<otherwise>
						<value-of select="concat(local-name(), '_', $letter, '_m', $frstM, '-', $lstM, dme:mdiv(.))"/>
					</otherwise>
				</choose>
			</variable>
			<attribute name="xml:id">
				<value-of select="$newID"/>
			</attribute>
			<apply-templates mode="#current" select="@* except @xml:id, node()"/>
		</copy>
	</template>


	<template name="outerSection">
		<variable as="element()+" name="firstMeasure" select="descendant::measure[@n = ('0', '1')]"/>
		<variable name="firstTempo">
			<choose>
				<when test="$firstMeasure/tempo/rend">
					<value-of select="
							if ($firstMeasure/tempo[@type = 'heading']) then
								$firstMeasure/tempo[@type = 'heading']/rend/text()
							else
								$firstMeasure/tempo/rend/text()"/>
				</when>
				<otherwise>
					<value-of select="
							if ($firstMeasure/tempo[@type = 'heading']) then
								$firstMeasure/tempo[@type = 'heading']/text()
							else
								$firstMeasure/tempo/text()"/>
				</otherwise>
			</choose>
		</variable>
		<variable name="translate" select="translate(lower-case($firstTempo), ' ', '_')"/>
		<value-of select="local-name() || '_' || $translate || dme:mdiv(.)"/>
	</template>
</stylesheet>
