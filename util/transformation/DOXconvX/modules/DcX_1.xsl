<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">





  <xd:doc>
    <xd:desc>adds @n to pb</xd:desc>
  </xd:doc>
  <template match="pb" mode="DcX_1">
    <copy>
      <if test=".[@facs]">
        <attribute name="n" select="substring-after(@facs, '_')"/>
      </if>
      <apply-templates mode="#current" select="@* except (@n), node()"/>
    </copy>
  </template>

  <xd:doc>
    <xd:desc>Pushes tempo up</xd:desc>
  </xd:doc>
  <template match="measure[@n = (0, 1)]" mode="DcX_1">
    <copy>
      <apply-templates select="@*"/>
      <apply-templates select="descendant::tempo"/>
      <apply-templates select="node() except *[local-name() = 'tempo']"/>
    </copy>
  </template>

  <xd:doc id="tempo_first_measure">
    <xd:desc>adds @tstamp and @part=%allto a &lt;tempo&gt; in first measure.</xd:desc>
  </xd:doc>
  <template match="tempo[ancestor::measure[@n = ('0', '1')]]" mode="DcX_1">
    <copy>
      <if test=".[not(@tstamp)]">
        <attribute name="tstamp" select="1"/>
      </if>
      <if test="map:get($options, 'genre') = ('orchestral', 'chamber', 'opera')">
        <attribute name="part" select="'%all'"/>
      </if>
      <apply-templates mode="#current" select="@*, node()"/>
    </copy>
  </template>



  <xd:doc>
    <xd:desc>adds @decls to facimile</xd:desc>
  </xd:doc>
  <template match="facsimile" mode="DcX_1">
    <copy>
      <attribute name="decls" select="'#digital_image'"/>
      <apply-templates mode="#current" select="@*, node()"/>
    </copy>
  </template>

  <xd:doc>
    <xd:desc>Adds #</xd:desc>
  </xd:doc>
  <template match="@startid[not(starts-with(., '#'))] | @endid[not(starts-with(., '#'))] | @resp[not(starts-with(., '#'))]" mode="DcX_1">
    <copy>
      <attribute name="{local-name()}" select="concat('#', .)"/>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>Adds @form, @measperf. Deletes @unitdur</xd:desc>
  </xd:doc>
  <template match="bTrem" mode="DcX_1">
    <choose>
      <when test="child::bTrem"/>
      <when test="@unitdur">
        <copy>
          <attribute name="measperf">
            <value-of select="@unitdur"/>
          </attribute>
          <attribute name="form">
            <value-of select="'meas'"/>
          </attribute>
          <apply-templates mode="#current" select="@* except @unitdur, node()"/>
        </copy>
      </when>
      <otherwise>
        <copy>
          <apply-templates mode="#current" select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>


  <variable name="dirs" select="$lists//id('dirs')/dme:item/text()"/>
  <xd:doc>
    <xd:desc>Wraps the text of a dir in a 'rend'. The text value is defined in lists.xml</xd:desc>
  </xd:doc>
  <template match="text()[(. = $dirs) and not(parent::rend)]" mode="DcX_1">

    <element name="rend" namespace="http://www.music-encoding.org/ns/mei">
      <attribute name="fontstyle" select="'normal'"/>
      <attribute name="halign" select="'center'"/>
      <choose>
        <when test=". = ('a2', 'a 2')">
          <value-of select="'a&#8198;2'"/>
        </when>
        <otherwise>
          <value-of select="."/>
        </otherwise>
      </choose>
    </element>
  </template>




  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="@accid[. = 'ss']" mode="DcX_1">
    <!--| @accid.ges[. = 'ss'] currently schema violation for this value, why?-->
    <attribute name="{name()}" select="'x'"/>
  </template>

  <xd:doc>
    <xd:desc>adds @resp to supplied</xd:desc>
  </xd:doc>
  <template match="supplied[not(@resp)]" mode="DcX_1">
    <copy>
      <attribute name="resp">
        <value-of select="'#NMA-editors'"/>
      </attribute>
      <apply-templates mode="#current" select="@*, node()"/>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>If the pointed &lt;note&gt; or &lt;chord &gt;have @staff the value of &lt;dynam&gt;/@staff is adjusted respectively.</xd:desc>
  </xd:doc>
  <template match="dynam" mode="DcX_1">
    <copy>
      <variable name="pointer" select="substring(@startid, 2) => id()"/>
      <choose>
        <when test="$pointer[@staff]">
          <attribute name="staff" select="$pointer/@staff"/>
        </when>
        <otherwise>
          <if test="@staff">
            <apply-templates select="@staff"/>
          </if>
        </otherwise>
      </choose>
      <apply-templates select="@* except @staff, node()"/>
    </copy>

  </template>


</stylesheet>
