<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd" version="2.0" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <b>Created on:</b> October 11, 2017 </p>
      <p><b>Last update</b>: September 29, 2021 </p>
      <p>
        <b>Contributors:</b> Felix Gründer, Oleksii Sapov </p>
      <p>
        <b>Features:</b>
        <ul>
          <li>a) select staffs</li>
          <li>b) select mdiv's</li>
          <li>c) select measure(s) to display the differences</li>
          <li>d) PDF print: remove title[@type='file'] and show only title in the current language</li>
          <li>e) remove all comments f) change schema path in processing instruction from relative to absolute</li>
        </ul>
      </p>
      <p><pre/>
        <b>Copyright</b>: 2021 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>

  <xsl:param name="voices"/>
  <xsl:param name="mdivIndex"/>
  <xsl:param name="diffMeasure"/>
  <xsl:param name="isPdf"/>
  <xsl:param name="lang"/>
  <xsl:param name="meiVersion"/>
  
  <!--This parameter is a workaround for XSpec limitation: the tested stylesheet does not get a global context. See https://github.com/xspec/xspec/wiki/Global-Context-Item-->
  <xsl:param name="global-context-item" select="."/>


  <xsl:include href="modules/identity-transform.xsl"/>
  <xsl:include href="modules/diff-overlay/slurs_ties.xsl"/>
  <xsl:include href="modules/diff-overlay/staffDef.xsl"/>
  <xsl:include href="modules/diff-overlay/clean_up.xsl"/>

  <xd:doc>
    <xd:desc>Main template.</xd:desc>
  </xd:doc>
  <xsl:template match="/">
    <!--a) select staves -->
    <xsl:choose>
      <xsl:when test="string-length($voices) > 0">
        <xsl:apply-templates mode="voices" select="."/>
      </xsl:when>
      <!--c) Select measure(s) for displaying the differences-->
      <xsl:when test="string-length($diffMeasure) > 0 and not(string-length($voices) > 0)">
        <xsl:apply-templates mode="diff-overlay" select="."/>
      </xsl:when>
      <!--d) PDF print-->
      <xsl:when test="number($isPdf) > 0 and not(string-length($voices) > 0) and not(string-length($diffMeasure) > 0)">
        <xsl:apply-templates mode="isPdf" select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  

  <xd:doc>
    <xd:desc> a) select staves </xd:desc>
  </xd:doc>
  <xsl:template match="mei:staff[not(contains($voices, concat('|', @n, '|')))]" mode="voices"/>
  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <xsl:template match="mei:staffDef[not(contains($voices, concat('|', @n, '|')))]" mode="voices"/>
  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <xsl:template match="mei:sb[not(contains($voices, concat('|', @n, '|')))]" mode="voices"/>
  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <xsl:template match="mei:pb[not(contains($voices, concat('|', @n, '|')))]" mode="voices"/>


  <xd:doc>
    <xd:desc> b) select mdiv's </xd:desc>
  </xd:doc>
  <xsl:template match="mei:mdiv[$mdivIndex > 0 and not(position() = $mdivIndex)]" mode="#all"/>



  <xd:doc>
    <xd:desc> d) PDF print: remove title[@type='file'] / show only title in the current language </xd:desc>
  </xd:doc>
  <xsl:template match="mei:fileDesc/mei:titleStmt/mei:title[@type = 'file']" mode="isPdf"/>
  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <xsl:template match="mei:fileDesc/mei:titleStmt/mei:title[@type = 'unit' and not(@xml:lang = $lang)]" mode="isPdf"/>


  <xd:doc>
    <xd:desc> e) remove all comments </xd:desc>
  </xd:doc>
  <xsl:template match="//*/comment()" mode="#all"/>



  <xd:doc>
    <xd:desc> f) change schema path in processing instruction from relative to absolute </xd:desc>
  </xd:doc>
  <xsl:template match="processing-instruction('xml-model')" mode="#all">

    <xsl:variable name="newSchemaSuffix">
      <xsl:choose>
        <xsl:when test="$meiVersion = '3'">
          <xsl:value-of select="''"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'-4.0'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="newSchemaRef">
      <xsl:value-of select="concat('href=&quot;https://dme.mozarteum.at/DME/schemata/mei-DME', $newSchemaSuffix, '.rng')"/>
    </xsl:variable>

    <xsl:variable name="typeAndSchematypens">
      <xsl:value-of select="substring-after(current(), '.rng')"/>
    </xsl:variable>

    <xsl:variable name="newProcessingInst">
      <xsl:value-of select="concat($newSchemaRef, $typeAndSchematypens)"/>
    </xsl:variable>

    <xsl:processing-instruction name="xml-model">
            <xsl:value-of select="$newProcessingInst"/>
        </xsl:processing-instruction>

  </xsl:template>


</xsl:stylesheet>
