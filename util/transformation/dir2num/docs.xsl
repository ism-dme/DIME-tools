<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <ul>
          <li>Sets tuplet@num.visible='true' if there is corresponding &lt;dir&gt; which contains a tuplet number.</li>
          <li>Adds tuplet@type='num_supplied_NMA-editors' if the correspoding &lt;dir&gt; was supplied. Note that the &lt;dir&gt; should contain @resp.</li>
          <li>Deletes &lt;dir&gt;s which contain a &lt;tuplet&gt; number including the respective supplied element.</li>
          <li>Sets tuplet@bracket.visible='true' if &lt;tuplet&gt; contains &lt;rest&gt;(s) AND 2) @num.visible is set to 'true'.</li>
        </ul>
      </p>
      <pre/>
      <b>Changelog</b>
      <p>
        <b id="version">1.0.0</b> 2022-12-21<ul>
          <li>Rename the tool: unsupplied-dir_@num-visible → dir2num</li>
          <li>Extend @num.visible rule for supplied dirs and cases when dir points via @tstamp. The corresponding supplied element is being deleted..</li>
          <li>Extend @bracket.visible rule by the following constraint: @num.visible should be set to 'true' </li>
          <li>Add tuplet@type="num_supplied_NMA-editors" if the corresponding dir was supplied</li>
          <li>Several fixes for different encoding cases</li>
          <li>Add unit tests</li>
        </ul>
      </p>
      <p>
        <b>0.0.1</b> 2018<ul>
          <li>
            <i>Changes:</i>
            <ul>
              <li>@bracket.visible<ul>
                  <li><i>true</i> if there is a rest in the tuplet</li>
                  <li>Otherwise <i>false</i>.</li>
                </ul>
              </li>
              <li>@num.visible<ul>
                  <li><i>true</i> if it is visible in NMA</li>
                  <li>Otherwise <i>false</i>.</li>
                </ul></li>
            </ul>
          </li>
          <li><i>Deletes</i>
            <ul>
              <li>&lt;dir&gt; (if it points to a &lt;note&gt; inside a &lt;tuplet&gt; and is not supplied).</li>
            </ul>
          </li>
        </ul>
      </p>
      <p><b>Contributors</b>: Oleksii Sapov. <pre/>
        <b>Copyright</b>: 2022 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
    </desc>
  </doc>
</stylesheet>
