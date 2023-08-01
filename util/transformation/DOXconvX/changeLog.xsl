<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <b>2.5.6</b> (2023-02-13)<ul>
          <li>Bugfix: transformatio failed because of the unrecognized movement name (#32)</li>       
        </ul>
      </p>
      <p>
        <b>2.5.5</b> (2023-02-07)<ul>
          <li>Update path on K. (#35)</li>       
          <li>Update resposible persons. (#29)</li>       
        </ul>
      </p>
      <p>
        <b>2.5.4</b> (2023-02-01)<ul>
          <li>Increase the number of possible movements to 30.</li>       
        </ul>
      </p>
      <p>
        <b>2.5.3</b> (2022-10-05)<ul>
          <li>improve handling of file names (especially needed for K. with two an less digits as K. 80)</li>
          <li>mode <i>meiHead</i>: delete the processing for &lt;perfResList&gt; as it is better to manually define it in the Werk-Header and just copy it.</li>
          <li>#bugfix: DcX_1: for dir with text 'ossia', 'origrace-g1' only the text node was deleted, now the whole dir is deleted </li>
          <li>add mode DcX_3 which deletes emtpy supplied elements</li>
        </ul>
      </p>
      <p>
        <b>2.5.2</b> (2022-05-19)<ul>
          <li>module <i>splitDynams</i>: consider only dynams with @tstamp</li>
          <li>module <i>DcX_1</i>: moves &lt;tempo&gt; as a first child of a &lt;measure&gt;</li>
          <li>change logic for matching &lt;dir&gt;s like <i>calando</i>, <i>simile</i>, etc. without &lt;rend&gt;</li>
          <li>If the pointed &lt;note> or &lt;chord> have @staff the value of &lt;dynam>/@staff is adjusted respectively</li>
          <li>For &lt;dir>s with text 'm.d.' add attributes @place=below and @staff. The value for @staff is derived from a) pointed &lt;note&gt; b) &lt;chord&gt; c) &lt;staff&gt;</li>
          <li>&lt;note&gt;: deletes @staff, @dur if ancestor is &lt;chord&gt;</li>
          <li>&lt;chord&gt;: adds/replaces @staff with the value of the first &lt;note&gt;/@staff</li>
        </ul>
      </p>
      <p>
        <b>2.5.1</b> (2022-02-18)<ul>
          <li>Adjustments that enable applying of  DOXconvX to piano concertos in 'orchestral' mode<ul>
              <li>Module <i>decls</i>: inserting of @decls=#uper/#lower for piano staves is not dependend on the option <i>genre</i> anymore. Instead, it is dynamically recognized by the attribute staff@codedval.</li>
              <li>Module <i>DcX_1</i>#tempo_first_measure: changed the logic for adding @part=%all (adds for orchestral, but not for piano)</li>
              <li>Module <i>dmeparts_layer</i>: #bugfix: Deletion of note@layer and rest@layer was defined for genre='chamber', 'piano' only. Now it is defined for any genre.</li>
            </ul></li>
          <li>Module <i>scoreDef</i>: the new created ID for &lt;scoreDef&gt; now conforms to the DIME guidelines</li>
        </ul>
      </p>
      <p>
        <b>2.5.0</b> (2021-04-13)<ul>
          <li>Remove module <i>checkAccidentalsVisibility</i>
          </li>
        </ul>
      </p>
      <p>
        <b>2.4.3</b> (2021-01-19)<ul>
          <li>Changed: <ul>
              <li>part=$all is not added when genre=piano</li>
              <li>split modi for better change tracking</li>
            </ul>
          </li>
          <li>Added: <xd:ul>
              <xd:li>Add @decls=#upper/#lower for staff@n=1/2 (for genre=piano only)</xd:li>
            </xd:ul>
          </li>
          <li>Deprecate: <xd:ul>
              <xd:li>add @curvedir="below" or changes its value to "below" if it is a &lt;slur&gt; of a grace note</xd:li>
              <li>delete slur/@lform[. = 'dotted']</li>
            </xd:ul>
          </li>
          <li>Bugfixes: <xd:ul>
              <xd:li>placeholder <i>movementString</i> in Werk-Header wasn't processed</xd:li>
            </xd:ul>
          </li>
        </ul>
      </p>
      <p>
        <b>2.4.2</b> (2020-12-04)<ul>
          <li>Changed: <ul>
              <li>&lt;appInfo&gt; and &lt;change&gt;s from the processed MEI file are inserted without any modifications. The functionality expects respective placeholders as processing instructions in the <i>Werk-Header</i>.</li>
            </ul>
          </li>
          <li>Added: <ul>
              <li>placeholders <i>meiVersion</i>, &lt;?key?&gt;, &lt;?meter?&gt;</li>
              <li>delete &lt;slur&gt;@lform[. = 'dotted']</li>
              <li>delete @layer for &lt;note&gt; and &lt;rest&gt;</li>
              <li>delete &lt;dir&gt; with text <i>ossia</i> or <i>origrace-g1</i></li>
              <li>delete &lt;supplied&gt; with no child elements</li>
              <li>changes @accid: "ss" => "x"</li>
              <li>When wrapping the content in &lt;rend&gt;, @halign='center' is added</li>
              <li>Add @part="%all" to the &lt;tempo&gt; in the first measure</li>
            </ul>
          </li>
        </ul>
      </p>
      <p>
        <b>2.4.1</b> (2020-11-05)<ul>
          <li>Changed: <ul>
              <li>If 'genre' is set to 'piano', the &lt;perfRes&gt; from the <i>Werk-Header</i> is not modified</li>
              <li>When processing the <i>Werk-Header</i>: the &lt;change&gt;s from the original file are preserved while the comments from the <i>Werk-Header</i>//&lt;revisionDesc&gt; are copied</li>
            </ul>
          </li>
          <li>Added: <ul>
              <li>Adds attributes for &lt;meter&gt; (from original &lt;scoreDef&gt;)</li>
              <li>Adds attributes for &lt;key&gt; (from databse export file for the current movement)</li>
              <li>Copies @version and @xml:id from the original &lt;application&gt;</li>
              <li>Prcesses new placeholder in the<i>Werk-Header</i> - <i>firstPage</i></li>
              <li>Deletes @dme.parts for genre <i>piano</i></li>
            </ul>
          </li>
        </ul>
      </p>
      <p>
        <b>2.4.0</b> (21.07.2020)<ul>
          <li>Delete modules countMeasures and create-IDs</li>
          <li>Bugfix: If &lt;staffDef&gt; does not have @dme.parts, original attributes are preserved.</li>
          <li>For the mode <b>deleteAttributes</b>: <ul>
              <li>restrict @position to staff/@position</li>
              <li>expand dynam/@subtype to @subtype</li>
              <li>add <ul>
                  <li>@mm</li>
                  <li>@enclose</li>
                  <li>note/@layer[contains(., '1 2')]</li>
                  <li>@right[. = 'rptboth']</li>
                  <li>@type[. = ('enclose', 'upbeat', 'Verlagsnummer', 'bartext', 'ce')]</li>
                </ul>
              </li>
              <li>Change the naming convention for the comparison files</li>
            </ul>
          </li>
          <li>Internal: <ul>
              <li>Delete <i>xd:</i>- and <i>xsl:</i>-prefixes where possible</li>
              <li>Delete the folder <i>external</i></li>
            </ul>
          </li>
        </ul>
      </p>
      <p>
        <b>2.3.13</b> (25.03.2020) <ul>
          <li>&lt;staffDef&gt;/@label.abbr is added for genre='orchestral' only</li>
          <li>&lt;label&gt;. The value is taken from one of the sources in the following precedence order (previously, from @label only): <ul>
              <li>&lt;label&gt;</li>
              <li>@label</li>
              <li>Instrument name which is referenced form the respective &lt;perfRes&gt;/@codedval</li>
            </ul>
          </li>
          <li>Deprecate <b>genres</b></li>
          <li>internal changes: <ul>
              <li>Move the deletion of @dme.parts to the deleteAttributes.xsl</li>
              <li>Move the adding of &lt;scoreDef&gt;/@optimize='false' to the scoreDef.xsl</li>
            </ul>
          </li>
        </ul>
      </p>
      <p>
        <b>2.3.12</b> (24.03.2020) <ul>
          <li>Extract <i>unsupplied-dir_@num-visible.xsl</i> for use as separate scenario</li>
          <li>&lt;application&gt;<ul>
              <li>add left and right trim for the first and last text nodes respectively</li>
              <li>&lt;persName&gt;[@xml:id="JoKep"]: add <ul>
                  <li><i>@authURI</i>='https://d-nb.info/gnd/174032757'</li>
                  <li><i>@authority</i>='GND'</li>
                  <li><i>@codedval</i>='174032757'</li>
                </ul></li>
              <li>&lt;persName&gt;[@xml:id="FKel"]: replace @<i>xml:id</i>='FKel' => @<i>analog</i>='#FK'</li>
              <li>&lt;ref&gt; for 'mozarteum.at': replace text to <i>Salzburg Mozarteum Foundation</i></li>
              <li>&lt;ref&gt; for 'edirom.de':<ul>
                  <li> add 'https' for <i>@target</i>
                  </li>
                  <li>add &lt;corpName&gt; with following attributes: <ul>
                      <li><i>@authURI</i>='https://d-nb.info/gnd/1095564986'</li>
                      <li><i>@authority</i>='GND'</li>
                      <li><i>@codedval</i>='1095564986'</li>
                      <li>text: 'ViFE'</li>
                    </ul></li>
                </ul>
              </li>
            </ul>
          </li>
          <li>&lt;revisionDesc&gt;<ul>
              <li>Replace value for <i>@resp</i>: '#FKel' => '#FK'</li>
            </ul></li>
        </ul>
      </p>
      <p>
        <b>2.3.11</b> (20.03.2020) <ul>
          <li>read &lt;key&gt; attributes from ISM-database and add them to &lt;workDesc&gt;/&lt;key&gt; and &lt;scoreDef&gt;</li>
          <li>reorganized modules for better comparison and more convenient development<ul>
              <li>added module <i>scoreDef</i> (extracted from <i>DcX_1</i>)</li>
              <li>moved create-IDs to another place in the transformation chain as it caused problems for other stylesheets</li>
              <li>added <i>checkAccidentalsVisibility</i></li>
              <li>added modules <i>deleteAttributes</i> and <i>unsupplied-dir_@num-visible</i> (extracted from <i>DcX_2</i>)</li>
            </ul>
          </li>
        </ul>
      </p>
      <p>
        <b>2.3.10</b> (13.03.2020) <ul>
          <li>#bugfix: options for create-IDs were not available</li>
        </ul>
      </p>
      <p>
        <b>2.3.9</b> (12.03.2020) <ul>
          <li>Remove the mode <i>checkAccidentals</i></li>
        </ul>
      </p>
      <p>
        <b>2.2.8</b> (11.03.2020) <ul>
          <li>&lt;appInfo&gt; and &lt;revisionDesc&gt; from the original file are preserved</li>
          <li>&lt;perfResList&gt;: add @analog, @authority</li>
          <li>&lt;perfRes&gt;: del @authority</li>
          <li>&lt;soreDef&gt;: for "orchestral", "chamber" add @optimize="false"</li>
          <li>rename mode 'string quartet' >> 'chamber'. When chamber: del @label.abbr</li>
          <li>changed the input of the processed document</li>
          <li>add changeLog</li>
        </ul>
      </p>
      <p>
        <ul>
          <li>06.03.2020: <i>2.2.7</i></li>
          <li>07.11.2019: <i>2.2.6</i></li>
          <li>17.09.2019: <i>2.2.5</i></li>
          <li>14.08.2019: <i>2.2.4</i></li>
          <li>23.07.2019: <i>2.2.3</i></li>
          <li>19.06.2019: <i>2.2.2</i></li>
          <li>04.06.2019: <i>2.2.1</i></li>
          <li>11.04.2019: <i>2.2.0</i></li>
          <li>26.03.2019: <i>2.1.1</i></li>
          <li>11.03.2019: <i>2.0.1</i></li>
          <li>25.03.2019: <i>2.1.0</i></li>
          <li>08.03.2019: <i>2.0.0</i></li>
          <li>20.11.2018: <i>1.1.0</i></li>
          <li>13.08.2018: <i>1.0.0</i></li>
        </ul>
      </p>
    </desc>
  </doc>

</xsl:stylesheet>
