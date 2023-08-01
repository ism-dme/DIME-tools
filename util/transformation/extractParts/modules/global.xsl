<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xd:doc>
    <xd:desc>
      <xd:p>Returns options passed to the GUI as map.</xd:p>
    </xd:desc>
  </xd:doc>
  <template name="options">
    <variable name="optionsGUI" select="doc($options.path)//id('extract_parts')/dme:parameters"/>
    <sequence select="
        let $entries := for $p in $optionsGUI/dme:parameter/data()
        return
          string($p)
        return
          '|' || string-join($entries, '|') || '|'"/>

  </template>


  <variable as="xs:boolean" name="all.parts.selected">
    <variable name="parts.tokenized" select="
        for $n in
        tokenize($parts, '\|')
        return
          if ($n != '') then
            $n
          else
            ()"/>

    <variable as="xs:string*" name="staffdef.n" select="//staffDef/@n => distinct-values()"/>
   
    <sequence select="functx:sequence-deep-equal($parts.tokenized, $staffdef.n)"/>
  </variable>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template mode="extract" match="sb[not(contains($parts, concat('|', @n, '|')))]">
    <if test="$all.parts.selected">
      <copy>
        <apply-templates select="@*"/>
      </copy>
    </if>
  </template>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template mode="extract" match="pb[not(contains($parts, concat('|', @n, '|')))]">
    <if test="$all.parts.selected">
      <copy>
        <apply-templates select="@*"/>
      </copy>
    </if>
  </template>


  <xd:doc>
    <xd:desc>Replaces the tempo/@staff value to the minimal of the current displayed.</xd:desc>
  </xd:doc>
  <template match="body//tempo">
    <copy>
      <attribute name="staff" select="min(dme:requested-staves('all'))"/>
      <apply-templates select="@* except @staff, node()"/>
    </copy>
  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Enables the fermata to be displayed.</xd:p>
      <xd:p>There exist different encoding cases: <xd:ul>
          <xd:li><xd:b>1</xd:b>: There exist two fermatas, attached two the first and the last staves but they apply for all staves. If a voice inbetween is extracted, the @staff should be adjusted. It relies on that if @place is present and on its value. If there is only one voice, only one fermata is copied and adjusted, otherwise, there are two fermatas.</xd:li>
          <xd:li><xd:b>2</xd:b>: There exist fermatas for each voice explicitly. They should be just copied then.</xd:li>
        </xd:ul>
      </xd:p>
    </xd:desc>
  </xd:doc>
  <template mode="extract" match="body//fermata" priority="1">
    <variable name="allStaves" select="dme:requested-staves('all')"/>

    <copy>
      <choose>
        <when test="@place[. = 'above']">
          <attribute name="staff" select="min($allStaves)"/>
          <apply-templates select="@* except @staff, node()"/>
        </when>
        <when test="@place[. = 'below'] and count($allStaves) > 1">
          <attribute name="staff" select="max($allStaves)"/>
          <apply-templates select="@* except @staff, node()"/>
        </when>
        <otherwise>
          <apply-templates select="@*, node()"/>
        </otherwise>
      </choose>
    </copy>

  </template>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template mode="extract" match="staff[@n = dme:requested-staves('layer')]//@ploc | staff[@n = dme:requested-staves('layer')]//@oloc | staff[@n = dme:requested-staves('layer')]//@stem.dir | staff[@n = dme:requested-staves('layer')]//@stem.sameas"/>

  <xd:doc>
    <xd:desc/>
    <xd:param name="id"/>
  </xd:doc>
  <template name="getListItems">
    <param as="xs:string" name="id"/>
    <copy-of select="doc($lib.path || 'lists/lists.xml')/id($id)/dme:item/data()"/>
  </template>




  <xd:doc>
    <xd:desc>
      <xd:p>Used only in the context of the layer extraction</xd:p>
      <xd:p>Expected syntax for $parts is |{staffNumber}.{layerNumber}|. Multiple entries are possible.</xd:p>
    </xd:desc>
    <xd:param name="mode">Values: <xd:ul>
        <xd:li>staff: returns staff number(s) where the whole staff is required, e.g. |5|</xd:li>
        <xd:li>layer: returns staff number(s) where a layer is required, e. g. {|5.1| => '5'}</xd:li>
        <xd:li>all: both cases</xd:li>
      </xd:ul></xd:param>
  </xd:doc>
  <function as="xs:string*" name="dme:requested-staves">
    <param name="mode"/>

    <!--example value: "1", "2.2"-->
    <variable name="voicesInput" select="
        for $n in
        tokenize($parts, '\|')
        return
          if ($n != '') then
            $n
          else
            ()"/>

    <for-each select="$voicesInput">
      <choose>
        <when test="$mode = 'staff'">
          <!-- only those which do not have dot: e.g. |5| not |5.1|-->
          <if test="not(contains(., '.'))">
            <sequence select="."/>
          </if>
        </when>
        <when test="$mode = 'layer'">
          <!-- only those which do have dot: e.g. |5.1| and not |5| -->
          <if test="contains(., '.')">
            <sequence select="substring-before(., '.')"/>
          </if>
        </when>
        <when test="$mode = 'all'">
          <sequence select="functx:substring-before-if-contains(., '.')"/>
        </when>
      </choose>
    </for-each>

  </function>


  <xd:doc>
    <xd:desc>
      <xd:p>Maps the @n-attribute of staves and their respective layer which are required in the input. </xd:p>
      <xd:p>Let's consider the input |2.1|3|. The map will contain a key '2' (staff/@n) and the value '1' (layer/@n), the value '3' is omitted as no layer is required to be extracted. </xd:p>
    </xd:desc>
  </xd:doc>
  <function name="dme:requested-staves-layers">
    <variable as="map(xs:string, xs:string)?" name="staff-layer_map">
      <map>
        <choose>
          <when test="contains($parts, '.')">
            <for-each select="
                for $n in
                tokenize($parts, '\|')
                return
                  if ($n != '') then
                    $n
                  else
                    ()">
              <if test="contains(., '.')">
                <map-entry key="substring-before(., '.')" select="substring-after(., '.')"/>
              </if>
            </for-each>
          </when>
          <otherwise/>
        </choose>
      </map>
    </variable>
    <copy-of select="$staff-layer_map"/>
  </function>



</stylesheet>
