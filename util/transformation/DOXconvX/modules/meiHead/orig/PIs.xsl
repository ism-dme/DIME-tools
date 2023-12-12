<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <template match="processing-instruction('appInfo')" mode="copyFromOrig">
    <copy-of select="$processedFile//meiHead//appInfo"/>
  </template>


  <template match="processing-instruction('changes')" mode="copyFromOrig">
    <apply-templates mode="revisionDesc" select="$processedFile//meiHead//revisionDesc/change"/>
  </template>

  <template match="processing-instruction('meter')" mode="insertFromMusic">
    <param name="origMusic" tunnel="yes"/>
    <variable name="scoreDef" select="($origMusic//scoreDef)[1]"/>
    <element name="meter" namespace="http://www.music-encoding.org/ns/mei">
      <attribute name="count" select="$scoreDef/@meter.count"/>
      <attribute name="unit" select="$scoreDef/@meter.unit"/>
    </element>
  </template>

  <template match="processing-instruction('key')" mode="insertFromDatabase">
    <param name="origMusic" tunnel="yes"/>
    <variable as="attribute()*" name="databaseAttrs" select="$databaseFileMovement//workDesc//key/@*[not(local-name() = 'sig')]"/>
    <element name="key" namespace="http://www.music-encoding.org/ns/mei">
      <for-each select="$databaseAttrs">
        <attribute name="{local-name()}" select="."/>
      </for-each>
    </element>
  </template>
</stylesheet>
