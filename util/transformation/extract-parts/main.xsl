<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xi:include href="docs.xsl" xpointer="element(/1/1)"/>
  <import href="changeLog.xsl"/>

  <include href="../lib/basic.xsl"/>
  <include href="modules/global.xsl"/>
  <include href="modules/scoreDef.xsl"/>
  <include href="modules/events.xsl"/>
  <include href="modules/controlEvents.xsl"/>
  <include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
  <include href="../lib/functions/functions_DIME.xsl"/>

  <param as="xs:string?" name="P_REQUESTED_PARTS">
    <call-template name="options.gui"/>
  </param>

  <param name="P_GLOBAL_CONTEXT_ITEM" select="."/>
  <param name="P_XSPEC_TEST" select="false()"/>
  <param name="P_MOVI" select="false()"/>
  <param name="P_SHRINK_MEASURES" select="true()"/>


  <variable name="XML_FILE_NAME" select="tokenize(base-uri(), '/')[last()]"/>
  <variable name="LIB_PATH" select="resolve-uri('../lib/')"/>
  <variable name="OPTIONS_PATH" select="resolve-uri('../options/options.xml')"/>
  <variable as="xs:string*" name="REQ_STAVES_ANY" select="dme:requested-staves('any')"/>
  <variable as="xs:string*" name="REQ_STAVES_COMPLETE" select="dme:requested-staves('staff')"/>
  <variable as="xs:string*" name="REQ_STAVES_EXTRACT_LAYERS" select="dme:requested-staves('layer')"/>



  <xd:doc>
    <xd:desc>Main template.</xd:desc>
  </xd:doc>
  <template match="/" name="main">
    <choose>
      <when test="$allPartsRequested">
        <message>No extraction performed as all parts are selected</message>
      </when>
      <when test="(count($partsList) >= 1) and $partExists?partExists">
        <call-template name="perform.extraction"/>
      </when>
      <otherwise>
        <if test="$P_XSPEC_TEST or $P_MOVI">
          <copy-of select="."/>
        </if>
        <call-template name="create.message.parts.nonavailable">
          <with-param name="partExists" select="$partExists"/>
        </call-template>
      </otherwise>
    </choose>
  </template>

</stylesheet>
