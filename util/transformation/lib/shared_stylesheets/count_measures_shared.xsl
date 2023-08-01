<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>

	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Computes and adds @n to measure</xd:p>
			<xd:p>
				<xd:b>MAKE SURE mdiv has an @xml:id or create one before applying this xslt</xd:b>
			</xd:p>
			<xd:p><xd:b>Algorithm</xd:b>: All previous measures within one mdiv are counted. For instance, if the current measure is '16' there would be '15' measures which are before ($n_of_measures_before). To get the number '16', an '1' should be added ($MeasureDifference). Following cases affect the further computing: <xd:ul>
					<xd:li>The first measure in mdiv bear @metcon='false': The @n should be set to '0'. $MeasureDifference is set to '0' and this affects the further numbering. So our '16th' measure will have @n='15'</xd:li>
					<xd:li>For instance, there were two endings on measure @n='8' before. There should be @n='8A' in the first ending and an @n='8B' in the second ending. So the numbering is doubled and all measures after @n='8A' have to be shifted by '-1' ($n_measure1stEndings_before). Our example measure will be then @n='14'.</xd:li>
					<xd:li>A similar situation is in the case of measure/@metcon='false'. For instance, it would be in measure n="4". If this measure type is placed in the end of section, it means it is the left side of a repetition. So @n="4a" . The corresponding measure in the next section bear @n="4b". This difference is captured by $n_of_LastMetcon_before. The example measure would be then @n="13"</xd:li>
					<xd:li>The case if there are measure/@metcon within an ending is captured by $Metcon_in_secondEnding</xd:li>
				</xd:ul></xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="mdiv[position() = (1 to count(//mdiv))]//measure" mode="countMeasures" name="countForMdiv">
		<xsl:copy>

			<xsl:variable as="attribute()" name="mdivID" select="ancestor::mdiv[1]/@xml:id"/>
			<xsl:variable as="attribute()" name="sectionID" select="ancestor::section[1]/@xml:id"/>

			<!--If this IS the first metcon-measure in the mdiv -->
			<xsl:variable as="xs:boolean" name="zeroMeasure" select="boolean(.[(@metcon = 'false') and not(preceding::measure[ancestor::mdiv[1]/@xml:id = $mdivID])])"/>
			<!--if there WERE a first metcon-measurein the mdiv -->
			<xsl:variable as="xs:boolean" name="zeroMeasure_before" select="boolean(preceding::measure[(@metcon = 'false') and not(preceding::measure[ancestor::mdiv[1]/@xml:id = $mdivID])])"/>
			<xsl:variable as="xs:integer" name="MeasureDifference">
				<xsl:choose>
					<xsl:when test="$zeroMeasure or $zeroMeasure_before">
						<xs:integer>0</xs:integer>
					</xsl:when>
					<xsl:otherwise>
						<xs:integer>1</xs:integer>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable as="xs:integer" name="n_of_measures_before" select="count(preceding::measure[ancestor::mdiv/@xml:id = $mdivID])"/>
			<!--If there were metcon-measures in the end of any section and they are not child of endings (which are counted separately)-->
			<xsl:variable name="n_of_LastMetcon_before" select="count(preceding::measure[(@metcon = 'false') and (ancestor::mdiv[1]/@xml:id = $mdivID) and not(following-sibling::measure) and not(parent::ending)])"/>
			<!--Count metcon-measures if they are children of the first ending-->
			<xsl:variable as="xs:integer" name="n_measure1stEndings_before" select="count(preceding::measure[parent::ending[(ancestor::mdiv[1]/@xml:id = $mdivID) and (following-sibling::ending)]])"/>
			<xsl:variable as="xs:integer" name="Metcon_in_secondEnding" select="
					count(preceding::measure[@metcon = 'false' and (parent::ending[preceding-sibling::ending and (ancestor::mdiv[1]/@xml:id = $mdivID)])])"/>

			<xsl:variable as="xs:string" name="n_number">
				<xsl:value-of select="$n_of_measures_before - $n_measure1stEndings_before - $n_of_LastMetcon_before - $Metcon_in_secondEnding + $MeasureDifference"/>
			</xsl:variable>

			<!-- if the current measure is a last metcon-measure in the mdiv. If false() = this is the last measure-->
			<xsl:variable as="xs:boolean" name="exists_following_measure" select="boolean(following::measure[ancestor::mdiv/@xml:id = $mdivID])"/>

			
			<xsl:variable as="xs:string" name="n">


				<xsl:choose>
					<xsl:when test=".[@metcon = 'false']">

						<xsl:choose>
							<xsl:when test="
									$zeroMeasure or ($exists_following_measure = false() (:i.e. no followwing measures exist so this is last metcon-measure in this mdiv:))">
								<xsl:value-of select="$n_number"/>
							</xsl:when>
							<xsl:when test="parent::ending[following-sibling::ending]">
								<xsl:value-of select="concat($n_number, 'aA')"/>
							</xsl:when>
							<xsl:when test="parent::ending[preceding-sibling::ending]">
								<xsl:value-of select="concat($n_number, 'aB')"/>
							</xsl:when>
							<!--Last metcon in the section-->
							<xsl:when test="not(following::measure[ancestor::section/@xml:id = $sectionID])">
								<xsl:value-of select="concat($n_number, 'a')"/>
							</xsl:when>
							<!--first metcon in the section but not zeroMeasure-->
							<xsl:when test="
									not($zeroMeasure) and
									not(preceding-sibling::measure)">
								<xsl:value-of select="concat($n_number, 'b')"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test=".[parent::ending[following-sibling::ending] and not(@metcon)]">
						<xsl:value-of select="concat($n_number, 'A')"/>
					</xsl:when>
					<xsl:when test=".[parent::ending[preceding-sibling::ending] and not(@metcon)]">
						<xsl:value-of select="concat($n_number, 'B')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$n_number"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:attribute name="xml:id" select="@xml:id"/>
			<xsl:attribute name="n" select="xs:string($n)"/>

			<xsl:apply-templates select="node() | @* except (@n, @xml:id)"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
