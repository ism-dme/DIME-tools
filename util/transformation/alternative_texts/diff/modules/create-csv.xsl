<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:fn="http://www.example.com/fn" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xsl:variable name="delim" select="';'"/>
	<xsl:variable name="break" select="'&#xA;'"/>
	<xsl:variable name="splitM" select="'(split / merged)'"/>

	<xsl:variable as="xs:string*" name="vSplitMergedSlurs" select="dme:split-merged-slurs()"/>
	<xsl:variable as="xs:string*" name="vSplitMergedBeams" select="dme:split-merged-tupl_beam('beam')"/>
	<xsl:variable as="xs:string*" name="vSplitMergedTuplets" select="dme:split-merged-tupl_beam('tuplet')"/>



	<xsl:variable name="autoCompareCSV">

		<xsl:for-each select="$vSplitMergedSlurs[not(. = '')]">
			<xsl:value-of select="."/>
			<xsl:value-of select="$delim"/>
			<xsl:value-of select="$splitM"/>
			<xsl:value-of select="$break"/>
		</xsl:for-each>

		<xsl:for-each select="$vSplitMergedTuplets[not(. = '')]">
			<xsl:value-of select="."/>
			<xsl:value-of select="$delim"/>
			<xsl:value-of select="$splitM"/>
			<xsl:value-of select="$break"/>
		</xsl:for-each>

		<xsl:for-each select="$vSplitMergedBeams[not(. = '')]">
			<xsl:value-of select="."/>
			<xsl:value-of select="$delim"/>
			<xsl:value-of select="$splitM"/>
			<xsl:value-of select="$break"/>
		</xsl:for-each>

		<xsl:for-each select="dme:correspElsExists('baseElsCorresp')">
			<xsl:variable name="currID" select="@xml:id"/>
			<xsl:variable name="correspEl" select="$comparedEls[@xml:id = $currID]"/>
			<xsl:variable as="xs:string" name="editionEqual" select="dme:edition-equal(., $correspEl)"/>
			<xsl:choose>
				<xsl:when test="not(tokenize($editionEqual, ',')[1] = 'true')">
					<xsl:value-of select="@xml:id"/>
					<xsl:value-of select="$delim"/>
					<xsl:value-of select="concat($correspEl/@xml:id, $edtType)"/>
					<xsl:value-of select="$delim"/>
					<xsl:value-of select="concat('(', $editionEqual, ')')"/>
					<xsl:value-of select="$break"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>

		<xsl:for-each select="dme:correspElsExists('baseElsNOCorresp')">
			<xsl:value-of select="@xml:id"/>
			<xsl:value-of select="$delim"/>
			<xsl:value-of select="'0'"/>
			<xsl:value-of select="$break"/>
		</xsl:for-each>

		<!--compared elements which do not have corresponding elements in the base file. Note: there is no needto repeat the comparison for comparedElHaveCorresp bcs those cases are included in baseElHaveCorresp-->
		<xsl:for-each select="dme:correspElsExists('compElsNoCorresp')">
			<xsl:value-of select="'0'"/>
			<xsl:value-of select="$delim"/>
			<xsl:value-of select="concat(@xml:id, $edtType)"/>
			<xsl:value-of select="$break"/>
		</xsl:for-each>

	</xsl:variable>


	<!--	needed bcs the $autoComparedCSV="note_123;note_123-B1note_456;note_456-B1" the $autoCompareTok looks then like  "note_123;note_123-B1", "note_456;note_456-B1"-->
	<xsl:variable name="autoComparedSeq" select="tokenize($autoCompareCSV, $break)"/>

	<xsl:variable name="diffProposals">
		<xsl:value-of select="concat('Reference text', $delim, 'Alternative text (', substring-after($edtType, '-'), ')', $delim, 'Differences')"/>
		<xsl:value-of select="$break"/>
		<xsl:value-of select="concat($baseFileName, $delim, $comparedFileName, $delim)"/>
		<xsl:value-of select="$break"/>
		<xsl:for-each select="$autoComparedSeq">
			<xsl:variable name="idEntries" select="dme:concatColumns(.)"/>
			<xsl:if test="
					not($idEntries
					= dme:diffList-entries())">
				<xsl:value-of select="string-join((dme:concatColumns(.), normalize-space(tokenize(., ';')[3])), ';')"/>
				<xsl:value-of select="$break"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>

	<xsl:variable name="possibleErrors">
		<xsl:variable as="xs:string*" name="entriesAuto">
			<xsl:for-each select="$autoComparedSeq">
				<xsl:sequence select="dme:concatColumns(.)"/>
			</xsl:for-each>
		</xsl:variable>

		<xsl:for-each select="$diffList">
			<xsl:variable name="firstColumns" select="dme:concatColumns(.)"/>
			<xsl:if test="not($firstColumns = $entriesAuto)">
				<xsl:value-of select="."/>
				<xsl:value-of select="$break"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>


	<xd:doc>
		<xd:desc/>
		<xd:param name="type"/>
	</xd:doc>
	<xsl:function name="dme:correspElsExists">
		<xsl:param name="type"/>
		<!--stores the IDs of the split/merged slurs in order to exclude them from the further comparison -->
		<!--'base' elements which have a corresponding element in 'compare'-->
		<xsl:variable as="element()*" name="els">
			<xsl:choose>
				<xsl:when test="$type = 'baseElsCorresp'">
					<xsl:sequence select="$baseEls[@xml:id = $comparedEls/@xml:id]"/>
				</xsl:when>
				<xsl:when test="$type = 'baseElsNOCorresp'">
					<xsl:sequence select="$baseEls[not(@xml:id = $comparedEls/@xml:id)]"/>
				</xsl:when>
				<xsl:when test="$type = 'compElsNoCorresp'">
					<xsl:sequence select="$comparedEls[not(@xml:id = $baseEls/@xml:id)]"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>


		<xsl:variable as="xs:string*" name="exclSpliteMergedSlurs">
			<xsl:for-each select="$els[local-name() = 'slur']">
				<xsl:variable as="xs:string?" name="ID" select="@xml:id"/>
				<xsl:choose>
					<xsl:when test="
							some $n in $vSplitMergedSlurs
								satisfies
								matches($n, $ID) = true()">
						<xsl:value-of select="@xml:id"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="output" select="$els[not(@xml:id = $exclSpliteMergedSlurs)]"/>
		<xsl:copy-of select="$output"/>
	</xsl:function>


	<xd:doc>
		<xd:desc>Joins the first and second columns of the diff-list {...}.csv. in order to be able to compare it with autoCompareCSV.</xd:desc>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:diffList-entries">
		<xsl:for-each select="$diffList">
			<xsl:value-of select="dme:concatColumns(.)"/>
		</xsl:for-each>
	</xsl:function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1"/>
		<xd:param name="arg2"/>
	</xd:doc>
	<xsl:function as="xs:anyAtomicType*" name="functx:value-union">
		<xsl:param as="xs:anyAtomicType*" name="arg1"/>
		<xsl:param as="xs:anyAtomicType*" name="arg2"/>

		<xsl:sequence select="
				distinct-values(($arg1, $arg2))
				"/>

	</xsl:function>

	<xd:doc>
		<xd:desc>The first two columns of the csv are merged. The space will be normalized.</xd:desc>
		<xd:param name="arg">the context node</xd:param>
	</xd:doc>
	<xsl:function name="dme:concatColumns">
		<xsl:param name="arg"/>
		<xsl:value-of select="string-join((normalize-space(tokenize($arg, ';')[1]), normalize-space(tokenize($arg, ';')[2])), ';')"/>
	</xsl:function>
</xsl:stylesheet>
