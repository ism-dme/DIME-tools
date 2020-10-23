<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	
	<xd:doc>
		<xd:desc>adds @key.sig, @key.mode, @key.pname of the non-transpoing instruments</xd:desc>
	</xd:doc>
	<xsl:template match="scoreDef" mode="scoreDef">
		
		<xsl:copy>
			<!--a temporary ID-->
			<xsl:attribute name="xml:id">
				<xsl:value-of select="generate-id()"/>
			</xsl:attribute>

			
			<xsl:if test="
				let $currGenre := map:get($options, 'genre'),
				$genres := ('orchestral', 'chamber')
				return
				some $n in $genres
				satisfies matches($n, $currGenre)">
				<xsl:attribute name="optimize" select="'false'"/>
			</xsl:if>
			
			<xsl:choose>
				<xsl:when test="map:get($options, 'meiHead') != '0' (:=Werk-header should be used:)">
					<xsl:variable as="attribute()*" name="databaseAttrs" select="$databaseFileMovement//workDesc//key/@*"/>
					<xsl:for-each select="$databaseAttrs">
						<xsl:attribute name="{'key.' || local-name()}" select="."/>
					</xsl:for-each>
					<xsl:apply-templates mode="#current" select="@* except @*[substring-after(local-name(), 'key.') = $databaseAttrs/local-name()]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="#current" select="@*"/>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:apply-templates mode="scoreDefChildren" select="node()"/>
			
		</xsl:copy>
	</xsl:template>
	
	
	
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staffGrp[staffGrp and (@barthru = 'false') and parent::scoreDef]" mode="scoreDefChildren">
		<xsl:variable name="NrStaffGrp" select="count(staffGrp)"/>
		<xsl:choose>
			<xsl:when test="($NrStaffGrp = 1) and not(staffDef)">
				<xsl:for-each select="child::node()">
					<xsl:apply-templates mode="#current" select="."/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*, node()"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="staffDef" mode="scoreDefChildren">
		<xsl:variable name="current" select="."/>
		
		<!--extract values from @dme.parts-->
		<xsl:variable name="dmeParts" select="
			for $n in tokenize(@dme.parts, ',')
			return
			normalize-space($n)"/>
		<xsl:variable name="multipleDMEparts" select="
			if (count($dmeParts) = 1) then
			false()
			else
			true()"/>
		<!--		find the respective perfRes-->
		<xsl:variable as="element()*" name="perfRes">
			<xsl:sequence select="$current/preceding::perfRes[@n = $dmeParts]"/>
		</xsl:variable>
		
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="count($dmeParts) >= 1">
					<xsl:call-template name="processStaffDef">
						<xsl:with-param name="dmeParts" select="$dmeParts"/>
						<xsl:with-param name="multipleDMEparts" select="$multipleDMEparts"/>
						<xsl:with-param name="perfRes" select="$perfRes"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message>No @dme.parts defined in <xsl:value-of select="@xml:id"/>, so original attributes are preserved.</xsl:message>
					<xsl:apply-templates select="@*, node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
	
	<xd:doc>
		<xd:desc/>
		<xd:param name="perfRes"/>
		<xd:param name="dmeParts"/>
		<xd:param name="multipleDMEparts"/>
	</xd:doc>
	<xsl:template name="processStaffDef">
		<xsl:param as="element()*" name="perfRes"/>
		<xsl:param name="dmeParts"/>
		<xsl:param name="multipleDMEparts"/>
		
		<!--		instrument from lists.xml-->
		<xsl:variable name="item" select="$lists//id($perfRes/@codedval)"/>
		<xsl:variable name="label.abbr" select="$item//dme:name[@xml:lang = 'IT']/@label.abbr"/>
		<xsl:variable name="label" select="$item//dme:name[@xml:lang = 'IT']/text()"/>
		<xsl:variable name="transposeIN" select="map:get($options, 'allParams')//id($label[1])/text()"/>
		
		<xsl:if test="$multipleDMEparts = false()">
			<xsl:attribute name="decls" select="concat('#', $perfRes/@xml:id)"/>
		</xsl:if>
		<xsl:variable name="genre" select="map:get($options, 'genre')"/>
		
		<xsl:if test="matches($genre, 'orchestral')">
			<xsl:call-template name="attr.label.abbr">
				<xsl:with-param name="label" select="$label"/>
				<xsl:with-param name="label.abbr" select="$label.abbr"/>
			</xsl:call-template>
		</xsl:if>
		
		
		
		
		<xsl:if test="exists($item/dme:transposition)">
			<xsl:call-template name="transpositionAttributes">
				<xsl:with-param name="label" select="$label"/>
				<xsl:with-param name="item" select="$item"/>
				<xsl:with-param name="transposeIN" select="$transposeIN"/>
			</xsl:call-template>
		</xsl:if>
		
		<xsl:apply-templates select="(@clef.line, @clef.shape, @dme.parts, @doxml.id, @lines, @xml:id, @n)"/>
		
		<xsl:choose>
			<xsl:when test="label">
				<xsl:apply-templates select="label"/>
			</xsl:when>
			<xsl:when test="@label">
				<xsl:element name="label" namespace="http://www.music-encoding.org/ns/mei">
					<xsl:value-of select="@label"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="label" namespace="http://www.music-encoding.org/ns/mei">
					<xsl:value-of select="$label"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
		
		
		<xsl:call-template name="createLayerDefs">
			<xsl:with-param name="multipleDMEparts" select="$multipleDMEparts"/>
			<xsl:with-param name="dmeParts" select="$dmeParts"/>
			<xsl:with-param name="perfRes" select="$perfRes"/>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:desc/>
		<xd:param name="multipleDMEparts"/>
		<xd:param name="dmeParts"/>
		<xd:param name="perfRes"/>
	</xd:doc>
	<xsl:template name="createLayerDefs">
		<xsl:param name="multipleDMEparts"/>
		<xsl:param name="dmeParts"/>
		<xsl:param as="element()*" name="perfRes"/>
		<xsl:if test="$multipleDMEparts = true()">
			<xsl:for-each select="$dmeParts">
				<xsl:element name="layerDef" namespace="http://www.music-encoding.org/ns/mei">
					<xsl:variable name="current" select="."/>
					
					<xsl:attribute name="decls" select="concat('#', $perfRes[@n = $current]/@xml:id)"/>
					<xsl:attribute name="n" select="position()"/>
				</xsl:element>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	
	
	
	<xd:doc>
		<xd:desc/>
		<xd:param name="label"/>
		<xd:param name="item"/>
		<xd:param name="transposeIN"/>
	</xd:doc>
	<xsl:template name="transpositionAttributes">
		<xsl:param name="label"/>
		<xsl:param name="item"/>
		<xsl:param name="transposeIN"/>
		
		<xsl:choose>
			<xsl:when test="$label = ('Clarinetto', 'Clarino', 'Corno')">
				<xsl:attribute name="trans.semi" select="$item/dme:transposition[text() = $transposeIN]//@trans.semi"/>
				<xsl:attribute name="trans.diat" select="$item/dme:transposition[text() = $transposeIN]//@trans.diat"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="trans.semi" select="$item//@trans.semi"/>
				<xsl:attribute name="trans.diat" select="$item//@trans.diat"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="@key.sig"/>
	</xsl:template>
	
	
	<xd:doc>
		<xd:desc/>
		<xd:param name="label"/>
		<xd:param name="label.abbr"/>
	</xd:doc>
	<xsl:template name="attr.label.abbr">
		<xsl:param name="label"/>
		<xsl:param name="label.abbr"/>
		<xsl:attribute name="label.abbr">
			<xsl:choose>
				<!--derive the roman integer for violine from its label-->
				<xsl:when test="
					(some $n in $label
					satisfies contains($n, 'Violino')) and @label">
					<xsl:variable name="violinoCount" select="tokenize(@label, '\s')[last()]"/>
					<xsl:value-of select="concat($label.abbr, ' ', $violinoCount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$label.abbr"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>
	
</xsl:stylesheet>
