<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs math xd mei uuid dme" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc><p><i>Adds/replaces @tstamps</i></p>
			<p>Exceptions (no @tstamps are added): 
				<ul>					
					<li>&lt;bTrem&gt;, &lt;fTrem&gt;</li>
					<li>Descendants of a &lt;chord&gt; </li>
					<li>&lt;layer&gt;s which have &lt;app&gt; or &lt;choice&gt; as ancestor or descendant</li>
				</ul>
			</p>			
			<p><b>Disclaimer</b>: The stylesheet uses an algorithm developed by <b>Johannes Kepper</b>, cf. : <ul><li>addIDs_and_tstamps.xsl (2014)</li><li>fixTstamps.xsl (2018)</li></ul> </p>
			<p>
				<b>Modified by: </b>Oleksii Sapov</p>
			<p><i>Current version</i> is <b id="version">1.1.0</b>. For more info see the <b>changeLog</b> below.</p>
		</desc>
	</doc>
	<xsl:include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
	<xsl:include href="../lib/basic.xsl"/>
	<xsl:import href="changeLog.xsl"/>
	
	
	<xsl:variable name="exceptions" select="'beatRpt', 'halfmRpt'"/>

	

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="/">

		<xsl:variable name="events">
			<xsl:apply-templates mode="events"/>
		</xsl:variable>

		<xsl:copy-of select="$events"/>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="measure" mode="events">
		<xsl:variable as="xs:integer" name="meter.count" select="preceding::scoreDef[@meter.count][1]/@meter.count cast as xs:integer"/>
		<xsl:variable as="xs:integer" name="meter.unit" select="preceding::scoreDef[@meter.unit][1]/@meter.unit cast as xs:integer"/>

		<xsl:copy>
			<xsl:apply-templates mode="#current" select="node() | @*">
				<xsl:with-param name="meter.count" select="$meter.count" tunnel="yes"/>
				<xsl:with-param name="meter.unit" select="$meter.unit" tunnel="yes"/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="meter.count"/>
		<xd:param name="meter.unit"/>
	</xd:doc>
	<xsl:template match="layer" mode="events">
		<xsl:param name="meter.count" tunnel="yes"/>
		<xsl:param name="meter.unit" tunnel="yes"/>

		<xsl:variable as="element()*" name="events">
			<xsl:call-template name="vEvents"/>
		</xsl:variable>

		<xsl:variable as="xs:double*" name="durations" select="dme:durations($events, $meter.count, $meter.unit)"/>

		<xsl:variable name="tstamps">
			<xsl:for-each select="$events">
				<xsl:variable name="pos" select="position()"/>
				<event id="{@xml:id}" onset="{sum($durations[position() lt $pos])}"/>
			</xsl:for-each>
		</xsl:variable>


		<xsl:choose>
			<xsl:when test="
					not(descendant::choice or ancestor::choice) and not(descendant::app or
					ancestor::app)">
				<xsl:copy>
					<xsl:apply-templates mode="#current" select="node() | @*">
						<xsl:with-param name="tstamps" select="$tstamps" tunnel="yes"/>
					</xsl:apply-templates>
				</xsl:copy>
			</xsl:when>
			<xsl:when test="descendant::choice | ancestor::choice | descendant::app | ancestor::app">
				<xsl:message select="
						'WARN: ' || @xml:id || ' is related to a choice or an app, tstamps need to be checked. Comment, *TODO* inserted.'"/>
				<xsl:comment select="'TODO: Check tstamps in the following layer.'"/>
				<xsl:copy-of select="."/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Returns sequence of the elements which fulfill the following constraints: <xd:ul>
					<xd:li>have @dur</xd:li>
					<xd:li>are not descendant of a &lt;chord&gt;</xd:li>
					<xd:li>belong to the $exceptions</xd:li>
				</xd:ul></xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="vEvents">
		<xsl:for-each select=".//*">
			<xsl:choose>
				<xsl:when test="@sameas">
					<xsl:variable name="reference" select="substring-after(@sameas, '#') => id()"/>
					<xsl:if test="$reference[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]">
						<xsl:sequence select="functx:add-attributes(., xs:QName('dur'), $reference/@dur)"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="@copyof">
					<xsl:variable name="reference" select="substring-after(@copyof, '#') => id()"/>
					<xsl:if test="$reference[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]">
						<xsl:sequence select="functx:add-attributes(., xs:QName('dur'), $reference/@dur)"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test=".[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)]">
						<xsl:sequence select="."/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>if $constraints1 or $constraints2 is true, the template calcTstamps is applied, otherwise the node is copied.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="layer//*" mode="events">

		<xsl:variable as="xs:boolean" name="constraints1" select="boolean(.[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)])"/>
		<xsl:variable as="xs:boolean" name="constraints2">
			<xsl:variable name="ref" select="id(substring-after(@sameas, '#'))"/>
			<xsl:sequence select="boolean($ref[(@dur and not(ancestor::chord) and not(@grace)) or (local-name() = $exceptions)])"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$constraints1 or $constraints2">
				<xsl:call-template name="calcTstamps"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates mode="#current" select="@*, node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Adds @tstamp.</xd:p>
		</xd:desc>
		<xd:param name="tstamps"/>
		<xd:param name="meter.unit"/>
		<xd:param name="meter.count"/>
	</xd:doc>
	<xsl:template name="calcTstamps">
		<xsl:param name="tstamps" tunnel="yes"/>
		<xsl:param name="meter.unit" tunnel="yes"/>
		<xsl:param name="meter.count" tunnel="yes"/>

		<xsl:variable as="xs:string" name="id" select="@xml:id"/>
		<xsl:variable name="onset" select="$tstamps//*[@id = $id]/@onset"/>

		<xsl:copy>
			<xsl:apply-templates mode="#current" select="@*"/>
			<xsl:choose>
				<xsl:when test="local-name() = 'beatRpt'">
					<xsl:attribute name="dur" select="$meter.unit"/>
				</xsl:when>
				<xsl:when test="local-name() = 'halfmRpt'">
					<xsl:choose>
						<xsl:when test="$meter.count = 4 and $meter.unit = 4">
							<xsl:attribute name="dur" select="2"/>
						</xsl:when>
						<xsl:when test="$meter.count = 6 and $meter.unit = 8">
							<xsl:attribute name="dur" select="4"/>
							<xsl:attribute name="dots" select="1"/>
						</xsl:when>
						<xsl:when test="$meter.count = 2 and $meter.unit = 2">
							<xsl:attribute name="dur" select="2"/>
						</xsl:when>
						<xsl:when test="$meter.count = 2 and $meter.unit = 4">
							<xsl:attribute name="dur" select="4"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="dur"/>
							<xsl:message>Could not identify the correct duration for halfmRpt</xsl:message>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>

			<xsl:variable as="xs:string*" name="old.tstamp" select="@tstamp"/>
			<xsl:variable as="xs:string" name="new.tstamp" select="string(round(($onset * $meter.unit) + 1, 5))"/>
			<xsl:variable as="xs:string" name="statement">
				<xsl:choose>
					<xsl:when test="number($new.tstamp) ge ($meter.count + 1)">
						<xsl:value-of select="'ATTENTION: new value is still to high'"/>
					</xsl:when>
					<xsl:when test="ancestor::tuplet">
						<xsl:value-of select="'(inside tuplet)'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="''"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>


			<xsl:attribute name="tstamp" select="$new.tstamp"/>
			<xsl:apply-templates mode="#current" select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="mRest | mSpace | mRpt" mode="events">
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="@*"/>
			<xsl:attribute name="tstamp" select="'1'"/>
			<xsl:apply-templates mode="#current" select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="events"/>
		<xd:param name="meter.count"/>
		<xd:param name="meter.unit"/>
	</xd:doc>
	<xsl:function as="xs:double*" name="dme:durations">
		<xsl:param name="events"/>
		<xsl:param name="meter.count"/>
		<xsl:param name="meter.unit"/>

		<xsl:for-each select="$events">
			<xsl:variable as="xs:double" name="dur">
				<xsl:choose>
					<xsl:when test="@dur">
						<xsl:value-of select="1 div number(@dur)"/>
					</xsl:when>
					<xsl:when test="local-name() = 'beatRpt'">
						<xsl:value-of select="1 div $meter.unit"/>
					</xsl:when>
					<xsl:when test="local-name() = 'halfmRpt'">
						<xsl:value-of select="($meter.count div 2) div $meter.unit"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable as="xs:double" name="tupletFactor">
				<xsl:choose>
					<xsl:when test="ancestor::tuplet">
						<xsl:value-of select="(ancestor::tuplet)[1]/number(@numbase) div (ancestor::tuplet)[1]/number(@num)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="1"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable as="xs:double" name="dots">
				<xsl:choose>
					<xsl:when test="@dots">
						<xsl:value-of select="number(@dots)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="0"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="(2 * $dur - ($dur div math:pow(2, $dots))) * $tupletFactor"/>
		</xsl:for-each>
	</xsl:function>

</xsl:stylesheet>
