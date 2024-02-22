<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="2.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>The module calculates if in addition to the $diffMeasure any other measures should be copied in order to display them in MoVI's diff-overlay. This is defined by the control events like slurs and ties: if they are contained in an &lt;app&gt; (NMA editions diff, ossias, except versions in K. 550) and point to other measures, then the diff-range will be enlarged to the maximum number of measures, depending on where the @endid points to.</p>
      <p>If a slur_tie is not contained in an &lt;app&gt; but still points to other measure, it will be transformed to a "cutted slur_tie" by the means of replacing its @endid with @tstamp2.</p>
      <p>If there are any slurs_ties pointing to the <i>diff-range</i>, they will be copied to the respective measure where its @endid poitns to and @startid will be replaced by @tstamp=0.</p>
      <p>Restrictions: <ul>
          <li>The decision process is not recursive, i.e. if other measures contain slurs or ties which point to other measures, those are not copied</li>
          <li>If @startid is in the measure <i>before</i> and @endid is in the measure <i>after</i> those slurs_ties are not captured currenty</li>
        </ul></p>
      <p>Versions:</p>
      <p>
        <b>0.1.0</b> (2021-09-28)<ul>
          <li>Implement "cutted slurs_ties"</li><li>Add restrictions for &lt;app&gt;.</li>
        </ul>
      </p>
      <p>Version <b>0.0.1</b> (2021-08-26)<ul>
          <li>initial</li>
        </ul>
      </p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2021 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>



  <variable as="xs:string*" name="diffMeasuresRange">
    <call-template name="diffMeasuresRange"/>
  </variable>
  
  <!--Holds a list of slurs_ties as elements which point to the diff_range-->
  <variable as="element()*" name="slurs_ties_to_insert">
    <call-template name="slursTiesToInsert">
      <with-param name="diffMeasuresRange" select="$diffMeasuresRange"/>
    </call-template>
  </variable>


  <xd:doc>
    <xd:desc>Checks if the current ID is in the list of the measures which should be copied.</xd:desc>
  </xd:doc>
  <template match="measure" mode="diff-overlay">

 

    <if test="some $a in $diffMeasuresRange
          satisfies $a = @xml:id">
      <copy>
        <apply-templates mode="diff-overlay" select="@*, node()"/>
        <variable name="measure_id" select="@xml:id"/>

        <!--  For slurs_ties which @endid points to a measure in the diff range, copy into the respective measure and replace @endid with @tstmp.-->
        <for-each select="$slurs_ties_to_insert">
          <!--Check if the current slur_tie should be in inserted in the currently matched measure.-->
          <if test="id(substring-after(@endid, '#'))/ancestor::measure/@xml:id = $measure_id">
            <copy>
              <attribute name="tstamp" select="0"/>
              <apply-templates select="@* except @startid, node()"/>
            </copy>
          </if>
        </for-each>
      </copy>
    </if>
  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Returns a list of IDs (as xs:string) of the measures which should be copied.</xd:p>
    </xd:desc>
  </xd:doc>
  <template name="diffMeasuresRange">

    <variable name="diffMeasure" select="$global-context-item/id($diffMeasure)"/>

    <variable as="element()*" name="slurs_ties_app">
      <!--select slurs_ties which live in an app, except those apps which werde used to encode versions in K. 550-->
      <sequence select="$diffMeasure//app[not(descendant::*[contains(@label, 'version')])]//(slur | tie)"/>
    </variable>

    <choose>
      <!--If there are no slurs_ties at all, return the ID of the $diffMeasure-->
      <when test="empty($slurs_ties_app)">
        <sequence select="$diffMeasure/@xml:id/string()"/>
      </when>
      <otherwise>
        <call-template name="getMeasureIDs">
          <with-param as="element()*" name="slurs_ties" select="$slurs_ties_app"/>
        </call-template>
      </otherwise>
    </choose>
  </template>




  <xd:doc>
    <xd:desc>
      <xd:p>Returns a list of measure@xml:id (as attribute()*) which shoud be copied.</xd:p>
    </xd:desc>
    <xd:param name="slurs_ties">element()*</xd:param>
  </xd:doc>
  <template name="getMeasureIDs">
    <param name="slurs_ties"/>

    <!--Get the pointer values from all slurs_ties (=@xml:id of notes and chords)-->
    <variable as="xs:string*" name="pointer_ids">
      <for-each select="'startid', 'endid'">
        <variable name="current_attribute" select="."/>
        <for-each select="$slurs_ties">
          <sequence select="substring-after(@*[local-name() = $current_attribute], '#')"/>
        </for-each>
      </for-each>
    </variable>

    <!--Get all measures where these pointers live.-->
    <variable as="element()+" name="pointed_measures" select="id(distinct-values($pointer_ids))/ancestor::measure"/>

    <variable name="pointed_measures_ids" select="distinct-values($pointed_measures/@xml:id)"/>

    <!--All measures in the file-->
    <variable name="measures_array" select="//measure/@xml:id"/>

    <!--Get the indices of the pointed measures in the array of all measures.-->
    <variable as="xs:integer+" name="indices">
      <for-each select="$pointed_measures_ids">
        <sequence select="index-of($measures_array, .)"/>
      </for-each>
    </variable>

    <!--Create a list of measure IDs from minimum to maximum position in the range.-->
    <for-each select="min($indices) to max($indices)">
      <variable name="curr" select="."/>
      <sequence select="$measures_array[$curr]"/>
    </for-each>

  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>For slurs_ties which @endid points to a measure out of diff range, replace @endid with @tstmp2.</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="slur | tie" mode="diff-overlay">
    <!--Trying to search the element of the @endid (may no be there if out of diff range.)-->
    <variable as="xs:boolean" name="endid_el" select="id(substring-after(@endid, '#'))/ancestor::measure/@xml:id/string() = $diffMeasuresRange"/>
    <choose>
      <when test="$endid_el">
        <copy>
          <apply-templates select="@*, node()"/>
        </copy>
      </when>
      <otherwise>
        <!--If the @endid-element is out of range, @endid will be replaced by @tstamp2. To calculate its value, we need to know: 
          1) @meter.count of the last scoreDef;
          2) Number of following measures in this diff-snippet, counted from those where the slur_tie lives;         
        -->
        <variable as="xs:integer" name="measures_count" select="count(following::measure[@xml:id = $diffMeasuresRange])"/>

        <variable as="xs:double" name="latest_tstamp" select="(preceding::scoreDef)[last()]/@meter.count + 0.99"/>
        <copy>
          <attribute name="tstamp2" select="concat($measures_count, 'm+', $latest_tstamp)"/>
          <apply-templates select="@* except (@endid, @tstamp2), node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Returns a list of slurs_ties (as element()) from previous 10 measures which point to the $diffMeasure via @startid, @endid.</xd:p>
    </xd:desc>
    <xd:param name="diffMeasuresRange"/>
  </xd:doc>
  <template name="slursTiesToInsert">
    <param as="xs:string+" name="diffMeasuresRange"/>

    <variable name="first_diffMeasure" select="$global-context-item/id($diffMeasuresRange[1])"/>

    <!-- Create a list of possible pointer elements (note, chord) for slur_tie@endid -->
    <variable as="xs:string+" name="diffRange_notes_chords">
      <for-each select="$first_diffMeasure, $global-context-item/id($diffMeasuresRange)[position() > 1]">
        <sequence select=".//(note | chord)/@xml:id/string()"/>
      </for-each>
    </variable>

    <!--Get 10 preceding measures.-->
    <!--Pick slurs and ties which @endid matches the value in $diffMeasure_notes_chords -->
    <!--Exclude those which are children of app, not first child-->
    <variable as="element()*" name="all_preceding_measures" select="$first_diffMeasure/preceding::measure"/>

    <variable as="xs:integer*" name="measures_count" select="($all_preceding_measures/last())[1]"/>  

    <for-each select="($measures_count - 6) to $measures_count">
      <sequence select="
          $all_preceding_measures[current()]//(slur | tie)[not(ancestor::*[parent::app and matches(string(position()), '[2-9]')]) and substring-after(@endid, '#') = $diffRange_notes_chords]"/>
    </for-each>
  </template>
</stylesheet>
