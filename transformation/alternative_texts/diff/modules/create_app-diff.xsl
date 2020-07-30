<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei math uuid dme" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:i>Creates/modifies app-diff_{KV-movement}.xml from diff-list_{KV-movement}.csv</xd:i>
			</xd:p>
		</xd:desc>
	</xd:doc>

	<!--search if there is an 'IGNORE' entry in the diff-list. Every line in the diff-list is checked. Assuming that the position of IGNORE is always > 0 it deletes the '0' in the output (e.g. '000400') -->
	<xsl:variable as="xs:integer?" name="ignorePos">
		<xsl:variable name="ignoreAvailable">
			<xsl:for-each select="$diffList">
				<xsl:choose>
					<xsl:when test="starts-with(., 'IGNORE')">
						<xsl:value-of select="position()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="xs:integer(0)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ignorePosLocal" select="replace($ignoreAvailable, '0', '')"/>
		<xsl:choose>
			<xsl:when test="$ignorePosLocal != ''">
				<xsl:value-of select="$ignorePosLocal cast as xs:integer"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="0"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="appGrpID" select="concat('ref', $edtType)"/>
	<!--	Expected value of $mergedColumns is sequnce of strings, e.g. "note_123;note_123-B1", "slur_123;0". The values are taken only from the first two columns. -->
	<xsl:variable as="xs:string*" name="mergedColumns">
		<xsl:choose>
			<xsl:when test="$ignorePos = 0">
				<xsl:sequence select="dme:diffList-entries()[(position() > 2)]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="dme:diffList-entries()[(position() > 2) and (position() &lt; $ignorePos)]"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


	<xsl:variable as="element()" name="appGrp">

		<appGrp xmlns="http://www.mozarteum.at/ns/dme">
			<xsl:attribute name="xml:id" select="$appGrpID"/>
			<xsl:for-each select="$mergedColumns">
				<xsl:variable name="elements_1" select="tokenize(., ';')[1] (:base element:)"/>
				<xsl:variable name="elements_2" select="tokenize(., ';')[2] (:compared element:)"/>
				<xsl:if test="$elements_1 != '' and $elements_2 != ''">
					<app>
						<xsl:for-each select="tokenize($elements_1, '\s')">
							<rdg>
								<xsl:attribute name="target" select="concat($baseFileName, '#', dme:getMeasureID(., $baseFileName), '#', .)"/>
							</rdg>
						</xsl:for-each>
						<xsl:for-each select="tokenize($elements_2, '\s')">
							<rdg>
								<xsl:attribute name="target" select="concat($comparedFileName, '#', dme:getMeasureID(., $comparedFileName), '#', .)"/>
							</rdg>
						</xsl:for-each>
					</app>
				</xsl:if>
			</xsl:for-each>
		</appGrp>


	</xsl:variable>

	<!--count rdgs and apps-->
	<xsl:variable name="newAppGrp">
		<xsl:apply-templates mode="countRdgApp" select="$appGrp"/>
	</xsl:variable>



	<xd:doc>
		<xd:desc>Counts the apps</xd:desc>
	</xd:doc>
	<xsl:template match="dme:app" mode="countRdgApp">
		<xsl:variable name="appCounter" select="count(preceding-sibling::dme:app) + 1"/>
		<xsl:copy>
			<xsl:attribute name="xml:id">
				<xsl:value-of select="concat('app_', $appCounter)"/>
			</xsl:attribute>
			<xsl:apply-templates mode="#current" select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc>Counts the readings</xd:desc>
	</xd:doc>
	<xsl:template match="dme:rdg" mode="countRdgApp">
		<xsl:variable name="rdgCounter" select="count(preceding-sibling::dme:rdg) + 1"/>
		<xsl:variable name="targetTok" select="tokenize(@target, '#')"/>

		<xsl:choose>
			<xsl:when test="$targetTok[position() = last()] = '0'">
				<xsl:copy>
					<xsl:attribute name="n">
						<xsl:value-of select="$rdgCounter"/>
					</xsl:attribute>
					<xsl:attribute name="target">
						<xsl:value-of select="dme:measureIDzeroCase(., $targetTok)"/>
					</xsl:attribute>
					<xsl:apply-templates mode="#current" select="node() | @* except @target"/>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:attribute name="n">
						<xsl:value-of select="$rdgCounter"/>
					</xsl:attribute>
					<xsl:apply-templates mode="#current" select="@* | node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc>Gets Measure ID</xd:desc>
		<xd:param name="elementID"/>
		<xd:param name="fileName"/>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:getMeasureID">
		<xsl:param as="xs:string" name="elementID"/>
		<xsl:param as="xs:string" name="fileName"/>

		<xsl:choose>
			<xsl:when test="contains($fileName, 'dmeref')">
				<xsl:value-of select="$baseDocNode//*[@xml:id = $elementID]/ancestor::mei:measure/@xml:id"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$comparedDocNode//*[@xml:id = $elementID]/ancestor::mei:measure/@xml:id"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xsl:variable name="oldAppDiff" select="doc($appDiffPATH)"/>
	<xsl:variable name="appDiff">
		<xsl:choose>
			<xsl:when test="doc-available($appDiffPATH)">
				<appDiff xmlns="http://www.mozarteum.at/ns/dme">
					<xsl:copy-of select="$newAppGrp"/>
					<xsl:copy-of select="$oldAppDiff//dme:appGrp[@xml:id != $appGrpID]"/>
				</appDiff>
			</xsl:when>
			<xsl:otherwise>
				<xsl:document>
					<appDiff xmlns="http://www.mozarteum.at/ns/dme">
						<xsl:copy-of select="$newAppGrp"/>
					</appDiff>
				</xsl:document>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


	<xd:doc>
		<xd:desc>Adds measure ID in the case when the @target points to '0'. The value is taken from the sibling rdg respective measure only by taking the value from the sibling rdg; edition type is taken into account.</xd:desc>
		<xd:param name="rdg"/>
		<xd:param name="targetTok">Needed to get the fileName which is associated with the current @target.</xd:param>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:measureIDzeroCase">
		<xsl:param as="node()" name="rdg"/>
		<xsl:param as="xs:string+" name="targetTok"/>

		<xsl:variable name="edType" select="tokenize($targetTok[1], '_')[1] (:expected value e.g. 'dmeref':)"/>
		<xsl:variable name="otherTargetTok" select="tokenize($rdg/../dme:rdg[not(ends-with(@target, '0'))[1]]/@target, '#')"/>

		<xsl:variable as="xs:string" name="measureID">
			<xsl:choose>
				<xsl:when test="$edType[contains(., 'dmeref')]">
					<xsl:value-of select="concat(substring-before($otherTargetTok[2], '-'), '#0')"/>
				</xsl:when>
				<xsl:when test="$edType[contains(., 'dmeedt')]">
					<xsl:variable name="edition-type.short" select="concat('-', substring-after($edType, 'dmeedt'))"/>
					<xsl:value-of select="concat($otherTargetTok[2], $edition-type.short, '#0')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="string-join(($targetTok[1], $measureID), '#') (:expected value e.g. 'dmeedtB1_458-002_5494.xml#measure_1-B1':)"/>
	</xsl:function>

</xsl:stylesheet>
