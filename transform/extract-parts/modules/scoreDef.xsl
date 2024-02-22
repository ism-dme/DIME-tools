<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xd:doc>
    <xd:desc>
      <xd:p/>
    </xd:desc>
  </xd:doc>
  <template match="scoreDef[not(ancestor::app) (:special case K. 550:)]" mode="step_one">
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
  <template match="staffDef" mode="m.delete.staffDefs">
    <choose>
      <!--One or more of the layerDefs-->
      <when test="
          some $staff in $REQ_STAVES_EXTRACT_LAYERS
            satisfies $staff = @n">
        <copy>
          <apply-templates select="@*"/>

          <variable name="layer.n" select="map:get(dme:requested-staves-layers(), current()/@n)"/>

          <call-template name="instrument.name.extracted.layer">
            <with-param name="pLayerDef" select="layerDef[@n = $layer.n]" tunnel="yes"/>
          </call-template>

        </copy>
      </when>
      <!--Whole staff-->
      <when test="
          some $staff in $REQ_STAVES_COMPLETE
            satisfies $staff = @n">
        <!--        <call-template name="instrument.name.extracted.staff"/>-->
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
          <apply-templates mode="#current" select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Returns new label text, e. g. "Clarinetti" => 'Clarinetto I'</xd:p>
    </xd:desc>
    <xd:param name="pLayerDef"/>
  </xd:doc>
  <template name="instrument.name.extracted.layer">
    <param name="pLayerDef" tunnel="yes"/>

    <variable as="element()" name="itemPerfRes" select="id(substring-after($pLayerDef/@decls, '#'))"/>
    <variable as="xs:string" name="instrumentNamePerfRes" select="$itemPerfRes/text() => normalize-space()"/>

    <variable as="document-node()" name="instrumentsList" select="doc($LIB_PATH || 'lists/instruments.xml')"/>
    <!--    TODO: The variable may be not optional later.-->
    <variable as="element()?" name="itemInstrumentsList" select="$instrumentsList/id($instrumentNamePerfRes)"/>

    <variable as="xs:string" name="instrumentName" select="$itemInstrumentsList/dme:name[@xml:lang = $P_LANGUAGE]/text() => normalize-space()"/>
    <variable as="xs:string" name="instrumentNameAbbr" select="$itemInstrumentsList/dme:name[@xml:lang = $P_LANGUAGE]/@label.abbr => normalize-space()"/>
    <variable as="map(xs:string, item()*)?" name="transposition">

      <choose>
        <when test="$itemPerfRes[@trans.diat and @trans.semi]">
          <variable as="element()" name="itemTransposition" select="$itemInstrumentsList/dme:transposition[@trans.semi = $itemPerfRes/@trans.semi and @trans.diat = $itemPerfRes/@trans.diat]"/>

          <variable as="element()" name="transpositionLabel" select="$itemTransposition/dme:label[@xml:lang = $P_LANGUAGE]"/>

          <sequence select="
              map {
                'label': ' ' || $transpositionLabel/text() => normalize-space(),
                'labelAbbr:': ' ' || $transpositionLabel/@label.abbr
              }"/>
        </when>
        <otherwise>
          <sequence select="map {}"/>
        </otherwise>
      </choose>

    </variable>

    <variable as="xs:string" name="romanInteger">
      <call-template name="roman.integer"/>
    </variable>


    <label xmlns="http://www.music-encoding.org/ns/mei">
      <xsl:attribute name="xml:id" select="label/@xml:id"/>
      <xsl:value-of select="$instrumentName || $romanInteger || $transposition('label')"/>
    </label>

    <labelAbbr xmlns="http://www.music-encoding.org/ns/mei">
      <xsl:attribute name="xml:id" select="label/@xml:id"/>
      <xsl:value-of select="$instrumentNameAbbr || $transposition('labelAbbr')"/>
    </labelAbbr>
  </template>



  <xd:doc>
    <xd:desc>
      <xd:p>Maps arabic and roman integers.</xd:p>
    </xd:desc>
    <xd:param name="layerDefN"/>
  </xd:doc>
  <template name="roman.integer">
    <param name="pLayerDef" tunnel="yes"/>

    <variable as="xs:boolean" name="sameTypeInstruments">
      <variable as="xs:integer" name="declsCount" select=".//layerDef/@decls => distinct-values() => count()"/>
      <sequence select="
          if ($declsCount > 1) then
            false()
          else
            true()"/>
    </variable>

    <variable as="map(xs:string, xs:string)?" name="romanIntegers" select="
        map {
          '1': 'I',
          '2': 'II',
          '3': 'III',
          '4': 'IV',
          '5': 'V',
          '6': 'VI',
          '7': 'VII',
          '8': 'VIII',
          '9': 'IX',
          '10': 'X'
        }
        "/>
    <choose>
      <when test="$sameTypeInstruments">
        <value-of select="' ' || map:get($romanIntegers, $pLayerDef/@n)"/>
      </when>
      <otherwise>
        <value-of select="()"/>
      </otherwise>
    </choose>

  </template>


</stylesheet>
