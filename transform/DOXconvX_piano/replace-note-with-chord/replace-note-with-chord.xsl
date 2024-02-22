<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>In some cases, there exist &lt;note&gt; from first &lt;layer&gt; and a &lt;chord&gt; from second layer, which share same @doxml.id. The stylesheet replaces the &lt;note&gt; by the respective &lt;chord&gt; </p>
      <p>You may try the MREs which resied in the same folder as the stylesheet.</p>
      <pre> </pre>
      <p><b>Current version</b>: <b id="version">1.0.0</b>. For the details see changeLog.</p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>

  <include href="../../lib/basic.xsl"/>
  

  <template match="/">

    <variable name="mode_1">
      <apply-templates mode="mode_1" select="."/>
    </variable>
    <variable name="mode_2">
      <apply-templates mode="mode_2" select="$mode_1"/>
    </variable>
    <copy-of select="$mode_2"/>
  </template>




  <template match="staff[count(child::layer) > 1]/layer[@n = 1]//note" mode="mode_1">
    <variable name="respectiveChord" select="ancestor::staff/layer[@n = 2]//chord[@doxml.id = current()/@doxml.id]"/>

    <choose>
      <when test="$respectiveChord">
        <copy-of select="$respectiveChord"/>
      </when>
      <otherwise>
        <copy>
          <apply-templates select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>


  <template match="staff[count(child::layer) > 1]/layer[@n = 2]//chord" mode="mode_1">
    <variable name="respectiveNote" select="ancestor::staff/layer[@n = 1]//note[@doxml.id = current()/@doxml.id]"/>

    <choose>
      <when test="$respectiveNote">
        <space xmlns="http://www.music-encoding.org/ns/mei">
          <xsl:attribute name="dur" select="@dur"/>
          <xsl:attribute name="tstamp" select="@tstamp"/>
          <xsl:attribute name="xml:id" select="'space_' || generate-id()"/>
        </space>
      </when>
      <otherwise>
        <copy>
          <apply-templates select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>

  <template match="
      beam[every $item in
      distinct-values(descendant::*/local-name())
        satisfies $item = 'space']" mode="mode_2">
    <apply-templates select="child::*"/>
  </template>
</stylesheet>
