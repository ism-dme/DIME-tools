<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schematron="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs xsl schematron sqf mei xd" version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on: </xd:b>July, 25 2018</xd:p>
      <xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
      <xd:p>
        <xd:p>
          <xd:b>Description:</xd:b>
          <xd:i>Should be applied on unique-rules.sch.</xd:i>        
        </xd:p>
      </xd:p>
    </xd:desc>
  </xd:doc>

  <xsl:output method="html" indent="yes"/>

  <!--reference Texts meiHead-->
  <xsl:variable name="phase_refTexts_meiHead" select="
      //schematron:phase[@id = 'refTexts_meiHead']/schematron:active/@pattern"/>
  <xsl:variable name="refTexts_meiHead" select="
      //schematron:pattern[@id =
      $phase_refTexts_meiHead]//schematron:p"/>

  <!--reference Texts music-->
  <xsl:variable name="phase_refTexts_music" select="
      //schematron:phase[@id =
      'refTexts_music']/schematron:active/@pattern"/>

  <xsl:variable name="refTexts_music" select="
      //schematron:pattern[@id =
      $phase_refTexts_music]//schematron:p"/>

  <!--alternative Texts meiHead-->
  <xsl:variable name="phase_altTexts_meiHead" select="
      //schematron:phase[@id =
      'altTexts_meiHead']/schematron:active/@pattern"/>
  <xsl:variable name="altTexts_meiHead" select="
      //schematron:pattern[@id =
      $phase_altTexts_meiHead]//schematron:p"/>

  <!--alternatice Texts music-->
  <xsl:variable name="phase_altTexts_music" select="
      //schematron:phase[@id =
      'altTexts_music']/schematron:active/@pattern"/>
  <xsl:variable name="altTexts_music" select="
      //schematron:pattern[@id =
      $phase_altTexts_music]//schematron:p"/>
  <!--takes long Time-->
  <xsl:variable name="phase_checkReferences" select="
      //schematron:phase[@id =
      'checkReferences']/schematron:active/@pattern"/>

  <xsl:variable name="checkReferences" select="
      //schematron:pattern[@id =
      $phase_checkReferences]//schematron:p"/>

  <xsl:template match="/">

    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>
          <xsl:value-of select="'Schematron documentation'"/>
        </title>
        <link rel="stylesheet" href="schematron.css" type="text/css"/>
        <!--   <meta charset="UTF-8"/>-->
      </head>

      <body>
        <h1>
          <xsl:value-of select="'Schematron documentation'"/>
        </h1>
        <h2>Content:</h2>
        <ul>
          <li>
            <a href="#reference_texts">Reference Texts</a>
            <ul>
              <li>
                <a href="#meiHead_ref">meiHead</a>
              </li>
              <li>
                <a href="#music_ref">music</a>
              </li>
            </ul>
          </li>
          <li>
            <a href="#alternative_texts">Alternative Texts</a>
            <ul>
              <li>
                <a href="#meiHead_alt">meiHead</a>
              </li>
              <li>
                <a href="#music_alt">music</a>
              </li>
            </ul>
          </li>
          <li>
            <a href="#checkReferences">check references</a>
          </li>
        </ul>
        <h2 id="refernce_texts">Reference Texts</h2>
        <div>
          <h4 id="meiHead_ref">&lt;meiHead></h4>
          <ol>
            <xsl:apply-templates select="$refTexts_meiHead"/>
          </ol>
          <h4 id="music_ref">&lt;music></h4>
          <ol>
            <xsl:apply-templates select="$refTexts_music"/>
          </ol>
        </div>
        <h2 id="alternative_texts">Alternative Texts</h2>
        <div>
          <h4 id="meiHead_alt">&lt;meiHead></h4>
          <ol>
            <xsl:apply-templates select="$altTexts_meiHead"/>
          </ol>
          <h4 id="music_alt">&lt;music></h4>
          <ol>
            <xsl:apply-templates select="$altTexts_music"/>
          </ol>
          <h2 id="checkReferences">Check references</h2>
          <ol>
            <xsl:apply-templates select="$checkReferences"/>
          </ol>
        </div>
      </body>
      <footer>Contact: sapov@mozarteum.at</footer>
    </html>
  </xsl:template>

  <xsl:template match="$refTexts_meiHead">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="$refTexts_music">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>


  <xsl:template match="$altTexts_meiHead">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="$altTexts_music">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

</xsl:stylesheet>
