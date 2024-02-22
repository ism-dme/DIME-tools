<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Checks if there exists a &lt;clef&gt;, which is placed between the first measure of the <i>diff-range</i> and its closest previous &lt;staffDef&gt;. If yes, its values of &lt;clef&gt;@line and &lt;clef&gt;@shape will be injected into respective &lt;staffDef&gt;.</p>
      <p>Values for every &lt;staff&gt; are checked.</p>
      <p>Only clefs with no @sameas are considered.</p>
      <p>Version <b>0.0.1</b> (2021-09-22)<ul>
          <li>initial</li>
        </ul>
      </p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2021 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>


  <!--Sequence of strings with comma-separated values in format 'staffDef@xml:id,@clef.line,@clef.shape'.-->
  <variable as="xs:string*" name="staffDefs">
    <call-template name="staffDefsToAdjust"/> 
  </variable>

  <xd:doc>
    <xd:desc>Matches any &lt;staffDef&gt;. If the current ID is in the list of the $staffDefs, changes the attribute values for @clef.line and @clef.shape. Otherwise just copies it.</xd:desc>
  </xd:doc>
  <template match="staffDef" mode="diff-overlay">

    <!--get arguments-->
    <variable as="xs:string*" name="IDs">
      <for-each select="$staffDefs">
        <sequence select="tokenize(., ',')[1]"/>
      </for-each>
    </variable>
    <variable as="xs:string*" name="clef.line">
      <for-each select="$staffDefs">
        <sequence select="tokenize(., ',')[2]"/>
      </for-each>
    </variable>
    <variable as="xs:string*" name="clef.shape">
      <for-each select="$staffDefs">
        <sequence select="tokenize(., ',')[3]"/>
      </for-each>
    </variable>
    <!--If current staffDef is in the list-->
    <variable name="index" select="index-of($IDs, @xml:id)"/>

    <copy>
      <choose>
        <when test="$clef.line[$index] and $clef.shape[$index]">
          <attribute name="clef.line" select="$clef.line[$index]"/>
          <attribute name="clef.shape" select="$clef.shape[$index]"/>
          <apply-templates select="@* except (@clef.line, @clef.shape), node()"/>
        </when>
        <otherwise>
          <apply-templates select="@*, node()"/>
        </otherwise>
      </choose>
    </copy>

  </template>



  <xd:doc>
    <xd:desc>Calculates values for $staffDefs. </xd:desc>
  </xd:doc>
  <template name="staffDefsToAdjust">
    

    <variable as="xs:string+" name="first_diffMeasure" select="$diffMeasuresRange[1]"/>

    <!--A set of staffDef/@n numbers before $first_diffMeasure-->
    <variable as="xs:integer+" name="staff_n" select="distinct-values($global-context-item/id($first_diffMeasure)/preceding::staffDef/@n)"/>

    <!--Select all nearest staffDefs in respect to the first_diffMeasure for every staff_n-->
    <variable as="element()" name="body" select="$global-context-item//body"/>
    <variable as="node()+" name="preceding_staffDefs">
      <sequence select="($body//*[@xml:id = $first_diffMeasure]/preceding::staffDef[@n = $staff_n])[last() and (@clef.shape, @clef.line)]"/>
    </variable>

    <!--    Select all claves between $first_diffMeasure and respective staffDefs for every staff_n-->
    <variable as="element()*" name="claves">
      <sequence select="($body/id($first_diffMeasure)/preceding::clef[not(@sameas) and ancestor::staff/@n = $staff_n])[last()]"/>
    </variable>

    <!--Get staffDef IDs and respective values for @clef.line and @clef.shape-->
    <for-each select="$claves">
      <variable name="current_staff_n" select="ancestor::staff/@n"/>
      <variable name="staffDef_id" select="$preceding_staffDefs[@n = $current_staff_n]/@xml:id"/>
      <sequence select="string-join(($staffDef_id, @line, @shape), ',')"/>
    </for-each>

  </template>


</stylesheet>
