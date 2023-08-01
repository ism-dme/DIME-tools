<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:p>
					<xd:i>Most of the functions and templates for the comparison.</xd:i>
				</xd:p>
			</xd:p>
		</xd:desc>
	</xd:doc>


	<xd:doc>
		<xd:desc/>
		<xd:param name="dNode"/>
	</xd:doc>
	<xsl:function as="element()*" name="dme:excludeEls">
		<xsl:param name="dNode"/>

		<xsl:variable as="xs:string*" name="notCorrespChildrenIDs">
			<xsl:call-template name="exclNotCorrespChildren"/>
		</xsl:variable>
		<xsl:variable name="step0" select="$dNode//mei:body//*[local-name() = $elsConfig]"/>
		<xsl:variable name="exclNotCorrespChildren" select="$step0[not(string(@xml:id) = $notCorrespChildrenIDs)]"/>
		<xsl:variable name="step1" select="$exclNotCorrespChildren[not(ancestor::node()[local-name() = $exclAncestors])]"/>

		<!--excludes slurs, ties, etc. which point to the elements which are children of excluded ancestors-->
		<xsl:variable as="xs:string*" name="excludedAncestorsChildren" select="$dNode//mei:body//*[local-name() = $exclAncestors]//*[local-name() = $elsConfig]/@xml:id"/>
		<xsl:variable name="step2" select="$step1[not(substring-after(@startid, '#') = $excludedAncestorsChildren) and not(substring-after(@endid, '#') = $excludedAncestorsChildren)]"/>

		<xsl:variable name="step3" select="$step2[not(@xml:id = $exceptions)]"/>

		<xsl:call-template name="cleanAttr">
			<xsl:with-param name="step3" select="$step3"/>
		</xsl:call-template>
	</xsl:function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="step3"/>
	</xd:doc>
	<xsl:template name="cleanAttr">
		<xsl:param name="step3"/>
		<xsl:for-each select="$step3">
			<xsl:copy>
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="contains(., $edtType)">
							<xsl:attribute name="{name()}" select="substring-before(., $edtType)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<xsl:apply-templates select="node()"/>
			</xsl:copy>
		</xsl:for-each>
	</xsl:template>


	<xd:doc>
		<xd:desc>Excludes the elements which are children of an added node, e.g. artic/accid as a child of an added note.</xd:desc>
	</xd:doc>
	<xsl:template name="exclNotCorrespChildren">

		<!--*****Sequence of strings with the IDs of the the excluded children of added nodes in the base file-->
		<!--		the value is e.g. 'note_1'. It is a corresponding ID in the compared node without suffix-->
		<xsl:variable name="comparedNodeIDs" select="
				for $b in $comparedDocNode//mei:body//*[local-name() = $elsConfig]/@xml:id
				return
					substring-before($b, $edtType)"/>

		<!--find base elements which do not have corresponding-->
		<xsl:variable name="baseElsNOCorresp" select="
				$baseDocNode//mei:body//*[not(
				string(@xml:id) = $comparedNodeIDs) and (local-name() = $elsConfig)]/@xml:id"/>

		<xsl:variable name="exclChildrenBase" select="$baseDocNode//mei:body//*[@xml:id = $baseElsNOCorresp]/descendant::node()[local-name() = $elsConfig]/@xml:id/string()"/>
		<!--*****-->

		<!--*****-->
		<!--	the value is e.g. 'note_1-B1'. It is a corresponding ID in the base node with suffix-->
		<xsl:variable name="baseNodeIDs" select="
				for $b in $baseDocNode//mei:body//*[local-name() = $elsConfig]/@xml:id
				return
					concat($b, $edtType)"/>

		<!--find compared elements which do not have corresponding-->
		<xsl:variable name="comparedElsNOCorresp" select="
				$comparedDocNode//mei:body//*[not(
				string(@xml:id) = $baseNodeIDs) and (local-name() = $elsConfig)]/@xml:id"/>

		<xsl:variable name="exclChildrenCompared" select="$comparedDocNode//mei:body//*[@xml:id = $comparedElsNOCorresp]/descendant::node()[local-name() = $elsConfig]/@xml:id/string()"/>
		<!--*****-->

		<!--create a sequence with their IDs-->
		<xsl:copy-of select="functx:value-union($exclChildrenBase, $exclChildrenCompared)"/>
	</xsl:template>

	<xd:doc>
		<xd:desc>edition-equal</xd:desc>
		<xd:param name="baseEl"/>
		<xd:param name="comparedEl"/>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:edition-equal">
		<xsl:param as="element()" name="baseEl"/>
		<xsl:param as="element()" name="comparedEl"/>

		<!--if the are any attributes to compare-->
		<xsl:variable name="baseElName" select="$baseEl/local-name()"/>
		<xsl:variable as="element()*" name="attributesList" select="$elementsList//dme:elementsTOcompare/*[dme:attributes]"/>
		<xsl:variable name="listEl" select="$attributesList[local-name() = $baseElName]"/>

		<xsl:variable as="element()" name="compareAttr">
			<xsl:call-template name="compareAttr">
				<xsl:with-param name="baseEl" select="$baseEl"/>
				<xsl:with-param name="comparedEl" select="$comparedEl"/>
				<xsl:with-param name="attributes" select="$listEl/dme:attributes/tokenize(text(), ',')"/>
			</xsl:call-template>
		</xsl:variable>

		<!--if the previous check for 'base' attributes was OK, further more specific check will be performed-->
		<xsl:variable name="compareText">
			<xsl:choose>
				<xsl:when test="$listEl[@text] (:only few elements have text nodes:)">
					<xsl:variable name="textTest" select="dme:compareText($baseEl, $comparedEl)"/>
					<xsl:value-of select="string-join(($textTest/@boolean, $textTest/@failed), ',')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'true'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--both attributes and text nodes should be equal-->
		<xsl:value-of select="
				if (($compareAttr/@boolean = 'true') and tokenize($compareText, ',')[1] = 'true') then
					'true'
				else
					string-join(($compareAttr/@failedAttr, tokenize($compareText, ',')[2]), ' ')"/>
	</xsl:function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="baseEl"/>
		<xd:param name="comparedEl"/>
		<xd:param name="attributes"/>
	</xd:doc>
	<xsl:template name="compareAttr">
		<xsl:param name="baseEl"/>
		<xsl:param name="comparedEl"/>
		<xsl:param name="attributes"/>

		<!--contains q sequence of strings: '0' if the comparison was true or the value of the failed attribute-->
		<xsl:variable as="xs:string*" name="checkAttributes">
			<xsl:for-each select="$attributes">
				<xsl:variable name="position" select="position()"/>
				<xsl:variable as="xs:string" name="attribute2check" select="$attributes[position() = $position]"/>
				<!--				if the elements have any attributes to compare-->
				<xsl:if test="$baseEl/@*[local-name() = $attribute2check] | $comparedEl/@*[local-name() = $attribute2check]">
					<xsl:variable name="attribute.1" select="$baseEl/@*[local-name() = $attribute2check]"/>
					<xsl:variable name="attribute.2">
						<xsl:variable name="chosen" select="$comparedEl/@*[local-name() = $attribute2check]"/>
						<xsl:sequence>
							<xsl:value-of select="$chosen"/>
						</xsl:sequence>
					</xsl:variable>


					<xsl:choose>
						<xsl:when test="
								$attribute.1 = $attribute.2">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="
					every $n in $checkAttributes
						satisfies matches($n, '^0$')">
				<result boolean="true"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="faliedAttr" select="
						normalize-space(replace(
						string-join($checkAttributes, ' '), '0', ' ')
						
						)"/>

				<!--the problem: when 1st accid has @accid.ges and the 2nd has @accid. In this case this corretction is not correct-->
				<!--<xsl:variable name="delAccidGes">
					<xsl:choose>
						<xsl:when test="contains($faliedAttr, 'accid')">
							<xsl:value-of select="normalize-space(replace($faliedAttr, 'accid.ges', ''))"/>
						</xsl:when>
						<xsl:when test="contains($faliedAttr, 'accid.ges')">
							<xsl:value-of select="normalize-space(replace($faliedAttr, 'accid', ''))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="$faliedAttr"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>-->

				<result boolean="false" failedAttr="{for $n in tokenize($faliedAttr, '\s') return concat('@', $n)}"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="baseEl"/>
		<xd:param name="comparedEl"/>
	</xd:doc>
	<xsl:function as="element()" name="dme:compareText">
		<xsl:param as="element()" name="baseEl"/>
		<xsl:param as="element()" name="comparedEl"/>

		<xsl:variable name="text.1" select="$baseEl//text()/normalize-space()"/>
		<xsl:variable name="text.2" select="$comparedEl//text()/normalize-space()"/>

		<!--		needed for the case: e.g. dynam1 is 'sempre p', dyman 2 is 'sempre', 'p' bcs. the second 'p' is in the <rend/>-->
		<xsl:variable name="text1Concat" select="string-join($text.1, ' ')"/>
		<xsl:variable name="text2Concat" select="string-join($text.2, ' ')"/>

		<xsl:choose>
			<xsl:when test="
					$text1Concat = $text2Concat">
				<result boolean="true"/>
			</xsl:when>
			<xsl:otherwise>
				<result boolean="false" failed="#text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xd:doc>
		<xd:desc>Checks for each ref and edt slur if there exist two slurs where the first points to the @startid and the another to the @endid. So those will be asplit / merged slurs.</xd:desc>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:split-merged-slurs">

		<!--finds if there are two slurs which are: the one has same @startid, the other has the same @endid. -->
		<xsl:call-template name="recognSplitMerged">
			<xsl:with-param name="els1" select="$baseEls[local-name() = 'slur']"/>
			<xsl:with-param name="els2" select="$comparedEls[local-name() = 'slur']"/>
			<xsl:with-param name="starts-with" select="'base'"/>
		</xsl:call-template>
		<xsl:call-template name="recognSplitMerged">
			<xsl:with-param name="els1" select="$comparedEls[local-name() = 'slur']"/>
			<xsl:with-param name="els2" select="$baseEls[local-name() = 'slur']"/>
			<xsl:with-param name="starts-with" select="'compared'"/>
		</xsl:call-template>

	</xsl:function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="els1"/>
		<xd:param name="els2"/>
		<xd:param name="starts-with"/>
	</xd:doc>
	<xsl:template name="recognSplitMerged">
		<xsl:param name="els1"/>
		<xsl:param name="els2"/>
		<!--The paarameter $starts-with is needed to know how to write the csv entries according to the base or compared files and how to add edtType-->
		<xsl:param name="starts-with"/>

		<xsl:for-each select="$els1">
			<xsl:variable as="xs:string?" name="currStartID" select="@startid"/>
			<xsl:variable as="xs:string?" name="currEndID" select="@endid"/>

			<xsl:variable as="xs:string?" name="startidCorrespSlur" select="$els2[string(@startid) = $currStartID]/string(@xml:id)"/>
			<xsl:variable as="xs:string?" name="endidCorrespSlur" select="$els2[string(@endid) = $currEndID]/string(@xml:id)"/>

			<!--if this is the same slur-->
			<xsl:choose>
				<xsl:when test="$starts-with = 'base'">
					<xsl:if test="$startidCorrespSlur != $endidCorrespSlur">
						<xsl:value-of select="concat(@xml:id, ';', concat($startidCorrespSlur, $edtType), ' ', concat($endidCorrespSlur, $edtType))"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$starts-with = 'compared'">
					<xsl:if test="$startidCorrespSlur != $endidCorrespSlur">
						<xsl:value-of select="concat($startidCorrespSlur, ' ', $endidCorrespSlur, ';', concat(@xml:id, $edtType))"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>

		</xsl:for-each>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="el"/>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:split-merged-tupl_beam">
		<xsl:param name="el"/>
		<xsl:variable as="xs:string*" name="all">
			<xsl:call-template name="recognSplitMergedTupletBeam">
				<xsl:with-param name="els1" select="$baseDocNode//mei:body//*[local-name() = $el]"/>
				<xsl:with-param name="els2" select="$comparedDocNode//mei:body//*[local-name() = $el]"/>
				<xsl:with-param name="starts-with" select="'base'"/>
			</xsl:call-template>
			<xsl:call-template name="recognSplitMergedTupletBeam">
				<xsl:with-param name="els1" select="$comparedDocNode//mei:body//*[local-name() = $el]"/>
				<xsl:with-param name="els2" select="$baseDocNode//mei:body//*[local-name() = $el]"/>
				<xsl:with-param name="starts-with" select="'compared'"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<!--			exclude beams which have tuplets as anscestors-->
			<xsl:when test="$el = 'beam'">
				<xsl:variable name="exclTupletAncestors">
					<xsl:call-template name="exclTupletAncestors">
						<xsl:with-param name="allBeams" select="$all"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:copy-of select="$exclTupletAncestors"/>
			</xsl:when>
			<xsl:when test="$el = 'tuplet'">
				<xsl:copy-of select="$all"/>
			</xsl:when>
		</xsl:choose>
	</xsl:function>

	<xd:doc>
		<xd:desc>Recognizes if tuplet or beam were split / merged. Additionaly, for the beam is checked if an element was unbeamed.</xd:desc>
		<xd:param name="els1"/>
		<xd:param name="els2"/>
		<xd:param name="starts-with"/>
	</xd:doc>
	<xsl:template name="recognSplitMergedTupletBeam">
		<xsl:param name="els1"/>
		<xsl:param name="els2"/>
		<!--The parameter $starts-with is needed to know how to write the csv entries according to the base or compared files and how to add edtType-->
		<xsl:param name="starts-with"/>


		<xsl:variable name="els1Reduced">
			<xsl:copy-of select="dme:reduceEl($els1)"/>
		</xsl:variable>
		<xsl:variable name="els2Reduced">
			<xsl:copy-of select="dme:reduceEl($els2)"/>
		</xsl:variable>

		<xsl:variable as="xs:string?" name="elName" select="$els1[1]/local-name()"/>

		<xsl:for-each select="$els1Reduced/*[local-name() = $elName]">
			<xsl:variable as="xs:string?" name="firstNode" select="node()[1]/@xml:id"/>
			<xsl:variable as="xs:string?" name="lastNode" select="node()[last()]/@xml:id"/>

			<xsl:variable name="elsWithoutBeams">
				<xsl:call-template name="elsWithoutBeams">
					<xsl:with-param name="arg1" select="."/>
					<xsl:with-param name="arg2" select="$starts-with"/>
				</xsl:call-template>
			</xsl:variable>

			<!--finds the ID of a tuplet/beam which has a corresponding first and last node as a descendant. Compares them. If they are different, the tuplet/beam is split.-->
			<xsl:choose>
				<xsl:when test="$starts-with = 'base'">
					<xsl:variable as="xs:string?" name="firstNodeCorresp" select="$els2Reduced/*[(local-name() = $elName) and node()[1][substring-before(@xml:id, $edtType) = $firstNode]]/@xml:id"/>
					<xsl:variable as="xs:string?" name="lastNodeCorresp" select="$els2Reduced/*[(local-name() = $elName) and node()[last()][substring-before(@xml:id, $edtType) = $lastNode]]/@xml:id"/>

					<xsl:if test="($firstNodeCorresp != $lastNodeCorresp) or $elsWithoutBeams/text()">
						<xsl:value-of select="normalize-space(concat(@xml:id, ';', $firstNodeCorresp, ' ', $lastNodeCorresp, ' ', $elsWithoutBeams/text()))"/>
					</xsl:if>

				</xsl:when>
				<xsl:when test="$starts-with = 'compared'">
					<xsl:variable as="xs:string?" name="firstNodeCorresp" select="$els2Reduced/*[(local-name() = $elName) and node()[1][concat(@xml:id, $edtType) = $firstNode]]/@xml:id"/>
					<xsl:variable as="xs:string?" name="lastNodeCorresp" select="$els2Reduced/*[(local-name() = $elName) and node()[last()][concat(@xml:id, $edtType) = $lastNode]]/@xml:id"/>

					<xsl:if test="($firstNodeCorresp != $lastNodeCorresp) or $elsWithoutBeams/text()">
						<xsl:value-of select="normalize-space(concat($firstNodeCorresp, ' ', $lastNodeCorresp, ' ', $elsWithoutBeams/text(), ';', @xml:id))"/>

					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xd:doc>
		<xd:desc>Returns the IDs of the elements in the corresponding node which are not beamed. Outuput format: document-node with a text node: e.g. "note_1 note_2"</xd:desc>
		<xd:param name="arg1"/>
		<xd:param name="arg2"/>
	</xd:doc>
	<xsl:template name="elsWithoutBeams">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>

		<xsl:choose>
			<xsl:when test="$arg2 = 'base'">
				<xsl:sequence select="$comparedDocNode//mei:body//*[(substring-before(@xml:id, $edtType) = $arg1/child::node()/@xml:id) and not(ancestor::node()[local-name() = 'beam'])]/string(@xml:id)"/>
			</xsl:when>
			<xsl:when test="$arg2 = 'compared'">
				<xsl:sequence select="
						$baseDocNode//mei:body//*[(some $n in $arg1/child::node()/@xml:id
							satisfies
							@xml:id = substring-before($n, $edtType)) and not(ancestor::node()[local-name() = 'beam'])]/string(@xml:id)"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xd:doc>
		<xd:desc/>
		<xd:param name="allBeams"/>
	</xd:doc>
	<xsl:template name="exclTupletAncestors">
		<xsl:param name="allBeams"/>

		<!--retrieve IDs of split / merged tuplets from CSV-->
		<xsl:variable name="getCell" select="
				for $n in $vSplitMergedTuplets
				return
					tokenize($n, ';')
				"/>
		<xsl:variable name="splitTupletsID" select="
				for $n in $getCell
				return
					tokenize($n, '\s')
				"/>

		<!--find IDs of their beams-->
		<xsl:variable as="xs:string*" name="exclSplitAncestorsForBeamBase" select="$baseDocNode/id($splitTupletsID)//mei:beam/@xml:id"/>
		<xsl:variable as="xs:string*" name="exclSplitAncestorsForBeamCompared" select="$comparedDocNode/id($splitTupletsID)//mei:beam/@xml:id"/>

		<!--exclude the beams with these IDs
		-->
		<xsl:variable name="exclSplitAncestorsForBeam" select="functx:value-union($exclSplitAncestorsForBeamBase, $exclSplitAncestorsForBeamCompared)"/>

		<xsl:choose>
			<xsl:when test="$exclSplitAncestorsForBeam != ()">
				<xsl:sequence select="
						for $n in $allBeams
						return
							if
							(some $b in
							$exclSplitAncestorsForBeam
								satisfies contains($n, $b)) then
								()
							else
								."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$allBeams"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:variable as="xs:string*" name="exceptions" select="dme:getExceptions()"/>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:getExceptions">
		<xsl:variable as="xs:string" name="workPart" select="substring-before(substring-after($baseFileName, 'dmeref_' (:dmeref is Ok bcs it'd be the same workPart for dmeedt:)), '_')"/>
		<xsl:variable as="xs:string*" name="exceptions" select="$elementsList//dme:exceptions//dme:part[@n = $workPart]/tokenize(text(), ',')"/>
		<xsl:copy-of select="$exceptions"/>
	</xsl:function>

	<xd:doc>
		<xd:desc>contains the beam/tuplet as root and rest/note as child elements. Is needed to find 'first'/'last' node</xd:desc>
		<xd:param name="arg">as document-node</xd:param>
	</xd:doc>
	<xsl:function name="dme:reduceEl">
		<xsl:param name="arg"/>
		<xsl:for-each select="$arg">
			<xsl:copy>
				<xsl:apply-templates select="@*"/>
				<xsl:copy-of select="descendant::mei:rest | descendant::mei:note"/>
			</xsl:copy>
		</xsl:for-each>
	</xsl:function>
</xsl:stylesheet>
