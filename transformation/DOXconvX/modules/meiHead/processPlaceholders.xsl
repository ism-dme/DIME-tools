<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	
	<xsl:variable name="movementInteger" select="map:get($optionsCalc, 'movementInteger')"/>
	<xsl:variable name="placeholdersHead" select="'fileName', 'kvMovement', 'kvNumber', 'movementInteger', 'movementString', 'workID', 'movementID', 'respInitials', 'respFullName', 'tempoFirstMeasure', 'movementPages', 'workTitleEN', 'workTitleDE', 'NMA-editors', 'tempoHeading', 'workID'"/>
	<xsl:variable name="databaseFileMovement" select="dme:databaseFile('movement')"/>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="
			*/text()[some $n in $placeholdersHead
				satisfies matches(., $n)] | @*[some $n in $placeholdersHead
				satisfies matches(., $n)]" mode="processPlaceholders">

		<xsl:variable name="pText" select="string(.)"/>
		<xsl:variable as="map(xs:string, xs:string?)" name="placeholdersMap">
			<xsl:call-template name="placeholdersMap"/>
		</xsl:variable>

		<!--The parameter movementString is added later bcs. it is context-dependend-->
		<xsl:variable as="xs:string" name="movementString">
			<xsl:call-template name="movementString"/>
		</xsl:variable>
		<xsl:variable name="placeholdersMap_" select="map:put($placeholdersMap, 'movementString', $movementString)"/>

		<!--find keys which do not occur in the current text-->
		<xsl:variable name="redundantKeys">
			<xsl:for-each select="map:keys($placeholdersMap)">
				<xsl:if test="not(contains($pText, .))">
					<xsl:sequence select="."/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>

		<!--del entries which are not relevant (performance reasons only)-->
		<xsl:variable name="cleanedMap" select="map:remove($placeholdersMap_, tokenize($redundantKeys, '\s'))"/>
		<xsl:variable name="mapKeys" select="map:keys($cleanedMap)"/>
		<xsl:variable as="xs:integer" name="mapSize" select="map:size($cleanedMap)"/>

		<xsl:call-template name="processText">
			<xsl:with-param name="pText" select="$pText"/>
			<xsl:with-param name="cleanedMap" select="$cleanedMap"/>
			<xsl:with-param name="mapKeys" select="$mapKeys"/>
			<xsl:with-param name="mapSize" select="$mapSize"/>
		</xsl:call-template>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="processing-instruction()[name() = $placeholdersHead]" mode="processPlaceholders" name="processPI">

		<xsl:copy-of copy-namespaces="no" select="$databaseFileMovement//*[@xml:id = name(current())]"/>

	</xsl:template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="pText"/>
		<xd:param name="cleanedMap"/>
		<xd:param name="mapKeys"/>
		<xd:param name="mapSize"/>
	</xd:doc>
	<xsl:template name="processText">
		<xsl:param name="pText"/>
		<xsl:param name="cleanedMap"/>
		<xsl:param name="mapKeys"/>
		<xsl:param as="xs:integer" name="mapSize"/>
		<!--attributes and text nodes are processed slightly different-->
		<xsl:choose>
			<xsl:when test=". instance of text()">
				<xsl:call-template name="replace_textNode">
					<xsl:with-param name="pText" select="$pText"/>
					<xsl:with-param name="vMap" select="$cleanedMap"/>
					<xsl:with-param name="mapKeys" select="$mapKeys"/>
					<xsl:with-param name="mapSize" select="$mapSize"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test=". instance of attribute()">
				<xsl:variable name="replacedAttrValue">
					<xsl:call-template name="replace_attrValue">
						<xsl:with-param name="pText" select="$pText"/>
						<xsl:with-param name="vMap" select="$cleanedMap"/>
						<xsl:with-param name="mapKeys" select="$mapKeys"/>
						<xsl:with-param name="mapSize" select="$mapSize"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:attribute name="{name()}" select="$replacedAttrValue"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="movementString">
		<xsl:choose>
			<xsl:when test="(ancestor::node()/@xml:lang) and (matches(., 'movementString'))">
				<xsl:value-of select="dme:movementString(ancestor::node()[@xml:lang][1]/@xml:lang cast as xs:string)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'NaN'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="pText"/>
		<xd:param name="counter"/>
		<xd:param name="vMap"/>
		<xd:param name="mapKeys"/>
		<xd:param name="mapSize"/>
	</xd:doc>
	<xsl:template name="replace_textNode">
		<xsl:param as="xs:string" name="pText"/>
		<xsl:param name="vMap"/>
		<xsl:param as="xs:string*" name="mapKeys"/>
		<xsl:param as="xs:integer" name="mapSize"/>
		<xsl:param name="counter" select="1"/>

		<xsl:choose>
			<xsl:when test="$counter &lt;= $mapSize">
				<xsl:variable name="currentKey" select="$mapKeys[$counter]"/>

				<!--		<xsl:message>Key: "<xsl:value-of select="$currentKey"/>" Value: "<xsl:value-of select="map:get($vMap, $currentKey)"/>" text: <xsl:value-of select="$pText"/>.</xsl:message>-->
				<xsl:variable name="replaced">
					<xsl:value-of select="
							if (map:get($vMap, $currentKey) != '') then
								replace($pText, $currentKey, map:get($vMap, $currentKey))
							else
								()"/>
				</xsl:variable>
				<xsl:call-template name="replace_textNode">
					<xsl:with-param name="pText" select="$replaced"/>
					<xsl:with-param name="vMap" select="$vMap"/>
					<xsl:with-param name="mapKeys" select="$mapKeys"/>
					<xsl:with-param name="mapSize" select="$mapSize"/>
					<xsl:with-param name="counter" select="$counter + 1"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pText"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xd:doc>
		<xd:desc/>
		<xd:param name="pText"/>
		<xd:param name="counter"/>
		<xd:param name="vMap"/>
		<xd:param name="mapKeys"/>
		<xd:param name="mapSize"/>
	</xd:doc>
	<xsl:template name="replace_attrValue">
		<xsl:param as="xs:string" name="pText"/>
		<xsl:param name="vMap"/>
		<xsl:param as="xs:string*" name="mapKeys"/>
		<xsl:param as="xs:integer" name="mapSize"/>
		<xsl:param name="counter" select="1"/>

		<xsl:choose>
			<xsl:when test="$counter &lt;= $mapSize">
				<xsl:variable name="currentKey" select="$mapKeys[$counter]"/>
				<xsl:variable name="replaced">
					<xsl:value-of select="replace($pText, $currentKey, map:get($vMap, $currentKey))"/>
				</xsl:variable>
				<xsl:call-template name="replace_textNode">
					<xsl:with-param name="pText" select="$replaced"/>
					<xsl:with-param name="vMap" select="$vMap"/>
					<xsl:with-param name="mapKeys" select="$mapKeys"/>
					<xsl:with-param name="mapSize" select="$mapSize"/>
					<xsl:with-param name="counter" select="$counter + 1"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pText"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="lang"/>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:movementString">
		<xsl:param name="lang"/>
		<xsl:variable name="langUpperCase" select="upper-case($lang)"/>
		<xsl:variable as="map(xs:integer, xs:string)" name="vmap">
			<xsl:choose>
				<xsl:when test="$langUpperCase = 'DE'">
					<xsl:map>
						<xsl:map-entry key="1" select="'1.'"/>
						<xsl:map-entry key="2" select="'2.'"/>
						<xsl:map-entry key="3" select="'3.'"/>
						<xsl:map-entry key="4" select="'4.'"/>
					</xsl:map>
				</xsl:when>
				<xsl:when test="$langUpperCase = 'EN'">
					<xsl:map>
						<xsl:map-entry key="1" select="'1st'"/>
						<xsl:map-entry key="2" select="'2nd'"/>
						<xsl:map-entry key="3" select="'3rd'"/>
						<xsl:map-entry key="4" select="'4th'"/>
					</xsl:map>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message>The file has other than DE/EN languages (@xml:lang="<xsl:value-of select="$langUpperCase"/>").</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="map:get($vmap, $movementInteger cast as xs:integer) cast as xs:string"/>
	</xsl:function>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:function name="dme:inputHead">
		<xsl:variable name="headBaseURI" select="'file:///K:/PROJEKTE/DMEDME/Edition/Referenztexte'"/>
		<xsl:variable name="headPath" select="concat($headBaseURI, '/KV%20', map:get($optionsCalc, 'KV'), '/Werk-header_', map:get($optionsCalc, 'KV'), '.xml')"/>
		<xsl:variable name="inputHead" select="doc($headPath)//meiHead"/>
		<xsl:copy-of select="$inputHead"/>
	</xsl:function>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template name="placeholdersMap">
		<xsl:map>
			<xsl:map-entry key="'fileName'" select="$fileName"/>
			<xsl:map-entry key="'kvMovement'" select="map:get($optionsCalc, 'kvMovement')"/>
			<xsl:map-entry key="'kvNumber'" select="map:get($optionsCalc, 'KV')"/>
			<xsl:map-entry key="'movementInteger'" select="$movementInteger"/>
			<xsl:map-entry key="'movementID'" select="$movementID"/>
			<xsl:map-entry key="'workID'" select="dme:workID()"/>
			<xsl:map-entry key="'respInitials'" select="dme:respPerson('initials')"/>
			<xsl:map-entry key="'respFullName'" select="dme:respPerson('fullName')"/>
			<xsl:map-entry key="'tempoHeading'" select="$databaseFileMovement//tempo/text()/string(.)"/>
			<xsl:map-entry key="'tempoFirstMeasure'" select="$processedFile/((//measure)[1]//tempo)[1]/string(text())"/>
			<xsl:map-entry key="'movementPages'" select="map:get($options, 'movementPages')"/>
			<xsl:map-entry key="'workTitleDE'" select="dme:workTitle('de')"/>
			<xsl:map-entry key="'workTitleEN'" select="dme:workTitle('en')"/>
		</xsl:map>
	</xsl:template>



	<xd:doc>
		<xd:desc/>
		<xd:param name="lang"/>
	</xd:doc>
	<xsl:function as="xs:string" name="dme:workTitle">
		<xsl:param name="lang"/>

		<xsl:variable name="value" select="dme:databaseFile('work')//meiHead//title[@type = 'unit' and @xml:lang = $lang]/text()/data()"/>
		<xsl:value-of select="string($value)"/>
	</xsl:function>


	<xd:doc>
		<xd:desc>Returns the document node of the file from the database meiHead export.</xd:desc>
		<xd:param name="type">Defines either it should be 'work' or other ('movement').</xd:param>
	</xd:doc>
	<xsl:function as="document-node()" name="dme:databaseFile">
		<xsl:param as="xs:string" name="type"/>

		<xsl:variable name="baseURI" select="'file:///K:/PROJEKTE/DMEDME/Edition/Referenztexte'"/>

		<xsl:choose>
			<xsl:when test="$type = 'work'">
				<xsl:variable name="path" select="$baseURI || '/KV%20' || map:get($optionsCalc, 'KV') || '/meiHead_database/meiheader_' || dme:workID() || '.xml'"/>
				<xsl:copy-of select="doc($path)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="path" select="$baseURI || '/KV%20' || map:get($optionsCalc, 'KV') || '/meiHead_database/meiheader_' || $movementID || '.xml'"/>
				<xsl:copy-of select="doc($path)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:function name="dme:workID">
		<xsl:variable name="TOK" select="tokenize($fileURL, '/')"/>
		<xsl:copy-of select="substring-after($TOK[last() - 1], '_')"/>
	</xsl:function>



	<!-- title type="movementHeading" muss nur ausgefüllt werden, wenn der Titel von der Tempobezeichnung abweicht. Wenn beides identisch ist, nur @analog="#tempo" hinzufügen -->

	<!-- Placeholders:
fileName				= "dmeref_138-002_2356.xml"
kvMovement 			= "387002'
kvNumber 				= "KV number", e.g. "387"
movementInteger = "movement integer" e.g. '1'  
movementString 	= "movement string" e.g. '1st' or '1.' Note: the language is dependend on the @xml:lang
workID
movementID 			= e.g. 387-002_4996 ->> "4996"
respInitials		= "ND"
respFullName 		= "Norbert Dubowy"
tempoHeading 		= "movement title" e.g. "Menuetto" "oXygen input-box" Note: currently reads the tempo from the first measure 
tempoFirstMeasure = "Allegro"
movementPages 	= "pages of the current movement" e.g. 15-18
-->
	
	
	
</xsl:stylesheet>
