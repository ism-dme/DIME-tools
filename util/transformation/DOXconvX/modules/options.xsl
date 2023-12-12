<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <template name="options">
    <variable name="optionsGUI" select="doc('../../options/options.xml')//id('DOXconvX')/dme:parameters"/>

    <map>
      <map-entry key="'meiHead'" select="$optionsGUI/id('meiHead')/string(text())"/>
      <map-entry key="'genre'" select="$optionsGUI/id('genre')/string(text())"/>
      <map-entry key="'movementPages'" select="$optionsGUI/id('pages')/string(text())"/>
    </map>
  </template>
  <!--	search map:get(.*'file')-->

  <template name="optionsCalc">
    <param name="file.name" select="$fileName"/>
    
    <variable name="kv.movement.dashed" select="
        substring-before(substring-after($file.name, '_'),
        '_')"/>
    <variable name="kv" select="
        substring-before($kv.movement.dashed, '-')"/>
    <variable name="movement" select="
        substring-after($kv.movement.dashed, '-')"/>
    <variable name="movement.integer" select="functx:chars($movement)[last()] cast as xs:string"/>
    <variable name="movement.n" select="'0' || $movement.integer"/>

    <map>
      <map-entry key="'movementID'" select="functx:substring-after-last($file.name, '_')"/>
      <map-entry key="'kvMovement'" select="translate($kv.movement.dashed, '-', '')"/>
      <map-entry key="'KV'" select="$kv"/>
      <map-entry key="'movementInteger'" select="$movement.integer"/>
      <map-entry key="'movementN'" select="$movement.n"/>
    </map>
  </template>
  <!--
<template name="piano_staves">
  <for-each select="$processedFile/></for-each>

</template>-->

</stylesheet>
