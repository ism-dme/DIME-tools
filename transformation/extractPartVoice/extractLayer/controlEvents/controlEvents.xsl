<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xsl:include href="startid.xsl"/>
	<xsl:include href="startid_endid.xsl"/>


	<xsl:variable as="xs:string*" name="controlEvents">
		<xsl:call-template name="getListItems">
			<xsl:with-param name="id" select="'controlEvents'"/>
		</xsl:call-template>
	</xsl:variable>

	<xd:doc>
		<xd:desc>
			<xd:p>Matches the <xd:i>control events</xd:i> defined in the <xd:i>lists.xml</xd:i>. If the element contains a @staff with the requested staff/staves value, it will be processed, otherwise not (i.e. it will be deleted). </xd:p>
			<xd:p>The element which do not has @layer will be copied. Those which do has @layer but the value doesn't contain the current layer number won't be processed (i.e. will be deleted).</xd:p>
			<xd:ul>
				<xd:li>Example 1: The dynam has @staff="2" and @layer="1 2". The requested staff-value is '2', layer-value is '1'. The dynam will be processed.</xd:li>
				<xd:li>Example 2: The slur has @staff="2" and @layer="2". The requested staff-value is '2', layer-value is '1'. The slur won't be processed.</xd:li>
				<xd:li>Example 3: The tie has @staff="2" and no @layer. The requested staff-value is '2', layer-value is '1'. The tie will be processed.</xd:li>
			</xd:ul>
			<xd:p>There are three types of processing for different cases:<xd:ul>
					<xd:li>The event has @tstamp</xd:li>
					<xd:li>The event has @startid but no @endid</xd:li>
					<xd:li>The event has both @startid and @endid</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="*[local-name() = $controlEvents]">
		<xsl:variable name="reqStaves" select="dme:findStaff('all')"/>

		<xsl:if test="(@staff = $reqStaves)">
			<xsl:variable name="reqLayer" select="map:get(dme:staff-layer_map(), @staff)"/>

			<xsl:choose>
				<!--If the element does not contain the requested layer number. E.g. dynam[@layer="1"] and the requested layer is '2'-->
				<xsl:when test="@layer and not(contains(@layer, $reqLayer))"/>
				<xsl:otherwise>
					<xsl:call-template name="matchCases">
						<xsl:with-param name="reqLayer" select="$reqLayer" tunnel="yes"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>There are three possible cases which might exist:<xd:ul>
					<xd:li>@tstamp</xd:li>
					<xd:li>@startid</xd:li>
					<xd:li>@startid and @endid</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
		<xd:param name="reqLayer"/>
	</xd:doc>
	<xsl:template name="matchCases">
		<xsl:param name="reqLayer" tunnel="yes"/>

		<xsl:choose>
			<xsl:when test="@tstamp">
				<xsl:if test="boolean(contains(@layer, $reqLayer))">
					<xsl:copy>
						<xsl:call-template name="copy"/>
					</xsl:copy>
				</xsl:if>
			</xsl:when>
			<xsl:when test="@startid and not(@endid)">
				<xsl:call-template name="changePointers">
					<xsl:with-param name="pointers" select="'startid'" tunnel="yes"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@startid and @endid">
				<xsl:call-template name="changePointers">
					<xsl:with-param name="pointers" select="'startid', 'endid'" tunnel="yes"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="pointers"/>
	</xd:doc>
	<xsl:template name="changePointers">
		<xsl:param name="pointers" tunnel="yes"/>

		<xsl:variable as="map(xs:string, xs:string)*" name="refs">
			<xsl:call-template name="vRefs"/>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="count($pointers) = 1 (:the number of the $pointers could be either 1 or 2 :)">
				<xsl:call-template name="startid">
					<xsl:with-param name="refs" select="$refs" tunnel="yes"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="startidEndid">
					<xsl:with-param name="refs" select="$refs" tunnel="yes"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Creats a map which consists of: <xd:ul>
					<xd:li><xd:b>key</xd:b>: string value of the current pointer, e.g. 'startid'</xd:li>
					<xd:li><xd:b>value</xd:b>: value of the new reference(s), e.g. 'note_123' or 'note_123,note_456'. Note: multiple values are possible if there exist an app or a choice</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
		<xd:param name="reqLayer"/>
		<xd:param name="pointers"/>
	</xd:doc>
	<xsl:template name="vRefs">
		<xsl:param name="reqLayer" tunnel="yes"/>
		<xsl:param name="pointers" tunnel="yes"/>

		<xsl:map>
			<xsl:for-each select="@*[local-name() = $pointers]">
				<xsl:variable name="currRefNode" select="id(substring-after(., '#'))"/>
				<xsl:variable as="xs:boolean" name="changePointerVal">
					<xsl:call-template name="vChangePointerVal">
						<xsl:with-param name="currRefNode" select="$currRefNode"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:choose>
					<xsl:when test="$changePointerVal">
						<xsl:variable name="newReferences" select="$currRefNode/ancestor::staff/layer[@n = $reqLayer]//node()[@tstamp = $currRefNode/@tstamp]/@xml:id"/>
						<xsl:map-entry key="local-name(.)" select="string-join(($newReferences), ',')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:map-entry key="local-name(.)" select="substring-after(string(.), '#')"/>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:for-each>
		</xsl:map>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Tests if the value of the current pointer should be changed or preserved.</xd:p>
			<xd:p>Return value: 'true' or 'false' as xs:boolean</xd:p>
		</xd:desc>
		<xd:param name="reqLayer"/>
		<xd:param name="currRefNode"/>
	</xd:doc>
	<xsl:template name="vChangePointerVal">
		<xsl:param name="reqLayer" tunnel="yes"/>
		<xsl:param name="currRefNode"/>

		<xsl:variable name="currRefNode_layerN" select="$currRefNode/ancestor::layer/@n/string()"/>
		<xsl:variable name="reqLayerRequired" select="boolean(contains(../@layer, $reqLayer)) (:Check if the @layer contains the requested layer value. E.g. if @layer='1' and input voice is |1.2|, the current control event should not be displayed:)"/>
	<!--If the requested layer has @sameas. 
		|| If yes, the value of the current attribute should be preserved as the whole content of that layer will be copied without changes. 
		|| Note: need to lookup from mdiv level as, for instance, a tie can point to an element from different measure-->
		<xsl:variable name="reqLayerSameas" select="
				let $currRefNode_measureN := $currRefNode/ancestor::measure/@n,
					$currStaff := ../@staff
				return
					boolean(ancestor::mdiv//measure[@n = $currRefNode_measureN]/staff[@n = $currStaff]/layer[@n = $reqLayer]/@sameas) "/>

		<xsl:choose>
			<!--If the pointer already points to the requested layer or if the requested layer has @sameas. 
				|| One of the conditions should be true. 
				|| Also the @layer of the control event should contain the requested layer number-->
			<xsl:when test="					
					let $pointedLayerTrue := ($currRefNode_layerN = $reqLayer)
					return
						($pointedLayerTrue or $reqLayerSameas) and $reqLayerRequired">
				<xsl:sequence select="false()"/>
			</xsl:when>
			<xsl:when test="($currRefNode_layerN != $reqLayer) and $reqLayerRequired (: if the pointer does not point to the requested layer:)">
				<xsl:sequence select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Copies the node. Replaces the value of the @startid or @endid (could be also the same. Calls the template 'copy'</xd:p>
		</xd:desc>
		<xd:param name="refs"/>
	</xd:doc>
	<xsl:template name="oneNewRefVal">
		<xsl:param name="refs" tunnel="yes"/>

		<xsl:copy>
			<xsl:variable name="currEl" select="."/>
			<xsl:for-each select="map:keys($refs)">
				<xsl:variable name="currKey" select="."/>
				<xsl:if test="$currEl/@*[local-name() = $currKey]">
					<xsl:attribute name="{.}" select="
							let $val := map:get($refs, .)
							return
								'#' || $val"/>
				</xsl:if>
			</xsl:for-each>
			<xsl:call-template name="copy"/>
		</xsl:copy>
	</xsl:template>



	<xd:doc>
		<xd:desc>
			<xd:p>Copies the attributes except those defined in the conditional.</xd:p>
		</xd:desc>
		<xd:param name="reqLayer"/>
	</xd:doc>
	<xsl:template name="copy">
		<xsl:param name="reqLayer" tunnel="yes"/>

		<xsl:if test="local-name() = 'dir' ">
			<xsl:apply-templates select="
				(:when a layer is extracted:)
				if ($reqLayer != '') then
				(@* except (@curvedir, @layer, @startid, @endid), node())
				else (:when a staff is extracted:)
				(@* except (@startid, @endid), node())
				"/>
		</xsl:if>

		<xsl:if test="not(local-name() = 'dir')">
			<xsl:apply-templates select="
					(:when a layer is extracted:)
					if ($reqLayer != '') then
						(@* except (@place, @curvedir, @layer, @startid, @endid), node())
					else (:when a staff is extracted:)
						(@* except (@startid, @endid), node())
					"/>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:desc>
			<xd:p>Copy all attributes except those depending on the mode, update the @xml:id</xd:p>
			<xd:p>Similar functionality as the template 'copy', but the child nodes are not processed. This is needed in context of a recursive template.</xd:p>
		</xd:desc>
		<xd:param name="reqLayer"/>
		<xd:param name="counter"/>
	</xd:doc>
	<xsl:template name="copyWithoutNodeUpdateID">
		<xsl:param name="reqLayer" tunnel="yes"/>
		<xsl:param name="counter"/>

		<xsl:apply-templates select="
				(:when a layer is extracted:)
				if ($reqLayer != '') then
					(@* except (@place, @curvedir, @layer, @startid, @endid, @xml:id))
				else (:when a staff is extracted:)
					(@* except (@startid, @endid, @xml:id))
				"/>
		<xsl:attribute name="xml:id" select="@xml:id || '-' || $counter"/>
	</xsl:template>


</xsl:stylesheet>
