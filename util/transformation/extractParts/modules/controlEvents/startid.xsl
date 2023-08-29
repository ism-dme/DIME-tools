<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xd:doc>
    <xd:desc>
      <xd:p>If there are more than on new reference, the template cloneNode_startid is called. Otherwise, the current @startid is updated</xd:p>
    </xd:desc>
    <xd:param name="refs"/>
    <xd:param name="pointers"/>
  </xd:doc>
  <template name="startid">
    <param name="refs" tunnel="yes"/>
    <param name="pointers" tunnel="yes"/>

    <variable name="vals" select="
        let $entry := map:get($refs, $pointers)
        return
          tokenize($entry, ',')"/>
    <variable name="count.vals" select="count($vals)"/>

    <choose>
      <when test="$count.vals > 1 (:if more than one new reference for at least one pointer exists:)">
        <variable name="el" select="."/>
        <for-each select="1 to $count.vals">
          <call-template name="clone.node.startid">
            <with-param name="el" select="$el"/>
            <with-param name="counter" select="." tunnel="yes"/>
            <with-param name="count.vals.startid" select="$count.vals" tunnel="yes"/>
            <with-param name="vals" select="$vals"/>
          </call-template>
        </for-each>
      </when>
      <!--if only one value for each pointer exists-->
      <otherwise>
        <call-template name="replace.reference"/>
      </otherwise>
    </choose>

  </template>



  <xd:doc>
    <xd:desc>
      <xd:p>$el is being cloned (case when app, choice, etc. are present). @xml:id is updated with suffix derived from $counter. The values for @startid are updated. If the $el has child nodes they will be processed in the same way recursively.</xd:p>
    </xd:desc>
    <xd:param name="el"/>
    <xd:param name="counter"/>
    <xd:param name="refs"/>
    <xd:param name="vals"/>
  </xd:doc>
  <template name="clone.node.startid">
    <param name="el"/>
    <param name="vals"/>
    <param name="counter" tunnel="yes"/>
    <param name="refs" tunnel="yes"/>

    <for-each select="$el">
      <copy>

        <call-template name="copy.controlevent.attrs.update.id">
          <with-param name="counter" select="$counter"/>
        </call-template>

        <choose>
          <when test="empty($vals) (:no referenced @xml:id is found:)">
            <attribute name="tstamp" select="
                let $referenced.node := substring-after(@startid, '#')
                return
                  ancestor::music/id($referenced.node)/@tstamp"/>
          </when>
          <otherwise>
            <if test="@startid">
              <attribute name="startid" select="'#' || $vals[$counter]"/>
            </if>
          </otherwise>
        </choose>

        <if test="node()">
          <call-template name="clone.node.startid">
            <with-param name="el" select="node()"/>
          </call-template>
        </if>
      </copy>
    </for-each>
  </template>


</stylesheet>
