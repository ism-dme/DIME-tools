<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc/>	
		<xd:param name="all"/>
		<xd:param name="els2apply"/>
		<xd:param name="els2exclude"/>
	</xd:doc>
	<template match="zone" mode="zone">
		<param name="all" tunnel="yes"/>
		<param name="els2apply" tunnel="yes"/>
		<param name="els2exclude" tunnel="yes"/>

		<copy>
			<choose>

				<when test="($all = 'YES' or local-name() = $els2apply) and not(local-name() = $els2exclude)">
					<variable as="xs:string" name="newID">
						<call-template name="newID"/>
					</variable>

					<attribute name="xml:id">
						<value-of select="$newID"/>
					</attribute>
					<call-template name="oldID"/>
					<apply-templates mode="#current" select="@* except (@xml:id, node())"/>
				</when>
				<otherwise>
					<apply-templates mode="#current" select="@*, node()"/>
				</otherwise>
			</choose>

		</copy>
	</template>


</stylesheet>
