<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">





  <xd:doc>
    <xd:desc>Extension of the functx:add-attributes <xd:p> Original description: <!--
  Adds attributes to XML elements 

 @author  Priscilla Walmsley, Datypic 
 @version 1.0 
 @see     http://www.xsltfunctions.com/xsl/functx_add-attributes.html 
 @param   $elements the element(s) to which you wish to add the attribute 
 @param   $attrNames the name(s) of the attribute(s) to add 
 @param   $attrValues the value(s) of the attribute(s) to add 
-->
      </xd:p>
      <xd:p>Deleted namespace when constructing the attribute as ist caused additional namespace declaration on the output node.</xd:p>
    </xd:desc>
    <xd:param name="elements">$elements the element(s) to which you wish to add the attribute </xd:param>
    <xd:param name="attrNames">$attrNames the name(s) of the attribute(s) to add</xd:param>
    <xd:param name="attrValues">$attrValues the value(s) of the attribute(s) to add </xd:param>
  </xd:doc>
  <xsl:function name="dme:add-mei-attributes" as="element()?" xmlns:dme="http://www.mozarteum.at/ns/dme">
    <xsl:param name="elements" as="element()*"/>
    <xsl:param name="attrNames" as="xs:QName*"/>
    <xsl:param name="attrValues" as="xs:anyAtomicType*"/>

    <xsl:for-each select="$elements">
      <xsl:variable name="element" select="."/>
      <xsl:copy>
        <xsl:for-each select="$attrNames">
          <xsl:variable name="seq" select="position()"/>
          <xsl:if test="not($element/@*[node-name(.) = current()])">
            <xsl:attribute name="{.}" select="$attrValues[$seq]"/>
          </xsl:if>
        </xsl:for-each>
        <xsl:copy-of select="@* | node()"/>
      </xsl:copy>
    </xsl:for-each>

  </xsl:function>

  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Oct 22, 2018</xd:p>
      <xd:p><xd:b>Author:</xd:b>Oleksii Sapov</xd:p>
      <xd:p>DIME functions library</xd:p>
    </xd:desc>
  </xd:doc>

  <function as="xs:string*" name="dme:tokenize-normalize-attr-vals">
    <param name="attr"/>
    <param name="pattern"/>

    <variable name="tok" select="
        for $a in $attr
        return
          tokenize($a, $pattern)"/>

    <sequence select="
        for $a in $tok
        return
          normalize-space($a)"/>
  </function>

  <function as="xs:string*" name="dme:tok-vals-with-space">
    <param name="attr"/>

    <variable name="tok" select="
        for $a in $attr
        return
          tokenize($a, '\s')"/>

    <sequence select="
        for $a in $tok
        return
          normalize-space($a)"/>
  </function>

  <xd:doc>
    <xd:desc>Outputs a sequence of strings.</xd:desc>
    <xd:param name="arg1">Input element which contains the string.</xd:param>
    <xd:param name="arg2">ID of the input field (DIME-tools, optional)</xd:param>
  </xd:doc>
  <xsl:function name="dme:tokValues">
    <xsl:param as="element()" name="arg1"/>
    <xsl:param as="xs:string" name="arg2"/>

    <xsl:variable name="textNode " select="$arg1/id($arg2)/string(text())"/>

    <xsl:sequence select="
        for $n in tokenize($textNode, ',')
        return
          normalize-space($n)"/>

  </xsl:function>

</stylesheet>
