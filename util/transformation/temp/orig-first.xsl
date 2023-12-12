<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <include href="../lib/basic.xsl"/>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="choice" name="initial-template">
    <copy>
      <apply-templates select="@*"/>
      <copy-of select="orig"/>
      <iterate select="*[not(local-name() = 'orig')]">
        <copy-of select="."/>
      </iterate>
    </copy>
  </template>



</stylesheet>
