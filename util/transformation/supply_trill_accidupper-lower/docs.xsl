<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Matches &lt;choice&gt; with &lt;trill&gt; that have supplied @accidupper or @accidlower. Replaces it by a &lt;trill&gt; element taken out of the &lt;corr&gt; tag and adds @type="{accidlower|accidupper}_supplied_{resp}"</p>
      <pre/>
      <b>Changelog</b>
      <p>
        <b id="version">0.0.2</b> 2023-04-04 <ul>
          <li>Improve XSpec tests.</li>                        
          <li>Add type check for the template with @match="choice[corr[supplied[trill]] and orig[trill]]".</li>                        
        </ul></p>
      <p>
        <b>0.0.1</b> 2023-03-22 </p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2023 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>
</stylesheet>
