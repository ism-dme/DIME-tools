<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xi:include href="docs.xsl" xpointer="element(/1/1)"/>
  <include href="options.xsl"/>
  <include href="../lib/basic.xsl"/>
  <include href="modules/extractMainVersion.xsl"/>
  <include href="modules/checkContextNote.xsl"/>
  <include href="modules/changeAccid.xsl"/>
  <include href="modules/doxml.xsl"/>
  <import href="changeLog.xsl"/>

<!--  <param as="xs:string?" name="type"/>-->
  <param as="xs:string" name="fileName"/>



  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="/">

    <variable name="changeAccid">
      <apply-templates mode="changeAccid" select="."/>
    </variable>


    <!--<call-template name="comparisonFileDOXconvX">
      <with-param name="changeAccid" select="$changeAccid"/>
    </call-template>-->

    <copy-of select="$changeAccid"/>
  </template>

  <!--<xd:doc>
    <xd:desc>Used as part of the DOXconvX.xsl only.</xd:desc>
    <xd:param name="changeAccid"/>
  </xd:doc>
  <template name="comparisonFileDOXconvX">
    <param name="changeAccid"/>

    <if test="$type = 'DOXconvX'">
      <variable name="folder" select="substring($fileName, 8, 7) || '_track-changes\'"/>
      <result-document href="{$folder || '8_' || 'checkAccidentalsVisibility.xml'}" indent="yes" method="xml">
        <copy-of select="$changeAccid"/>
      </result-document>
    </if>
  </template>-->

</stylesheet>
