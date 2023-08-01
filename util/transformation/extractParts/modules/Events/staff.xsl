<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <include href="layer.xsl"/>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template mode="extract" match="staff">
    <choose>
      <when test="
        some $staff in $req.staves.extract.layers
        satisfies $staff = @n">
        <copy>
          <apply-templates select="@*"/>
          <!--Special case for K. 550-->
          <if test="app">
            <call-template name="versionsCase">
              <with-param name="staffN" select="@n"/>
            </call-template>
          </if>
          <apply-templates mode="layer" select="layer[@n = map:get(dme:requested-staves-layers(), current()/@n)]"/>
        </copy>
      </when>
      <when test="
        some $staff in $req.staves.complete
        satisfies $staff = @n">
        <copy-of select="."/>
      </when>
    </choose>
  </template>


  <xd:doc>
    <xd:desc/>
    <xd:param name="staffN"/>
  </xd:doc>
  <xsl:template name="versionsCase">
    <xsl:param name="staffN"/>

    <xsl:variable name="IDsecondPart" select="substring-after(@xml:id, '_')"/>
    <app xmlns="http://www.music-encoding.org/ns/mei">
      <!--<xsl:attribute name="xml:id" select="'app_' || $IDsecondPart"/>-->
      <xsl:apply-templates select="app/@*"/>
      <xsl:variable name="currApp" select="app"/>

      <!--Just if app would have more variants-->
      <xsl:for-each select="1 to count($currApp/child::*)">
        <xsl:variable name="counter" select=". cast as xs:integer"/>
        <xsl:variable name="child" select="($currApp/child::*)[$counter]"/>
        <xsl:element name="{$child/name()}">
          <xsl:apply-templates select="$child/@*"/>
          <xsl:apply-templates mode="layer" select="$child/layer[@n = map:get(dme:requested-staves-layers(), $staffN)]"/>
        </xsl:element>
      </xsl:for-each>
    </app>

  </xsl:template>


</stylesheet>
