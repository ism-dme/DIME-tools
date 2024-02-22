<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xi:include href="docs.xsl" xpointer="element(/1/1)"/>

  <param as="xs:string" name="fileName"/>
  <param as="xs:string" name="fileURL"/>

  <!--This parameter is a workaround for XSpec limitation: the tested stylesheet does not get a global context. See https://github.com/xspec/xspec/wiki/Global-Context-Item-->
  <param name="global-context-item" select="."/>

  <include href="modules/options.xsl"/>
  <include href="modules/meiHead/meiHead.xsl"/>
  <include href="modules/scoreDef.xsl"/>
  <include href="modules/DcX_1.xsl"/>
  <include href="modules/chords.xsl"/>
  <include href="modules/decls.xsl"/>
  <include href="modules/stacciss.xsl"/>
  <include href="modules/DcX_2.xsl"/>
  <include href="modules/deleteAttributes.xsl"/>
  <include href="modules/dmeparts_layer.xsl"/>
  <include href="modules/splitDynams.xsl"/>
  <include href="modules/DcX_3.xsl"/>
  <include href="../lib/applicationChanges.xsl"/>
  <include href="../lib/functions/functions_DIME.xsl"/>
  <include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
  <include href="../lib/basic.xsl"/>
  <import href="changeLog.xsl"/>

  <variable as="document-node()" name="lists" select="doc('../lib/lists/lists.xml')"/>

  <variable as="map(xs:string, item()*)" name="options">
    <call-template name="options"/>
  </variable>
  <variable as="map(xs:string, item()*)" name="optionsCalc">
    <call-template name="optionsCalc"/>
  </variable>
  <variable name="movementID" select="map:get($optionsCalc, 'movementID')"/>
  <variable as="xs:string" name="KV" select="map:get($optionsCalc, 'KV')"/>

  <variable as="document-node()" name="processedFile" select="$global-context-item"/>

  <variable name="meiHead">
    <choose>
      <when test="map:get($options, 'meiHead') = '1'">
        <apply-templates mode="meiHead" select="$processedFile"/>
      </when>
      <when test="map:get($options, 'meiHead') = '0'">
        <apply-templates mode="perfRes" select="$processedFile"/>
      </when>
    </choose>
  </variable>

  <variable name="scoreDef">
    <apply-templates mode="scoreDef" select="$meiHead"/>
  </variable>

  <variable name="DcX_1">
    <apply-templates mode="DcX_1" select="$scoreDef"/>
  </variable>

  <variable name="decls">

    <!--If there are any piano parts in the piece-->
    <choose>
      <when test="$processedFile//staff/@codedval[. = 'ka']">
        <apply-templates mode="decls" select="$DcX_1"/>
      </when>
      <otherwise>
        <copy-of select="$DcX_1"/>
      </otherwise>
    </choose>
  </variable>

  <variable name="chords">
    <apply-templates mode="chords" select="$decls"/>
  </variable>

  <variable name="stacciss">
    <apply-templates mode="stacciss" select="$chords"/>
  </variable>

  <variable name="DcX_2">
    <apply-templates mode="DcX_2" select="$stacciss"/>
  </variable>

  <variable name="splitDynams">
    <apply-templates mode="splitDynams" select="$DcX_2"/>
  </variable>

  <variable name="deleteAttributes">
    <apply-templates mode="deleteAttributes" select="$splitDynams"/>
  </variable>

  <variable name="codedval_position_ho_vo">
    <apply-templates mode="codedval_position_ho_vo" select="$deleteAttributes"/>
  </variable>

  <variable name="dmeparts_layer">
    <apply-templates mode="dmeparts_layer" select="$codedval_position_ho_vo"/>
  </variable>

  <variable name="tuplet">
    <apply-templates mode="tuplet" select="$dmeparts_layer"/>
  </variable>

  <variable name="DcX_3">
    <apply-templates mode="DcX_3" select="$tuplet"/>
  </variable>

  <variable name="applicationChanges">
    <apply-templates mode="applicationChanges" select="$DcX_3"/>
  </variable>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="/" name="main">
    <!--When applying XSpec use this code instead-->
    <!--    <copy-of select="$tuplet"/>-->
    <call-template name="trackChanges"/>
    <copy-of select="$applicationChanges"/>
  </template>




  <xd:doc>
    <xd:desc>Creates intermediate files for comparison.</xd:desc>
  </xd:doc>
  <template name="trackChanges">
    <variable name="vars" select="$meiHead, $scoreDef, $DcX_1, $decls, $chords, $stacciss, $DcX_2, $splitDynams, $deleteAttributes, $codedval_position_ho_vo, $dmeparts_layer, $tuplet, $DcX_3, $applicationChanges"/>


    <variable name="folder" select="substring($fileName, 8, 7) || '_track-changes\'"/>

    <result-document href="{$folder || '0.xml'}" indent="yes" method="xml">
      <copy-of select="."/>
    </result-document>

    <variable name="modi" select="'meiHead', 'scoreDef', 'various_1', 'decls', 'chords', 'stacciss', 'various_2', 'splitDynams', 'deleteAttributes', 'codedval_position_ho_vo', 'dmeparts_layer', 'tuplet', 'DcX_3', 'applicationChanges'"/>
    <for-each select="$modi">
      <variable name="pos" select="position()"/>
      <result-document href="{$folder || $pos || '_' || . || '.xml'}" indent="yes" method="xml">
        <sequence select="$vars[$pos]"/>
      </result-document>
    </for-each>
  </template>

  <variable name="currentStylesheet" select="doc('')"/>
</stylesheet>
