<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:oxy="http://www.oxygenxml.com/oxy" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <import href="../lib/basic.xsl"/>
  
<!--  <param name="p.schemaVersion"></param>
  
  <variable name="schemaLocation" as="xs:string">
    <choose>
      <when test="$p.schemaVersion = "></when>
    </choose>
    
  </variable>
-->
  <template match="/">
    <xsl:text disable-output-escaping="yes">
&lt;?xml-model href="https://dme.mozarteum.at/DME/schemata/mei-DME-4.0.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?&gt;
            </xsl:text>

    <copy-of select="."/>
  </template>

</stylesheet>
