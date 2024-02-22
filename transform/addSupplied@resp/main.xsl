<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <import href="../lib/basic.xsl"/>
  <!--  <xi:include href="docs/docs.xsl" xpointer="element(/1/1)"/>
  <import href="docs/changeLog.xsl"/>-->

  <xd:doc>
    <xd:desc>Adds @resp to &lt;supplied&gt; where missing.</xd:desc>
  </xd:doc>

  <param name="respValue" select="'#NMA-editors'"/>

  <template match="supplied[not(@resp)]">
    <copy>
      <attribute name="resp">
        <value-of select="$respValue"/>
      </attribute>
      <apply-templates mode="#current" select="@*, node()"/>
    </copy>
  </template>






</stylesheet>
