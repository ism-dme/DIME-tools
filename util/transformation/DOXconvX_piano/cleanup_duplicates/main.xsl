<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <b>Fixses dox2mei piano conversion issues for rest and clef.</b>
      </p>
      <p>After conversion there exist same rests and claves in every layer. Following changes are applied for the elements in the layers > 1: <ul>
          <li>&lt;rest&gt; is replaced with &lt;space&gt;</li>
          <li>clef gets @sameas if there exists layers with same number in the following measures</li>
        </ul>
      </p>

      <pre> </pre>
      <p><b>Current version</b>: <b id="version">0.0.1</b>. For the details see changeLog.</p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2022 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>

  <include href="../../lib/basic.xsl"/>
  <include href="changeLog.xsl"/>



  <xd:doc>
    <xd:desc>Converts rest to space or adds @sameas to clef if they are not in the first layer.</xd:desc>
  </xd:doc>
  <template match="layer[@n > 1]//(rest | clef)">

    <variable name="current.doxml.id" select="@doxml.id"/>
    <variable name="current.local.name" select="local-name()"/>

    <choose>
      <!--Check if the counterpart element in the first layer exists-->
      <when test="ancestor::staff/layer[@n = 1]//*[@doxml.id = $current.doxml.id and $current.local.name = local-name()]">
        <choose>
          <when test="local-name() = 'rest'">
            <element name="space" namespace="http://www.music-encoding.org/ns/mei">
              <attribute name="xml:id" select="'space_' || substring-after(@xml:id, '_')"/>
              <apply-templates select="@* except @xml:id, node()"/>
            </element>
          </when>
          <when test="local-name() = 'clef'">

            <variable as="xs:boolean" name="following.layernumber.exists">
              <variable as="attribute()" name="current.staff.n" select="ancestor::staff/@n"/>
              <variable as="attribute()" name="current.layer.n" select="ancestor::layer/@n"/>
              <sequence select="boolean(following::measure//staff[@n = $current.staff.n]//layer[@n = $current.layer.n])"/>
            </variable>

            <choose>
              <when test="$following.layernumber.exists or following-sibling::*">
                <variable name="main.clef.id" select="ancestor::staff/layer[@n = 1]//clef[@doxml.id = $current.doxml.id]/@xml:id"/>
                <element name="clef" namespace="http://www.music-encoding.org/ns/mei">
                  <attribute name="sameas" select="'#' || $main.clef.id"/>
                  <apply-templates select="(@xml:id, @doxml.id)"/>
                </element>
              </when>
              <otherwise/>
            </choose>
          </when>
        </choose>
      </when>
      <otherwise>
        <copy>
          <apply-templates select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>

  </template>

  <!--<variable name="currentStylesheet" select="doc('')"/>-->
</stylesheet>
