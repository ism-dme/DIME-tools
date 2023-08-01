<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <variable name="movementInteger" select="map:get($optionsCalc, 'movementInteger')"/>
  <!--<variable name="placeholders" select="'meiVersion'"/>-->
  <!--  <variable name="placeholders" select="'fileName', 'kvMovement', 'kvNumber', 'movementInteger', 'movementString', 'workID', 'movementID', 'respInitials', 'respFullName', 'tempoFirstMeasure', 'movementPages', 'workTitleEN', 'workTitleDE', 'NMA-editors', 'tempoHeading', 'workID', 'firstPage', 'meiVersion'"/>-->
  <variable as="map(xs:string, xs:string?)" name="placeholdersMap">
    <call-template name="placeholdersMap"/>
  </variable>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="
      */text()[some $n in map:keys($placeholdersMap)
        satisfies matches(., $n)] | @*[some $n in map:keys($placeholdersMap)
        satisfies matches(., $n)]" mode="processPlaceholders">

    <variable name="pText" select="string(.)"/>


    <!--The parameter movementString is added later bcs. it is context-dependend-->
    <variable as="xs:string" name="movementString">
      <call-template name="movementString"/>
    </variable>
    <variable name="placeholdersMap_" select="map:put($placeholdersMap, 'movementString', $movementString)"/>

    <!--find keys which do not occur in the current text-->
    <variable name="redundantKeys">
      <for-each select="map:keys($placeholdersMap)">
        <if test="not(contains($pText, .))">
          <sequence select="."/>
        </if>
      </for-each>
    </variable>

    <!--del entries which are not relevant (performance reasons only)-->
    <variable name="cleanedMap" select="map:remove($placeholdersMap_, tokenize($redundantKeys, '\s'))"/>
    <variable name="mapKeys" select="map:keys($cleanedMap)"/>
    <variable as="xs:integer" name="mapSize" select="map:size($cleanedMap)"/>

    <call-template name="processText">
      <with-param name="pText" select="$pText"/>
      <with-param name="cleanedMap" select="$cleanedMap"/>
      <with-param name="mapKeys" select="$mapKeys"/>
      <with-param name="mapSize" select="$mapSize"/>
    </call-template>
  </template>


  <!--  <template match="processing-instruction()[name() = $placeholders]" mode="processPlaceholders" name="processPI">
    <copy-of copy-namespaces="no" select="$databaseFileMovement//*[@xml:id = name(current())]"/>
  </template>-->


  <xd:doc>
    <xd:desc/>
    <xd:param name="pText"/>
    <xd:param name="cleanedMap"/>
    <xd:param name="mapKeys"/>
    <xd:param name="mapSize"/>
  </xd:doc>
  <template name="processText">
    <param name="pText"/>
    <param name="cleanedMap"/>
    <param name="mapKeys"/>
    <param as="xs:integer" name="mapSize"/>
    <!--attributes and text nodes are processed slightly different-->
    <choose>
      <when test=". instance of text()">
        <call-template name="replace_textNode">
          <with-param name="pText" select="$pText"/>
          <with-param name="vMap" select="$cleanedMap"/>
          <with-param name="mapKeys" select="$mapKeys"/>
          <with-param name="mapSize" select="$mapSize"/>
        </call-template>
      </when>
      <when test=". instance of attribute()">
        <variable name="replacedAttrValue">
          <call-template name="replace_attrValue">
            <with-param name="pText" select="$pText"/>
            <with-param name="vMap" select="$cleanedMap"/>
            <with-param name="mapKeys" select="$mapKeys"/>
            <with-param name="mapSize" select="$mapSize"/>
          </call-template>
        </variable>
        <attribute name="{name()}" select="$replacedAttrValue"/>
      </when>
    </choose>
  </template>

  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="movementString">
    <choose>
      <when test="(ancestor::node()/@xml:lang) and (matches(., 'movementString'))">
        <value-of select="dme:movementString(ancestor::node()[@xml:lang][1]/@xml:lang cast as xs:string)"/>
      </when>
      <otherwise>
        <value-of select="'NaN'"/>
      </otherwise>
    </choose>
  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="pText"/>
    <xd:param name="counter"/>
    <xd:param name="vMap"/>
    <xd:param name="mapKeys"/>
    <xd:param name="mapSize"/>
  </xd:doc>
  <template name="replace_textNode">
    <param as="xs:string" name="pText"/>
    <param name="vMap"/>
    <param as="xs:string*" name="mapKeys"/>
    <param as="xs:integer" name="mapSize"/>
    <param name="counter" select="1"/>

    <choose>
      <when test="$counter &lt;= $mapSize">
        <variable name="currentKey" select="$mapKeys[$counter]"/>

        <!--		<message>Key: "<value-of select="$currentKey"/>" Value: "<value-of select="map:get($vMap, $currentKey)"/>" text: <value-of select="$pText"/>.</message>-->
        <variable as="xs:string" name="replaced">
          <value-of select="
              if (map:get($vMap, $currentKey) != '') then
                replace($pText, $currentKey, map:get($vMap, $currentKey))
              else
                ()"/>
        </variable>
        <call-template name="replace_textNode">
          <with-param name="pText" select="$replaced"/>
          <with-param name="vMap" select="$vMap"/>
          <with-param name="mapKeys" select="$mapKeys"/>
          <with-param name="mapSize" select="$mapSize"/>
          <with-param name="counter" select="$counter + 1"/>
        </call-template>
      </when>
      <otherwise>
        <value-of select="$pText"/>
      </otherwise>
    </choose>

  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="pText"/>
    <xd:param name="counter"/>
    <xd:param name="vMap"/>
    <xd:param name="mapKeys"/>
    <xd:param name="mapSize"/>
  </xd:doc>
  <template name="replace_attrValue">
    <param as="xs:string" name="pText"/>
    <param name="vMap"/>
    <param as="xs:string*" name="mapKeys"/>
    <param as="xs:integer" name="mapSize"/>
    <param name="counter" select="1"/>

    <choose>
      <when test="$counter &lt;= $mapSize">
        <variable name="currentKey" select="$mapKeys[$counter]"/>
        <variable name="replaced">
          <value-of select="replace($pText, $currentKey, map:get($vMap, $currentKey))"/>
        </variable>
        <call-template name="replace_textNode">
          <with-param name="pText" select="$replaced"/>
          <with-param name="vMap" select="$vMap"/>
          <with-param name="mapKeys" select="$mapKeys"/>
          <with-param name="mapSize" select="$mapSize"/>
          <with-param name="counter" select="$counter + 1"/>
        </call-template>
      </when>
      <otherwise>
        <value-of select="$pText"/>
      </otherwise>
    </choose>

  </template>


  <xd:doc>
    <xd:desc/>
    <xd:param name="lang"/>
  </xd:doc>
  <function as="xs:string" name="dme:movementString">
    <param name="lang"/>
    <variable name="langUpperCase" select="upper-case($lang)"/>
    <variable as="map(xs:integer, xs:string)" name="vmap">
      <choose>
        <when test="$langUpperCase = 'DE'">
          <map>
            <for-each select="1 to 30">
              <map-entry key="." select=". || '.'"/>              
            </for-each>            
          </map>
        </when>
        <when test="$langUpperCase = 'EN'">
          <map>
            <map-entry key="1" select="'1st'"/>
            <map-entry key="2" select="'2nd'"/>
            <map-entry key="3" select="'3rd'"/>
            <for-each select="4 to 30">
              <map-entry key="." select=". || 'th'"/>              
            </for-each> 
          </map>
        </when>
        <otherwise>
          <message>The file has other than DE/EN languages (@xml:lang="<value-of select="$langUpperCase"/>").</message>
        </otherwise>
      </choose>
    </variable>

 
    
    <choose>
      <when test="map:get($vmap, $movementInteger cast as xs:integer)">
        <value-of select="map:get($vmap, $movementInteger cast as xs:integer) cast as xs:string"/>
      </when>
      <otherwise><message>Movement number was not recognized, please update meiHead mannually!</message>
      <value-of select="'NaN'"/>
      </otherwise>
    </choose>
  </function>




  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="placeholdersMap">
    <map>
      <map-entry key="'fileName'" select="$fileName || '.xml'"/>
      <map-entry key="'kvMovement'" select="map:get($optionsCalc, 'kvMovement')"/>
      <map-entry key="'kvNumber'" select="map:get($optionsCalc, 'KV')"/>
      <map-entry key="'movementInteger'" select="$movementInteger"/>
      <!-- The value of movementString is context dependent and will be instantiated later-->
      <map-entry key="'movementString'" select="'NaN'"/>
      <map-entry key="'movementID'" select="map:get($optionsCalc, 'movementID')"/>
      <map-entry key="'workID'" select="dme:workID()"/>
      <map-entry key="'respInitials'" select="dme:respPerson('initials')"/>
      <map-entry key="'respFullName'" select="dme:respPerson('fullName')"/>
      <map-entry key="'tempoHeading'" select="$databaseFileMovement//tempo/text()/string(.)"/>
      <map-entry key="'tempoFirstMeasure'" select="$processedFile/((//measure)[1]//tempo)[1]/string(text())"/>
      <map-entry key="'movementPages'" select="map:get($options, 'movementPages')"/>
      <map-entry key="'workTitleDE'" select="dme:workTitle('de')"/>
      <map-entry key="'workTitleEN'" select="dme:workTitle('en')"/>
      <map-entry key="'meiVersion'" select="$processedFile/mei/@meiversion/string()"/>
      <map-entry key="'firstPage'" select="
          let $input := map:get($options, 'movementPages')
          return
            if (matches($input, '.*-.*')) then
              substring-before($input, '-')
            else
              $input"/>
    </map>
  </template>



  <xd:doc>
    <xd:desc/>
    <xd:param name="lang"/>
  </xd:doc>
  <function as="xs:string" name="dme:workTitle">
    <param name="lang"/>

    <variable name="value" select="dme:databaseFile('work')//meiHead//title[@type = 'unit' and @xml:lang = $lang]/text()/data()"/>
    <value-of select="string($value)"/>
  </function>


  <xd:doc>
    <xd:desc>Derives work ID from the folder name. E.g. '309_3836' => '3836'</xd:desc>
  </xd:doc>
  <function name="dme:workID">
    <variable name="TOK" select="tokenize($fileURL, '/')"/>
    <copy-of select="substring-after($TOK[last() - 1], '_')"/>
  </function>



  <!-- Placeholders:
fileName				= "dmeref_138-002_2356.xml"
kvMovement 			= "387002'
kvNumber 				= "KV number", e.g. "387"
movementInteger = "movement integer" e.g. '1'  
movementString 	= "movement string" e.g. '1st' or '1.' Note: the language is dependend on the @xml:lang
workID
movementID 			= e.g. 387-002_4996 ->> "4996"
respInitials		= "ND"
respFullName 		= "Norbert Dubowy"
tempoHeading 		= "movement title" e.g. "Menuetto" "oXygen input-box" Note: currently reads the tempo from the first measure 
tempoFirstMeasure = "Allegro"
movementPages 	= "pages of the current movement" e.g. 15-18
firstPage 	= "first page of the current movement" e.g. 15. Used for id('digital_image')//ref/@target
-->

</stylesheet>
