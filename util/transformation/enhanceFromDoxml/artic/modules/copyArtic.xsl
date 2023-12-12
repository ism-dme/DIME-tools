<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <template name="copyArtic">
    <variable as="element()" name="refEl" select="$doxml//*[@xml:id = current()/@doxml.id]"/>

    <variable as="xs:string+" name="analyzeLine" select="tokenize($refEl/@line, '\s')"/>

    <choose>
      <when test="
          some $a in $analyzeLine
            satisfies matches($a, 'ss:\d')">
        <value-of select="false()"/>
      </when>
      <otherwise>
        <value-of select="true()"/>
      </otherwise>
    </choose>






    <!--    <copy-of select="$refEl"/>-->

  </template>



</stylesheet>
