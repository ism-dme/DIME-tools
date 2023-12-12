<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
		<desc>
			<p>
				<i>Adds @layer="1 2" to &lt;dynam>, &lt;dir>, &lt;fermata>, &lt;trill>, &lt;turn>, &lt;slur>, &lt;tie>.</i>
			</p>
			<p><b>Specifications</b>: <ul>
					<li>&lt;dynam>, &lt;dir>, &lt;fermata>, &lt;trill>, &lt;turn>: In presence of two layers, these control events must have always an @layer: either @layer="1 2" (common control event) or @layer="1"/@layer="2" (control event related only to one of the two layers, but missing in the other layer)</li>
					<li>&lt;slur>, &lt;tie&gt; In presence of two layers, these control events must have @layer="1 2" only when the main element which they relate to is pointed by @sameas (&lt;tie>) or @stem.sameas (&lt;slur>), that is for &lt;slur> or &lt;tie&gt; in passages "a 2" (unisono). Otherwise they never have a @layer. If there exists a &lt;rest&gt; in other &lt;layer&gt; on the same @tstamp as pointed element no @layer is added.</li>
				</ul>			
			</p>	
			<pre> </pre>
			<p><b>Current version</b>: <b id="version">1.1.0</b>. For the details see changeLog.</p>
			<p><b>Contributors</b>: Oleksii Sapov. <pre/> <b>Copyright</b>: 2020 Internationale Stiftung Mozarteum Salzburg.<pre/>Licensed under the Educational Community License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <a href="https://opensource.org/licenses/ECL-2.0">https://opensource.org/licenses/ECL-2.0</a><pre/>Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.</p>		
		</desc>
	</doc>
	
	<xsl:include href="../lib/basic.xsl"/>
	<xsl:include href="../lib/functions/functx-1.0-doc-2007-01.xsl"/>
	<xsl:include href="../lib/applicationChanges.xsl"/>
	<xsl:include href="../lib/templates.xsl"/>
	<xsl:import href="changeLog.xsl"/>


	<xsl:variable as="xs:string*" name="controlEvents">
		<xsl:call-template name="getListItems">
			<xsl:with-param name="id" select="'controlEvents'"/>
		</xsl:call-template>
	</xsl:variable>


	<xd:doc>
		<xd:desc>Only elements which point to a staff with two layers are processed, otherwise they are copied.</xd:desc>
	</xd:doc>
	<xsl:template match="*[local-name() = $controlEvents]">
		<xsl:copy>

			<xsl:choose>
				<!--test for having more then one layer-->
				<xsl:when test="ancestor::measure//staff[@n = current()/@staff][count(layer) > 1]">
					<xsl:call-template name="process"/>
					<xsl:apply-templates select="@*, node()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Splits the control events into three cases: <xd:ul>
					<xd:li>tstamp</xd:li>
					<xd:li>startid</xd:li>
					<xd:li>startEndid</xd:li>
				</xd:ul></xd:p>
			<xd:p>Also ensures that there doesn't exist a @layer already.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="process">

		<xsl:if test="not(@layer)">
			<xsl:choose>
				<xsl:when test="@tstamp">
					<xsl:call-template name="tstampCase"/>
				</xsl:when>
				<xsl:when test="@startid and not(@endid)">
					<xsl:call-template name="startidCase"/>
				</xsl:when>
				<xsl:when test="@startid and @endid">
					<xsl:call-template name="startEndIDCase"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message>The element <xsl:value-of select="@xml:id"/> has either @tstamp, @startid no @endid (copied). </xsl:message>
					<xsl:apply-templates select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Prepares parameters for the template restTest</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="tstampCase">

		<xsl:variable name="pointedStaff" select="ancestor::measure/staff[@n = current()/@staff]"/>
		<xsl:variable name="mRestExists" select="$pointedStaff//mRest"/>
		<xsl:variable name="restExists" select="$pointedStaff//rest[@tstamp = current()/@tstamp]"/>

		<xsl:call-template name="restTest">
			<xsl:with-param name="mRestExists" select="$mRestExists"/>
			<xsl:with-param name="restExists" select="$restExists"/>
			<xsl:with-param name="pointedStaff" select="$pointedStaff"/>
		</xsl:call-template>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Prepares parameters for the <xd:i>restTest</xd:i> template.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="startidCase">
		<xsl:variable name="pointedEl" select="id(substring-after(@startid, '#'))"/>
		<xsl:variable name="otherLayer" select="dme:vOtherLayer($pointedEl)"/>
		<xsl:variable name="mRestExists" select="$otherLayer//mRest"/>
		<xsl:variable name="restExists" select="$otherLayer//rest[@tstamp = $pointedEl/@tstamp]"/>

		<xsl:call-template name="restTest">
			<xsl:with-param name="mRestExists" select="$mRestExists"/>
			<xsl:with-param name="restExists" select="$restExists"/>
			<xsl:with-param name="pointedStaff" select="$pointedEl/ancestor::staff"/>
		</xsl:call-template>

	</xsl:template>



	<xd:doc>
		<xd:desc>
			<xd:p>Checks if there is an &lt;mRest&gt; in any of the respective &lt;layer&gt; or if there is a &lt;rest&gt; which starts at the same @tstamp as the control event. If any exists, the value of @layer will not be '1 2' but '1' or '2'.</xd:p>
		</xd:desc>
		<xd:param name="mRestExists"/>
		<xd:param name="restExists"/>
		<xd:param name="pointedStaff"/>
	</xd:doc>
	<xsl:template name="restTest">
		<xsl:param name="mRestExists"/>
		<xsl:param name="restExists"/>
		<xsl:param name="pointedStaff"/>

		<xsl:choose>
			<xsl:when test="($mRestExists or $restExists) and not($mRestExists and $restExists)">
				<xsl:if test="$mRestExists">
					<xsl:variable name="mRestLayer" select="$mRestExists/ancestor::layer/@n"/>
					<xsl:call-template name="addAttributes">
						<xsl:with-param name="pointedStaff" select="$pointedStaff"/>
						<xsl:with-param name="exclLayer" select="$mRestLayer"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$restExists">
					<xsl:variable name="restLayer" select="$restExists/ancestor::layer/@n"/>
					<xsl:call-template name="addAttributes">
						<xsl:with-param name="pointedStaff" select="$pointedStaff"/>
						<xsl:with-param name="exclLayer" select="$restLayer"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<!--just double check if there were no notes where the event is attached to-->
			<xsl:when test="not($mRestExists and $restExists)">
				<xsl:attribute name="layer" select="'1 2'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Adds @layer and @place.</xd:p>
		</xd:desc>
		<xd:param name="pointedStaff"/>
		<xd:param name="exclLayer">Used to exclude the layer numher from the available in the current staff. Assumes that there exist two layers only.</xd:param>
	</xd:doc>
	<xsl:template name="addAttributes">
		<xsl:param name="pointedStaff"/>
		<xsl:param name="exclLayer"/>

		<xsl:variable name="layerValue" select="functx:value-except($pointedStaff/layer/@n, $exclLayer)"/>
		<xsl:attribute name="layer" select="$layerValue"/>
		<xsl:if test="not(@tstamp)">
			<xsl:attribute name="place">
				<xsl:choose>
					<xsl:when test="xs:integer($layerValue) = 1">
						<xsl:value-of select="'above'"/>
					</xsl:when>
					<xsl:when test="xs:integer($layerValue) = 2">
						<xsl:value-of select="'below'"/>
					</xsl:when>
				</xsl:choose>
			</xsl:attribute>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>If the elemenets pointed by @startid, @endits have references to @sameas, @stem.sameas or layer/@sameas, a @layer="1 2' will be added.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="startEndIDCase">

		<xsl:variable as="item()+" name="tests">
			<xsl:call-template name="startEndIDtests"/>
		</xsl:variable>

		<xsl:variable as="item()+" name="rests">
			<xsl:call-template name="vRests"/>
		</xsl:variable>

		<xsl:if test="
				some $boolean in $tests
					satisfies $boolean = true()">
			<xsl:if test="
					not(some $boolean in $rests
						satisfies $boolean = true())">
				<xsl:attribute name="layer" select="'1 2'"/>
			</xsl:if>
		</xsl:if>

	</xsl:template>


	<xd:doc>
		<xd:desc>Returns a sequence of boolean values. Checks if: <xd:ul>
				<xd:li>there exists respective layer/@sameas</xd:li>
				<xd:li>the pointed element has references via @sameas, @stem.sameas</xd:li>
				<xd:li>there exists a &lt;mRest&gt; in the respective &lt;layer&gt; or &lt;rest&gt;</xd:li>
			</xd:ul>
		</xd:desc>
	</xd:doc>
	<xsl:template name="startEndIDtests">
		<xsl:for-each select="@startid, @endid">
			<xsl:variable name="pointedEl" select="id(substring-after(., '#'))"/>
			<xsl:variable as="xs:boolean" name="layerSameas">
				<xsl:call-template name="layerSameasTrue">
					<xsl:with-param name="pointedEl" select="$pointedEl"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable as="xs:boolean" name="pointer">
				<xsl:call-template name="pointerTrue">
					<xsl:with-param name="pointedEl" select="$pointedEl"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:sequence select="
					boolean($layerSameas or $pointer)"/>
		</xsl:for-each>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Returns a sequence of boolean values. If it contains any true-value it means there exists a &lt;mRest&gt; or a &lt;rest&gt; at the same @tstamp as the respective &lt;layer&gt;.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="vRests">
		<xsl:for-each select="@startid, @endid">
			<xsl:variable name="pointedEl" select="id(substring-after(., '#'))"/>
			<xsl:variable name="otherLayer" select="dme:vOtherLayer($pointedEl)"/>
			<xsl:variable name="mRestExists" select="$otherLayer//mRest"/>
			<xsl:variable name="restExists" select="$otherLayer//rest[@tstamp = $pointedEl/@tstamp]"/>
			<xsl:sequence select="
					boolean($mRestExists or $restExists)"/>
		</xsl:for-each>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>If other &lt;layer&gt; has @sameas</xd:p>
		</xd:desc>
		<xd:param name="pointedEl"/>
	</xd:doc>
	<xsl:template name="layerSameasTrue">
		<xsl:param name="pointedEl"/>

		<xsl:variable name="startidElLayerN" select="$pointedEl/ancestor::layer/@n"/>
		<xsl:variable name="pointedStaff" select="$pointedEl/ancestor::staff"/>
		<xsl:variable name="otherLayer" select="$pointedStaff/layer[not(@n = $startidElLayerN)]"/>
		<xsl:copy-of select="exists($otherLayer[@sameas])"/>
	</xsl:template>


	<xd:doc>
		<xd:desc>If there exists a @sameas or @stem.sameas pointer</xd:desc>
		<xd:param name="pointedEl"/>
	</xd:doc>
	<xsl:template name="pointerTrue">
		<xsl:param name="pointedEl"/>

		<xsl:variable name="pointedMeasure" select="$pointedEl/ancestor::measure"/>
		<xsl:variable name="sameasTrue" select="exists($pointedMeasure//*[substring-after(@sameas, '#') = $pointedEl/@xml:id])"/>
		<xsl:variable name="stemSameasTrue" select="exists($pointedMeasure//*[substring-after(@stem.sameas, '#') = $pointedEl/@xml:id])"/>
		<xsl:copy-of select="boolean($sameasTrue or $stemSameasTrue)"/>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Returns a &lt;layer&gt; which is a sibling of the &lt;layer&gt; of the pointed element.</xd:p>
		</xd:desc>
		<xd:param name="pointedEl"/>
	</xd:doc>
	<xsl:function as="element()" name="dme:vOtherLayer">
		<xsl:param name="pointedEl"/>

		<xsl:variable name="pointedElLayerN" select="$pointedEl/ancestor::layer/@n"/>
		<xsl:variable name="pointedStaff" select="$pointedEl/ancestor::staff"/>
		<xsl:copy-of select="$pointedStaff/layer[not(@n = $pointedElLayerN)]"/>
	</xsl:function>

	<xsl:variable name="currentStylesheet" select="doc('')"/>

</xsl:stylesheet>
