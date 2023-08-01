<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <template name="getTies">
   
    <for-each select="$doxml//dme:line[@tied]">
      
      <variable as="xs:string" name="endid">
        <choose>
          <when test="$piano">
            <message>Converting as piano.</message>
            <sequence select="(following::dme:line[@type = 'note'][ancestor::dme:staff/@n eq current()/ancestor::dme:staff/@n][@pianoVoice = current()/@pianoVoice])[1]/@xml:id"/>
          </when>
          <otherwise>
            <sequence select="(following::dme:line[@type = 'note'][ancestor::dme:staff/@n eq current()/ancestor::dme:staff/@n])[1]/@xml:id"/>
          </otherwise>
        </choose>
      </variable>
      
      <sequence>
        <xsl:element name="tie" namespace="http://www.music-encoding.org/ns/mei">
          <attribute name="startid" select="@xml:id"/>
          <attribute name="endid" select="$endid"/>
          <if test="@tie.shape[. = 'dotted']">
            <attribute name="supply" select="'yes'"/>
          </if>

          <variable as="xs:string?" name="curvedirTie">
            <call-template name="curvedirTie"/>
          </variable>

          <if test="not($curvedirTie = '')">
            <attribute name="curvedir" select="$curvedirTie"/>
          </if>

        </xsl:element>
      </sequence>
    </for-each>
  </template>



  <template name="curvedirTie">

    <variable as="xs:string+" name="lineAttrTokNorm" select="dme:tokenize-normalize-attr-vals(@line, '\s')"/>


    <variable as="xs:integer+" name="performTest">
      <iterate select="$lineAttrTokNorm">

        <choose>
          <when test="matches(., '^tu$')">
            <sequence select="1"/>
            <break/>
          </when>
          <when test="matches(., '^td$')">
            <sequence select="2"/>
            <break/>
          </when>
          <otherwise>
            <sequence select="0"/>
          </otherwise>
        </choose>
      </iterate>
    </variable>

    <choose>
      <when test="sum($performTest) = 1">
        <value-of select="'above'"/>
      </when>
      <when test="sum($performTest) = 2">
        <value-of select="'below'"/>
      </when>
      <otherwise>
        <value-of select="''"/>
      </otherwise>
    </choose>

  </template>


</stylesheet>
