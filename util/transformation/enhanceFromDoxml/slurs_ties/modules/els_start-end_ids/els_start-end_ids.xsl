<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <include href="slurs.xsl"/>
  <include href="ties.xsl"/>

  <variable as="element()*" name="doxmlEls">

    <variable as="element()*" name="doxmlSlurs">
      <call-template name="getSlurs"/>
    </variable>

    <variable as="element()*" name="doxmlTies">
      <call-template name="getTies"/>
    </variable>

    <variable as="map(xs:string, element()*)" name="MEIelsMap">
      <map>
        <map-entry key="'slur'" select="$modifiedMEI//slur"/>
        <map-entry key="'tie'" select="$modifiedMEI//tie"/>
      </map>
    </variable>


    <for-each select="$doxmlSlurs, $doxmlTies">
      <call-template name="compare_MEI-DOXML_els">
        <with-param name="currMEIelsMap" select="$MEIelsMap"/>
      </call-template>
    </for-each>

  </variable>


  <template name="compare_MEI-DOXML_els">
    <param name="currMEIelsMap"/>


    <variable as="map(*)*" name="meiElsPointersMap">
      <call-template name="createMaps">
        <with-param name="els" select="map:get($currMEIelsMap, current()/local-name())"/>
      </call-template>
    </variable>

    <variable as="element()" name="swapedPointers">
      <call-template name="swapPointers"/>
    </variable>

    <variable as="map(xs:string, xs:string)" name="currDoxmlElPointersMap">
      <call-template name="createMaps">
        <with-param as="element()" name="els" select="$swapedPointers"/>
      </call-template>
    </variable>

    <variable as="xs:integer+" name="performTest">
      <call-template name="performTest">
        <with-param name="meiElsPointersMap" select="$meiElsPointersMap"/>
        <with-param name="currDoxmlElPointersMap" select="$currDoxmlElPointersMap"/>
      </call-template>
    </variable>

    <choose>
      <when test="
          (sum($performTest) &lt; 2) and not(some $a in ($swapedPointers/@startid, $swapedPointers/@endid)
            satisfies substring-after($a, '#') = '')">
        <sequence select="$swapedPointers"/>
      </when>
      <otherwise/>
    </choose>

  </template>


  <template name="performTest">
    <param name="meiElsPointersMap"/>
    <param name="currDoxmlElPointersMap"/>

    <for-each select="'startid', 'endid'">
      <choose>
        <when test="
            some $i in (for $b in $meiElsPointersMap
            return
              map:get($b, .))
              satisfies map:get($currDoxmlElPointersMap, .) = $i">
          <value-of select="1"/>
        </when>
        <otherwise>
          <value-of select="0"/>
        </otherwise>
      </choose>
    </for-each>
  </template>

  <template name="createMaps">
    <param as="element()*" name="els"/>

    <for-each select="$els">
      <map>
        <map-entry key="'startid'" select="string(@startid)"/>
        <map-entry key="'endid'" select="string(@endid)"/>
      </map>
    </for-each>
  </template>



  <template name="swapPointers">
    <variable name="currEl" select="."/>
    
    <copy>
      <for-each select="'startid', 'endid'">
       <!-- <message>
          <value-of select=". || ': ' || $currEl/@*[local-name() = current()]"/>
        </message>-->
        <attribute name="{.}">
          <call-template name="replaceValuesStartEndIDs">
            <with-param name="currEl" select="$currEl"/>
          </call-template>
        </attribute>
      </for-each>

      <variable as="element()?" name="respectiveMeiFirstNote" select="$modifiedMEI//note[@doxml.id = current()/@startid]"/>
      <attribute name="staff" select="$respectiveMeiFirstNote/ancestor::mei:staff/@n"/>
      <attribute name="measureID" select="$respectiveMeiFirstNote/ancestor::mei:measure/@xml:id"/>
      <!--      <attribute name="color" select="'red'"/>-->
      <attribute name="xml:id" select="local-name() || '_' || generate-id()"/>
      <apply-templates select="@* except (@startid, @endid)"/>
    </copy>


  </template>

  <template name="replaceValuesStartEndIDs">
    <param name="currEl"/>

    <sequence select="'#' || $modifiedMEI//mei:note[@doxml.id = $currEl/@*[name() = current()]]/@xml:id"/>
  </template>



</stylesheet>
