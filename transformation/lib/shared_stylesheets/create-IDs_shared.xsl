<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<!--		example value '458001'-->
	<xsl:variable name="lists.create-IDs" select="doc('../lists/lists.xml')"/>
	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">$all</xd:param>
		<xd:param name="arg2">$els2apply</xd:param>
		<xd:param name="arg3">$els2exclude</xd:param>
	</xd:doc>
	<xsl:template match="body//*" mode="main" name="main">
		<xsl:param name="arg1" tunnel="yes"/>
		<xsl:param name="arg2" tunnel="yes"/>
		<xsl:param name="arg3" tunnel="yes"/>

		<xsl:copy>
			<xsl:choose>

				<xsl:when test="($arg1 = '1' or local-name() = $arg2) and not(local-name() = $arg3)">
					<xsl:variable as="xs:string" name="newID">
						<xsl:call-template name="newID"/>
					</xsl:variable>

					<xsl:attribute name="xml:id">
						<xsl:value-of select="$newID"/>
					</xsl:attribute>

					<xsl:call-template name="oldID"/>
					<xsl:call-template name="addN"/>

					<xsl:apply-templates mode="#current" select="@* except (@xml:id, @n[parent::mdiv]), node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="#current" select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:copy>
	</xsl:template>



	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<xsl:template name="newID">
		<xsl:param as="element()" name="element" select="."/>

		<xsl:choose>
			<xsl:when test="local-name() = ('mdiv', 'score')">
				<xsl:value-of select="local-name() || '_' || map:get($optionsCalc, 'kvMovement') || dme:mdiv(.)"/>
			</xsl:when>
			<xsl:when test="local-name() = ('scoreDef', 'staffGrp')">
				<xsl:variable name="digits">
					<xsl:call-template name="countPrecedingEls">
						<xsl:with-param name="element" select="."/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat(local-name(), '_', $digits)"/>
			</xsl:when>
			<xsl:when test="local-name() = 'staffDef'">
				<xsl:call-template name="staffDef"/>
			</xsl:when>
			<xsl:when test="(local-name() = ('label', 'lb')) and ancestor::staffDef">
				<xsl:call-template name="label_lb"/>
			</xsl:when>
			<xsl:when test="local-name() = 'layerDef'">
				<xsl:call-template name="layerDef"/>
			</xsl:when>
			<xsl:when test="local-name() = 'measure'">
				<xsl:value-of select="
						let $KV := map:get($optionsCalc, 'KV')
						return
							'm' || @n || '_k' || $KV || '_' || map:get($optionsCalc, 'movementN') || dme:mdiv(.)"/>
			</xsl:when>
			<xsl:when test="local-name() = 'zone'">
				<xsl:variable name="refMeasureID" select="
						let $ref := '#' || @xml:id
						return
							//measure[$ref = @facs]/@xml:id"/>
				<xsl:value-of select="
						if ($refMeasureID != '') then
							('zoneOf_' || $refMeasureID)
						else
							@xml:id"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable as="xs:string" name="uniqueId">
					<xsl:value-of select="xs:integer(substring-after(generate-id(), 'e')) * 6"/>
				</xsl:variable>
				<xsl:value-of select="concat(local-name(), '_', $uniqueId)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="staffDef">
		<xsl:variable name="ancestorScoreDef" select="ancestor::scoreDef/@xml:id"/>
		<xsl:variable name="counter" select="count(preceding::staffDef[ancestor::scoreDef/@xml:id = $ancestorScoreDef]) + 1"/>
		<xsl:value-of select="concat(local-name(), '_P', $counter, dme:scoreDefNumbers(.))"/>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="label_lb">
		<xsl:variable name="ancestorScoreDef" select="ancestor::scoreDef/@xml:id"/>
		<xsl:variable name="staffdefCounter" select="count(ancestor::staffDef/preceding::staffDef[ancestor::scoreDef/@xml:id = $ancestorScoreDef]) + 1"/>
		<xsl:value-of select="concat(local-name(), '_P', $staffdefCounter, dme:scoreDefNumbers(.))"/>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="layerDef">
		<xsl:variable name="perfRes" select="id(substring-after(@decls, '#'))"/>
		<xsl:variable name="item" select="$lists.create-IDs//id($perfRes/@codedval)"/>
		<xsl:variable name="label.abbr_dot" select="$item//dme:name[@xml:lang = 'IT']/@label.abbr"/>
		<xsl:variable name="label.abbr" select="substring-before($label.abbr_dot, '.')"/>
		<xsl:variable name="scoreDefID" select="ancestor::scoreDef/@xml:id"/>
		<!--Find all layerDefs in the same scoreDef for the same instrument-->
		<xsl:variable name="multipleLayerDefs" select="ancestor::scoreDef//layerDef[id(substring-after(@decls, '#'))/@codedval = $perfRes/@codedval]"/>

		<xsl:variable name="output">
			<xsl:choose>
				<!--If there are other layerDefs for the same instrument-->
				<xsl:when test="count($multipleLayerDefs) > 1">
					<!--find all preceding layerDefs in the same scoreDef with the same @codedval (e.g.'wc')-->
					<xsl:variable name="precedingLayerDefs" select="preceding::layerDef[ancestor::scoreDef/@xml:id = $scoreDefID][id(substring-after(@decls, '#'))/@codedval = $perfRes/@codedval]"/>
					<xsl:variable name="suffix" select="string(count($precedingLayerDefs) + 1)"/>
					<xsl:value-of select="concat(local-name(), '_', $label.abbr, $suffix, dme:scoreDefNumbers(.))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="dme:scoreDefNumbers(.) != ''">
							<xsl:value-of select="concat(local-name(), '_', $label.abbr, dme:scoreDefNumbers(.))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(local-name(), '_', $label.abbr_dot)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy-of select="$output"/>
	</xsl:template>


	<xd:doc>
		<xd:desc>counts preceding eleements</xd:desc>
		<xd:param name="element"/>
	</xd:doc>
	<xsl:template name="countPrecedingEls">
		<xsl:param name="element"/>
		<!--staffGrp are also nested that's where the XPath expression with ancestor is needed, hopefully there will be no nested scoreDefs-->
		<xsl:variable name="NrPrecElem" select="dme:countPreceding($element) + count($element/ancestor::node()[local-name() = $element/local-name()]) + 1"/>
		<!--check if '01' or '11', so if '0' is needed to be prefixed-->
		<xsl:choose>
			<xsl:when test="string-length(string($NrPrecElem)) > 1">
				<xsl:value-of select="$NrPrecElem"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('0', $NrPrecElem)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="section" mode="section">

		<xsl:variable name="frstM" select="measure[1]/@n"/>
		<xsl:variable name="lstM" select="measure[last()]/@n"/>
		<xsl:variable name="letter">
			<xsl:variable name="sectCounter" select="count(preceding-sibling::section)"/>
			<xsl:value-of select="$lists.create-IDs//id('capitalLetters')/dme:item[$sectCounter + 1]"/>
		</xsl:variable>

		<xsl:copy>
			<xsl:variable name="newID">

				<xsl:choose>
					<!--if this is a big section which wraps all the others-->
					<xsl:when test="parent::score and child::section">
						<xsl:variable name="frstTmp">
							<xsl:choose>
								<xsl:when test="descendant::measure[@n = ('0', '1')]/tempo/rend">
									<xsl:value-of select="
											let $raw := descendant::measure[@n = ('0', '1')]/tempo/rend/text()
											return
												translate(lower-case($raw), ' ', '_')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="
											let $raw := descendant::measure[@n = ('0', '1')]/tempo/text()
											return
												translate(lower-case($raw), ' ', '_')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<xsl:value-of select="local-name() || '_' || $frstTmp || dme:mdiv(.)"/>
					</xsl:when>
					<!--if there are endings -->
					<xsl:when test=".[ending]">
						<xsl:variable name="lastM-ending" select=".//ending[last()]//measure[last()]/substring-before(@n, '_')"/>
						<xsl:value-of select="concat(local-name(), '_', $letter, '_m', $frstM, '-', $lastM-ending, dme:mdiv(.))"/>
					</xsl:when>
					<!--normal case-->
					<xsl:otherwise>
						<xsl:value-of select="concat(local-name(), '_', $letter, '_m', $frstM, '-', $lstM, dme:mdiv(.))"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:attribute name="xml:id">
				<xsl:value-of select="$newID"/>
			</xsl:attribute>
			<xsl:apply-templates mode="#current" select="@* except @xml:id, node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:variable name="refs" select="$lists.create-IDs//id('REFS')/dme:item/text()"/>
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="@*[local-name() = ($refs)]" mode="references">
		<xsl:variable name="currentVal" select="."/>
		<xsl:variable name="values" select="
				for $n in tokenize(., '\s+')
				return
					substring-after($n, '#')"/>
		<xsl:variable name="refElem" select="
				//*[some $n in $values
					satisfies (@oldID = $n)]"/>

		<xsl:choose>
			<xsl:when test="$refElem">
				<xsl:variable name="newValue">
					<xsl:call-template name="newRefVal">
						<xsl:with-param name="refElem" select="$refElem"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:attribute name="{name()}" select="$newValue"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="oldID">
		<xsl:if test="@xml:id">
			<xsl:attribute name="oldID">
				<xsl:value-of select="@xml:id"/>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="@*[local-name() = 'oldID']" mode="references"/>

	<xd:doc>
		<xd:desc/>
		<xd:param name="refElem"/>
	</xd:doc>
	<xsl:template name="newRefVal">
		<xsl:param name="refElem"/>

		<xsl:for-each select="$refElem">
			<xsl:choose>
				<xsl:when test="position() != last() (:if there are multiple entries:)">
					<xsl:value-of select="concat('#', @xml:id, ' ')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('#', @xml:id)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>


	<xd:doc>
		<xd:desc>Adds @n to mdiv.</xd:desc>
		<xd:param name="arg1"/>
	</xd:doc>
	<xsl:template name="addN">
		<xsl:param as="element()" name="arg1" select="."/>

		<xsl:variable as="xs:string" name="mdiv">
			<xsl:choose>
				<xsl:when test="count(//mdiv) > 1">
					<xsl:value-of select="dme:countMdiv($arg1)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="local-name() = 'mdiv'">
			<xsl:variable name="n" select="functx:chars(map:get($optionsCalc, 'kvMovement'))[last()]"/>
			<xsl:attribute name="n">
				<!--	values like n="3b"-->
				<xsl:value-of select="concat($n, $mdiv)"/>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">The context element.</xd:param>
	</xd:doc>
	<xsl:function name="dme:countMdiv">
		<xsl:param as="element()" name="arg1"/>

		<xsl:variable name="counter" select="count($arg1/preceding::mdiv) + 1"/>
		<xsl:value-of select="concat('_0', $counter)"/>
	</xsl:function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<xsl:function name="dme:countPreceding">
		<xsl:param name="element"/>
		<xsl:value-of select="count($element/preceding::node()[local-name() = $element/local-name()])"/>
	</xsl:function>


	<xd:doc>
		<xd:desc>Creates suffix '_sc{$countScoreDef}' if there are more then one scoreDefs in the body, otherwise the output is an empty string.</xd:desc>
		<xd:param name="context"/>
	</xd:doc>
	<xsl:function name="dme:scoreDefNumbers">
		<xsl:param as="node()" name="context"/>
		<xsl:choose>
			<xsl:when test="count($context/ancestor::body//scoreDef) > 1">
				<xsl:variable name="countScoreDef">
					<xsl:call-template name="countPrecedingEls">
						<xsl:with-param name="element" select="$context/ancestor::scoreDef"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat('_sc', $countScoreDef)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="context"/>
	</xd:doc>
	<xsl:function name="dme:mdiv">
		<xsl:param as="node()" name="context"/>

		<xsl:choose>
			<xsl:when test="count($context/ancestor::mei//mdiv) > 1">
				<xsl:value-of select="dme:countMdiv($context)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:function>
</xsl:stylesheet>
