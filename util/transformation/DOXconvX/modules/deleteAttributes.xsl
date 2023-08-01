<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <template match="@ho | @vo | staff/@codedval | staff/@position" mode="codedval_position_ho_vo"/>
  <template match="@tuplet" mode="tuplet"/>


  <xd:doc>
    <xd:desc>Deletes attributes</xd:desc>
  </xd:doc>
  <template match="@func[. = 'caution'] | @evidence[. = 'analogy'] | lem/@resp | dynam/@plist | space/@layer[contains(., '1 2')] | note/@layer[contains(., '1 2')] | @mm | @enclose | @subtype | @right[. = 'rptboth'] | @type[. = ('enclose', 'upbeat', 'Verlagsnummer', 'bartext', 'ce')]" mode="deleteAttributes"/>

  <xd:doc>
    <xd:desc>
      <xd:p>For piano, and chamber music we do need the placement attribute for notes in lower layers except for grace notes.</xd:p>
      <xd:p>Note that dox2mei for piano music outputs layer@n=7 which corresponds to the first layer. Therefore, these layers are excluded.</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="layer[(@n > 1 and not(@n = 7))]//note[not(@grace)]/@stem.dir" mode="deleteAttributes">
    <choose>
      <when test="ancestor::staff[matches(@codedval, 'ka')] or map:get($options, 'genre') = 'chamber'"/>
      <when test="map:get($options, 'genre') = 'orchestral'">
        <copy/>
      </when>
      <otherwise>
        <message>The genre of the piece is other then 'piano', 'piano concerto', 'chamber' or 'orchestral'. Therefore, @stem.dir at <value-of select="parent::note/@xml:id"/> will be preserved!</message>
      </otherwise>
    </choose>
  </template>

</stylesheet>
