<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <include href="../../lib/basic.xsl"/>

  <variable name="all_second_tied_notes" select="
      let $tie_endids := //tie/@endid
      return
        for $endid in $tie_endids
        return
          substring($endid, 2)"/>



  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="note">

    <variable as="xs:boolean" name="second_tied_note">
      <call-template name="second_tied_note"/>
    </variable>   

    <copy>
      <choose>
        <when test="$second_tied_note">
          <variable as="attribute()?" name="first_tied_note_accidval">
            <call-template name="firstTiedNoteAccidVal"/>
          </variable>
          
          <if test="$first_tied_note_accidval">
            <attribute name="accid.ges" select="$first_tied_note_accidval"/>
          </if>
          
          <apply-templates select="@* except (@accid, @accid.ges), node()"/>
        </when>        
        <otherwise>          
          <apply-templates select="@*, node()"/>
        </otherwise>
      </choose> 
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
    <xd:desc>Returns the @accid/@accid.ges value (if exists) of the first tied note. If the value does not exist returns item().</xd:desc>
  </xd:doc>
  <template name="firstTiedNoteAccidVal">
    <variable name="first_tied_note" select="//tie[substring(@endid, 2) = current()/@xml:id]/substring(@startid, 2) => id()"/>
    <choose>
      <when test="$first_tied_note[@accid]">
        <sequence select="$first_tied_note/@accid"/>
      </when>
      <when test="$first_tied_note[@accid.ges]">
        <sequence select="$first_tied_note/@accid.ges"/>
      </when>
      <when test="$first_tied_note[descendant::*/@accid]">
        <sequence select="$first_tied_note/descendant::*/@accid"/>
      </when>
      <when test="$first_tied_note[descendant::*/@accid.ges]">
        <sequence select="$first_tied_note/descendant::*/@accid.ges"/>
      </when>
      <otherwise/>        
    </choose>
  </template>

  

</stylesheet>
