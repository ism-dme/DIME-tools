<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p id="description">
        <i>Extracts one or more parts from a score.</i>
      </p>
      <pre> </pre>
      <p>
        <b>Parameters: </b>
        <ul>
          <li>P_REQUESTED_PARTS<p>The parameter can be passed either via CLI or by utilizing the GUI implemented in oXygen XML Editor. To access the GUI, open the file <i>**/options/options.xml</i> in Author mode. The syntax of the parameter is as follows: <i>|&lt;staffNumber>[.&lt;layerNumber>]?|</i>. For instance, <i>|2.2|</i> refers to the second staff, second layer. Note that the layer-part is optional. If you want to extract the second staff completely, you have to pass <i>|2|</i>. Multiple combinations are possible, e. g. <i>|2.2.|4.1|5|</i>. If all parts contained in the score are requested, e.g. <i>|1|2|3|4|</i> for a string quartet, the file will be simply copied.</p></li>
          <li>P_GLOBAL_CONTEXT_ITEM and P_XSPEC_TEST<p>Both parameters are used in the context of XSpec unit testing only.</p></li>
          <li>P_MOVI<p>The parameter should be set to <i>true()</i> it the stylesheet is called from MoVi or any other web application.</p></li>
          <li>P_SHRINK_MEASURES<p>Enables the feature of creating &lt;mulitRest&gt;s. Default is <i>true()</i></p></li>
        </ul>
      </p>
      <p>
        <b>Notes: </b>
        <ul>
          <li>If the MEI file contains multiple &lt;scoreDef&gt;s with a different number of staves, the tool might not work properly. The workaround is to temporarily comment out the score portions</li>
        </ul>
      </p>
      <p><b>Current version</b>: <b id="version">2.0.0</b>. For details see the changeLog.</p>
      <p><b>Contributors</b>: Oleksii Sapov-Erlinger.<pre/><b>Copyright</b>: 2020-2023 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>


</stylesheet>
