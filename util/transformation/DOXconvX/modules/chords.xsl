<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="chord[descendant::note[@staff] or descendant::note[@dur] or descendant::note[@dots]]" mode="chords">
    <variable name="current.element" select="."/>
    <variable as="xs:string+" name="attributes" select="'staff', 'dur', 'dots'"/>

    <variable as="attribute()*" name="attributes.present">
      <for-each select="$attributes">
        <if test="$current.element/descendant::note/@*[local-name() = current()]">
          <sequence select="$current.element/@*[local-name() = current()]"/>
        </if>
      </for-each>
    </variable>

    <copy>
      <if test="descendant::note[@staff]">
        <attribute name="staff">
          <value-of select="(descendant::note/@staff)[1]"/>
        </attribute>
      </if>
      <if test="descendant::note[@dur]">
        <attribute name="dur">
          <value-of select="min(descendant::note/@dur)"/>
        </attribute>
      </if>

      <if test="descendant::note[@dots]">
        <attribute name="dots">
          <value-of select="max(descendant::note/@dots)"/>
        </attribute>
      </if>
      <apply-templates select="@* except $attributes.present, node()"/>
    </copy>
  </template>


</stylesheet>
