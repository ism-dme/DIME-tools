<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs math xd mei uuid dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <i>Checks if the sum of the durations of the elements which have a @dur attributed in a &lt;layer&gt; is equal to the expected metrum.</i>
      </p>
      <p>The stylesheet outputs the file <i>&lt;fileName>_wrong_durations.txt</i> which contains a list of the &lt;layer&gt;/@xml:ids where the durations are possibly wrong.</p>
      <p>Following &lt;layer&gt;s are not considered:<ul>
          <li>Descendants of uncomplete measures (@metcon='false')</li>
          <li>&lt;layer&gt;s which have &lt;mRest&gt;, &lt;multiRest&gt;, &lt;mSpace&gt; as descendants</li>
          <li>&lt;layer&gt;[@sameas]</li>
          <li>If a &lt;layer> contains &lt;app&gt; or &lt;choice&gt;, only the descendants of its first child are considered for the check</li>
        </ul>
      </p>
      <pre> </pre>
      <p><b>Current version</b>: <b id="version">1.1.1</b>. For the details see the changeLog.</p>
      <p><b>Author</b>: Oleksii Sapov. <b>Disclaimer</b>: The stylesheet uses some logic and code parts form <i>addTstamps.xsl</i> which was created by Johannes Kepper on May 22, 2016.<pre/>
        <b>Copyright</b>: 2021 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>

  <include href="../../transformation/lib/functions/functx-1.0-doc-2007-01.xsl"/>
  <import href="changeLog.xsl"/>



  <xd:doc>
    <xd:desc>The input document is processed in two modes subsequently: <xd:ul>
        <xd:li><xd:i>extract_main_reading</xd:i>: extracts all nodes from the first child of an &lt;app&gt; or &lt;choice&gt;.</xd:li>
        <xd:li><xd:i>check_durations</xd:i>: performs the calculations</xd:li>
      </xd:ul>
    </xd:desc>
  </xd:doc>
  <template match="/">


    <variable name="break" select="'&#xA;'"/>

    <variable name="extract_main_reading">
      <apply-templates mode="extract_main_reading" select="."/>
    </variable>

    <variable as="xs:string*" name="check_durations">
      <apply-templates mode="check_durations" select="$extract_main_reading"/>
    </variable>

    <choose>
      <when test="empty($check_durations)">
        <message>No errors found!</message>
      </when>
      <otherwise>
        <!--Values for output text-file -->
        <copy-of select="
            let $values := for $n in $check_durations
            return
              (if (not(empty($n))) then
                $n
              else
                ())
            return
              string-join($values, $break)"/>
      </otherwise>
    </choose>


    <variable as="xs:string*" name="metcon.measures" select="//measure[@metcon = 'false']/@xml:id/string()"/>
    <variable as="xs:string*" name="app.choice.layers" select="//layer[descendant::app or descendant::choice]/@xml:id/string()"/>

    <if test="not(empty($metcon.measures)) or not(empty($app.choice.layers))">
      <message>Additionaly, you may check following code parts mannually:</message>
    </if>

    <if test="not(empty($metcon.measures))">
      <message><value-of select="$break"/>Measures with @metcon="false": <variable name="metcon.measures" select="//measure[@metcon = 'false']/@xml:id/string()"/><xsl:value-of select="
            'id((''' ||
            string-join($metcon.measures, ''', ''') || '''))'"/>
      </message>
    </if>

    <if test="not(empty($app.choice.layers))">
      <message>Layers, containig app or choice (by default only the first child is checked): <value-of select="
            'id((''' ||
            string-join($app.choice.layers, ''', ''') || '''))'"/>
      </message>
    </if>

  </template>

  <xd:doc>
    <xd:desc>Extracts all nodes from the first child of an &lt;app&gt; or &lt;choice&gt;.</xd:desc>
  </xd:doc>
  <template match="app | choice" mode="extract_main_reading">
    <apply-templates select="child::*[1]/child::*"/>
  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Checks if the sum of the durations of the elements which have a @dur attributed in a &lt;layer&gt; is equal to the expected metrum.</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="/" mode="check_durations">

    <!--For debugging-->
    <!--    <variable as="xs:string*" name="output">-->
    <!-- Applies the template compare_durations for every &lt;layer&gt; which match the constraints.-->
    <for-each select="//layer[not(@sameas) and not(ancestor::measure[@metcon = 'false']) and not(descendant::mRest | descendant::multiRest | descendant::app | descendant::mSpace | descendant::choice)]">

      <variable as="xs:string*" name="current_layer_wrong">
        <call-template name="compare_durations"/>
      </variable>
      <if test="not(empty($current_layer_wrong))">
        <call-template name="compare_durations"/>
      </if>
    </for-each>
    <!--</variable>-->

    <!--    <copy-of select="$output"/>-->

  </template>




  <xd:doc>
    <xd:desc>Durations of the elements with @dur are calculated and compared to the expected metrum count.</xd:desc>
  </xd:doc>
  <template match="layer" mode="check_durations" name="compare_durations">
    <variable name="last_scoredef" select="(preceding::scoreDef[@meter.count])[last()]"/>
    <variable as="xs:integer" name="meter.count" select="$last_scoredef/@meter.count cast as xs:integer"/>
    <variable as="xs:integer" name="meter.unit" select="$last_scoredef/@meter.unit cast as xs:integer"/>

    <!--Contains all descendants with @dur except $events.dur.exceptions-->
    <variable as="element()*" name="events">
      <call-template name="vEvents"/>
    </variable>

    <!--This should be the value when we sum up all (preprocessed) durations. 1 is always a whole measure so it could be the maximum expected correct value.-->
    <variable as="xs:decimal" name="expected_count" select="(1 div $meter.unit) * $meter.count"/>

    <!--Here we calculate the sum of the durations in the current layer-->
    <variable name="current_count" select="
        let $durations_sequence :=
        dme:durations(., $events, $meter.count, $meter.unit)
        return
          sum($durations_sequence)"/>


    <choose>
      <when test="$current_count = $expected_count"/>
      <!--As stated above, '1' is the maximum value.-->
      <when test="$current_count > $expected_count">
        <value-of select="@xml:id"/>
      </when>
      <when test="$current_count &lt; $expected_count">
        <!--There is a possiblity, that the layer contains tuplets. In this case the sum of the durations will be a very little less then the expected result. e. g. for the expected_count '0.75' it would be '0.74999999....'. To catch up these cases, we would perform 0.749 + 0.001 and test again if the expected and actual results match. -->

        <!--Count of the after-comma-places in the $expected_count-->
        <variable as="xs:integer" name="expected_count_after_comma_numbers_count" select="
            let $substring_after := string($expected_count) => substring-after('.')
            return
              functx:chars($substring_after) => count()"/>

        <variable as="xs:decimal" name="current_count_with_tuplet_factor">
          <!--  Get the number by which we will shift the comma. -->
          <variable as="xs:integer" name="shift">
            <choose>
              <!--The case, when expected_count is '1' is special and is hard typed with shift of two places. -->
              <when test="$expected_count = 1">
                <sequence select="100"/>
              </when>
              <!-- E. g. when the expected_count is '0.75', the value will be 2+1=3. We need add 1, as the $current_count might be '0.74999999' and we need to get to '0.749' -->
              <otherwise>
                <sequence select="math:pow(10, $expected_count_after_comma_numbers_count + 1) cast as xs:integer"/>
              </otherwise>
            </choose>
          </variable>

          <!-- In order to get from '0.74999999' to '0.749' we shift first the comma to the left =>  '749.99999' then perform floor() => '749(.000)' then shift back to the right => '0.749'. Finally, a value of '0.001' is added. And in this example we would get '0.75' which would match $expected_count-->
          <sequence select="(floor($current_count * $shift) div $shift) + (1 div $shift)"/>
        </variable>

        <if test="not($current_count_with_tuplet_factor = $expected_count)">
          <value-of select="@xml:id"/>
        </if>

      </when>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Returns a sequence of the elements which fulfil the following constraints:<xd:ul>
          <xd:li>have @dur</xd:li>
          <xd:li>are not descendant of &lt;chord&gt;</xd:li>
          <xd:li>do not belong to the $events.dur.exceptions</xd:li>
        </xd:ul>
      </xd:p>
    </xd:desc>
  </xd:doc>
  <template name="vEvents">
    <variable name="events.dur.exceptions" select="'beatRpt', 'halfmRpt'"/>

    <for-each select=".//*">
      <choose>
        <!--I the current element has @sameas, @dur and @dots are copied from the referenced element-->
        <when test="@sameas and not(@dur)">

          <variable as="element()" name="reference">
            <sequence select="substring-after(@sameas, '#') => id()"/>
          </variable>

          <if test="$reference[(not(ancestor::chord) and not(@grace)) or (local-name() = $events.dur.exceptions)]">
            <choose>
              <when test="$reference[@dur and @dots]">
                <copy>
                  <attribute name="dur" select="$reference/@dur"/>
                  <attribute name="dots" select="$reference/@dots"/>
                  <apply-templates select="@*, node()"/>
                </copy>
              </when>
              <when test="$reference[@dur]">
                <copy>
                  <attribute name="dur" select="$reference/@dur"/>
                  <apply-templates select="@*, node()"/>
                </copy>
              </when>
            </choose>
          </if>
          
          <if test="$reference//*">
            <for-each select="$reference//*">
              <if test="@dur and not(ancestor::chord) and not(@grace) or (local-name() = $events.dur.exceptions)">
                <sequence select="."/>
              </if>
            </for-each>
          </if>
          
        </when>
        <when test="@copyof">

          <variable as="element()" name="reference">
            <sequence select="substring-after(@copyof, '#') => id()"/>
          </variable>

          <if test="$reference[@dur and not(ancestor::chord) and not(@grace) or (local-name() = $events.dur.exceptions)]">
            <sequence select="$reference"/>
          </if>
          <!--In case if the reference is e.g. beam which does not contain @dur but its children may-->
          <if test="$reference//*">
            <for-each select="$reference//*">
              <if test="@dur and not(ancestor::chord) and not(@grace) or (local-name() = $events.dur.exceptions)">
                <sequence select="."/>
              </if>
            </for-each>
          </if>
        </when>
        <otherwise>
          <if test="@dur and not(ancestor::chord) and not(@grace) or (local-name() = $events.dur.exceptions)">
            <sequence select="."/>
          </if>
        </otherwise>
      </choose>
    </for-each>
  </template>


  <xd:doc>
    <xd:desc>Returen sequence whith elements durations in the respect to the system where <xd:i>1</xd:i> is a whole measure.</xd:desc>
    <xd:param name="layer"/>
    <xd:param name="events"/>
    <xd:param name="meter.count"/>
    <xd:param name="meter.unit"/>
  </xd:doc>
  <function as="xs:decimal*" name="dme:durations">
    <param name="layer"/>
    <param name="events"/>
    <param name="meter.count"/>
    <param name="meter.unit"/>

    <for-each select="$events">

      <variable as="attribute()" name="dur_attr" select="@dur"/>
      <variable as="xs:decimal" name="dur">
        <choose>
          <when test="$dur_attr">
            <value-of select="1 div number($dur_attr)"/>
          </when>
          <when test="local-name() = 'beatRpt'">
            <value-of select="1 div $meter.unit"/>
          </when>
          <when test="local-name() = 'halfmRpt'">
            <value-of select="($meter.count div 2) div $meter.unit"/>
          </when>
        </choose>
      </variable>

      <variable as="xs:decimal" name="tupletFactor">
        <choose>
          <when test="@sameas">
            <!--The problem with @sameas elements is: after you added @dur (and @dots) in the $vEvents you cannot access the ancesotors. So here we get the 'original' element from the current layer and we are able to check if it is part of a tuplet. -->
            <variable as="element()?" name="orig.element.tuplet" select="($layer/id(current()/@xml:id)/ancestor::tuplet)[1]"/>
            <choose>
              <when test="$orig.element.tuplet">
                <value-of select="$orig.element.tuplet/number(@numbase) div $orig.element.tuplet/number(@num)"/>
              </when>
              <otherwise>
                <value-of select="1"/>
              </otherwise>
            </choose>
          </when>
          <when test="ancestor::tuplet">
            <value-of select="(ancestor::tuplet)[1]/number(@numbase) div (ancestor::tuplet)[1]/number(@num)"/>
          </when>
          <otherwise>
            <value-of select="1"/>
          </otherwise>
        </choose>
      </variable>

      <variable as="xs:decimal" name="dots">
        <variable as="xs:integer?" name="dots_attr" select="xs:integer(@dots)"/>
        <choose>
          <when test="$dots_attr">
            <value-of select="$dots_attr"/>
          </when>
          <otherwise>
            <value-of select="0"/>
          </otherwise>
        </choose>
      </variable>

      <value-of select="(2 * $dur - ($dur div math:pow(2, $dots))) * $tupletFactor"/>
    </for-each>
  </function>


  <xd:doc>
    <xd:desc>Identity transform.</xd:desc>
  </xd:doc>
  <template match="node() | @*" mode="#all">
    <copy>
      <apply-templates mode="#current" select="node() | @*"/>
    </copy>
  </template>

  <output indent="yes" method="text"/>
</stylesheet>
