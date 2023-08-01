<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <template name="accidentals">
    <param name="doxmlNote" tunnel="yes"/>
    <param name="accidentalsMap" tunnel="yes"/>

    <choose>
      <when test="$doxmlNote/@accid">
        <choose>
          <when test="$doxmlNote/@accid.explicit">
            <attribute name="accid" select="map:get($accidentalsMap, $doxmlNote/@accid)"/>
          </when>
          <otherwise>
            <call-template name="checkPrevDoxmlNotes">
              <with-param name="mode" select="'doxmlNoteHasAccid'" tunnel="yes"/>
            </call-template>
          </otherwise>
        </choose>
      </when>
      <!--Assuming that there is no @accid as this checks the previous test.-->
      <when test="$doxmlNote/@accid.explicit[. = 'true']">
        <attribute name="accid" select="'n'"/>
      </when>
      <otherwise>
        <call-template name="checkPrevDoxmlNotes">
          <with-param name="mode" select="'doxmlNoteHasNOAccid'" tunnel="yes"/>
        </call-template>
      </otherwise>
    </choose>
  </template>

</stylesheet>
