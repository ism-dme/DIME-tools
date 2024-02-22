<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:uuid="java:java.util.UUID"
  xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl" exclude-result-prefixes="xs xd mei math uuid dme" version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on: </xd:b>Oct 3, 2018</xd:p>
      <xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
      <xd:p>
        <xd:p>
          <xd:b>Description:</xd:b>
          <xd:i>Inserts a sb or pb in the staff.</xd:i>
        </xd:p>
        <xd:p>
          <xd:b>Usage</xd:b>:<xd:ul>
            <xd:li>Open addElement-list.csv with Excel. Note: the file is located in the same repository as addElement.xsl, currently "..\util\xslt_oxygen\reference_texts\addElement"</xd:li>
            <xd:li>Column 1: Insert name(s) of the element(s) to be inserted.</xd:li>
            <xd:li>Column 2: an @xml:id of the mdiv</xd:li>
            <xd:li>Column 3: @n of the measure to insert after</xd:li>
            <xd:li>Column 4: @n of the staff</xd:li>
            <xd:li>Column 5+: Up from this column you may insert any number of attributes with respective values. Note: if the respective cell remains empty, no attribute will be inserted</xd:li>
            <xd:li>Save the .csv file and apply the transformation scenario on your xml-file</xd:li>
            <xd:li>Don't commit the changes in the .csv, execute the TortioseSVN-'revert'-command instead</xd:li>
          </xd:ul>
        </xd:p>
        <xd:p><xd:b>Remarks</xd:b>:<xd:ul>
            <xd:li>Every new element gets an @xml:id and @n of the parent staff per default. If the processed file is of the type 'dmeedt', the @xml:id will get the edition-type-suffix, e.g. '-B1'.</xd:li>
            <xd:li>If you don't use the predefined oxygen transformation scenario from 'utils documentation page': the parameter 'current.file.name' have to be set to '${cfn}'</xd:li>
          </xd:ul>
        </xd:p>
      </xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:param name="current.file.name"/>

  <xsl:variable name="csvInput" select="unparsed-text-lines('addSbPb-list.CSV', 'UTF-8')" as="xs:string*"/>
  <!--creates a list of all attributes which may be inserted, later only if there is a corresponding value, the attribute will beinserted-->
  <xsl:variable name="attributeNames" select="tokenize($csvInput[1], ';')[position() > 4]" as="xs:string*"/>
  <!--$root is needed for the dme:staffID_RoPosition() as a context node-->
  <xsl:variable name="root" select="/" as="document-node()"/>
  <!--contains a list of strings, e.g.  "staff_id:2" which is a concatenation of a staff/@xml:id and a position of the respective row in the list-->
  <xsl:variable name="staffID_RowPosition" select="dme:staffID_RowPosition()" as="xs:string*"/>
  <xsl:variable name="staffID" select="
      for $n in $staffID_RowPosition
      return
        substring-before($n, ':')" as="xs:string*"/>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <xsl:template match="/">
    <xsl:apply-templates/>
 <!--   <xsl:message>
      <xsl:value-of select="$staffID"/>
    </xsl:message>-->
  </xsl:template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <xsl:template match="mei:staff[@xml:id = $staffID]">
    <!--$xmlID is needed for the function contains() which requries a string-->
    <xsl:variable name="xmlID" select="@xml:id" as="xs:string"/>
    <!--<xsl:message>template matched</xsl:message>-->
    <xsl:copy>
      <xsl:apply-templates select="@*, node()"/>
      <!--contains the value from the list $staffID_RowPosition which corresponds to the current xml:id-->
      <xsl:variable name="correspRowPosition" select="xs:integer(substring-after($staffID_RowPosition[contains(., $xmlID)], ':'))" as="xs:integer"/>
      <!--contains the whole coresponding row from the input list-->
      <xsl:variable name="correspRow" select="$csvInput[$correspRowPosition]" as="xs:string"/>
      <xsl:variable name="elementName" select="tokenize($correspRow, ';')[1]" as="xs:string"/>
      <xsl:element name="{$elementName}" namespace="http://www.music-encoding.org/ns/mei">
        <xsl:attribute name="xml:id" select="dme:createID($elementName, .)"/>
        <xsl:attribute name="n" select="@n"/>
        <!--check if there are any additional attributes in the imput list-->
        <xsl:for-each select="$attributeNames">
          <xsl:variable name="attributePosition" select="position()"/>
          <!--check if there is a corresponding value for this attribute-->
          <xsl:variable name="attributeValue" select="$correspRow[number($attributePosition + 4)]" as="xs:string*"/>
          <xsl:if test="$attributeValue != ''">
            <xsl:attribute name="{.}" select="$attributeValue"/>
          </xsl:if>
        </xsl:for-each>
        <!--<xsl:message>correspRow: <xsl:value-of select="$correspRowPosition"/></xsl:message>-->
        <xsl:message terminate="no">A '<xsl:value-of select="dme:createID($elementName, .)"/>' was inserted inside '<xsl:value-of select="@xml:id"/>'.</xsl:message>
      </xsl:element>
    </xsl:copy>
  </xsl:template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <xsl:function name="dme:staffID_RowPosition" as="xs:string*">

    <xsl:variable name="return" as="xs:string*">
      <xsl:for-each select="$csvInput">
        <xsl:variable name="mdivID" select="tokenize(., ';')[2]" as="xs:string?"/>
        <xsl:variable name="measureN" select="tokenize(., ';')[3]" as="xs:string?"/>
        <xsl:variable name="_staffN_" select="tokenize(., ';')[4]" as="xs:string?"/>
        <xsl:variable name="position" select="position()" as="xs:integer"/>
       <!-- <xsl:variable name="staffID" select="
            $root//mei:staff[ancestor::mei:mdiv[@xml:id = $mdivID] and ancestor::mei:measure[@n =
            $measureN] and (@n = $_staffN_)]/@xml:id" as="xs:string?"/>-->
  <!--  for the case 458-004 only   --> <xsl:variable name="staffID" select="
            $root//mei:staff[ancestor::mei:mdiv[@xml:id = $mdivID] and ancestor::mei:measure[@n =
            (xs:integer($measureN) -1)] and (@n = $_staffN_)]/@xml:id" as="xs:string?"/>
        <!--<xsl:message>Variables: <xsl:value-of select="concat($mdivID, ', ', $measureN, ', ', $_staffN_, ', ', $position, ', ', $staffID)"/></xsl:message>-->
        <xsl:if test="$staffID">
          <xsl:value-of select="concat($staffID, ':', $position)"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
 <!--   <xsl:if test="$return != ''">
      <xsl:message>staffID: <xsl:value-of select="$return"/></xsl:message>
    </xsl:if>-->
    <xsl:copy-of select="$return"/>
  </xsl:function>



  <xd:doc>
    <xd:desc/>
    <xd:param name="elementName"/>
    <xd:param name="node"/>
  </xd:doc>
  <xsl:function name="dme:createID" as="xs:string">
    <xsl:param name="elementName" as="xs:string"/>
    <xsl:param name="node" as="node()"/>

    <xsl:variable name="baseID" select="concat($elementName, '_', number(substring(generate-id($node), 4)) * 3)" as="xs:string?"/>
    <xsl:variable name="newID" as="xs:string?">
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
  </xsl:function>

  <xsl:output indent="yes" encoding="UTF-8" method="xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:mode on-no-match="shallow-copy"/>
</xsl:stylesheet>
