<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xi:include href="docs.xsl" xpointer="element(/1/1)"/>
  <include href="../lib/basic.xsl"/>


  <variable name="global-context-item" select="."/>

  <xd:doc>
    <xd:desc>
      <xd:p>Mode.1 deletes redundant dirs and sets correct values for tuplet's attributes.</xd:p>
      <xd:p>After the previous step is completed, empty supplied ellements might be left over. Those are deleted with mode.2</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="/">
    <variable name="var.1">
      <apply-templates mode="mode.1" select="."/>
    </variable>

    <variable name="var.2">
      <apply-templates mode="mode.2" select="$var.1"/>
    </variable>
    <copy-of select="$var.2"/>
  </template>


  <!--dir/@xml:ids which point to tuplet//descendant::*
  - NB: in most cases this would be a note, but also could be a chord (cf. K. 169/02).
  -->
  <variable name="dir.num.startid" select="$global-context-item//dir[matches(./text()/normalize-space(), '^[0-9][0-9]?$')]/substring(@startid, 2)"/>



  <xd:doc>
    <xd:desc>Sets @num.visible and @bracket.visible to TRUE or FALSE</xd:desc>
  </xd:doc>
  <template match="tuplet" mode="mode.1">
    <copy>
      <variable name="pointed.element.startid" select="descendant::*[@xml:id = $dir.num.startid]"/>
     <!-- <message>
        <xsl:value-of select="@xml:id"/>
      </message>-->
      <!--Some tuplets are pointed by dir@tstamp, which is usually the case for released files.-->
      <variable as="element()?" name="pointed.element.tstamp">
        <variable name="tuplet.staff" select="ancestor::staff/@n"/>
        <variable name="dir.matches.staff" select="ancestor::measure//dir[@staff = $tuplet.staff]"/>
        <variable name="dir.num.tstamp" select="$dir.matches.staff[matches(./text()/normalize-space(), '^[0-9][0-9]?$')]/round(@tstamp/data(), 5)"/>
        <sequence select="descendant::*[round(@tstamp, 5) = $dir.num.tstamp]"/>
      </variable>

      <choose>
        <when test="$pointed.element.startid">
          <attribute name="num.visible">
            <value-of select="'true'"/>
          </attribute>
          <call-template name="supply.num">
            <with-param name="pointed.element" select="$pointed.element.startid"/>
          </call-template>
        </when>
        <when test="$pointed.element.tstamp">
          <attribute name="num.visible">
            <value-of select="'true'"/>
          </attribute>
          <call-template name="supply.num">
            <with-param name="pointed.element" select="$pointed.element.tstamp"/>
          </call-template>
        </when>
        <otherwise>
          <copy-of select="@num.visible"/>
        </otherwise>
      </choose>
      <apply-templates mode="#current" select="@* except @num.visible, node()"/>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>@bracket.visible should be set to 'true' if 1) tuplet contains (a) rest(s) AND 2) @num.visible is set to 'true'.</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="tuplet" mode="mode.2">
    <copy>
      <choose>
        <when test="descendant::rest and (@num.visible = 'true')">
          <attribute name="bracket.visible">
            <value-of select="'true'"/>
          </attribute>
        </when>
        <otherwise>
          <attribute name="bracket.visible">
            <value-of select="'false'"/>
          </attribute>
        </otherwise>
      </choose>
      <apply-templates mode="#current" select="@* except @bracket.visible, node()"/>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Adds @type if the corresponding dir is supplied.</xd:p>
      <xd:p> Syntax: {element}@type={attributName}_supplied_{@resp}</xd:p>
    </xd:desc>
    <xd:param name="pointed.element">Descendant of tuplet which the dir points to.</xd:param>
  </xd:doc>
  <template name="supply.num">
    <param name="pointed.element"/>


    <variable as="element(supplied)?" name="corresponding.dir.supplied">
      <variable name="pointed.element.staff" select="ancestor::staff/@n"/>
      <variable name="dirs.same.staff" select="ancestor::measure//dir[@staff = $pointed.element.staff]"/>

      <variable name="dir.num.startid" select="$dirs.same.staff[substring(@startid, 2) = $pointed.element/@xml:id]"/>
      <variable name="dir.num.tstamp" select="$dirs.same.staff[round(@tstamp, 5) = $pointed.element/round(@tstamp, 5)]"/>

      <choose>
        <when test="$dir.num.startid/parent::supplied">
          <copy-of select="$dir.num.startid/parent::supplied"/>
        </when>
        <when test="$dir.num.tstamp/parent::supplied">
          <copy-of select="$dir.num.tstamp/parent::supplied"/>
        </when>
      </choose>
    </variable>

    <if test="$corresponding.dir.supplied">
      <variable name="resp" select="$corresponding.dir.supplied/@resp => substring-after('#')"/>

      <attribute name="type">
        <value-of select="'num_' || 'supplied_' || $resp"/>
      </attribute>
    </if>
  </template>


  <!--@xml:ids of tuplet descendants-->
  <variable name="tuplet.descendants.id" select="$global-context-item//tuplet//*/@xml:id"/>

  <xd:doc>
    <xd:desc>Deletes a &lt;dir&gt; which points to an @xml:id of a 'tuplet/note'</xd:desc>
  </xd:doc>
  <template match="dir" mode="mode.1">
    <variable name="start.id.local" select="substring(@startid, 2)"/>

    <variable name="tstamp.matches">
      <variable name="dir.tstamp" select="round(@tstamp/data(), 5)"/>
      <variable name="dir.staff" select="@staff"/>
      <variable name="matching.staff" select="ancestor::measure//staff[@n = $dir.staff]"/>

      <sequence select="$matching.staff//note[@tstamp = $dir.tstamp], $matching.staff//chord[@tstamp = $dir.tstamp]"/>
    </variable>

    <choose>
      <when test="matches(./text()/normalize-space(), '^[0-9][0-9]?$')">
        <choose>
          <when test="($start.id.local = $tuplet.descendants.id)"/>
          <when test="$tstamp.matches">
            <if test="count($tstamp.matches) > 1">
              <message>
                <xsl:value-of select="@xml:id"/> matches more then one element. Check the measure <value-of select="ancestor::measure/@xml:id"/> manually!
</message>
            </if>
          </when>
          <otherwise>
            <call-template name="copy.element"/>
          </otherwise>
        </choose>
      </when>
      <otherwise>
        <call-template name="copy.element"/>
      </otherwise>
    </choose>
  </template>



  <xd:doc>
    <xd:desc>Deletes left-over empty supplied elements.</xd:desc>
  </xd:doc>
  <template match="supplied[not(*)][not(normalize-space())]" mode="mode.2"/>
</stylesheet>
