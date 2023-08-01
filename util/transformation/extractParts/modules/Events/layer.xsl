<?xml version="1.0" encoding="UTF-8"?>
	
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xsl:variable name="attributes2remove" select="('stem.dir', 'stem.sameas', 'ploc', 'oloc')"/>
	<xd:doc>
		<xd:desc>
			<xd:ul>
				<xd:li>resolves layer/@sameas</xd:li>
			</xd:ul> or <xd:ul>
				<xd:li>process each descendant</xd:li>
				<xd:li>resolves its @sameas</xd:li>
				<xd:li>deletes @stem.sameas, @stem.dir, @ploc, @oloc</xd:li>
				<xd:li>or copies it</xd:li>
			</xd:ul>
		</xd:desc>
	</xd:doc>
	<xsl:template match="layer" mode="layer">
		<xsl:choose>
			<xsl:when test="@sameas">
				<xsl:variable name="pointedEl" select="id(substring-after(@sameas, '#'))"/>
				<xsl:copy-of select="functx:add-or-update-attributes($pointedEl, xs:QName('xml:id'), @xml:id)"/>
			</xsl:when>
			<xsl:when test="descendant::node()[@sameas]">
				<xsl:copy>
					<xsl:call-template name="createFirstLayer"/>
					<xsl:call-template name="processLayerDescendants">
						<xsl:with-param name="Els" select="node()"/>
					</xsl:call-template>
				</xsl:copy>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:call-template name="createFirstLayer"/>
					<xsl:apply-templates select="node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xd:doc>
		<xd:desc>
			<xd:p>Resolves @sameas. Original attributes from the 'pointer' are preserved. Attributes defined in $attributes2remove are deleted. Recursive template.</xd:p>
		</xd:desc>
		<xd:param name="Els"/>
	</xd:doc>
	<xsl:template name="processLayerDescendants">
		<xsl:param name="Els"/>

		<xsl:for-each select="$Els">
			<xsl:choose>
				<xsl:when test="@sameas and not(node())">
					<xsl:variable as="element()" name="vResolvedEl">
						<xsl:call-template name="TvResolvedEl"/>
					</xsl:variable>
					<xsl:copy-of select="functx:remove-attributes($vResolvedEl, $attributes2remove)"/>
				</xsl:when>
				<!--assumes is has node() children-->
				<xsl:when test="@sameas">
					<xsl:copy>
						<xsl:variable name="pointedEl" select="id(substring-after(@sameas, '#'))"/>
						<xsl:variable name="currentAttrs" select="@* except @sameas"/>
						<xsl:variable name="pointedELattrs" select="$pointedEl/@*[not(local-name() = ($attributes2remove, $currentAttrs/local-name()))]"/>
						<xsl:copy-of select="$currentAttrs"/>
						<xsl:copy-of select="$pointedELattrs"/>
						<xsl:call-template name="processLayerDescendants">
							<xsl:with-param name="Els" select="node()"/>
						</xsl:call-template>
					</xsl:copy>
				</xsl:when>
				<xsl:when test="node()">
					<xsl:copy>
						<xsl:apply-templates select="@*[not(local-name() = $attributes2remove)]"/>
						<xsl:call-template name="processLayerDescendants">
							<xsl:with-param name="Els" select="node()"/>
						</xsl:call-template>
					</xsl:copy>
				</xsl:when>
				<!--This conditional is needed bcs. the node() can be a text node as well.-->
				<xsl:when test=". instance of element()">
					<xsl:copy-of select="functx:remove-attributes(., $attributes2remove)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>



	<xd:doc>
		<xd:desc>
			<xd:p>Returns the referenced element. Replaces the attribute values or adds the attributes from the pointer element.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="TvResolvedEl">
		<xsl:variable name="pointedEl" select="id(substring-after(@sameas, '#'))"/>
		<!--The attributes which will be preserved-->
		<xsl:variable name="attrs" select="@*[local-name() != 'sameas']"/>
		<xsl:variable as="xs:QName*" name="attrsQNames">
			<xsl:for-each select="$attrs">
				<xsl:sequence select="xs:QName(name())"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable as="xs:string*" name="vals">
			<xsl:for-each select="$attrs">
				<xsl:sequence select="string()"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:copy-of select="functx:add-or-update-attributes($pointedEl, $attrsQNames, $vals)"/>
	</xsl:template>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="createFirstLayer">
		<xsl:attribute name="n" select="'1'"/>
		<xsl:attribute name="xml:id" select="@xml:id"/>
		<xsl:apply-templates select="@* except (@n, @xml:id)"/>
	</xsl:template>

</xsl:stylesheet>
