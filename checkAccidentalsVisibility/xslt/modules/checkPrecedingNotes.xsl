<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc>If all values of the $changeAccid are true(), the @accid should be changed to @accid.ges.</xd:desc>
	</xd:doc>
	<xsl:template name="checkPrecedingNotes">

		<xsl:variable as="xs:boolean+" name="changeAccid">
			<xsl:call-template name="preparePrecedings"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="
					some $a in $changeAccid
						satisfies $a = true()">
				<xsl:sequence select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:desc>Checks if the context note has precedings. Calculates few variables.</xd:desc>
	</xd:doc>
	<xsl:template as="xs:boolean*" name="preparePrecedings">

		<xsl:variable as="node()" name="currentNote" select="ancestor::note"/>
		<xsl:variable as="node()*" name="precedingNotes" select="$currentNote/preceding::note[ancestor::layer/@xml:id = $currentNote/ancestor::layer/@xml:id]"/>

		<xsl:choose>
			<xsl:when test="not(empty($precedingNotes)) (:would be empty if it is the first note in the measure:)">
				<xsl:call-template name="preparePreceding">
					<xsl:with-param name="precedingNotes" select="$precedingNotes"/>
					<xsl:with-param name="currentNote" select="$currentNote"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:desc>An intermediate template. Calcualtes few variables and calls the template 'iterate'.</xd:desc>
		<xd:param name="precedingNotes"/>
		<xd:param name="currentNote"/>
	</xd:doc>
	<xsl:template name="preparePreceding">
		<xsl:param as="node()*" name="precedingNotes"/>
		<xsl:param as="node()*" name="currentNote"/>

		<xsl:variable as="map(xs:string, xs:string)" name="paramsCurrent">
			<xsl:call-template name="params">
				<xsl:with-param name="El" select="$currentNote"/>
			</xsl:call-template>
		</xsl:variable>


		<xsl:call-template name="iterate">
			<xsl:with-param name="allPrecedingNotes" select="$precedingNotes"/>
			<xsl:with-param name="paramsCurrent" select="$paramsCurrent"/>
			<xsl:with-param as="xs:boolean" name="natural" select=". = 'n'"/>
		</xsl:call-template>
	</xsl:template>


	<xd:doc>
		<xd:desc>Checks every preceding note in reverse order.</xd:desc>
		<xd:param name="allPrecedingNotes"/>
		<xd:param name="paramsCurrent"/>
		<xd:param name="natural"/>
		<xd:param name="allTiedNotes"/>
	</xd:doc>
	<xsl:template name="iterate">
		<xsl:param as="node()*" name="allPrecedingNotes"/>
		<xsl:param as="map(xs:string, xs:string)" name="paramsCurrent"/>
		<xsl:param as="xs:boolean" name="natural"/>
		<xsl:param name="allTiedNotes" tunnel="yes"/>

		<xsl:iterate select="reverse($allPrecedingNotes)">

			<xsl:variable as="map(xs:string, xs:string?)" name="paramsPreceding">
				<xsl:call-template name="params">
					<xsl:with-param name="El" select="."/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:variable as="xs:boolean+" name="samePitchOct">
				<xsl:for-each select="'pname', 'oct'">
					<xsl:variable name="paramsCurrentVal" select="map:get($paramsCurrent, .)"/>
					<xsl:variable name="paramsPrecedingVal" select="map:get($paramsPreceding, .)"/>

					<xsl:choose>
						<xsl:when test="($paramsCurrentVal = '') or ($paramsPrecedingVal = '')">
							<xsl:value-of select="false()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:sequence select="
									if ($paramsCurrentVal = $paramsPrecedingVal) then
										true()
									else
										false()"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="@grace">
					<xsl:value-of select="false()"/>
				</xsl:when>
				<xsl:when test="
						every $a in $samePitchOct
							satisfies $a = true()">

					<xsl:variable name="precedingAccid" select="map:get($paramsPreceding, 'accid')"/>

					<xsl:choose>
						<xsl:when test="map:get($paramsCurrent, 'accid') = $precedingAccid">
							<xsl:choose>
								<xsl:when test="@xml:id = $allTiedNotes">
									<xsl:value-of select="false()"/>
									<xsl:break/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="true()"/>
									<xsl:break/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$natural and matches($precedingAccid, '^[^n]$')">
							<xsl:value-of select="false()"/>
							<xsl:break/>
						</xsl:when>
						<xsl:when test="not($natural) and matches($precedingAccid, '^n$')">
							<xsl:value-of select="false()"/>
							<xsl:break/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="false()"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:iterate>
	</xsl:template>


	<xd:doc>
		<xd:desc>Stores the compared parameters (@oct, @dur, @accid|@accid.ges) in a map.</xd:desc>
		<xd:param name="El"/>
	</xd:doc>
	<xsl:template name="params">
		<xsl:param name="El"/>

		<xsl:variable name="Element" select="
				if ($El[@sameas]) then
					$El/ancestor::body//*[@xml:id = substring($El/@sameas, 2)]
				else
					$El"/>

		<xsl:map>
			<xsl:map-entry key="'pname'" select="$Element/string(@pname)"/>
			<xsl:map-entry key="'oct'" select="$Element/string(@oct)"/>
			<xsl:map-entry key="'accid'" select="
					let $attr :=
					if ($Element//accid) then
						($Element//accid)[last()]/(@accid | @accid.ges)
					else
						$Element/(@accid | @accid.ges)
					return
						string($attr)"/>
		</xsl:map>
	</xsl:template>

</xsl:stylesheet>
