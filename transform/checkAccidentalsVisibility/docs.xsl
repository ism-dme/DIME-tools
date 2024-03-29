<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>Changes the visibility of the accidentals (@accid => @accid.ges).</i>
			</p>
			<p><b>Rules</b>:<pre/>The checked note (later: <i>context note</i>) <ul>
					<li>is not a grace note</li>
					<li>is not a second tied note</li>
					<li>does not have a cautional accident (@func='caution')</li>
				</ul>
				<pre/> There exists a preceding &lt;note&gt; in the same &lt;layer&gt; which<ul>
					<li>@pname and @oct match with the respective attributes of the context note</li>
					<li> @accid or @accid.ges match with the respective attributes of the context note, except:<ul>
							<li>for the context note/@accid != "n": there are no naturals inbetween</li>
							<li>for the context note/@accid = "n": there are no other accidentals inbetween</li>
						</ul>
					</li>
					<li>is not a grace note</li>
					<li>is not a second tied note</li>
				</ul>
			</p>
			<p>
				<b>Notes:</b>
				<ul>
					<li>It is assumed that the given values for @accid are correct.</li>
					<li>If &lt;note&gt; contains &lt;app&gt; or &lt;choice&gt;, the @accid-/@accid.ges-values are taken from &lt;lem&gt; or &lt;corr&gt; respectively. In absence of those, the value is derived from the first child node.</li>
					<li>There are few cases when a note may have two accidentals. For instance, after f/@accid="x" may happen f/accid/@accid="n" accid/@accid="s". In such cases the @accid is always preserved. When the note is not a context note but a compared note the comparing value is taken from the last &lt;accid&gt;.</li>
				</ul>
			</p>
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.1.1</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/>
				<b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>
		</desc>
	</doc>
</stylesheet>