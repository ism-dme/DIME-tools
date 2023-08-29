<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p id="description">
        <i>Extracts one or more parts from a score .</i>
      </p>
      <pre> </pre>
      <p>
        <b>Usage: </b> The tool expects parameter <xd:i>parts</xd:i> which can be either passed via CLI or utilizing GUI implemented in oXygen. To access the GUI, open the file **/options/options.xml in Author mode. The syntax of  the parameter<xd:i>parts</xd:i> is as following |&lt;staffNumber>[.&lt;layerNumber>]?|. For instance, |2.2| refers to second staff, second layer. Note that the layer-part is optional. If you want to extract the second staff completely, you have to pass |2|. Multiple combinations are possible, e. g. |2.2.|4.1|5|. If all parts contained in the score are requested, e. g. |1|2|3|4| for a string quartet, the file will be just copied.</p>
      <pre> </pre>
      <p><b>Current version</b>: <b id="version">1.2.0</b>. For details see the changeLog.</p>
      <p><b>Contributors</b>: Oleksii Sapov-Erlinger.<pre/><b>Copyright</b>: 2020-2023 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>


</stylesheet>
