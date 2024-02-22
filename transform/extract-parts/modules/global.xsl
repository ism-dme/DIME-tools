<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="perform.extraction">

    <!--Currently, works only for whole staff extraction, e.g. '2', '6', but not for '2.1, '6.2', etc.-->
    <variable as="xs:string*" name="partsToExtract" select="$partsList[not(. = $partExists?nonAvailableParts)]"/>

    <call-template name="create.message.extracting.parts">
      <with-param name="partsToExtract" select="$partsToExtract"/>
      <with-param name="partExists" select="$partExists"/>
    </call-template>

    <variable name="extractedEvents">
      <apply-templates mode="step_one" select="$P_GLOBAL_CONTEXT_ITEM//mei:music"/>
    </variable>


    <!--<result-document href="{'../debug/extracted-events.xml'}" indent="yes" method="xml">
      <copy-of select="$extractedEvents"/>
    </result-document>-->

    <variable name="extractedControlEvents">
      <variable as="xs:boolean" name="onePartRequested" select="count($partsToExtract) eq 1"/>

      <choose>
        <when test="$onePartRequested and $P_SHRINK_MEASURES">
          <variable as="element()" name="multiRestMeasures">
            <call-template name="calculate.multirest.measures">
              <with-param name="pDocNode" select="$extractedEvents"/>
            </call-template>
          </variable>

          <apply-templates mode="step_two" select="$extractedEvents">
            <with-param as="element()?" name="pMultiRestMeasures" select="$multiRestMeasures" tunnel="yes"/>
          </apply-templates>

        </when>
        <otherwise>
          <apply-templates mode="step_two" select="$extractedEvents"/>
        </otherwise>
      </choose>

    </variable>


    <variable name="output">
      <mei xmlns="http://www.music-encoding.org/ns/mei">
        <xsl:copy-of select="mei:mei/@*, .//mei:meiHead"/>
        <xsl:copy-of select="$extractedControlEvents"/>
      </mei>
    </variable>

    <!--Used for XSpec-->
    <choose>
      <when test="$P_XSPEC_TEST or $P_MOVI">
        <copy-of select="$output"/>
      </when>
      <otherwise>
        <result-document href="{substring-before($XML_FILE_NAME, '.') || '_' || string-join($partsToExtract, '-') || '.mei'}" indent="yes" method="xml">
          <copy-of select="$output"/>
        </result-document>
      </otherwise>
    </choose>
  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Returns options passed to the GUI as map.</xd:p>
    </xd:desc>
  </xd:doc>
  <template name="options.gui">
    <variable as="element()*" name="parameters.values" select="doc($OPTIONS_PATH)//id('extract_parts')/dme:parameters"/>

    <variable as="xs:string*" name="req.parts" select="
        for $p in $parameters.values/dme:parameter/data()
        return
          string($p)"/>

    <choose>
      <when test="
          every $entry in $req.parts
            satisfies $entry = ''">
        <sequence select="''"/>
      </when>
      <otherwise>
        <sequence select="
            '|' || string-join($req.parts, '|') || '|'"/>
      </otherwise>
    </choose>


  </template>

  <!--An additional variable is neede, as $parts can be also passed via command line. Otherwise it would be sufficient to use $parameters.values from GUI.-->
  <variable as="xs:string*" name="partsList" select="
      for $n in
      tokenize($P_REQUESTED_PARTS, '\|')
      return
        if ($n != '') then
          $n
        else
          ()"/>

  <variable as="xs:boolean" name="allPartsRequested">
    <variable as="xs:string*" name="staffDefN" select="//staffDef/@n => distinct-values()"/>
    <sequence select="functx:sequence-deep-equal($partsList, $staffDefN)"/>
  </variable>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="sb[not(contains($P_REQUESTED_PARTS, concat('|', @n, '|')))]" mode="step_one">
    <if test="$allPartsRequested">
      <copy>
        <apply-templates select="@*"/>
      </copy>
    </if>
  </template>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="pb[not(contains($P_REQUESTED_PARTS, concat('|', @n, '|')))]" mode="step_one">
    <if test="$allPartsRequested">
      <copy>
        <apply-templates select="@*"/>
      </copy>
    </if>
  </template>




  <xd:doc>
    <xd:desc/>
  </xd:doc>

  <xd:doc>
    <xd:desc/>
    <xd:param name="id"/>
  </xd:doc>
  <template name="get.config.items">
    <param as="xs:string" name="id"/>
    <copy-of select="doc($LIB_PATH || 'lists/lists.xml')/id($id)/dme:item/data()"/>
  </template>




  <xd:doc>
    <xd:desc>
      <xd:p>Used only in the context of the layer extraction</xd:p>
      <xd:p>Expected syntax for $P_REQUESTED_PARTS is |{staffNumber}.{layerNumber}|. Multiple entries are possible.</xd:p>
    </xd:desc>
    <xd:param name="mode">Values: <xd:ul>
        <xd:li>staff: returns <xd:b>staff</xd:b> number(s) where the whole staff is required, e.g. |6| => ('6').</xd:li>
        <xd:li>layer: returns <xd:b>staff</xd:b> number(s) where a layer is required, e. g. |5.1| => ('5')</xd:li>
        <xd:li>all: both cases, e.g. |5.1|6| => ('5', '6').</xd:li>
      </xd:ul>
    </xd:param>
  </xd:doc>
  <function as="xs:string*" name="dme:requested-staves">
    <param name="mode"/>

    <!--example value: "1", "2.2"-->
    <variable name="voicesInput" select="
        for $n in
        tokenize($P_REQUESTED_PARTS, '\|')
        return
          if ($n != '') then
            $n
          else
            ()"/>

    <for-each select="$voicesInput">
      <choose>
        <when test="$mode = 'staff'">
          <!-- Complete staves (no layer extraction requested): e.g. |5|-->
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
        <when test="$mode = 'any'">
          <sequence select="functx:substring-before-if-contains(., '.')"/>
        </when>
      </choose>
    </for-each>

  </function>


  <xd:doc>
    <xd:desc>
      <xd:p>Maps the @n-attribute of staves and their respective layer which are requested. </xd:p>
      <xd:p>Example: for the input |2.1|3|, the map will contain the key '2' (staff/@n) and the value '1' (layer/@n), the value '3' is omitted as no layer is required to be extracted. </xd:p>
    </xd:desc>
  </xd:doc>
  <function name="dme:requested-staves-layers">
    <map>
      <choose>
        <when test="contains($P_REQUESTED_PARTS, '.')">
          <for-each select="
              for $n in
              tokenize($P_REQUESTED_PARTS, '\|')
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
  </function>
  <!--
  <template name="t.startid.pointer">
    <sequence select="$global.context.item/id(substring-after(current(), '#'))"/>
  </template>
