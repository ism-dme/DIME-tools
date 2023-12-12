<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xi:include href="docs.xsl" xpointer="element(/1/1)"/>

  <include href="../../lib/basic.xsl"/>
  <include href="../../lib/functions/functx-1.0-doc-2007-01.xsl"/>
  <include href="../../lib/functions/functions_DIME.xsl"/>
  <include href="../get_doxml/options.xsl"/>
  <include href="../get_doxml/doxml_root.xsl"/>
  <include href="modules/MEI/modifyMEI.xsl"/>
  <include href="modules/els_start-end_ids/els_start-end_ids.xsl"/>


  <!--TODO: For piano concerto the test should be more specific.-->
  <variable as="xs:boolean" name="piano">
    <choose>
      <when test="$doxml//@pianoVoice">
        <message>Converting as piano.</message>
        <sequence select="true()"/>
      </when>
      <otherwise>
        <sequence select="false()"/>
      </otherwise>
    </choose>
  </variable>

  <variable name="modifiedMEI">
    <apply-templates mode="del_orig_els" select="/"/>
  </variable>

  <variable name="els_start-end_ids">
    <apply-templates mode="els_start-end_ids" select="$modifiedMEI"/>
    <message>Inserted <value-of select="count($doxmlEls)"/> element(s): <xsl:value-of select="string-join($doxmlEls/@xml:id, ' ')"/>.</message>
  </variable>


  <template match="/">
    <copy-of select="$els_start-end_ids"/>
  </template>


</stylesheet>
