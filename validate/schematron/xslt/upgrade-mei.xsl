<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="4.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="../../../transformation/lib/basic.xsl"/>


  <xsl:template match="dlentry[child::dt/text()[contains(., 'phase')]]/dd">
    <xsl:choose>
      <xsl:when test="contains(text(), 'refTexts_v4')">
        <xsl:copy>
          <xsl:value-of select="text() || ', refTexts_v5'"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:output doctype-public="-//OASIS//DTD DITA Topic//EN" doctype-system="topic.dtd" indent="yes" method="xml"/>


</xsl:stylesheet>
