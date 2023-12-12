<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  

  <template name="keySigs">
    <param name="doxmlNote" tunnel="yes"/>
    <param name="accidentalsMap" tunnel="yes"/>

    <choose>
      <!--sometimes dox has @accid.explicit for naturals, sometimes not...-->
      <when test="$doxmlNote/@accid.explicit">
        <attribute name="accid" select="
            if ($doxmlNote/@accid) then
              map:get($accidentalsMap, $doxmlNote/@accid)
            else
              'n'"/>
      </when>
      <when test="not($doxmlNote/@accid)">
        <call-template name="checkPrevDoxmlNotes">
          <with-param name="mode" select="'keySigNoAccid'" tunnel="yes"/>
        </call-template>
      </when>
      <when test="$doxmlNote/@accid">
        <call-template name="checkPrevDoxmlNotes">
          <with-param name="mode" select="'keySigAccid'" tunnel="yes"/>
        </call-template>
      </when>
    </choose>
  </template>



</stylesheet>
