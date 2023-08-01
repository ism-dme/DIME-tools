<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xd:doc>
    <xd:desc>changes @startid to @tstamp in dynams</xd:desc>
  </xd:doc>
  <template match="
      dynam[@startid and not(@tstamp)]" mode="DcX_2">
    <variable as="xs:string*" name="dynams" select="$lists//id('dynams_2')/dme:item/text()"/>
    <choose>
      <when test="
          some $n in $dynams
            satisfies text() = $n">
        <variable name="startXmlID" select="substring(@startid, 2)"/>
        <variable name="newTstamp" select="(//note[@xml:id = $startXmlID]/@tstamp) | (//chord[@xml:id = $startXmlID]/@tstamp)"/>
        <copy>
          <attribute name="tstamp" select="$newTstamp"/>
          <apply-templates mode="#current" select="@* except @startid, node()"/>
        </copy>
      </when>
      <otherwise>
        <copy>
          <apply-templates mode="#current" select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>





  <xd:doc>
    <xd:desc>If the note has @enclose="brack" and @accid. The @accid will be supplied.</xd:desc>
  </xd:doc>
  <template match="note" mode="DcX_2">
    <copy>

      <if test="ancestor::chord">
        <call-template name="ancestorChord"/>
      </if>

      <if test="@grace and not(@stem.dir)">
        <attribute name="stem.dir" select="'up'"/>
      </if>

      <choose>
        <when test="(@enclose = 'brack') and @accid">
          <choose>
            <when test="ancestor::chord">
              <apply-templates mode="#current" select="@* except (@enclose, @accid, @staff, @dur), node()"/>
            </when>
            <otherwise>
              <apply-templates mode="#current" select="@* except (@enclose, @accid), node()"/>
            </otherwise>
          </choose>

          <element name="supplied" namespace="http://www.music-encoding.org/ns/mei">
            <attribute name="resp" select="'#NMA-editors'"/>
            <attribute name="xml:id" select="concat('supplied_', substring-after(@xml:id, '_'))"/>
            <element name="accid" namespace="http://www.music-encoding.org/ns/mei">
              <attribute name="accid" select="@accid"/>
              <attribute name="xml:id" select="concat('accid_', substring-after(@xml:id, '_'))"/>
            </element>
          </element>
        </when>
        <otherwise>
          <choose>
            <when test="ancestor::chord">
              <apply-templates mode="#current" select="@* except (@staff, @dur), node()"/>
            </when>
            <otherwise>
              <apply-templates mode="#current" select="@*, node()"/>
            </otherwise>
          </choose>
        </otherwise>
      </choose>

    </copy>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="rest[ancestor::chord]" mode="DcX_2">
    <call-template name="ancestorChord"/>
  </template>


  <xd:doc>
    <xd:desc/>
    <xd:param name="element"/>
  </xd:doc>
  <template name="ancestorChord">
    <param name="element" select="."/>
    <variable name="currentID" select="@xml:id"/>

    <if test="not(@dots)">
      <if test="ancestor::chord//*[@dots and @xml:id != $currentID] (:other notes or rests in chord:)">
        <attribute name="dots" select="0"/>
      </if>
    </if>


  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Delete &lt;dir&gt;s with text 'origrace-g1' or 'ossia'</xd:p>
      <xd:p>For &lt;dir&gt;s with text 'm.d.' add attributes @place=below and @staff. The value for @staff is derived from a) pointed note b) chord c) staff</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="dir" mode="DcX_2">

    <choose>
      <when test="contains(text(), 'origrace-g1') or contains(text(), 'ossia')"/>
      <when test="text()[contains(., 'm.d.')]">
        <copy>
          <attribute name="place" select="'below'"/>
          <variable as="xs:string" name="staff.value">
            <variable name="pointer" select="substring(@startid, 2) => id()"/>
            <choose>
              <when test="$pointer[@staff]">
                <value-of select="$pointer/@staff/string()"/>
              </when>
              <when test="$pointer/ancestor::chord[@staff]">
                <value-of select="$pointer/ancestor::chord/@staff/string()"/>
              </when>
              <otherwise>
                <value-of select="$pointer/ancestor::staff/@n/string()"/>
              </otherwise>
            </choose>
          </variable>
          <attribute name="staff" select="$staff.value"/>
          <apply-templates select="@* except (@place, @staff), node()"/>
        </copy>
      </when>
      <otherwise>
        <copy>
          <apply-templates select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>

  </template>



</stylesheet>
