<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <include href="../../lib/basic.xsl"/>
  <!--  <include href="../../lib/functions/functx-1.0-doc-2007-01.xsl"/>-->
  <!--  <include href="../../lib/functions/functions_DIME.xsl"/>-->

  <variable name="all_second_tied_notes" select="
      let $tie_endids := //tie/@endid
      return
        for $endid in $tie_endids
        return
          substring($endid, 2)"/>



  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="note[not((@accid, @accid.ges))]">

    <variable as="xs:boolean" name="second_tied_note">
      <call-template name="second_tied_note"/>
    </variable>

    <variable as="xs:boolean?" name="prev_note_has_accidn">
      <call-template name="prev_note_has_accidn"/>
    </variable>

    <copy>
      <choose>
        <when test="$second_tied_note">
          <variable as="xs:boolean" name="first_tied_note_has_accidn">
            <call-template name="first_tied_note_has_accidn"/>
          </variable>
          <if test="$first_tied_note_has_accidn">
            <attribute name="accid.ges" select="'n'"/>
          </if>
        </when>
        <when test="$prev_note_has_accidn">
          <attribute name="accid.ges" select="'n'"/>
        </when>
        <otherwise/>
      </choose>
      <apply-templates select="@*, node()"/>
    </copy>

  </template>

  <xd:doc>
    <xd:desc>Checks if the current note is a second tied note</xd:desc>
  </xd:doc>
  <template name="second_tied_note">
    <choose>
      <when test="
          some $id in $all_second_tied_notes
            satisfies $id = @xml:id">
        <sequence select="true()"/>
      </when>
      <otherwise>
        <sequence select="false()"/>
      </otherwise>
    </choose>
  </template>

  <xd:doc>
    <xd:desc>Checks if the first tied note has (@accid or @accid.ges)=n</xd:desc>
  </xd:doc>
  <template name="first_tied_note_has_accidn">
    <variable name="first_tied_note" select="//tie[substring(@endid, 2) = current()/@xml:id]/substring(@startid, 2) => id()"/>
    <choose>
      <when test="$first_tied_note[(@accid[. = 'n']) or (@accid.ges[. = 'n'])]">
        <sequence select="true()"/>
      </when>
      <otherwise>
        <sequence select="false()"/>
      </otherwise>
    </choose>
  </template>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="prev_note_has_accidn">
    <variable name="prev_notes_same_layer" select="preceding::note[ancestor::layer/@xml:id = current()/ancestor::layer/@xml:id]"/>

    <variable as="map(xs:string, xs:string?)" name="oct_pname_current_note">
      <call-template name="store_params">
        <with-param name="el" select="."/>
      </call-template>
    </variable>


    <iterate select="reverse($prev_notes_same_layer)">

      <variable as="map(xs:string, xs:string?)" name="oct_pname_preceding_note">
        <call-template name="store_params">
          <with-param name="el" select="."/>
        </call-template>
      </variable>

      <variable as="xs:boolean" name="same_pname_oct">
        <call-template name="same_pname_oct">
          <with-param name="oct_pname_current_note" select="$oct_pname_current_note"/>
          <with-param name="oct_pname_preceding_note" select="$oct_pname_preceding_note"/>
        </call-template>
      </variable>


      <if test="$same_pname_oct">
        <choose>
          <when test="(@accid[. = 'n'], @accid.ges[. = 'n'])">
            <sequence select="true()"/>
            <break/>
          </when>
          <!--These would be all other values for @accid and @accid.ges then "n" as the later was checked in the previous statement. -->
          <when test="(@accid, @accid.ges)">
            <sequence select="false()"/>
            <break/>
          </when>
          <otherwise/>
        </choose>
      </if>

    </iterate>

    <!--<sequence>
      <call-template name="boolean_checker">
        <with-param name="boolean_seq" select="$checkEveryAttr"/>
      </call-template>
    </sequence>-->


  </template>


  <xd:doc>
    <xd:desc>Compares @pname and @oct of the current note and the preceding note of the current iteration.</xd:desc>
  </xd:doc>
  <template name="same_pname_oct">
    <param as="map(xs:string, xs:string)" name="oct_pname_current_note"/>
    <param as="map(xs:string, xs:string)" name="oct_pname_preceding_note"/>

    <variable as="xs:boolean+" name="checkEveryAttr">
      <for-each select="'pname', 'oct'">
        <variable name="paramsCurrentVal" select="map:get($oct_pname_current_note, .)"/>
        <variable name="paramsPrecedingVal" select="map:get($oct_pname_preceding_note, .)"/>

        <choose>
          <when test="($paramsCurrentVal = '') or ($paramsPrecedingVal = '')">
            <value-of select="false()"/>
          </when>
          <otherwise>
            <sequence select="
                if ($paramsCurrentVal = $paramsPrecedingVal) then
                  true()
                else
                  false()"/>
          </otherwise>
        </choose>
      </for-each>
    </variable>

    <sequence>
      <call-template name="boolean_checker">
        <with-param name="boolean_seq" select="$checkEveryAttr"/>
      </call-template>
    </sequence>

  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="el"/>
  </xd:doc>
  <template name="store_params">
    <param as="element()*" name="el"/>

    <map>
      <map-entry key="'pname'" select="$el/string(@pname)"/>
      <map-entry key="'oct'" select="$el/string(@oct)"/>
      <!--      <map-entry key="'accid'" select="$el/string(@accid)"/>-->
    </map>
  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="boolean_seq"/>
  </xd:doc>
  <template name="boolean_checker">
    <param name="boolean_seq"/>

    <sequence>
      <choose>
        <when test="
            every $a in $boolean_seq
              satisfies $a = true()">
          <value-of select="true()"/>
        </when>
        <otherwise>
          <value-of select="false()"/>
        </otherwise>
      </choose>
    </sequence>
  </template>
</stylesheet>
