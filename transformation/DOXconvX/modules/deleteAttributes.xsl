<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xd:doc>
		<xd:desc>Deletes attributes</xd:desc>
	</xd:doc>
	<template match="@func[. = 'caution'] | @ho | @vo | @evidence[. = 'analogy'] | lem/@resp | @tuplet | staff/@codedval | staff/@position | dynam/@plist | space/@layer[contains(., '1 2')] | note/@layer[contains(., '1 2')] | @mm | @enclose | @subtype | @right[. = 'rptboth'] | @type[. = ('enclose', 'upbeat', 'Verlagsnummer', 'bartext', 'ce')]" mode="deleteAttributes"/>


	<xd:doc/>
	<template match="@dme.parts" mode="deleteAttributes">
		<call-template name="genres">
			<with-param name="exceptionGenre" select="'chamber'"/>
		</call-template>
	</template>

	<xd:doc>
		<xd:desc>Deletes second layer/@stem.dir when it is in the second layer and this is not a grace note.</xd:desc>
	</xd:doc>
	<template match="layer[(@n = '2') and not(.//note[@grace])]//@stem.dir" mode="deleteAttributes">
		<call-template name="genres">
			<with-param name="exceptionGenre" select="'orchestral'"/>
		</call-template>
	</template>


	<template name="genres">
		<param name="exceptionGenre"/>

		<choose>
			<when test="
					let $currGenre := map:get($options, 'genre')
					return
						matches($currGenre, $exceptionGenre)"> </when>
			<otherwise>
				<copy/>
			</otherwise>
		</choose>
	</template>

</stylesheet>
