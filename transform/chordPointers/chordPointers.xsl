<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <include href="../lib/basic.xsl"/>
  <xi:include href="docs/docs.xsl" xpointer="element(/1/1)"/>
  <import href="docs/changeLog.xsl"/>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="slur | dynam[@startid]" name="initial-template">
    <copy>
      <for-each select="@startid, @endid">
        <call-template name="replacePointer">
          <with-param name="pointer" select="."/>
        </call-template>
      </for-each>
      <apply-templates select="@* except (@endid, @startid), node()"/>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>Replaces the value of @startid or @endid</xd:desc>
    <xd:param name="pointer"/>
  </xd:doc>
  <template name="replacePointer">
    <param as="attribute()" name="pointer"/>

    <variable name="reference" select="id(substring-after($pointer, '#'))"/>

<!--    <variable as="xs:boolean" name="testChord">
      <call-template name="testChord">
        <with-param name="reference" select="id(substring-after($pointer, '#'))" tunnel="yes"/>
      </call-template>
    </variable>-->

    <attribute name="{local-name($pointer)}" select="
        if ($reference/ancestor::chord) then
          '#' || string($reference/ancestor::chord/@xml:id)
        else
          string($pointer)"/>
  </template>

  <xd:doc>
    <xd:desc>Checks if there exists a chord. If yes, checks if there are any ties which start/end from/at this chord. If yes, the note reference should be preserved.</xd:desc>
    <xd:param name="reference"/>
  </xd:doc>
  <!--<template name="testChord">
    <param name="reference" tunnel="yes"/>
    <choose>
      <when test="$reference/ancestor::chord">
        <choose>
          <when test="parent::node()/local-name() = 'slur'">
            <call-template name="tie"/>
          </when>
          <otherwise>
            <value-of select="true()"/>
          </otherwise>
        </choose>
      </when>
      <otherwise>
        <value-of select="false()"/>
      </otherwise>
    </choose>

  </template>-->

  <xd:doc>
    <xd:desc>Additional check for the tie.</xd:desc>
    <xd:param name="reference"/>
  </xd:doc>
  <!--<template name="tie">
    <param name="reference" tunnel="yes"/>

    <variable name="chord_descendants_or_self" select="
        for $ID in $reference/ancestor::chord//@xml:id
        return
          '#' || $ID"/>

    <variable name="ties" select="
        let $currName := local-name(.)
        return
          $reference/ancestor::mdiv//tie[@*[local-name() = $currName] = $chord_descendants_or_self]"/>

    <value-of select="
        if ($ties) then
          false()
        else
          true()"/>
  </template>-->


</stylesheet>
