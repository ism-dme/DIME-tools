<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <include href="firtsCheck.xsl"/>
  <include href="getCurrentKeySigs.xsl"/>
  <include href="keySigs.xsl"/>
  <include href="accidentals.xsl"/>
  <include href="checkPrevDoxmlNotes/checkPrevDoxmlNotes.xsl"/>

  <!--Use the accid constraint for works which were already in the proofreading-->
  <!--  <template match="body//note[@doxml.id and not(descendant::accid)]" mode="keySigs_accidentals">-->
  <template match="body//note[@doxml.id]" mode="keySigs_accidentals">
    <!--<message>
      <xsl:value-of select="@xml:id"/>
    </message>-->

    <copy>
      <call-template name="firstCheck"/>
      <apply-templates select="@* except (@accid, @accid.ges), node()"/>
    </copy>
  </template>



</stylesheet>
