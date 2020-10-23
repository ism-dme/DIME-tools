<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei math uuid dme" extension-element-prefixes="exsl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:exsl="http://exslt.org/common" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on: </xd:b>Oct 3, 2018</xd:p>
			<xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:p>
					<xd:b>Description:</xd:b>
					<xd:i>Inserts an element after another element.</xd:i>
				</xd:p>
				<xd:p>
					<xd:b>Usage</xd:b>:<xd:ul>
						<xd:li>Open addElement-list.csv with Excel. Note: the file is located in the same repository as addElement.xsl, currently "..\util\xslt_oxygen\reference_texts\addElement"</xd:li>
						<xd:li>Column 1: Insert name(s) of the element(s) to be inserted. Any names, any number of those are allowed</xd:li>
						<xd:li>Column 2: (optional) insert xml:id of the respective mdiv, then ':', then @n of the measure, after which the element will be inserted (useful for pb/sb)</xd:li>
						<xd:li>Column 3: @xml:id of an element after which the new Element wil be inserted</xd:li>
						<xd:li>Column 4+: Up from this column you may insert any number of attributes with respective values. Note: if the respective cell stays empty, no attribute will be inserted</xd:li>
						<xd:li>Save the .csv file and apply the transformation scenario on your xml-file</xd:li>
						<xd:li>Don't commit the changes in the .csv, execute the TortioseSVN-'revert'-command instead</xd:li>
					</xd:ul>
				</xd:p>
				<xd:p><xd:b>Remarks</xd:b>:<xd:ul>
						<xd:li>Every new element gets an @xml:id per default. If the processed file is of the type 'dmeedt', the @xml:id will get the edition-type-suffix, e.g. '-B1'.</xd:li>
						<xd:li>If you don't use the predefined oxygen transformation scenario from 'utils documentation page': the parameter 'current.file.name' have to be set to '${cfn}'</xd:li>
					</xd:ul>
				</xd:p>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:param name="current.file.name"/>
	<xsl:include href="../../lib/basic.xsl"/>
	<xsl:variable as="xs:string*" name="changes.input" select="unparsed-text-lines('addElement-list.CSV', 'UTF-8')"/>
	<xsl:variable as="xs:string*" name="measureCell" select="
			for $n in $changes.input
			return
				tokenize($n, ';')[2]"/>
	<xsl:variable name="insert-after_mdivID" select="
			for $n in $measureCell
			return
				substring-before($n, ':')"/>
	<xsl:variable name="insert-after_measureNumber" select="
			for $n in $measureCell
			return
				substring-after($n, ':')"/>
	<xsl:variable name="insert-after_elementID" select="
			for $n in $changes.input
			return
				tokenize($n, ';')[3]"/>
	<xsl:variable name="attributeNames" select="tokenize($changes.input[1], ';')[position() > 3]"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="//*[@xml:id = $insert-after_elementID] | mei:mdiv[@xml:id = $insert-after_mdivID]//mei:measure[@n = $insert-after_measureNumber]">
		<xsl:copy>
			<xsl:apply-templates select="@*, node()"/>
		</xsl:copy>

		<xsl:variable name="correspRow" select="dme:correspRow(.)"/>
		<xsl:element name="{$correspRow[1]}" namespace="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="xml:id" select="dme:newID($correspRow[1], .)"/>
			<xsl:for-each select="$attributeNames">
				<xsl:variable name="attributePosition" select="position()"/>
				<xsl:variable as="xs:string*" name="attributeValue" select="$correspRow[number($attributePosition + 3)]"/>
				<xsl:if test="$attributeValue != ''">
					<xsl:attribute name="{.}" select="$attributeValue"/>
				</xsl:if>
			</xsl:for-each>
			<xsl:message terminate="no">A '<xsl:value-of select="dme:newID($correspRow[1], .)"/>' was inserted after'<xsl:value-of select="@xml:id"/>'.</xsl:message>
		</xsl:element>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="elementID"/>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:correspRow_elementID">
		<xsl:param as="xs:string" name="elementID"/>

		<xsl:variable as="xs:integer?" name="positionList">
			<xsl:for-each select="$changes.input">
				<xsl:variable name="forEach-currentN" select="tokenize(., ';')[2]"/>
				<xsl:variable name="forEach-currentID" select="tokenize(., ';')[3]"/>
				<xsl:if test="($forEach-currentID = $elementID) or ($forEach-currentN = $elementID)">
					<xsl:value-of select="position()"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable as="xs:string*" name="return" select="tokenize($changes.input[$positionList], ';')"/>
		<xsl:copy-of select="$return"/>
	</xsl:function>


	<xd:doc>
		<xd:desc/>
		<xd:param name="mdviID"/>
		<xd:param name="MeasureN"/>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:correspRow_MeasureN">
		<xsl:param as="xs:string" name="mdviID"/>
		<xsl:param as="xs:string" name="MeasureN"/>

		<xsl:variable name="measureCell" select="string-join(($mdviID, $MeasureN), ':')"/>
		<xsl:variable as="xs:integer?" name="positionList">
			<xsl:for-each select="$changes.input">
				<xsl:variable name="forEach-currentMeasureCell" select="tokenize(., ';')[2]"/>
				<xsl:if test="$forEach-currentMeasureCell = $measureCell">
					<xsl:value-of select="position()"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable as="xs:string*" name="return" select="tokenize($changes.input[$positionList], ';')"/>
		<xsl:copy-of select="$return"/>
	</xsl:function>


	<xd:doc>
		<xd:desc/>
		<xd:param name="node"/>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:correspRow">
		<xsl:param as="node()?" name="node"/>

		<xsl:variable as="xs:string*" name="correspRow" select="
				if (local-name($node) = 'measure') then
					dme:correspRow_MeasureN(xs:string($node/ancestor::mei:mdiv/@xml:id), xs:string($node/@n))
				else
					dme:correspRow_elementID(xs:string($node/@xml:id))"/>
		<xsl:copy-of select="$correspRow"/>
	</xsl:function>

	<xd:doc>
		<xd:desc/>
		<xd:param name="elementName"/>
		<xd:param name="node"/>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:newID">
		<xsl:param as="xs:string" name="elementName"/>
		<xsl:param as="node()" name="node"/>

		<xsl:variable as="xs:string?" name="baseID" select="concat($elementName, '_', number(substring(generate-id($node), 4)) * 3)"/>
		<xsl:variable as="xs:string?" name="newID">
			<xsl:choose>
				<xsl:when test="$current.file.name[contains(., 'dmeedt')]">
					<xsl:value-of select="string-join(($baseID, substring-after(tokenize($current.file.name, '_')[1], 'dmeedt')), '-')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$baseID"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy-of select="$newID"/>
		<!--<xsl:message>New ID: <xsl:value-of select="$newID"/></xsl:message>-->
	</xsl:function>


</xsl:stylesheet>
