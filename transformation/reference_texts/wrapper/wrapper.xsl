<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei math uuid dme" extension-element-prefixes="exsl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:exsl="http://exslt.org/common" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description:</xd:b>
				<xd:i>Wraps elements. The elements for poreccessing and the atrributes have to be defined in the elements2wrap-list.CSV.</xd:i>
			</xd:p>
			<xd:p>
				<xd:b>User guide for elements2wrap-list.CSV:</xd:b>
				<xd:ul>
					<xd:li>Open elements2wrap-list.CSV with Excel; this file is located in the same repository as wrapper.xsl, currently "..\util\xslt_oxygen\alternative_texts\wrapper"</xd:li>
					<xd:li>There are two usage cases:<xd:ul>
							<xd:li>
								<xd:b>Case 1: elements to wrap are specified by their IDs:</xd:b>
								<xd:ul>
									<xd:li>Column 1: insert name(s) of the wrapper element(s)</xd:li>
									<xd:li>Column 2: an @xml:id of the element to be wrapped</xd:li>
									<xd:li>Column 3: leave empty</xd:li>
								</xd:ul>
							</xd:li>
							<xd:li><xd:b>Case 2: elements to wrap are specified by their name</xd:b> (note: all ellements with the name will be wrapped): <xd:ul>
									<xd:li>Column 1: insert name of the wrapper element</xd:li>
									<xd:li>Column 2: leave empty</xd:li>
									<xd:li>Column 3: name of the elements to be wrapped</xd:li>
								</xd:ul>
							</xd:li>
							<xd:li><xd:b>For all cases:</xd:b> Column 4+: Up from this column you may insert any number of attributes with respective values. Note: if the respective cell remains empty, no attribute will be inserted</xd:li>
						</xd:ul>
					</xd:li>
					<xd:li>
						<xd:b>General remarks:</xd:b>
						<xd:ul>
							<xd:li>Save the .csv file and apply the transformation scenario on your xml-file</xd:li>
							<xd:li>Don't commit the changes in the .csv, execute the TortioseSVN-'revert'-command instead</xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>Sep 12, 2018<xd:ul>
					<xd:li>
						<xd:i>Updates:</xd:i>
						<xd:ul>28.11.2018 </xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
		</xd:desc>
	</xd:doc>

	<xsl:param as="xs:string*" name="changes.input" select="unparsed-text-lines('elements2wrap-list.CSV', 'UTF-8')"/>
	<xsl:include href="../../lib/basic.xsl"/>
	<!--variables for the template 'respectiveID-->
	<xsl:variable as="xs:string*" name="ID" select="
			for $n in $changes.input
			return
				tokenize($n, ';')[2]"/>
	<xsl:variable as="xs:string*" name="attributeNames" select="tokenize($changes.input[1], ';')[position() > 3]"/>

	<!--variables for the template wrappAllElements-->
	<xsl:variable as="xs:string*" name="wrapperName" select="tokenize($changes.input[2], ';')[1]"/>
	<xsl:variable as="xs:string*" name="elName" select="tokenize($changes.input[2], ';')[3]"/>
	<xd:doc>
		<xd:desc>Wraps elements with specified IDs</xd:desc>
	</xd:doc>
	<xsl:template match="mei:*[@xml:id = $ID]" name="respectiveID">
		<xsl:variable name="correspRow" select="dme:correspRow(@xml:id)"/>
		<xsl:variable as="xs:string" name="newID" select="concat($correspRow[1], '_', substring-after(@xml:id, '_'))"/>

		<xsl:element name="{$correspRow[1]}" namespace="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="xml:id" select="$newID"/>
			<xsl:for-each select="$attributeNames">
				<xsl:variable name="attributePosition" select="position()"/>
				<xsl:variable as="xs:string*" name="attributeValue" select="$correspRow[number($attributePosition + 3)]"/>
				<xsl:if test="$attributeValue != ''">
					<xsl:attribute name="{.}" select="$attributeValue"/>
				</xsl:if>
			</xsl:for-each>
			<xsl:copy>
				<xsl:apply-templates mode="#current" select="@*, node()"/>
			</xsl:copy>
		</xsl:element>
		<xsl:message terminate="no">The '<xsl:value-of select="@xml:id"/>' was wrapped in a <xsl:value-of select="$newID"/></xsl:message>
	</xsl:template>

	<xd:doc>
		<xd:desc>Wraps all elements with specified local-name</xd:desc>
	</xd:doc>
	<xsl:template match="mei:*[(local-name() = $elName) and not(parent::node()/local-name() = $wrapperName)]" name="wrappAllElements">

		<xsl:variable as="xs:string" name="newID" select="concat($wrapperName, '_', substring-after(@xml:id, '_'))"/>

		<xsl:element name="{$wrapperName}" namespace="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="xml:id" select="$newID"/>
			<xsl:for-each select="$attributeNames">
				<xsl:variable name="attributePosition" select="position()"/>
				<xsl:variable name="secondRow" select="tokenize($changes.input[2], ';')"/>
				<xsl:variable as="xs:string*" name="attributeValue" select="$secondRow[number($attributePosition + 3)]"/>
				<xsl:if test="$attributeValue != ''">
					<xsl:attribute name="{.}" select="$attributeValue"/>
				</xsl:if>
				<!--			<xsl:message terminate="no">attributeNames '<xsl:value-of select="$attributeNames"/>'</xsl:message>
				<xsl:message terminate="no">secondRow '<xsl:value-of select="$secondRow"/>'</xsl:message>
				<xsl:message terminate="no">position() '<xsl:value-of select="position()"/>'</xsl:message>
				<xsl:message terminate="no">attributeValue '<xsl:value-of select="$attributeValue"/>'</xsl:message>-->
			</xsl:for-each>
			<xsl:copy>
				<xsl:apply-templates select="@*, node()"/>
			</xsl:copy>
		</xsl:element>
		<xsl:message terminate="no">The '<xsl:value-of select="@xml:id"/>' was wrapped in a <xsl:value-of select="$newID"/></xsl:message>

	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="elementID"/>
	</xd:doc>
	<xsl:function as="xs:string*" name="dme:correspRow">
		<xsl:param as="xs:string" name="elementID"/>

		<xsl:variable as="xs:integer?" name="position">
			<xsl:for-each select="$changes.input">
				<xsl:variable name="forEach-currentID" select="tokenize(., ';')[2]"/>
				<xsl:if test="$forEach-currentID = $elementID">
					<xsl:value-of select="position()"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable as="xs:string*" name="return" select="tokenize($changes.input[$position], ';')"/>
		<xsl:copy-of select="$return"/>
	</xsl:function>

</xsl:stylesheet>
