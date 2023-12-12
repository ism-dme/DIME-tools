<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <variable name="measures2match" select="
      for $a in $doxmlEls
      return
        $a/@measureID"/>

  <template match="measure[@xml:id/string() = $measures2match]" mode="els_start-end_ids">
    <copy>
      <apply-templates select="@*, node()"/>
      <variable name="el2insert" select="$doxmlEls[@measureID = current()/@xml:id]"/>


      <for-each select="$el2insert">
        <choose>
          <when test="@supply">
            <xsl:element name="supplied" namespace="http://www.music-encoding.org/ns/mei">
              <attribute name="resp" select="'#NMA-editors'"/>
              <attribute name="xml:id" select="'supplied_' || generate-id()"/>
              <sequence select="functx:remove-attributes(., ('measureID', 'supply'))"/>
            </xsl:element>
          </when>
          <otherwise>
            <sequence select="functx:remove-attributes(., 'measureID')"/>
          </otherwise>
        </choose>
      </for-each>
    </copy>

  </template>

  <template match="mei:supplied[descendant::slur or descendant::tie]" mode="del_orig_els"/>
  <template match="tie | slur" mode="del_orig_els"/>



</stylesheet>