-->

  <variable as="map(xs:string, item()*)" name="partExists">
    <call-template name="check.part.existence"/>
  </variable>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="check.part.existence">

    <variable as="xs:string+" name="availableStaffN">
      <try>
        <sequence select="$P_GLOBAL_CONTEXT_ITEM//mei:staff/@n => distinct-values()"/>
        <catch>
          <message>The file does not contain any mei:staff/@n</message>
        </catch>
      </try>
    </variable>

    <variable as="xs:string*" name="requestedStaves" select="
        for $part in $partsList
        return
          functx:substring-before-if-contains($part, '.')"/>

    <variable as="xs:boolean" name="partExistsLocal">
      <variable as="xs:string*" name="temp">
        <for-each select="$requestedStaves">
          <if test="functx:is-value-in-sequence(., $availableStaffN)">
            <sequence select="."/>
          </if>
        </for-each>
      </variable>
      <sequence select="(count($temp) > 0)"/>
      <!--      <sequence select="
          if (count($temp) > 0) then
            true()
          else
            if (count($temp) eq 1) then
              (:check empty string:)
              boolean($temp[1])
            else
              false()"/>-->
    </variable>

    <variable as="xs:string*" name="nonAvailableParts">
      <for-each select="$requestedStaves">
        <if test="functx:is-value-in-sequence(., $availableStaffN) => not()">
          <sequence select="."/>
        </if>
      </for-each>
    </variable>


    <sequence select="
        map {
          'partExists': $partExistsLocal,
          'nonAvailableParts': $nonAvailableParts
        }"/>
    <!--DBG:-->
    <!--    <sequence select="true(), ('10')"/>-->
  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="partsToExtract"/>
    <xd:param name="partExists"/>
  </xd:doc>
  <template name="create.message.extracting.parts">
    <param name="partsToExtract"/>
    <param name="partExists"/>
    <message>Extracting the requested parts: <value-of select="string-join($partsToExtract, ', ')"/>. <if test="count($partExists?nonAvailableParts) > 0">Note that the following requested staves are not available in the current MEI: <value-of select="string-join($partExists?nonAvailableParts, ', ')"/>.</if>
    </message>
  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="partExists"/>
  </xd:doc>
  <template name="create.message.parts.nonavailable">
    <param name="partExists"/>
    <message><value-of select="'The requested part(s) (' || string-join($partExists?nonAvailableParts, ', ') || ') is/are not available in the MEI file or no parts were requested!'"/>. NB: No extraction was performed.</message>
  </template>


</stylesheet>
