<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<!--		example value '458001'-->
	<variable name="lists.create-IDs" select="doc('../lists/lists.xml')"/>
	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">$all</xd:param>
		<xd:param name="arg2">$els2apply</xd:param>
		<xd:param name="arg3">$els2exclude</xd:param>
	</xd:doc>
	<template match="body//*" mode="main" name="main">
		<param name="arg1" tunnel="yes"/>
		<param name="arg2" tunnel="yes"/>
		<param name="arg3" tunnel="yes"/>

		<copy>
			<choose>

				<when test="($arg1 = '1' or local-name() = $arg2) and not(local-name() = $arg3)">
					<variable as="xs:string" name="newID">
						<call-template name="newID"/>
					</variable>

					<attribute name="xml:id">
						<value-of select="$newID"/>
					</attribute>

					<call-template name="oldID"/>
					<call-template name="addN"/>

					<apply-templates mode="#current" select="@* except (@xml:id, @n[parent::mdiv]), node()"/>
				</when>
				<otherwise>
					<apply-templates mode="#current" select="@*, node()"/>
				</otherwise>
			</choose>

		</copy>
	</template>



	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<template name="newID">
		<param as="element()" name="element" select="."/>



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


	<xd:doc>
		<xd:desc>counts preceding eleements</xd:desc>
		<xd:param name="element"/>
	</xd:doc>
	<template name="countPrecedingEls">
		<param name="element"/>
		<!--staffGrp are also nested that's where the XPath expression with ancestor is needed, hopefully there will be no nested scoreDefs-->
		<variable name="NrPrecElem" select="dme:countPreceding($element) + count($element/ancestor::node()[local-name() = $element/local-name()]) + 1"/>
		<!--check if '01' or '11', so if '0' is needed to be prefixed-->
		<choose>
			<when test="string-length(string($NrPrecElem)) > 1">
				<value-of select="$NrPrecElem"/>
			</when>
			<otherwise>
				<value-of select="concat('0', $NrPrecElem)"/>
			</otherwise>
		</choose>

	</template>


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
			<variable name="newID">

				<choose>
					<!--if this is a big section which wraps all the others-->
					<when test="parent::score and child::section">
						<variable name="frstTmp">
							<choose>
								<when test="descendant::measure[@n = ('0', '1')]/tempo/rend">
									<value-of select="
											let $raw := descendant::measure[@n = ('0', '1')]/tempo/rend/text()
											return
												translate(lower-case($raw), ' ', '_')"/>
								</when>
								<otherwise>
									<value-of select="
											let $raw := descendant::measure[@n = ('0', '1')]/tempo/text()
											return
												translate(lower-case($raw), ' ', '_')"/>
								</otherwise>
							</choose>
						</variable>

						<value-of select="local-name() || '_' || $frstTmp || dme:mdiv(.)"/>
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


	<variable name="refs" select="$lists.create-IDs//id('REFS')/dme:item/text()"/>
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="@*[local-name() = ($refs)]" mode="references">
		<variable name="currentVal" select="."/>
		<variable name="values" select="
				for $n in tokenize(., '\s+')
				return
					substring-after($n, '#')"/>
		<variable name="refElem" select="
				//*[some $n in $values
					satisfies (@oldID = $n)]"/>

		<choose>
			<when test="$refElem">
				<variable name="newValue">
					<call-template name="newRefVal">
						<with-param name="refElem" select="$refElem"/>
					</call-template>
				</variable>
				<attribute name="{name()}" select="$newValue"/>
			</when>
			<otherwise>
				<copy/>
			</otherwise>
		</choose>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template name="oldID">
		<if test="@xml:id">
			<attribute name="oldID">
				<value-of select="@xml:id"/>
			</attribute>
		</if>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="@*[local-name() = 'oldID']" mode="references"/>

	<xd:doc>
		<xd:desc/>
		<xd:param name="refElem"/>
	</xd:doc>
	<template name="newRefVal">
		<param name="refElem"/>

		<for-each select="$refElem">
			<choose>
				<when test="position() != last() (:if there are multiple entries:)">
					<value-of select="concat('#', @xml:id, ' ')"/>
				</when>
				<otherwise>
					<value-of select="concat('#', @xml:id)"/>
				</otherwise>
			</choose>
		</for-each>
	</template>


	<xd:doc>
		<xd:desc>Adds @n to mdiv.</xd:desc>
		<xd:param name="arg1"/>
	</xd:doc>
	<template name="addN">
		<param as="element()" name="arg1" select="."/>

		<if test="$DIME-FileNaming">
			<variable as="xs:string" name="mdiv">
				<choose>
					<when test="count(//mdiv) > 1">
						<value-of select="dme:countMdiv($arg1)"/>
					</when>
					<otherwise>
						<value-of select="''"/>
					</otherwise>
				</choose>
			</variable>

			<if test="local-name() = 'mdiv'">
				<variable name="n" select="functx:chars(map:get($optionsCalc, 'kvMovement'))[last()]"/>
				<attribute name="n">
					<!--	values like n="3b"-->
					<value-of select="concat($n, $mdiv)"/>
				</attribute>
			</if>
		</if>
	</template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">The context element.</xd:param>
	</xd:doc>
	<function name="dme:countMdiv">
		<param as="element()" name="arg1"/>

		<variable name="counter" select="count($arg1/preceding::mdiv) + 1"/>
		<value-of select="concat('_0', $counter)"/>
	</function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<function name="dme:countPreceding">
		<param name="element"/>
		<value-of select="count($element/preceding::node()[local-name() = $element/local-name()])"/>
	</function>


	<xd:doc>
		<xd:desc>Creates suffix '_sc{$countScoreDef}' if there are more then one scoreDefs in the body, otherwise the output is an empty string.</xd:desc>
		<xd:param name="context"/>
	</xd:doc>
	<function name="dme:scoreDefNumbers">
		<param as="node()" name="context"/>
		<choose>
			<when test="count($context/ancestor::body//scoreDef) > 1">
				<variable name="countScoreDef">
					<call-template name="countPrecedingEls">
						<with-param name="element" select="$context/ancestor::scoreDef"/>
					</call-template>
				</variable>
				<value-of select="concat('_sc', $countScoreDef)"/>
			</when>
			<otherwise>
				<value-of select="''"/>
			</otherwise>
		</choose>
	</function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="context"/>
	</xd:doc>
	<function name="dme:mdiv">
		<param as="node()" name="context"/>

		<choose>
			<when test="count($context/ancestor::mei//mdiv) > 1">
				<value-of select="dme:countMdiv($context)"/>
			</when>
			<otherwise>
				<value-of select="''"/>
			</otherwise>
		</choose>

	</function>
</stylesheet>
