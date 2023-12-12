<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <!--Note: This stylesheet is used for documentation and for recording the application processing in the MEI file. The modules described below are chained via an oXygen transformation scenario. For debugging you may configure separate transformation of each module, where the main stylesheet has either the name of the module (e.g. keySigs_accidentals) or is named "main.xsl"-->
  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <i>Corrects the MEI after the base conversion from DOX using respective data from doxml.</i>
      </p>
      <p>Modules:<ul>
          <li><b>slurs and ties:</b> re-inserts slurs and ties</li>
          <li><b>chordPointers</b> If &lt;slur> or &lt;dynam> points to a &lt;note> which is a descendant of a &lt;chord>, the pointer value will be replaced by the reference to chord@xml:id </li>
          <li><b>del_curvedir</b> Deletes slur@curvedir except those slurs which point to a chord, grace or chord note..</li>
          <li><b>keysigs and accidentals + secondTiedNote: </b>re-inserts @accid and @accid.ges</li>
        </ul></p>
      <pre/>
      <p><b>Usage notes</b>: <xd:ul>
          <xd:li>Define the respective doxml-file in options.xml</xd:li>
          <li>In the transformation scenario chain the modules in the order stated above</li>
          <li>Sometimes dox2mei adds notes with doubled <i>@doxml.id</i>s which causes an error for <b>slurs_ties</b> module when finding @startid or @endid as only one pointer is allowed. A possible workaround is to find duplicates (//note/@doxml.id[preceding::note/@doxml.id = .]) in the transformed MEI-file and comment out one of the dupicated notes (preferable not the chord note).</li>
        </xd:ul></p>
      <pre/>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2021 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
      <pre/>
      <p><i>Current version</i>: <b id="version">1.2.3</b>. For more info see the <b>changeLog</b>.</p>
    </desc>
  </doc>
  <import href="changeLog.xsl"/>
  <include href="../lib/applicationChanges.xsl"/>
  <include href="../lib/basic.xsl"/>
  <template match="/">
    <variable name="applicationChange">
      <apply-templates mode="applicationChanges" select="/"/>
    </variable>

    <copy-of select="$applicationChange"/>
  </template>

  <variable name="currentStylesheet" select="doc('')"/>
</stylesheet>
