<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <i>This is an extension of the DOX conversion process. Among other corrections, it enriches the encoding by the project specific features.</i>
      </p>
      <p><b>Usage notes</b>: <ul>
          <li>The input XML file is expected to be in a folder with DIME naming convention. E. g. '309_3836' for K. 309 files</li>
          <li>For piano concerto set the mode "orchestral" in the options</li>
          <li>Check if &lt;perfRes&gt;/@codedval are set in the correct order and add text for the vocalVoice (e.g. <i>Villanela</i>) if applicable</li>
          <li>Check if &lt;staffDef&gt;/@dme.parts point to the correct&lt;perfRes&gt;/@n</li>
          <li>Don't do any other modification either in &lt;perfResList&gt; or &lt;scoreDef&gt;</li>
        </ul>
      </p>
      <p>The changes which the stylesheet preforms are grouped by the following modes:</p>
      <p>
        <b>meiHead</b>
        <ul>
          <li>A new &lt;meiHead&gt; from <i>Werk-header_{kVNumber}</i> is inserted instead of the &lt;meiHead&gt; of the transformed file (path for the Werk-header: <i>K:/PROJEKTE/DIME/6_Edition/{kvNumber})</i>.</li>
          <li>The placeholders in the Werk-header/&lt;meiHead&gt; are replaced by the respective values.</li>
          <li>Following elements and attributes from the original &lt;meiHead&gt; are inserted: &lt;appInfo&gt;, &lt;change&gt;s</li>
        </ul>     
      </p>
      <p>
        <b>scoreDef</b>
        <ul>
          <li>&lt;scoreDef&gt;: <ul>
              <li>adds @key.mode, @key.pname, (@key.accid) from ISM-database</li>
              <li>adds @optimize="false" (for genre="orchestral, chamber" only)</li>
            </ul>
            <pre/>
          </li>
          <li>&lt;staffDef&gt;<ul>
              <li>
                <ul><i>Adds:</i>
                  <li>@label.abbr (for genre='orchestral' only)</li>
                  <li>&lt;layerDef&gt;s (if there are more than one values in the @dme.parts, e.g. @dme.parts='1 2')</li>
                  <li>@decls (the parent node is defined by the presence or absence of &lt;layerDef&gt;s or not)</li>
                  <li>&lt;label&gt;. The value is derived from one of the following sources in the precedence order: <ul>
                      <li>&lt;label&gt;</li>
                      <li>@label</li>
                      <li>respective &lt;perfRes&gt;/@codedval</li>
                    </ul>
                  </li>
                  <li>@trans.semi, @trans.diat, @key.sig for transposing instruments</li>
                </ul>
              </li>
              <li>Deletes:</li><ul>
                <li>@key.sig (non-transposing instruments)</li>
              </ul>
            </ul>
          </li>
          <li>Deletes redundant &lt;staffGrp/ (if it has only one &lt;staffGrp/as a child and doesn't have any &lt;staffDef &gt; as a child) <pre/>
          </li>
        </ul>
      </p>
      <p>
        <b>DcX_1 </b>
        <ul>
          <li>
            <i>Add:</i>
            <ul>
              <li>For &lt;facsimile&gt;: @decls=#digital_image</li>
              <li>For &lt;dir&gt;s: if it contains following text "rallentando, calando, tenuto, ten., simile, semplice, pizzicato, pizz., arco, staccato, stacc.", this text will be wrapped into &lt;rend&gt; with respective @fontstyle and @halign attributes. Additionaly, the text ('a2', 'a 2') is changed to a{unicode}2</li>
              <li>For @startid, @endid, @resp: '#'</li>
              <li>For &lt;pb&gt;: @n</li>
              <li>bTrem/@form="meas" if bTrem has @unitdur</li>
              <li>For a &lt;tempo&gt; in the first measure (@n=('0', '1')): <ul>
                  <li>@tstamp="1"</li>
                  <li>@part="%all" (for genres='orchestral', 'chamber', 'opera')</li>
                </ul></li>
              <li>@resp="#NMA-editors" to all &lt;supplied&gt; with no @resp</li>
            </ul>
            <pre/>
          </li>
          <li>
            <i>Delete:</i>
            <ul>
              <li>bTrem[child::bTrem]</li>
            </ul>
            <pre/>
          </li>
          <li>
            <i>Change:</i>
            <ul>
              <li>@accid: "ss" => "x"</li>
              <li>&lt;bTrem&gt;@unitdur =&gt; @measperf</li>
              <li>moves &lt;tempo&gt; as a first child of a &lt;measure&gt;</li>
              <li>If the pointed &amp;lt;note&amp;gt; or &amp;lt;chord &amp;gt;have @staff the value of &amp;lt;dynam&amp;gt;/@staff is adjusted respectively.</li>
            </ul>
            <pre/>
          </li>
        </ul>
      </p>
      <p>
        <b>decls</b> Adds @decls=#upper/#lower for left / right hand of piano part respectively (recognizes it by @codedval="ka" which is present in doxml)<ul> </ul>
        <pre/>
      </p>
      <p>
        <b>chords</b>
        <ul>
          <li>adds / replaces &lt;chord&gt;/@dots with the highest value of descendant note/@dots</li>
          <li>adds / replaces &lt;chord&gt;/@dur with the hightest value of descendant note/@dur</li>
          <li>adds / replaces &lt;chord&gt;/@staff with the value of the first &lt;note&gt;/@staff</li>
        </ul>
        <pre/>
      </p>
      <p><b>stacciss</b>: changes @artic=stacciss to "spicc"</p>
      <p>
        <b>DcX_2</b>
        <ul>
          <li>
            <i>Changes:</i>
            <ul>
              <li>&lt;dynam/&gt;: @startid =&gt; @tstamp if text is: 'crescendo', 'cresc.', 'cre', 'scendo', 'scen', 'sotto voce', 'decrescendo'</li>
              <li>For &lt;dir&gt; with text <i>m.d.</i>: add @place=below and @staff. The value for @staff is derived from a) pointed &lt;note&gt; b) &lt;chord&gt; c) &lt;staff&gt;</li>
            </ul>
          </li>
          <li>
            <i>Deletes:</i>
            <ul>
              <li>&lt;dir&gt;s with text <i>ossia</i> or <i>origrace-g1</i></li>
            </ul>
          </li>
        </ul>
        <ul>
          <li>&lt;note&gt;: <ul>
              <li>deletes @staff, @dur if ancestor is &lt;chord&gt;</li>
              <li>adds @dots if other &lt;note> in the &lt;chord> has @dots</li>
              <li>@stem.dir='up' if this is a grace note</li>
              <li>if @enclose=brack and @accid are present, the @accid is wrapped into &lt;supplied/>, @enclose is deleted</li>
            </ul></li>
        </ul>
      </p>
      <p>
        <b>splitDynams</b>
        <p>
          <i>Processes split crescendo: ('cre', 'scendo'), ('cre', 'scen', 'do'), ('crescen', 'do'). <b>Note:</b> children of 'orig', 'rdg' are excluded</i>
          <ul>
            <li>
              <i>Adds:</i>
              <ul>
                <li>@vrgp, @next, @extender, @label to the first part</li>
                <ul>
                  <li>@vrgp, @next, @prev, @extender, @label to the second part if it is intermediate</li>
                  <li>@vrgp, @prev, @label to the second part if it is terminate</li>
                </ul>
                <li>@vrgp, @prev, @label to the third part, if exists</li>
              </ul>
            </li>
          </ul>
        </p>
      </p>
      <p>
        <b>
          <b>deleteAttributes</b>
        </b>
        <p>
          <ul>
            <li>
              <i>Deletes</i>
              <ul>
                <li>@func=caution</li>
                <li>@evidence=analogy</li>
                <li>&lt;lem&gt;/@resp</li>
                <li>&lt;dynam&gt;/@plist</li>
                <li>&lt;space&gt;/@layer='1 2'</li>
                <li>&lt;note&gt;/@layer= '1 2'</li>
                <li>@mm</li>
                <li>@enclose</li>
                <li>@subtype</li>
                <li>@right[.='rptboth']</li>
                <li>@type[.=('enclose', 'upbeat', 'Verlagsnummer', 'bartext', 'ce')]</li>
                <li>@stem.dir in the second layer (for genre='chamber', 'piano')</li>
                <li>&lt;space&gt;/@layer ='1 2'</li>
                <li>&lt;note&gt;/@layer ='1 2'</li>
              </ul>
            </li>
          </ul>
        </p>
      </p>
      <p>
        <b>
          <b>codedval_position_ho_vo</b>
        </b>
        <p>
          <ul>
            <li>
              <i>Deletes</i>
              <ul>
                <li>@ho</li>
                <li>@vo</li>
                <li>staff/@codedval</li>
                <li>staff/@position</li>
              </ul>
            </li>
          </ul>
        </p>
      </p>
      <p>
        <b>
          <b>dmeparts_layer</b>
        </b>
        <p>
          <ul>
            <li>
              <i>Deletes</i>
              <ul>
                <li>@layer for &lt;note&gt; and &lt;rest&gt;</li>
                <li>@dme.parts (for genre='chamber', 'piano')</li>
              </ul>
            </li>
          </ul>
        </p>
      </p>
      <p>
        <b>tuplet</b> : deletes @tuplet</p>
      <p>
        <b>DcX_3</b> : deletes empty supplied elements</p>
      <p>
        <b>applicationChanges</b>:  updates &lt;application&gt;  and  &lt;changes&gt;
      </p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2018-2022 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
      <p><i>Current version</i>: <b id="version">2.5.3</b>. For more info see the <b>changeLog</b>.</p>
    </desc>
  </doc>
</stylesheet>
