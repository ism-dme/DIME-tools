<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <template name="getSlurs">

    <for-each select="$doxml//dme:line[@slur.start]">
      <variable as="element()" name="currLine" select="."/>
      <variable as="xs:string+" name="slur.start.vals" select="dme:tok-vals-with-space(@slur.start)"/>


      <sequence>
        <for-each select="$slur.start.vals">
          <xsl:element name="slur" namespace="http://www.music-encoding.org/ns/mei">
            <attribute name="startid" select="$currLine/@xml:id"/>

            <variable as="xs:string?" name="track">
              <variable name="secondChar" select="substring(., 2, 1)"/>
              <choose>
                <when test="matches($secondChar, '\d')">
                  <value-of select="$secondChar"/>
                </when>
                <otherwise>
                  <value-of select="''"/>
                </otherwise>
              </choose>
            </variable>

            <attribute name="endid">
              <call-template name="slurEndID">
                <with-param name="currLine" select="$currLine" tunnel="yes"/>
                <with-param name="track" select="$track" tunnel="yes"/>
              </call-template>
            </attribute>

            <if test="contains(., 'dotted')">
              <attribute name="supply" select="'yes'"/>
            </if>

            <variable as="xs:string?" name="curvedir">
              <call-template name="curvedir">
                <with-param as="element()" name="currLine" select="$currLine"/>
                <with-param name="track" select="$track" tunnel="yes"/>
              </call-template>
            </variable>

            <if test="not($curvedir = '')">
              <attribute name="curvedir" select="$curvedir"/>
            </if>

          </xsl:element>
        </for-each>
      </sequence>

    </for-each>
  </template>


  <template name="slurEndID">
    <param name="currLine" tunnel="yes"/>

    <variable as="xs:string?" name="findEndid">
      <call-template name="findEndid"/>
    </variable>

    <if test="$findEndid = ''">
      <message>The @endid value for <xsl:value-of select="$currLine/@xml:id"/> was not found! </message>
    </if>
    <sequence select="$findEndid"/>

  </template>



  <template name="findEndid">
    <param name="currLine" tunnel="yes"/>
    <param name="track" tunnel="yes"/>

    <variable name="currVal" select="."/>



    <variable as="element()*" name="following.lines">
      <choose>
        <when test="$piano">
          <sequence select="($currLine/following::dme:line[@type = 'note'][@slur.end][ancestor::dme:staff/@n eq $currLine/ancestor::dme:staff/@n][@pianoVoice = $currLine/@pianoVoice])"/>
        </when>
        <otherwise>
          <sequence select="$currLine/following::dme:line[@type = 'note'][@slur.end][ancestor::dme:staff/@n eq $currLine/ancestor::dme:staff/@n]"/>
        </otherwise>
      </choose>
    </variable>



    <iterate select="$following.lines">

      <variable as="xs:string*" name="currValsFollowingline" select="dme:tok-vals-with-space(@slur.end)"/>

      <choose>
        <when test="not(matches($track, '[\d]'))">
          <variable as="xs:integer+" name="containsTerminateVal">
            <for-each select="$currValsFollowingline">
              <choose>
                <when test="matches(., '^z$|^rs$|^rs_dotted$')">
                  <sequence select="1"/>
                </when>
                <otherwise>
                  <sequence select="0"/>
                </otherwise>
              </choose>
            </for-each>
          </variable>
          <if test="sum($containsTerminateVal) &gt; 0">
            <sequence select="@xml:id"/>
            <break/>
          </if>
        </when>
        <when test="matches($track, '[\d]')">

          <variable as="xs:string+" name="currFollowingLineTrack" select="
              for $a in $currValsFollowingline
              return
                substring($a, 2, 1)"/>

          <variable as="xs:integer+" name="containsTerminateVal">
            <choose>
              <when test="
                  (some $a in $currFollowingLineTrack
                    satisfies $a eq $track) or (some $a in $currValsFollowingline
                    satisfies $a eq 'rs')">
                <sequence select="1"/>
              </when>
              <otherwise>
                <sequence select="0"/>
              </otherwise>
            </choose>

          </variable>

          <if test="sum($containsTerminateVal) &gt; 0">
            <sequence select="@xml:id"/>
            <break/>
          </if>
        </when>
        <otherwise/>
      </choose>
    </iterate>
  </template>


  <template name="curvedir">
    <param as="element()" name="currLine"/>
    <param name="track" tunnel="yes"/>

    <variable as="xs:string?" name="base" select="substring(., 1, 1)"/>
    <variable name="lineAttr" select="$currLine/@line"/>
    <variable name="sub" select="substring-after($lineAttr, $base || $track || ':')"/>
    <variable name="tokenize" select="dme:tokenize-normalize-attr-vals($sub, ',')"/>
    <variable as="xs:string*" name="verticalPositionVals">
      <sequence select="$tokenize[2], $tokenize[4]"/>
    </variable>

    <sequence>
      <choose>
        <when test="
            every $a in $verticalPositionVals
              satisfies matches($a, '^[0-9]+$')">
          <value-of select="'above'"/>
        </when>
        <when test="
            every $a in $verticalPositionVals
              satisfies matches($a, '^-[0-9]+$')">
          <value-of select="'below'"/>
        </when>
        <otherwise>
          <value-of select="''"/>
        </otherwise>
      </choose>
    </sequence>

  </template>


</stylesheet>
