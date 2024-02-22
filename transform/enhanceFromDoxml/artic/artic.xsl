<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xi:include href="docs/docs.xsl" xpointer="element(/1/1)"/>
  <import href="docs/changeLog.xsl"/>

  <include href="../../lib/basic.xsl"/>
  <include href="../../lib/functions/functx-1.0-doc-2007-01.xsl"/>
  <!--  <include href="../../lib/functions/functions_DIME.xsl"/>-->
  <include href="../get_doxml/options.xsl"/>
  <include href="../get_doxml/doxml_root.xsl"/>
  <include href="modules/modifyMEI.xsl"/>
  
  <param name="genre" select="'string quartet'"/>

  <!--  <variable name="processedMEI" select="/"/>-->


  <variable name="modifiedMEI">
    <apply-templates mode="artic" select="/"/>
  </variable>



  <template match="/">
    <copy-of select="$modifiedMEI"/>
  </template>


</stylesheet>
