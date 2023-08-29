<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xd:doc>
    <xd:desc>
      <xd:p>Updates @startid and @endid.</xd:p>
      <xd:p>If there are multiple new references, clones the element.</xd:p>
    </xd:desc>
    <xd:param name="refs"/>
  </xd:doc>
  <template name="two.pointers.case">
    <param name="refs" tunnel="yes"/>

    <variable name="count.vals.startid" select="
        let $t := tokenize(map:get($refs, 'startid'), ',')
        return
          count($t)"/>
    <variable name="count.vals.endid" select="
        let $t := tokenize(map:get($refs, 'endid'), ',')
        return
          count($t)"/>

    <choose>
      <!--if more than one new reference for at least one pointer exists-->
      <when test="
          let $countVals := sum(($count.vals.startid, $count.vals.endid))
          return
            $countVals > 2">

        <variable name="el" select="."/>
        <variable as="xs:string*" name="pointer.pairs">
          <call-template name="t.pointer.pairs"/>
        </variable>

        <for-each select="1 to ($count.vals.startid * $count.vals.endid)">
          <call-template name="clone.node.two.pointers">
            <with-param name="el" select="$el"/>
            <with-param name="counter" select="."/>
            <with-param name="pointer.pairs" select="$pointer.pairs" tunnel="yes"/>
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
      <xd:p>Zipps each new reference of the @startid with the correspoindig new reference of the @endid.</xd:p>
      <xd:p>Returns sequence of strings. Example: ("note_123,note_456,", "note_123,note_789")</xd:p>
    </xd:desc>
    <xd:param name="refs"/>
  </xd:doc>
  <template name="t.pointer.pairs">
    <param as="map(xs:string, xs:string)*" name="refs" tunnel="yes"/>
    <for-each select="
        let $a := map:get($refs, 'startid')
        return
          tokenize($a, ',')">
      <variable name="currStartid" select="."/>
      <for-each select="
          let $a := map:get($refs, 'endid')
          return
            tokenize($a, ',')">
        <sequence select="string-join(($currStartid, .), ',')"/>
      </for-each>
    </for-each>
  </template>


  <!--TODO: merge with template@name=clone.node.startid-->
  <xd:doc>
    <xd:desc>
      <xd:p>$el is being cloned (case when app, choice, etc. are present). @xml:id is updated with suffix derived from $counter. The values for @startid are updated. If the $el has child nodes they will be processed in the same way recursively.</xd:p>
    </xd:desc>
    <xd:param name="el"/>
    <xd:param name="counter"/>
    <xd:param name="pointer.pairs"/>
  </xd:doc>
  <template name="clone.node.two.pointers">
    <param name="el"/>
    <param name="counter"/>
    <param name="pointer.pairs" tunnel="yes"/>

    <for-each select="$el">
      <copy>
        <!--copy all atributes except @startid, @endid, update the @xml:id-->
        <call-template name="copy.controlevent.attrs.update.id">
          <with-param name="counter" select="$counter"/>
        </call-template>
        <!--update pointers-->
        <variable name="entry" select="$pointer.pairs[$counter]"/>
        <variable name="vals" select="tokenize($entry, ',')"/>
        <if test="@startid">
          <attribute name="startid" select="'#' || $vals[1]"/>
        </if>
        <if test="@endid">
          <attribute name="endid" select="'#' || $vals[2]"/>
        </if>

        <if test="node()">
          <call-template name="clone.node.two.pointers">
            <with-param name="el" select="node()"/>
            <with-param name="counter" select="$counter"/>
          </call-template>
        </if>
      </copy>
    </for-each>
  </template>

</stylesheet>
