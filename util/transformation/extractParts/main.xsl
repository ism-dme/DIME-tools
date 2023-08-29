<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xi:include href="docs.xsl" xpointer="element(/1/1)"/>
  <import href="changeLog.xsl"/>

  <include href="../lib/basic.xsl"/>
  <include href="modules/global.xsl"/>
  <include href="modules/scoreDef.xsl"/>
  <include href="modules/Events/staff.xsl"/>
  <include href="modules/controlEvents/controlEvents.xsl"/>
  <include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>

  <param name="parts" as="xs:string?">
    <call-template name="options.gui"/>
  </param>

  <param name="global.context.item" select="."/>
  <param name="xspec.test" select="false()"/>


  <variable name="xml.file.name" select="tokenize(base-uri(), '/')[last()]"/>
  <variable name="lib.path" select="resolve-uri('../lib/')"/>
  <variable name="options.path" select="resolve-uri('../options/options.xml')"/>
  <variable name="req.staves.complete" select="dme:requested-staves('staff')"/>
  <variable name="req.staves.extract.layers" select="dme:requested-staves('layer')"/>



  <xd:doc>
    <xd:desc>Main template.</xd:desc>
  </xd:doc>
  <template match="/" name="main">
    <choose>
      <when test="$all.parts.requested">
        <message>All parts selected, therefore no extraction performed.</message>
      </when>
      <when test="string-length($parts) > 0">
        <message>Extracting following parts: <value-of select="string-join($parts.tokenized, ', ')"/>
        </message>

        <variable name="extracted.events">
          <apply-templates select="$global.context.item" mode="extract.events"/>
        </variable>

        <variable name="output">
          <apply-templates mode="extract.controlEvents" select="$extracted.events"/>
        </variable>

        <result-document href="{substring-before($xml.file.name, '.') || '_' || string-join($parts.tokenized, '-') || '.mei'}" indent="yes" method="xml">
          <copy-of select="$output"/>
        </result-document>
        <!--Needed for XSpec-->
        <if test="$xspec.test">
          <copy-of select="$output"/>
        </if>
      </when>
      <otherwise>
        <message>No parts requested, therefore no extraction performed.</message>
      </otherwise>
    </choose>
  </template>

</stylesheet>
