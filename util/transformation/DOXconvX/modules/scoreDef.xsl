<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <xd:doc>
    <xd:desc>adds @key.sig, @key.mode, @key.pname of the non-transpoing instruments</xd:desc>
  </xd:doc>
  <template match="scoreDef" mode="scoreDef">

    <copy>
      <!--Create @xml:id which conforms to DIME guidelines-->
      <variable name="digits">
        <call-template name="countPrecedingEls">
          <with-param name="element" select="."/>
        </call-template>
      </variable>

      <attribute name="xml:id">
        <value-of select="concat(local-name(), '_', $digits)"/>
      </attribute>


      <if test="map:get($options, 'genre') = ('orchestral', 'chamber')">
        <attribute name="optimize" select="'false'"/>
      </if>

      <choose>
        <when test="map:get($options, 'meiHead') != '0' (:=Werk-header should be used:)">
          <variable as="attribute()*" name="databaseAttrs" select="$databaseFileMovement//workDesc//key/@*"/>
          <for-each select="$databaseAttrs">
            <attribute name="{'key.' || local-name()}" select="."/>
          </for-each>
          <apply-templates mode="#current" select="@* except @*[substring-after(local-name(), 'key.') = $databaseAttrs/local-name()]"/>
        </when>
        <otherwise>
          <apply-templates mode="#current" select="@*"/>
        </otherwise>
      </choose>

      <apply-templates mode="scoreDefChildren" select="node()"/>

    </copy>
  </template>



  <xd:doc>
    <xd:desc>Deletes redundant staffGrp?</xd:desc>
  </xd:doc>
  <template match="staffGrp[staffGrp and (@barthru = 'false') and parent::scoreDef]" mode="scoreDefChildren">
    <variable name="NrStaffGrp" select="count(staffGrp)"/>
    <choose>
      <when test="($NrStaffGrp = 1) and not(staffDef)">
        <for-each select="child::node()">
          <apply-templates mode="#current" select="."/>
        </for-each>
      </when>
      <otherwise>
        <copy>
          <apply-templates select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="staffDef" mode="scoreDefChildren">
    <variable name="current" select="."/>

    <!--extract values from @dme.parts-->
    <variable name="dmeParts" select="
        for $n in tokenize(@dme.parts, ',')
        return
          normalize-space($n)"/>
    <variable name="multipleDMEparts" select="
        if (count($dmeParts) = 1) then
          false()
        else
          true()"/>
    <!--		find the respective perfRes-->
    <variable as="element()*" name="perfRes">
      <sequence select="$current/preceding::perfRes[@n = $dmeParts]"/>
    </variable>

    <copy>
      <choose>
        <when test="count($dmeParts) >= 1">
          <call-template name="processStaffDef">
            <with-param name="dmeParts" select="$dmeParts"/>
            <with-param name="multipleDMEparts" select="$multipleDMEparts"/>
            <with-param name="perfRes" select="$perfRes"/>
          </call-template>
        </when>
        <otherwise>
          <message>No @dme.parts defined in staffDef@<value-of select="@xml:id"/>, therefore original attributes are preserved.</message>
          <apply-templates select="@*, node()"/>
        </otherwise>
      </choose>
    </copy>
  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="perfRes"/>
    <xd:param name="dmeParts"/>
    <xd:param name="multipleDMEparts"/>
  </xd:doc>
  <template name="processStaffDef">
    <param as="element()*" name="perfRes"/>
    <param name="dmeParts"/>
    <param name="multipleDMEparts"/>

    <!--		instrument from lists.xml-->
    <variable name="item" select="$lists//id($perfRes/@codedval)"/>
    <variable name="label.abbr" select="$item//dme:name[@xml:lang = 'IT']/@label.abbr"/>
    <variable name="label" select="$item//dme:name[@xml:lang = 'IT']/text()"/>
    <variable name="transposeIN" select="map:get($options, 'allParams')//id($label[1])/text()"/>

    <if test="$multipleDMEparts = false()">
      <attribute name="decls" select="concat('#', $perfRes/@xml:id)"/>
    </if>
    <variable name="genre" select="map:get($options, 'genre')"/>

    <if test="matches($genre, 'orchestral')">
      <call-template name="attr.label.abbr">
        <with-param name="label" select="$label"/>
        <with-param name="label.abbr" select="$label.abbr"/>
      </call-template>
    </if>




    <if test="exists($item/dme:transposition)">
      <call-template name="transpositionAttributes">
        <with-param name="label" select="$label"/>
        <with-param name="item" select="$item"/>
        <with-param name="transposeIN" select="$transposeIN"/>
      </call-template>
    </if>

    <apply-templates select="(@clef.line, @clef.shape, @dme.parts, @doxml.id, @lines, @xml:id, @n)"/>

    <choose>
      <when test="label">
        <apply-templates select="label"/>
      </when>
      <when test="@label">
        <element name="label" namespace="http://www.music-encoding.org/ns/mei">
          <value-of select="@label"/>
        </element>
      </when>
      <otherwise>
        <element name="label" namespace="http://www.music-encoding.org/ns/mei">
          <value-of select="$label"/>
        </element>
      </otherwise>
    </choose>


    <call-template name="createLayerDefs">
      <with-param name="multipleDMEparts" select="$multipleDMEparts"/>
      <with-param name="dmeParts" select="$dmeParts"/>
      <with-param name="perfRes" select="$perfRes"/>
    </call-template>
  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="multipleDMEparts"/>
    <xd:param name="dmeParts"/>
    <xd:param name="perfRes"/>
  </xd:doc>
  <template name="createLayerDefs">
    <param name="multipleDMEparts"/>
    <param name="dmeParts"/>
    <param as="element()*" name="perfRes"/>
    <if test="$multipleDMEparts = true()">
      <for-each select="$dmeParts">
        <element name="layerDef" namespace="http://www.music-encoding.org/ns/mei">
          <variable name="current" select="."/>

          <attribute name="decls" select="concat('#', $perfRes[@n = $current]/@xml:id)"/>
          <attribute name="n" select="position()"/>
        </element>
      </for-each>
    </if>
  </template>



  <xd:doc>
    <xd:desc/>
    <xd:param name="label"/>
    <xd:param name="item"/>
    <xd:param name="transposeIN"/>
  </xd:doc>
  <template name="transpositionAttributes">
    <param name="label"/>
    <param name="item"/>
    <param name="transposeIN"/>

    <choose>
      <when test="$label = ('Clarinetto', 'Clarino', 'Corno')">
        <attribute name="trans.semi" select="$item/dme:transposition[text() = $transposeIN]//@trans.semi"/>
        <attribute name="trans.diat" select="$item/dme:transposition[text() = $transposeIN]//@trans.diat"/>
      </when>
      <otherwise>
        <attribute name="trans.semi" select="$item//@trans.semi"/>
        <attribute name="trans.diat" select="$item//@trans.diat"/>
      </otherwise>
    </choose>
    <apply-templates select="@key.sig"/>
  </template>


  <xd:doc>
    <xd:desc/>
    <xd:param name="label"/>
    <xd:param name="label.abbr"/>
  </xd:doc>
  <template name="attr.label.abbr">
    <param name="label"/>
    <param name="label.abbr"/>
    <attribute name="label.abbr">
      <choose>
        <!--derive the roman integer for violine from its label-->
        <when test="
            (some $n in $label
              satisfies contains($n, 'Violino')) and @label">
          <variable name="violinoCount" select="tokenize(@label, '\s')[last()]"/>
          <value-of select="concat($label.abbr, ' ', $violinoCount)"/>
        </when>
        <otherwise>
          <value-of select="$label.abbr"/>
        </otherwise>
      </choose>
    </attribute>
  </template>


  <xd:doc>
    <xd:desc>counts preceding elements</xd:desc>
    <xd:param name="element"/>
  </xd:doc>
  <template name="countPrecedingEls">
    <param name="element"/>
    <!--staffGrp are also nested that's where the XPath expression with ancestor is needed, hopefully there will be no nested scoreDefs-->
    <variable name="NrPrecElem" select="dme:countPreceding($element) + count($element/ancestor::node()[local-name() = $element/local-name()]) + 1"/>
    <!--check if '01' or '11', so if '0' is needed to be prefixed-->
    <choose>
      <when test="string-length(string($NrPrecElem)) > 1">
        <value-of select="$NrPrecElem"/>
      </when>
      <otherwise>
        <value-of select="concat('0', $NrPrecElem)"/>
      </otherwise>
    </choose>

  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="element"/>
  </xd:doc>
  <function name="dme:countPreceding">
    <param name="element"/>
    <value-of select="count($element/preceding::node()[local-name() = $element/local-name()])"/>
  </function>


</stylesheet>
