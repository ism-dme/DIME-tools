<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	
	<xd:doc>
		<xd:desc>Copies elements form the original file.</xd:desc>
	</xd:doc>
	<xsl:template match="perfRes" mode="copyFromOrig">
		<xsl:apply-templates mode="perfRes" select="$processedFile//perfRes"/>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="perfRes" mode="perfRes">
		<xsl:variable name="listItem" select="$lists//id(current()/@codedval)"/>
		<xsl:variable name="classVocal" select="boolean($listItem/@class = ('voices', 'choruses'))"/>
		<xsl:copy>

			<xsl:variable name="perfResID">
				<xsl:value-of select="dme:perfResID(., $classVocal)"/>
			</xsl:variable>

			<xsl:attribute name="xml:id">
				<xsl:value-of select="$perfResID"/>
			</xsl:attribute>

			<xsl:variable name="nameEN" select="lower-case($listItem/dme:name[@xml:lang = 'EN']/text())"/>
			<xsl:attribute name="label">
				<xsl:value-of select="$nameEN"/>
			</xsl:attribute>

			<xsl:apply-templates mode="#current" select="@* except (@xml:id, @label, @authority), node()"/>

			<!--add names for the instruments-->
			<xsl:if test="not($classVocal)">
				<xsl:value-of select="dme:countInstr(., $nameEN)"/>
			</xsl:if>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc>Finds if there are more then one instruments of the same group and adjusts their names. E.g. clarinet-1, clarinet-2</xd:desc>
		<xd:param name="arg1">current perfRes</xd:param>
		<xd:param name="arg2">$nameEn</xd:param>
	</xd:doc>
	<xsl:function name="dme:countInstr">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>

		<xsl:variable name="currCodedval" select="$arg1/@codedval"/>
		<xsl:variable as="xs:integer" name="countCodedval" select="count($arg1/parent::perfResList/*[$currCodedval = @codedval])"/>

		<xsl:variable name="output">
			<xsl:choose>
				<xsl:when test="$countCodedval > 1">
					<xsl:variable as="xs:integer" name="currNumber" select="count($arg1/preceding-sibling::perfRes[@codedval = $currCodedval]) + 1"/>
					<xsl:value-of select="concat($arg2, '-', $currNumber)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$arg2"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:copy-of select="$output"/>
	</xsl:function>


	<xd:doc>
		<xd:desc>Creates ID. Counts previous perfRes according to if they are instrumenal or vocal.</xd:desc>
		<xd:param name="arg1">current perfRes</xd:param>
		<xd:param name="arg2">$classVocal</xd:param>
	</xd:doc>
	<xsl:function name="dme:perfResID">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>


		<xsl:variable name="instrVoc">
			<xsl:choose>
				<xsl:when test="$arg2">
					<xsl:value-of select="'vocal'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'instr'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable as="xs:string*" name="class">
			<xsl:choose>
				<xsl:when test="$arg2">
					<xsl:sequence select="distinct-values($lists//@class[. = ('voices', 'choruses')])"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:sequence select="distinct-values($lists//@class[not(. = ('voices', 'choruses'))])"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable as="xs:integer" name="countPrev">
			<xsl:variable as="xs:string*" name="perfRes2count">
				<xsl:for-each select="$arg1/preceding-sibling::perfRes">
					<xsl:variable name="codedval" select="string(@codedval)"/>
					<xsl:if test="$lists//id($codedval)/@class = $class">
						<xsl:sequence select="'1'"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:variable>
			<xsl:value-of select="count($perfRes2count) + 1"/>
		</xsl:variable>
		<xsl:variable name="output" select="concat($instrVoc, 'Voice_', $countPrev)"/>

		<xsl:copy-of select="$output"/>
	</xsl:function>
</xsl:stylesheet>
