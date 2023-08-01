<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <include href="orig/PIs.xsl"/>
  <include href="processPlaceholders.xsl"/>


  <variable name="databaseFileMovement" select="dme:databaseFile('movement')"/>
  <variable name="Werk-Header.baseURI" select="'file:///K:/PROJEKTE/DIME/6_Edition/Referenztexte'"/>


  <!--  test:-->
  <!--    <variable name="Werk-Header.baseURI" select="'../../meiHead_test/'"/>-->

  <xd:doc>
    <xd:desc>Replaces the processed meiHead with the Werk-Header and replaces the placeholders there from different sources (processed meiHead, database, &lt;music&gt;</xd:desc>
  </xd:doc>
  <template match="meiHead" mode="meiHead">

    <!--Inserts elements and attributes from the input <meiHead> into the  Werk-header (as variable)-->
    <variable name="copy.input.meiHead">
      <apply-templates mode="copyFromOrig" select="dme:werk-header()"/>
    </variable>

    <variable name="processPlaceholders">
      <apply-templates mode="processPlaceholders" select="$copy.input.meiHead"/>
    </variable>

    <variable name="insertFromDatabase">
      <apply-templates mode="insertFromDatabase" select="$processPlaceholders"/>
    </variable>

    <variable name="insertFromMusic">
      <apply-templates mode="insertFromMusic" select="$insertFromDatabase">
        <with-param name="origMusic" select="//music" tunnel="yes"/>
      </apply-templates>
    </variable>

    <copy-of select="$insertFromMusic"/>
  </template>


  <xd:doc>
    <xd:desc>Returns the document node of the file from the database meiHead export.</xd:desc>
    <xd:param name="type">Defines either it should be 'work' or other ('movement').</xd:param>
  </xd:doc>
  <function as="document-node()" name="dme:databaseFile">
    <param as="xs:string" name="type"/>

    <choose>
      <when test="$type = 'work'">
        <variable name="path" select="$Werk-Header.baseURI || '/KV%20' || map:get($optionsCalc, 'KV') || '/meiHead_database/meiheader_' || dme:workID() || '.xml'"/>
        <copy-of select="doc($path)"/>
      </when>
      <otherwise>
        <variable name="path" select="$Werk-Header.baseURI || '/KV%20' || map:get($optionsCalc, 'KV') || '/meiHead_database/meiheader_' || $movementID || '.xml'"/>
        <copy-of select="doc($path)"/>
      </otherwise>
    </choose>
  </function>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <function name="dme:werk-header">

    <variable name="headPath" select="concat($Werk-Header.baseURI, '/KV%20', map:get($optionsCalc, 'KV'), '/Werk-header_', map:get($optionsCalc, 'KV'), '.xml')"/>
    <variable name="inputHead" select="doc($headPath)//meiHead"/>
    <copy-of select="$inputHead"/>
  </function>
</stylesheet>
