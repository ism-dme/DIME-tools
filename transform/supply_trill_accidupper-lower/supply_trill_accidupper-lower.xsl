<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs mei xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xi:include href="docs.xsl" xpointer="element(/1/1)"/>
  <include href="../lib/basic.xsl"/>
  <include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
  <include href="../lib/functions/functions_DIME.xsl"/>
  <include href="../lib/applicationChanges.xsl"/>



  <template match="/">
<!--    <variable name="process.choice">
      <apply-templates select="." mode="process.choice"/>
    </variable>

    <sequence>
      <apply-templates mode="applicationChanges" select="$process.choice"/>
    </sequence>-->
    <apply-templates select="." mode="process.choice"/>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Matches choice with trill that have supplied @accidupper or @accidlower</xd:p>
    </xd:desc>
  </xd:doc>
  <template as="element()" mode="process.choice" match="choice[corr[supplied[trill]] and orig[trill]]">
    <choose>
      <when test="corr/supplied/trill[@accidupper] and orig/trill[not(@accidupper)]">
        <call-template name="create.trill">
          <with-param name="trill" select="corr/supplied/trill[@accidupper]"/>
          <with-param name="supplied.attribute.name" select="corr/supplied/trill/@accidupper/name()"/>
        </call-template>
      </when>
      <when test="corr/supplied/trill[@accidlower] and orig/trill[not(@accidlower)]">
        <call-template name="create.trill">
          <with-param name="trill" select="corr/supplied/trill[@accidlower]"/>
          <with-param name="supplied.attribute.name" select="corr/supplied/trill/@accidlower/name()"/>
        </call-template>
      </when>
      <otherwise>
        <call-template name="copy.element"/>
      </otherwise>
    </choose>
  </template>



  <xd:doc>
    <xd:desc>Copies the trill from corr with all its attributes. Adds @type.</xd:desc>
    <xd:param name="trill"/>
    <xd:param name="supplied.attribute.name"/>
  </xd:doc>
  <template name="create.trill">
    <param name="trill" as="element()"/>
    <param name="supplied.attribute.name" as="xs:string"/>


    <variable name="type.value">
      <variable name="resp.value" select="$trill/parent::supplied/@resp => substring-after('#')"/>
      <value-of select="$supplied.attribute.name || '_' || 'supplied_' || $resp.value"/>
    </variable>

    <copy-of select="
        dme:add-mei-attributes(
        $trill, xs:QName('type'), $type.value)"/>
  </template>


  <variable name="currentStylesheet" select="doc('')"/>
</stylesheet>
