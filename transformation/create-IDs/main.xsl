<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<include href="modules/prepareIDs.xsl"/>
	<include href="modules/matchBody.xsl"/>
	<include href="modules/options.xsl"/>
	<include href="modules/zone.xsl"/>
	<include href="../lib/basic.xsl"/>
	<include href="../lib/functions/functions_DIME.xsl"/>
	<include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
	<include href="../lib/shared_stylesheets/count_measures_shared.xsl"/>



	<variable as="xs:boolean" name="DIME-FileNaming" select="matches($fileName, '[a-z]{6}_\d{3}-\d{3}_')"/>
	<variable as="map(xs:string, item()*)" name="options">
		<call-template name="options"/>
	</variable>
	<variable as="map(xs:string, item()*)?" name="optionsCalc">
		<call-template name="optionsCalc"/>
	</variable>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">
		<variable name="prepareIDs">
			<apply-templates mode="prepareIDs" select="."/>
		</variable>

		<variable name="countMeasures">
			<choose>
				<when test="map:get($options, 'recount_measures') = 'YES'">
					<variable name="output">
						<apply-templates mode="countMeasures" select="$prepareIDs"/>
					</variable>
					<copy-of select="$output"/>
				</when>
				<otherwise>
					<copy-of select="$prepareIDs"/>
				</otherwise>
			</choose>
		</variable>

		<variable name="all" select="map:get($options, 'all')"/>
		<variable name="els2apply" select="map:get($options, 'els2apply')"/>
		<variable name="els2exclude" select="map:get($options, 'els2exclude')"/>
		<variable name="addSuffix" select="
				if (map:get($options, 'addSuffix') = 'YES') then
					true()
				else
					false()"/>
		<variable name="suffix" select="map:get($options, 'suffix')"/>

		<variable name="main">
			<apply-templates mode="matchBody" select="$countMeasures">
				<with-param name="arg1" select="$all" tunnel="yes"/>
				<with-param name="arg2" select="$els2apply" tunnel="yes"/>
				<with-param name="arg3" select="$els2exclude" tunnel="yes"/>
				<with-param name="addSuffix" select="$addSuffix" tunnel="yes"/>
				<with-param name="suffix" select="$suffix" tunnel="yes"/>
			</apply-templates>
		</variable>

		<variable name="zone">
			<apply-templates mode="zone" select="$main">
				<with-param name="all" select="$all" tunnel="yes"/>
				<with-param name="els2apply" select="$els2apply" tunnel="yes"/>
				<with-param name="els2exclude" select="$els2exclude" tunnel="yes"/>
			</apply-templates>
		</variable>

		<variable name="output">
			<choose>
				<when test="
						($all = 'YES' or (some $n in $els2apply
							satisfies $n = 'section')) and not(some $n in $els2exclude
							satisfies ($n = 'section'))">
					<variable name="section">
						<apply-templates mode="section" select="$zone"/>
					</variable>
					<apply-templates mode="references" select="$section"/>
				</when>
				<otherwise>
					<apply-templates mode="references" select="$zone"/>
				</otherwise>
			</choose>
		</variable>

		<copy-of select="$output"/>
	</template>


</stylesheet>
