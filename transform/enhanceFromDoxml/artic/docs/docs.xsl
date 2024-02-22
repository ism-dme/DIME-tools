<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc id="doc" scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>The module <i>artic</i> deletes wrong articulation (usually staccato).</p>
      <p>For <i>slurred staccato</i> DOX contains the following note modifier 'ss'. These entries are typically correct. However, there exist also the entries in the form 'ss:\d' (RegEx), e.g. ss:2. Where the digit is probably the voice. These entries are wrong! Probably OMR captured the dot of the neighbours note, ut this is not always the case. In DOXML these modifiers are still recognized as @artic="slurrd-stacc". Example (K. 331-001):</p>
      <![CDATA[  <line xml:id="d28e5875" type="note" dur="Q" pname="e" oct="4" artic="slurred-stacc"
               pianoVoice="2"
               line="Q E4 v:2 ss:2"/>]]>
      <pre> </pre>
      <p><b>Current version</b>: <b id="version">0.0.1</b>. For the details see changeLog.</p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2022 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>
  
</stylesheet>
