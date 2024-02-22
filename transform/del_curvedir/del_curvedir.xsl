<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <include href="../lib/basic.xsl"/>
  <xi:include href="docs/docs.xsl" xpointer="element(/1/1)"/>
  <import href="docs/changeLog.xsl"/>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="slur/@curvedir">

    <variable as="xs:boolean*" name="restrictedPointers">
      <for-each select="../@startid, ../@endid">
        <variable name="pointer" select="substring(., 2) => id()"/>

        <choose>
          <when test="$pointer/ancestor::chord or $pointer[@grace] or $pointer/local-name() = 'chord'">
            <sequence select="true()"/>
          </when>
          <otherwise>
            <sequence select="false()"/>
          </otherwise>
        </choose>
      </for-each>
    </variable>

    <choose>
      <!--Preserve @curvedir if the slur points to a chord or to a grace note-->
      <when test="
          some $a in $restrictedPointers
            satisfies $a = true()">
        <copy/>
      </when>
      <otherwise/>
    </choose>
  </template>


</stylesheet>
