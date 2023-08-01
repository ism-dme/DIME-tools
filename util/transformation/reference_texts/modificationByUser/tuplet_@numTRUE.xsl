<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:uuid="java:java.util.UUID" xmlns:dme="http://www.mozarteum.at/ns/dme" exclude-result-prefixes="xs xd mei math uuid dme" version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:i>Correction for a rare afterDOXconverting mistake: tuplet/@num='true'</xd:i>
      </xd:p>
      <xd:p>
        <xd:ul>
          <xd:li>
            <xd:b>user guide:</xd:b>
            <xd:ul>
              <xd:li>New values of @num and @numbase are set in the dialog box while transformation (use oxygen scenario)</xd:li>
            </xd:ul>
          </xd:li>
        </xd:ul>
      </xd:p>
      <xd:p><xd:b>Created on: </xd:b>March 3, 2018</xd:p>
      <xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
      <xd:p>
        <xd:ul>
          <xd:li>
            <xd:b>Updates: </xd:b>
            <xd:ul>
              <xd:li>Nov 22, 2018</xd:li>
            </xd:ul>
          </xd:li>
        </xd:ul>
      </xd:p>
    </xd:desc>
  </xd:doc>
  <xsl:param name="num" as="xs:integer"/>
  <xsl:param name="numbase" as="xs:integer"/>



  <xd:doc>
    <xd:desc>sets @numbase </xd:desc>
  </xd:doc>
  <xsl:template match="mei:tuplet[@num = 'true']/@num">
    <xsl:attribute name="num">
      <xsl:value-of select="$num"/>
    </xsl:attribute>
    <xsl:message>@numbase of '<xsl:value-of select="../@xml:id"/>' was changed from '<xsl:value-of select="."/>' to '<xsl:value-of select="$num"/>'</xsl:message>
  </xsl:template>


  <xd:doc>
    <xd:desc>sets @numbase</xd:desc>
  </xd:doc>
  <xsl:template match="mei:tuplet[@num = 'true']/@numbase">
    <xsl:attribute name="numbase">
      <xsl:value-of select="$numbase"/>
    </xsl:attribute>
    <xsl:message>@numbase of '<xsl:value-of select="../@xml:id"/>' was changed from '<xsl:value-of select="."/>' to '<xsl:value-of select="$numbase"/>'</xsl:message>
  </xsl:template>

  <xsl:output indent="yes" encoding="UTF-8" method="xml"/>
  <xsl:strip-space elements="*"/>
  <xsl:mode on-no-match="shallow-copy"/>

</xsl:stylesheet>
