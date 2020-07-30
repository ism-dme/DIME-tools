<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:functx="http://www.functx.com" xmlns:dme="http://www.mozarteum.at/ns/dme"
  exclude-result-prefixes="xs xd mei dme functx" version="3.0" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b>March 3, 2018
      <xd:ul><xd:b>Updates</xd:b>:
        <xd:li>Oct 22 2018</xd:li>
      </xd:ul>        
      </xd:p>      
      <xd:p><xd:b>Author:</xd:b>Oleksii Sapov</xd:p>
      <xd:p>
        <xd:p>
          <xd:b>Description:</xd:b>
          <xd:i>Adds a suffix to @xml:id's in the body.</xd:i>
        </xd:p>
      </xd:p>
    </xd:desc>
  </xd:doc>
    
	<xsl:variable as="xs:string*" name="referencesList" select="doc('../../../lib/lists/lists.xml')//id('REFS')/dme:item/text()"/>
	
  <xd:doc>
    <xd:desc>adds suffixes</xd:desc>
  </xd:doc>
	<xsl:template match="body//@*[name() = ($referencesList, 'xml:id')]"
    mode="add_suffixes">
    <xsl:variable name="name" select="name()"/>
    <xsl:choose>
      <xsl:when test=".[$name = 'plist']">
        <xsl:variable name="values"
          select="
            for $i in
            tokenize(., '\s')
            return
              concat($i, '-', $editionType)"/>
        <xsl:attribute name="{$name}">
          <xsl:variable name="newValue" select="string-join(($values), '&#x20;')"/>
          <xsl:value-of select="$newValue"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="newValue" select="concat(., '-', $editionType)"/>
        <xsl:attribute name="{$name}">
          <xsl:value-of select="$newValue"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
   
    <xsl:if test="contains(.[not((parent::section or parent::ending))], '-')">
      <xsl:message terminate="no">The attribute <xsl:value-of select="."/> contains '-' which is not allowed. Please,
        change it manually in 'dmeref'.</xsl:message>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
