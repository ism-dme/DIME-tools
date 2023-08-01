<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  
  <template name="currentSig">
    
    <variable as="xs:string?" name="key.sig.raw.val">
      <call-template name="T.key.sig.raw.val"/>
    </variable>


    <variable as="xs:string*" name="sharps" select="('f', 'c', 'g', 'd', 'a', 'e', 'b')"/>
    <variable as="xs:string*" name="flats" select="('b', 'e', 'a', 'd', 'g', 'c', 'f')"/>

    <variable name="numberOfAccidentals" select="functx:substring-after-if-contains($key.sig.raw.val, '-') => number()"/>

    <choose>
      <when test="$key.sig.raw.val = '0'">
        <value-of select="''"/>
      </when>
      <when test="starts-with($key.sig.raw.val, '-')">
        <sequence select="subsequence($flats, 1, $numberOfAccidentals)"/>
      </when>
      <otherwise>
        <sequence select="subsequence($sharps, 1, $numberOfAccidentals)"/>
      </otherwise>
    </choose>
  </template>


  <template name="T.key.sig.raw.val">
    <param name="doxmlNote" tunnel="yes"/>


    <variable as="item()*" name="key.sig.line">
      <!--first check if there were change for key signatures before staff. In doxml it is defined by the line with text keysign-->
      <call-template name="T.key.sig.line"/>
    </variable>

    <variable name="key.sig.staff" select="$doxmlNote/parent::dme:staff/@key/string()"/>

    <choose>
      <when test="not($key.sig.line[last()] = 'false')">
        <value-of select="$key.sig.line"/>
      </when>
      <when test="$key.sig.staff">
        <value-of select="$key.sig.staff"/>
      </when>
      <otherwise>
        <message>@key of <value-of select="@xml:id"/> is not unclear in doxml!</message>
      </otherwise>
    </choose>
  </template>

  <template name="T.key.sig.line">
    <param name="doxmlNote" tunnel="yes"/>

    <!--first check if this is the first line in the staff-->
    <choose>
      <when test="$doxmlNote/preceding-sibling::dme:line">
        <!--check for every line in reverted order if it has keysign info-->
        <iterate select="reverse($doxmlNote/preceding-sibling::dme:line)">
          <choose>
            <when test="contains(text(), 'keysign')">
              <value-of select="tokenize(text(), '\s')[2]"/>
              <break/>
            </when>
            <otherwise>
              <value-of select="false()"/>
            </otherwise>
          </choose>
        </iterate>
      </when>
      <otherwise>
        <value-of select="false()"/>
      </otherwise>
    </choose>
  </template>

  <!--these templates are for getting the key.sigs from MEI-->

  <!--<template name="currentSig">

    <variable as="xs:string" name="key.sig.meival">
      <call-template name="key.sig.meival">
        <with-param name="currentStaff" select="ancestor::staff/@n"/>
      </call-template>
    </variable>


    <variable as="xs:string*" name="sharps" select="('f', 'c', 'g', 'd', 'a', 'e', 'b')"/>
    <variable as="xs:string*" name="flats" select="('b', 'e', 'a', 'd', 'g', 'c', 'f')"/>

    <variable name="numberOfAccidentals" select="substring($key.sig.meival, 1, 1) => number()"/>

    <choose>
      <when test="$key.sig.meival = '0'">
        <value-of select="''"/>
      </when>
      <when test="ends-with($key.sig.meival, 's')">
        <sequence select="subsequence($sharps, 1, $numberOfAccidentals)"/>
      </when>
      <when test="ends-with($key.sig.meival, 'f')">
        <sequence select="subsequence($flats, 1, $numberOfAccidentals)"/>
      </when>
    </choose>
  </template>


  <template name="key.sig.meival">
    <param name="currentStaff"/>

    <variable name="key.sig.staffDef" select="(preceding::scoreDef)[last()]//staffDef[@n = $currentStaff]/@key.sig"/>
    <variable name="key.sig.scoreDef" select="(preceding::scoreDef)[last()]/@key.sig"/>

    <choose>
      <when test="$key.sig.staffDef">
        <value-of select="$key.sig.staffDef"/>
      </when>
      <when test="$key.sig.scoreDef">
        <value-of select="$key.sig.scoreDef"/>
      </when>
      <otherwise>
        <message>@key.sig from previous scoreDef, relative to <value-of select="@xml:id"/> is not defined!</message>
      </otherwise>
    </choose>
  </template>-->
</stylesheet>
