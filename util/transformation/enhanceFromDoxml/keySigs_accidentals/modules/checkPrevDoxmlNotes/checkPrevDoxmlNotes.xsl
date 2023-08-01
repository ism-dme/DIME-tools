<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <include href="accid_true.xsl"/>

  <template name="checkPrevDoxmlNotes">
    <param name="accidentalsMap" tunnel="yes"/>
    <param name="doxmlNote" tunnel="yes"/>
    <param name="mode" tunnel="yes"/>

    <variable as="element()*" name="doxmlPrecedingLines">
      <call-template name="T.doxmlPrecedingLines"/>
    </variable>

    <choose>
      <!--First note in the measure-->
      <when test="empty($doxmlPrecedingLines)">
        <choose>
          <when test="$mode = 'keySigAccid'">
            <attribute name="accid.ges" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
          </when>
          <when test="$mode = 'keySigNoAccid'">
            <attribute name="accid" select="'n'"/>
          </when>
          <when test="$mode = 'doxmlNoteHasAccid'">
            <attribute name="accid" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
          </when>
          <when test="$mode = 'doxmlNoteHasNOAccid'"/>
        </choose>
      </when>
      <otherwise>

        <variable as="xs:string" name="accid_true">
          <call-template name="accid_true">
            <with-param name="doxmlPrecedingLines" select="$doxmlPrecedingLines" tunnel="yes"/>
          </call-template>
        </variable>

        <choose>
          <when test="contains($accid_true, 'true')">
            <choose>
              <when test="$mode = 'keySigAccid'">
                <attribute name="accid" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
              </when>
              <when test="$mode = 'keySigNoAccid'">
                <attribute name="accid" select="'n'"/>
              </when>
              <when test="$mode = 'doxmlNoteHasAccid'">
                <attribute name="accid" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
              </when>
              <when test="$mode = 'doxmlNoteHasNOAccid'">
                <attribute name="accid" select="'n'"/>
              </when>
            </choose>
          </when>
          <when test="contains($accid_true, 'false')">
            <choose>
              <when test="$mode = 'keySigAccid'">
                <attribute name="accid.ges" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
              </when>
              <when test="$mode = 'keySigNoAccid'">
<!--Current note belongs to the current score signatures. In the same measure exist a previous note with same pitch which does not have @accid. -->
                <attribute name="accid.ges" select="'n'"/>
              </when>
              <when test="$mode = 'doxmlNoteHasAccid'">
                <attribute name="accid.ges" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
              </when>
              <when test="$mode = 'doxmlNoteHasNOAccid'">    
<!--If the previous note would have @accid=n or @accid.ges=n the current note would have @accid.ges-=n as well-->
<!--                deprecated: we do need @accid.ges=n on accidentals-->
                  <!--<if test="contains($accid_true, 'accidgesn')">
                    <attribute name="accid.ges" select="'n'"/>
                  </if>-->                                 
              </when>
            </choose>
          </when>
          <otherwise>
            <message>Situation in <xsl:value-of select="@xml:id"/> is undefined.</message>
          </otherwise>
        </choose>
      </otherwise>
    </choose>
  </template>


  <template name="T.doxmlPrecedingLines">
    <param name="doxmlNote" tunnel="yes"/>
    <!--<message>
      <xsl:value-of select="$doxmlNote/@xml:id"/>
    </message>-->
    <choose>
      <when test="$genre = 'piano'">
        <variable as="xs:string" name="hand">
          <choose>
            <when test="matches($doxmlNote/@pianoVoice, '^[1-5]$')">
              <value-of select="'right'"/>
            </when>
            <when test="matches($doxmlNote/@pianoVoice, '^[6-9]|10$')">
              <value-of select="'left'"/>
            </when>
          </choose>
        </variable>

        <variable name="handsMap" select="map{
            'right':'^[1-5]$', 
            'left':'^[6-9]|10$'}"/>

        <iterate select="reverse($doxmlNote/preceding-sibling::dme:line)">
          <choose>
            <when test="@type = 'barline'">
              <break/>
            </when>
            <when test="matches(@pianoVoice, map:get($handsMap, $hand))">
              <choose>
                <when test="$doxmlNote[@grace]">
                  <sequence select="."/>
                </when>
                <otherwise>
                  <!--exclude grace notes if curent note is not a grace note-->
                  <if test="not(@grace)">
                    <sequence select="."/>
                  </if>
                </otherwise>
              </choose>

            </when>
          </choose>
        </iterate>
      </when>
      <otherwise>
        <iterate select="reverse($doxmlNote/preceding-sibling::dme:line)">
          <choose>
            <when test="@type = 'barline'">
              <break/>
            </when>
            <otherwise>
              <sequence select="."/>
            </otherwise>
          </choose>
        </iterate>
      </otherwise>
    </choose>
  </template>


</stylesheet>
