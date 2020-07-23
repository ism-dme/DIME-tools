<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs math xd mei uuid dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:i>Checks if the sum of the element durations in a &lt;layer&gt; is equal to the expected number according to the current meter.</xd:i>
			</xd:p>
			<xd:p><xd:b>Note</xd:b>: The &lt;layer&gt;s in the following measures are not processed: <xd:ul>
				<xd:li>uncomplete measures (@metcon='false')</xd:li>
				<xd:li>those which have &lt;mRest&gt;, &lt;app&gt;, &lt;choice&gt; or &lt;tuplet&gt; as descendants</xd:li>
			</xd:ul>
			</xd:p>
			<xd:p><xd:b>User guide:</xd:b> The stylesheet outputs a <xd:i>wrong_durations.txt</xd:i> in the same folder as the file to which the transformation was applied. This output file contatins the list of the @xml:id of the &lt;layer&gt;s where the durations are possibly wrong. Note that the XML-file itself is not changes in any way.</xd:p>			
			<xd:p><xd:b>Disclaimer</xd:b> Some parts of the stylesheet (e.g. <xd:i>dme:durations()</xd:i>) are taken frome the stylesheet for calculating the timestamps developed by Johannes Kepper.</xd:p>
			<xd:p><xd:i>Current version</xd:i>: <xd:b id="version">1.0.0</xd:b>. For more info see the <xd:b>changeLog</xd:b> below.</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
		</xd:desc>
	</xd:doc>
	<import href="changeLog.xsl"/>

	<variable name="exceptions" select="'beatRpt', 'halfmRpt'"/>
	<variable name="break" select="'&#xA;'"/>


	<!--TODO: 
NOTHING-->

	<xd:doc>
		<xd:desc/>

	</xd:doc>
	<template match="/">

		<variable as="text()*" name="wrong_durations">
			<call-template name="layers">
				<with-param name="layers" select="//layer[not(ancestor::measure[@metcon = 'false'])][not(descendant::mRest | descendant::app | descendant::choice)][not(descendant::tuplet)]"/>
			</call-template>
		</variable>

		<result-document href="wrong_durations.txt">
			<copy-of select="string-join($wrong_durations, $break)"/>
		</result-document>
	</template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template name="layers">
		<param name="layers"/>

		<for-each select="$layers">
			<call-template name="durations"/>
		</for-each>
	</template>


	<template match="layer" name="durations">

		<variable as="xs:integer" name="meter.count" select="preceding::scoreDef[@meter.count][1]/@meter.count cast as xs:integer"/>
		<variable as="xs:integer" name="meter.unit" select="preceding::scoreDef[@meter.unit][1]/@meter.unit cast as xs:integer"/>
		<variable name="events" select=".//*[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]"/>
		<variable as="xs:double*" name="durations" select="dme:durations($events, $meter.count, $meter.unit)"/>

		<variable name="expectedCount" select="(1 div $meter.unit) * $meter.count"/>

		<if test="not(sum($durations) = $expectedCount)">
			<value-of select="@xml:id"/>
		</if>

	</template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="events"/>
		<xd:param name="meter.count"/>
		<xd:param name="meter.unit"/>
	</xd:doc>
	<function as="xs:double*" name="dme:durations">
		<param name="events"/>
		<param name="meter.count"/>
		<param name="meter.unit"/>

		<for-each select="$events">
			<variable as="xs:double" name="dur">
				<choose>
					<when test="@dur">
						<value-of select="1 div number(@dur)"/>
					</when>
					<when test="local-name() = 'beatRpt'">
						<value-of select="1 div $meter.unit"/>
					</when>
					<when test="local-name() = 'halfmRpt'">
						<value-of select="($meter.count div 2) div $meter.unit"/>
					</when>
				</choose>
			</variable>
			<variable as="xs:double" name="tupletFactor">
				<choose>
					<when test="ancestor::tuplet">
						<value-of select="(ancestor::tuplet)[1]/number(@numbase) div (ancestor::tuplet)[1]/number(@num)"/>
					</when>
					<otherwise>
						<value-of select="1"/>
					</otherwise>
				</choose>
			</variable>
			<variable as="xs:double" name="dots">
				<choose>
					<when test="@dots">
						<value-of select="number(@dots)"/>
					</when>
					<otherwise>
						<value-of select="0"/>
					</otherwise>
				</choose>
			</variable>
			<value-of select="(2 * $dur - ($dur div math:pow(2, $dots))) * $tupletFactor"/>
		</for-each>
	</function>

	<output indent="yes" method="text"/>
</stylesheet>
