<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <template name="firstCheck">


    <variable name="doxmlNote" select="$doxml//dme:line[@type = 'note' and @xml:id = current()/@doxml.id]"/>
    <variable as="map(xs:string, xs:string)" name="accidentalsMap" select="map{
      '#':'s', 
      '##':'x', 
      'b':'f',
      'bb':'ff'}"/>

    <variable as="xs:string*" name="scoreDefSig">
      <call-template name="currentSig">
        <with-param name="doxmlNote" select="$doxmlNote" tunnel="yes"/>
      </call-template>
    </variable>


    <variable as="element()?" name="secondTiedNote">
      <call-template name="secondTiedNote">
        <with-param name="doxmlNote" select="$doxmlNote"/>
      </call-template>
    </variable>

    <choose>
      <when test="$secondTiedNote">
        <choose>
          <when test="$doxmlNote/@accid">
            <choose>
              <when test="$doxmlNote/@accid.explicit">
                <attribute name="accid" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
              </when>
              <otherwise>
                <attribute name="accid.ges" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
              </otherwise>
            </choose>
          </when>
          <when test="$doxmlNote/@accid.explicit[. = 'true']">
            <attribute name="accid" select="'n'"/>
          </when>
          <otherwise>

            <variable as="xs:string" name="first_tied_note_accid_n">
              <call-template name="checkPrevDoxmlNotes_if_accid_n">
                <with-param name="doxmlNote" select="$secondTiedNote" tunnel="yes"/>
              </call-template>
            </variable>

            <choose>
              <when test="contains($first_tied_note_accid_n, 'true')">
                <attribute name="accid.ges" select="'n'"/>
              </when>
              <otherwise>
              </otherwise>
            </choose>
          </otherwise>
        </choose>
      </when>
      <!--Class "key signatures"-->
      <when test="
          (some $a in $scoreDefSig
            satisfies $a = @pname)">
        <call-template name="keySigs">
          <with-param name="doxmlNote" select="$doxmlNote" tunnel="yes"/>
          <with-param name="accidentalsMap" select="$accidentalsMap" tunnel="yes"/>
        </call-template>
      </when>
      <!--Class "accidentals"-->
      <otherwise>
        <call-template name="accidentals">
          <with-param name="doxmlNote" select="$doxmlNote" tunnel="yes"/>
          <with-param name="accidentalsMap" select="$accidentalsMap" tunnel="yes"/>
        </call-template>
      </otherwise>
    </choose>
  </template>


  <template name="secondTiedNote">
    <param name="doxmlNote"/>

    <variable name="doxmlNote_staff_n" select="$doxmlNote/ancestor::dme:staff/@n"/>

    <choose>
      <when test="$genre = 'piano'">
        <variable name="doxmlNote_pianoVoice" select="$doxmlNote/@pianoVoice"/>

        <sequence select="reverse($doxmlNote/preceding::dme:line[@type = 'note'][ancestor::dme:staff/@n eq $doxmlNote_staff_n][@pianoVoice = $doxmlNote_pianoVoice])[1][@tied]"/>
      </when>
      <otherwise>
        <sequence select="reverse($doxmlNote/preceding::dme:line[@type = 'note'][ancestor::dme:staff/@n eq $doxmlNote_staff_n])[1][@tied]"/>
      </otherwise>
    </choose>

  </template>
</stylesheet>
