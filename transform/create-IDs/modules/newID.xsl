<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<template name="newID">
		<param as="element()" name="element" select="."/>
		<param name="addSuffix" tunnel="yes"/>

		<choose>
			<when test="$addSuffix">
				<call-template name="addSuffix"/>
			</when>
			<otherwise>
				<call-template name="default"/>
			</otherwise>
		</choose>

	</template>




	<template name="default">

		<choose>	
			<when test="local-name() = ('mdiv', 'score') and $DIME-FileNaming">
				<value-of select="local-name() || '_' || map:get($optionsCalc, 'kvMovement') || dme:mdiv(.)"/>
			</when>

			<when test="local-name() = ('scoreDef', 'staffGrp')">
				<variable name="digits">
					<call-template name="countPrecedingEls">
						<with-param name="element" select="."/>
					</call-template>
				</variable>
				<value-of select="concat(local-name(), '_', $digits)"/>
			</when>
			<when test="local-name() = 'staffDef'">
				<call-template name="staffDef"/>
			</when>
			<when test="(local-name() = ('label', 'lb')) and ancestor::staffDef">
				<call-template name="label_lb"/>
			</when>
			<when test="local-name() = 'layerDef'">
				<call-template name="layerDef"/>
			</when>

			<when test="local-name() = 'measure'">
				<choose>
					<when test="$DIME-FileNaming">
						<value-of select="
								let $KV := map:get($optionsCalc, 'KV')
								return
									'm' || @n || '_k' || $KV || '_' || map:get($optionsCalc, 'movementN') || dme:mdiv(.)"/>
					</when>
					<otherwise>
						<value-of select="'m' || @n || dme:mdiv(.)"/>
					</otherwise>
				</choose>
			</when>
			<when test="local-name() = 'zone'">
				<variable name="refMeasureID" select="
						let $ref := '#' || @xml:id
						return
							//measure[$ref = @facs]/@xml:id"/>
				<value-of select="
						if ($refMeasureID != '') then
							('zoneOf_' || $refMeasureID)
						else
							@xml:id"/>
			</when>
			<when test="local-name() = 'tempo'">
				<value-of select="
						let $precedingTempoCount := count(preceding::tempo[ancestor::music]) + 1
						return
							'tempo0' || $precedingTempoCount"/>
			</when>
			<otherwise>
				<variable as="xs:string" name="uniqueId">
					<value-of select="xs:integer(substring-after(generate-id(), 'e')) * 6"/>
				</variable>
				<value-of select="local-name() || '_' || $uniqueId"/>
			</otherwise>
		</choose>
	</template>

	<template name="addSuffix">
		<param tunnel="yes" name="suffix"/>

		<value-of select="@xml:id || $suffix"/>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template name="staffDef">
		<variable name="ancestorScoreDef" select="ancestor::scoreDef/@xml:id"/>
		<variable name="counter" select="count(preceding::staffDef[ancestor::scoreDef/@xml:id = $ancestorScoreDef]) + 1"/>
		<value-of select="concat(local-name(), '_P', $counter, dme:scoreDefNumbers(.))"/>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template name="label_lb">
		<variable name="ancestorScoreDef" select="ancestor::scoreDef/@xml:id"/>
		<variable name="staffdefCounter" select="count(ancestor::staffDef/preceding::staffDef[ancestor::scoreDef/@xml:id = $ancestorScoreDef]) + 1"/>
		<value-of select="concat(local-name(), '_P', $staffdefCounter, dme:scoreDefNumbers(.))"/>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template name="layerDef">
		<variable name="perfRes" select="id(substring-after(@decls, '#'))"/>
		<variable name="item" select="$lists.create-IDs//id($perfRes/@codedval)"/>
		<variable name="label.abbr_dot" select="$item//dme:name[@xml:lang = 'IT']/@label.abbr"/>
		<variable name="label.abbr" select="substring-before($label.abbr_dot, '.')"/>
		<variable name="scoreDefID" select="ancestor::scoreDef/@xml:id"/>
		<!--Find all layerDefs in the same scoreDef for the same instrument-->
		<variable name="multipleLayerDefs" select="ancestor::scoreDef//layerDef[id(substring-after(@decls, '#'))/@codedval = $perfRes/@codedval]"/>

		<variable name="output">
			<choose>
				<!--If there are other layerDefs for the same instrument-->
				<when test="count($multipleLayerDefs) > 1">
					<!--find all preceding layerDefs in the same scoreDef with the same @codedval (e.g.'wc')-->
					<variable name="precedingLayerDefs" select="preceding::layerDef[ancestor::scoreDef/@xml:id = $scoreDefID][id(substring-after(@decls, '#'))/@codedval = $perfRes/@codedval]"/>
					<variable name="suffix" select="string(count($precedingLayerDefs) + 1)"/>
					<value-of select="concat(local-name(), '_', $label.abbr, $suffix, dme:scoreDefNumbers(.))"/>
				</when>
				<otherwise>
					<choose>
						<when test="dme:scoreDefNumbers(.) != ''">
							<value-of select="concat(local-name(), '_', $label.abbr, dme:scoreDefNumbers(.))"/>
						</when>
						<otherwise>
							<value-of select="concat(local-name(), '_', $label.abbr_dot)"/>
						</otherwise>
					</choose>
				</otherwise>
			</choose>
		</variable>
		<copy-of select="$output"/>
	</template>
</stylesheet>
