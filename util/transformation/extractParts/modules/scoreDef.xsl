<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xd:doc>
    <xd:desc>
      <xd:p/>
    </xd:desc>
  </xd:doc>
  <template mode="extract.events" match="scoreDef[not(ancestor::app) (:special case K. 550:)]">
    <variable as="element()" name="delete.staffDefs">
      <apply-templates mode="m.delete.staffDefs" select="."/>
    </variable>
    <variable as="element()" name="clean.staffGrps">
      <apply-templates mode="m.adjust.staffGrps" select="$delete.staffDefs"/>
    </variable>
    <copy-of select="$clean.staffGrps"/>
  </template>


  <xd:doc>
    <xd:p>Processes staffDef depending if the whole staffDef is requested for extraction or one of the layerDefs.</xd:p>
    <xd:p>Deletes staves (mei:staffDef) which do not match the requested part number.</xd:p>
  </xd:doc>
  <template mode="m.delete.staffDefs" match="staffDef">
    <choose>
      <when test="
          some $staff in $req.staves.extract.layers
            satisfies $staff = @n">
        <copy>
          <apply-templates select="@*"/>

          <variable name="layer.n" select="map:get(dme:requested-staves-layers(), current()/@n)"/>

          <label xmlns="http://www.music-encoding.org/ns/mei">
            <xsl:attribute name="xml:id" select="label/@xml:id"/>

            <xsl:call-template name="label">
              <xsl:with-param name="layerDef" select="layerDef[@n = $layer.n]"/>
            </xsl:call-template>
          </label>
        </copy>
      </when>
      <when test="
          some $staff in $req.staves.complete
            satisfies $staff = @n">
        <copy-of select="."/>
      </when>
      <!--Other staffDefs are deleted.-->
    </choose>
  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Empty and redundant staffGrps are deleted; @symbol is adjusted.</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="staffGrp" mode="m.adjust.staffGrps">
    <choose>
      <!--Delete empty staffGrps-->
      <when test="not(descendant::staffDef)"/>
      <!--Delete redundant stafGrp. E.g. when extracting Violins there are one staffGrp for Violin I, II and one stafGrp for strings. When extracting Violin I, hte strings-staffGrp would be redundant:-->
      <!--   <staffGrp barthru="true" symbol="bracket" xml:id="staffGrp_04">
        <staffGrp symbol="brace" xml:id="staffGrp_05">
          <staffDef clef.line="2" clef.shape="G" decls="#instrVoice_11" dme.parts="11" doxml.id="d27e466" label.abbr="Vl. I" lines="5" n="7" xml:id="staffDef_P7">
            <label xml:id="label_P7">Violino I</label>
          </staffDef>
        </staffGrp>
      </staffGrp>-->
      <when test="parent::staffGrp and count(child::staffGrp/staffDef) = 1">
        <apply-templates mode="#current"/>
      </when>
      <!--If only one part is extracted (e.g. Oboe II out from Flauto, Oboi, Clarinetti), the bracket should be replaced 'none'.-->
      <when test="count(child::staffDef) = 1">
        <choose>
          <!--But: when multiple parts remains on the staff, @symbol should be preserved -->
          <when test="count(child::staffDef//descendant::layerDef) > 1">
            <copy>
              <apply-templates mode="#current" select="@*, node()"/>
            </copy>
          </when>
          <otherwise>
            <copy>
              <attribute name="symbol" select="'none'"/>
              <apply-templates mode="#current" select="@* except @symbol, node()"/>
            </copy>
          </otherwise>
        </choose>
      </when>
      <otherwise>
        <copy>
          <apply-templates select="@*, node()" mode="#current"/>
        </copy>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Returns new label text, e. g. "Clarinetti" => 'Clarinetto I'</xd:p>
    </xd:desc>
    <xd:param name="layerDef"/>
  </xd:doc>
  <template name="label">
    <param name="layerDef"/>

    <variable name="codedval" select="id(substring-after($layerDef/@decls, '#'))/@codedval"/>
    <variable name="name" select="doc($lib.path || 'lists/lists.xml')/id($codedval)/dme:name[@xml:lang = 'IT']/data()"/>
    <value-of select="concat($name, ' ', dme:voice-number($layerDef/@n))"/>
  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Maps part number to the roman integer.</xd:p>
    </xd:desc>
    <xd:param name="n"/>
  </xd:doc>
  <function name="dme:voice-number">
    <param name="n"/>
    
    <variable as="map(xs:string, xs:string)?" name="RomanIntegers">
      <map>
        <map-entry key="'1'" select="'I'"/>
        <map-entry key="'2'" select="'II'"/>
        <map-entry key="'3'" select="'III'"/>
        <map-entry key="'4'" select="'IV'"/>
      </map>
    </variable>
    <value-of select="map:get($RomanIntegers, $n)"/>
  </function>


</stylesheet>
