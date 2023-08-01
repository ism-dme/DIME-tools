<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xd:doc/>
  <template match="@dme.parts" mode="dmeparts_layer">
    <choose>
      <when test="map:get($options, 'genre') = 'orchestral'">
        <copy/>
      </when>
      <when test="map:get($options, 'genre') = ('chamber', 'piano')"/>
      <otherwise>
        <message>The genre of the piece is other then 'piano', 'piano concerto', 'chamber' or 'orchestral'. Therefore, @dme.parts at <value-of select="parent::note/@xml:id"/> will be preserved!</message>
      </otherwise>
    </choose>
  </template>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="note/@layer | rest/@layer" mode="dmeparts_layer"/>

</stylesheet>
