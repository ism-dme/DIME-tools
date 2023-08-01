<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc>
		<xd:desc>If all values of the $changeAccid are true(), the @accid should be changed to @accid.ges.</xd:desc>
	</xd:doc>
	<template name="checkPrecedingNotes">

		<variable as="xs:boolean+" name="changeAccid">
			<call-template name="preparePrecedings"/>
		</variable>

		<choose>
			<when test="
					some $a in $changeAccid
						satisfies $a = true()">
				<sequence select="true()"/>
			</when>
			<otherwise>
				<sequence select="false()"/>
			</otherwise>
		</choose>
	</template>


	<xd:doc>
		<xd:desc>Checks if the context note has precedings. Calculates few variables.</xd:desc>
	</xd:doc>
	<template as="xs:boolean*" name="preparePrecedings">

		<variable as="node()" name="currentNote" select="ancestor::note"/>
		<variable as="node()*" name="precedingNotes" select="$currentNote/preceding::note[ancestor::layer/@xml:id = $currentNote/ancestor::layer/@xml:id]"/>

		<choose>
			<when test="not(empty($precedingNotes)) (:would be empty if it is the first note in the measure:)">
				<call-template name="preparePreceding">
					<with-param name="precedingNotes" select="$precedingNotes"/>
					<with-param name="currentNote" select="$currentNote"/>
				</call-template>
			</when>
			<otherwise>
				<value-of select="false()"/>
			</otherwise>
		</choose>
	</template>


	<xd:doc>
		<xd:desc>An intermediate template. Calcualtes few variables and calls the template 'iterate'.</xd:desc>
		<xd:param name="precedingNotes"/>
		<xd:param name="currentNote"/>
	</xd:doc>
	<template name="preparePreceding">
		<param as="node()*" name="precedingNotes"/>
		<param as="node()*" name="currentNote"/>

		<variable as="map(xs:string, xs:string)" name="paramsCurrent">
			<call-template name="params">
				<with-param name="El" select="$currentNote"/>
			</call-template>
		</variable>


		<call-template name="iterate">
			<with-param name="allPrecedingNotes" select="$precedingNotes"/>
			<with-param name="paramsCurrent" select="$paramsCurrent"/>
			<with-param as="xs:boolean" name="natural" select=". = 'n'"/>
		</call-template>
	</template>


	<xd:doc>
		<xd:desc>Checks every preceding note in reverse order.</xd:desc>
		<xd:param name="allPrecedingNotes"/>
		<xd:param name="paramsCurrent"/>
		<xd:param name="natural"/>
		<xd:param name="allTiedNotes"/>
	</xd:doc>
	<template name="iterate">
		<param as="node()*" name="allPrecedingNotes"/>
		<param as="map(xs:string, xs:string)" name="paramsCurrent"/>
		<param as="xs:boolean" name="natural"/>
		<param name="allTiedNotes" tunnel="yes"/>

		<iterate select="reverse($allPrecedingNotes)">

			<variable as="map(xs:string, xs:string?)" name="paramsPreceding">
				<call-template name="params">
					<with-param name="El" select="."/>
				</call-template>
			</variable>

			<variable as="xs:boolean+" name="samePitchOct">
				<for-each select="'pname', 'oct'">
					<variable name="paramsCurrentVal" select="map:get($paramsCurrent, .)"/>
					<variable name="paramsPrecedingVal" select="map:get($paramsPreceding, .)"/>

					<choose>
						<when test="($paramsCurrentVal = '') or ($paramsPrecedingVal = '')">
							<value-of select="false()"/>
						</when>
						<otherwise>
							<sequence select="
									if ($paramsCurrentVal = $paramsPrecedingVal) then
										true()
									else
										false()"/>
						</otherwise>
					</choose>
				</for-each>
			</variable>

			<choose>
				<when test="@grace">
					<value-of select="false()"/>
				</when>
				<when test="
						every $a in $samePitchOct
							satisfies $a = true()">

					<variable name="precedingAccid" select="map:get($paramsPreceding, 'accid')"/>

					<choose>
						<when test="map:get($paramsCurrent, 'accid') = $precedingAccid">
							<choose>
								<when test="@xml:id = $allTiedNotes">
									<value-of select="false()"/>
									<break/>
								</when>
								<otherwise>
									<value-of select="true()"/>
									<break/>
								</otherwise>
							</choose>
						</when>
						<when test="$natural and matches($precedingAccid, '^[^n]$')">
							<value-of select="false()"/>
							<break/>
						</when>
						<when test="not($natural) and matches($precedingAccid, '^n$')">
							<value-of select="false()"/>
							<break/>
						</when>
						<otherwise>
							<value-of select="false()"/>
						</otherwise>
					</choose>
				</when>
				<otherwise>
					<value-of select="false()"/>
				</otherwise>
			</choose>
		</iterate>
	</template>


	<xd:doc>
		<xd:desc>Stores the compared parameters (@oct, @dur, @accid|@accid.ges) in a map.</xd:desc>
		<xd:param name="El"/>
	</xd:doc>
	<template name="params">
		<param name="El"/>

		<variable name="Element" select="
				if ($El[@sameas]) then
					$El/ancestor::body//*[@xml:id = substring($El/@sameas, 2)]
				else
					$El"/>

		<map>
			<map-entry key="'pname'" select="$Element/string(@pname)"/>
			<map-entry key="'oct'" select="$Element/string(@oct)"/>
			<map-entry key="'accid'" select="
					let $attr :=
					if ($Element//accid) then
						($Element//accid)[last()]/(@accid | @accid.ges)
					else
						$Element/(@accid | @accid.ges)
					return
						string($attr)"/>
		</map>
	</template>

</stylesheet>
