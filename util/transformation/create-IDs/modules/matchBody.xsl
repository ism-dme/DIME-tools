<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<include href="newID.xsl"/>
	<include href="section.xsl"/>


	<variable name="lists.create-IDs" select="doc('../../lib/lists/lists.xml')"/>
	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">$all</xd:param>
		<xd:param name="arg2">$els2apply</xd:param>
		<xd:param name="arg3">$els2exclude</xd:param>
	</xd:doc>
	<template match="body//*" mode="matchBody" name="main">
		<param name="arg1" tunnel="yes"/>
		<param name="arg2" tunnel="yes"/>
		<param name="arg3" tunnel="yes"/>

		<copy>
			<choose>

				<when test="($arg1 = 'YES' or local-name() = $arg2) and not(local-name() = $arg3)">
					<variable as="xs:string" name="newID">
						<call-template name="newID"/>
					</variable>

					<attribute name="xml:id">
						<value-of select="$newID"/>
					</attribute>

					<call-template name="oldID"/>

					<if test="local-name() = 'mdiv'">
						<call-template name="addN"/>
					</if>

					<apply-templates mode="#current" select="@* except (@xml:id, @n[parent::mdiv]), node()"/>
				</when>
				<otherwise>
					<apply-templates mode="#current" select="@*, node()"/>
				</otherwise>
			</choose>

		</copy>
	</template>



	<xd:doc>
		<xd:desc>counts preceding eleements</xd:desc>
		<xd:param name="element"/>
	</xd:doc>
	<template name="countPrecedingEls">
		<param name="element"/>
		<!--staffGrp are also nested that's where the XPath expression with ancestor is needed, hopefully there will be no nested scoreDefs-->
		<variable name="NrPrecElem" select="dme:countPreceding($element) + count($element/ancestor::node()[local-name() = $element/local-name()]) + 1"/>
		<!--check if '01' or '11', so if '0' is needed to be prefixed-->
		<choose>
			<when test="string-length(string($NrPrecElem)) > 1">
				<value-of select="$NrPrecElem"/>
			</when>
			<otherwise>
				<value-of select="concat('0', $NrPrecElem)"/>
			</otherwise>
		</choose>

	</template>





	<variable name="refs" select="$lists.create-IDs//id('REFS')/dme:item/text()"/>
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="@*[local-name() = ($refs)]" mode="references">
		<variable name="currentVal" select="."/>
		<variable name="values" select="
				for $n in tokenize(., '\s+')
				return
					substring-after($n, '#')"/>
		<variable name="refElem" select="
				//*[some $n in $values
					satisfies (@oldID = $n)]"/>

		<choose>
			<when test="$refElem">
				<variable name="newValue">
					<call-template name="newRefVal">
						<with-param name="refElem" select="$refElem"/>
					</call-template>
				</variable>
				<attribute name="{name()}" select="$newValue"/>
			</when>
			<otherwise>
				<copy/>
			</otherwise>
		</choose>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template name="oldID">
		<if test="@xml:id">
			<attribute name="oldID">
				<value-of select="@xml:id"/>
			</attribute>
		</if>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="@*[local-name() = 'oldID']" mode="references"/>

	<xd:doc>
		<xd:desc/>
		<xd:param name="refElem"/>
	</xd:doc>
	<template name="newRefVal">
		<param name="refElem"/>

		<for-each select="$refElem">
			<choose>
				<when test="position() != last() (:if there are multiple entries:)">
					<value-of select="concat('#', @xml:id, ' ')"/>
				</when>
				<otherwise>
					<value-of select="concat('#', @xml:id)"/>
				</otherwise>
			</choose>
		</for-each>
	</template>


	<xd:doc>
		<xd:desc>Adds @n to mdiv.</xd:desc>
		<xd:param name="arg1"/>
	</xd:doc>
	<template name="addN">
		<param as="element()" name="arg1" select="."/>
		<choose>
			<when test="$DIME-FileNaming">
				<variable as="xs:string" name="mdiv">
					<choose>
						<when test="count(//mdiv) > 1">
							<value-of select="dme:countMdiv($arg1)"/>
						</when>
						<otherwise>
							<value-of select="''"/>
						</otherwise>
					</choose>
				</variable>

				<variable name="n" select="functx:chars(map:get($optionsCalc, 'kvMovement'))[last()]"/>
				<attribute name="n">
					<!--	values like n="3b"-->
					<value-of select="concat($n, $mdiv)"/>
				</attribute>
			</when>
			<otherwise>
				<attribute name="n" select="count(preceding::mdiv) + 1"/>
			</otherwise>
		</choose>
	</template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="arg1">The context element.</xd:param>
	</xd:doc>
	<function name="dme:countMdiv">
		<param as="element()" name="arg1"/>

		<variable name="counter" select="count($arg1/preceding::mdiv) + 1"/>
		<value-of select="concat('_0', $counter)"/>
	</function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="element"/>
	</xd:doc>
	<function name="dme:countPreceding">
		<param name="element"/>
		<value-of select="count($element/preceding::node()[local-name() = $element/local-name()])"/>
	</function>


	<xd:doc>
		<xd:desc>Creates suffix '_sc{$countScoreDef}' if there are more then one scoreDefs in the body, otherwise the output is an empty string.</xd:desc>
		<xd:param name="context"/>
	</xd:doc>
	<function name="dme:scoreDefNumbers">
		<param as="node()" name="context"/>
		<choose>
			<when test="count($context/ancestor::body//scoreDef) > 1">
				<variable name="countScoreDef">
					<call-template name="countPrecedingEls">
						<with-param name="element" select="$context/ancestor::scoreDef"/>
					</call-template>
				</variable>
				<value-of select="concat('_sc', $countScoreDef)"/>
			</when>
			<otherwise>
				<value-of select="''"/>
			</otherwise>
		</choose>
	</function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="context"/>
	</xd:doc>
	<function name="dme:mdiv">
		<param as="node()" name="context"/>

		<choose>
			<when test="count($context/ancestor::mei//mdiv) > 1">
				<value-of select="dme:countMdiv($context)"/>
			</when>
			<otherwise>
				<value-of select="''"/>
			</otherwise>
		</choose>

	</function>
</stylesheet>
