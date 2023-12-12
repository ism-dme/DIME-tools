<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <variable as="xs:string*" name="accid.explicit" select="$doxml//dme:line[@type = 'note' and @accid.explicit = 'true']/@xml:id"/>
  

  <variable name="doxml">
    <variable name="doxmlFileRelativePath" select="map:get($options, 'fileRelativePath')"/>
    <variable name="inputBaseURI" select="base-uri($doxmlFileRelativePath)"/>
    <variable name="inputDoxml" select="resolve-uri($doxmlFileRelativePath, $inputBaseURI)"/>
    <apply-templates mode="doxml" select="doc($inputDoxml)"/>
  </variable>



  <template match="dme:staff" mode="doxml">
    <copy>
      <apply-templates select="@*"/>
      <attribute name="n" select="count(preceding-sibling::dme:staff) + 1"/>
      <apply-templates select="node()"/>
    </copy>
  </template>
</stylesheet>
