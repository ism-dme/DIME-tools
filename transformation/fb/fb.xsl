<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>Semi-automatic input of the figured bass.</i>
			</p>
			<p><b>Usage notes</b>:<ul>
					<li>Copy and rename the file <i>./config/config_template.dita</i>. (Either leave it in the same directory or adjust the paths for CSS and Schematron.)</li>
					<li>Fill in the table</li>
					<li>Add this file as configuration by using the <i>../lib/DIME-tools/DIME-tools.xml</i></li>
					<li>Apply the transformation scenario <i>fb</i> to the MEI file.</li></ul></p>
			<p><i>Current version</i>: <b id="version">1.2.0</b>. For more info see the <b>changeLog</b>.</p>
			<p>
				<b>Author: </b>Oleksii Sapov</p>
		</desc>
	</doc>

	<include href="../lib/applicationChanges.xsl"/>
	<include href="../lib/basic.xsl"/>
	<import href="changeLog.xsl"/>

	<variable as="document-node()" name="config">
		<variable name="configRelPathAttr" select="doc('../lib/DIME-tools/DIME-tools.xml')//id('figuredBass')//@file"/>
		<variable name="optionsURI" select="base-uri($configRelPathAttr)"/>
		<variable name="configURI" select="resolve-uri($configRelPathAttr, $optionsURI)"/>
		<sequence select="doc($configURI)"/>
	</variable>



	<!--	positions of the entries in the table-->
	<variable as="xs:integer" name="measurePos" select="$config//colspec[@colname = 'measure']/xs:integer(@colnum)"/>
	<variable as="xs:integer" name="tstampPos" select="$config//colspec[@colname = 'tstamp']/xs:integer(@colnum)"/>
	<variable as="xs:integer" name="f-valuesPos" select="$config//colspec[@colname = 'f-values']/xs:integer(@colnum)"/>
	<variable as="xs:integer" name="extenderPos" select="$config//colspec[@colname = 'extender']/xs:integer(@colnum)"/>
	<variable as="xs:integer" name="tstamp2Pos" select="$config//colspec[@colname = 'tstamp2']/xs:integer(@colnum)"/>
	<variable as="xs:integer" name="suppliedPos" select="$config//colspec[@colname = 'supplied']/xs:integer(@colnum)"/>

	<!--	select only rows which contain data-->
	<variable name="filledRows" select="$config//tbody/row[entry[position() = $measurePos]/text() != '']"/>

	<!--a data map-->
	<variable name="data" select="
			for $n in $filledRows
			return
				map {
					'measure':
					normalize-space($n/entry[position() = $measurePos]/string()),
					'tstamp':
					normalize-space($n/entry[position() = $tstampPos]/string()),
					'f-values': for $p in
					$n/entry[position() = $f-valuesPos]//li/string()
					return
						normalize-space($p),
					'extender': for $p in
					$n/entry[position() = $extenderPos]//li/string()
					return
						normalize-space($p),
					'tstamp2': for $p in
					$n/entry[position() = $tstamp2Pos]//li/string()
					return
						normalize-space($p),
					'supplied':
					normalize-space($n/entry[position() = $suppliedPos]/string())
				}
			"/>

	<!--only the measures which are affected will be matched-->
	<variable name="m" select="
			for $n in $data
			return
				map:get($n, 'measure')"/>


	<xd:doc>
		<xd:desc>main template</xd:desc>
	</xd:doc>
	<template match="/">
		<variable name="createHarm">
			<apply-templates mode="createHarm" select="."/>
		</variable>

		<variable name="addIDs">
			<apply-templates mode="addIDs" select="$createHarm"/>
		</variable>

		<variable name="supply">
			<apply-templates mode="supply" select="$addIDs"/>
		</variable>

		<call-template name="suppliedMsg">
			<with-param name="node" select="$addIDs"/>
		</call-template>

		<variable name="cleanUp">
			<apply-templates mode="cleanUp" select="$supply"/>
		</variable>

		<variable name="output">
			<apply-templates mode="applicationChanges" select="$cleanUp"/>
		</variable>

		<copy-of select="$output"/>

	</template>

	<xd:doc>
		<xd:desc>Matches measure which are in the data.</xd:desc>
	</xd:doc>
	<template match="mei:measure[@n = $m]" mode="createHarm" name="createHarm">
		<variable as="element()" name="measureEl" select="."/>
		<variable name="measureN" select="@n/string()"/>
		<variable name="lastStaff" select="mei:staff[last()]/@n"/>

		<copy>
			<apply-templates select="@*, node()"/>

			<call-template name="harm">
				<with-param name="measureEl" select="$measureEl"/>
				<with-param name="measureN" select="$measureN"/>
				<with-param name="lastStaff" select="$lastStaff"/>
			</call-template>

		</copy>
	</template>

	<xd:doc>
		<xd:desc>Creates &lt;harm&gt;</xd:desc>
		<xd:param name="measureEl"/>
		<xd:param name="measureN"/>
		<xd:param name="lastStaff"/>
	</xd:doc>
	<template name="harm">
		<param as="element()" name="measureEl"/>
		<param name="measureN"/>
		<param name="lastStaff"/>

		<for-each select="$data">
			<variable name="currentMap" select="."/>
			<variable name="rowMeasure" select="map:get(., 'measure')"/>

			<choose>
				<when test="$measureN = $rowMeasure (:finds the correct row with data:)">
					<harm xmlns="http://www.music-encoding.org/ns/mei">
						<xsl:variable name="tstamp" select="map:get(., 'tstamp')"/>
						<!--	in case something is supplied-->
						<xsl:choose>
							<xsl:when test="map:get(., 'supplied') = 'other'">
								<xsl:attribute name="supplied" select="concat($measureEl/@xml:id, ';', $tstamp)"/>
							</xsl:when>
							<xsl:when test="map:get(., 'supplied') = 'harm'">
								<xsl:attribute name="supplyME" select="'yes'"/>
							</xsl:when>
						</xsl:choose>

						<xsl:attribute name="place" select="'below'"/>
						<xsl:attribute name="staff" select="$lastStaff"/>
						<xsl:attribute name="tstamp" select="$tstamp"/>

						<fb>
							<xsl:for-each select="map:get(., 'f-values')">
								<xsl:variable name="pos" select="position()"/>
								<xsl:if test=". != ''">
									<f>

										<xsl:call-template name="extender">
											<xsl:with-param name="pos" select="$pos"/>
											<xsl:with-param name="currentMap" select="$currentMap"/>
											<xsl:with-param name="measureEl" select="$measureEl"/>
											<xsl:with-param name="lastStaff" select="$lastStaff"/>
											<xsl:with-param name="tstamp" select="$tstamp"/>
										</xsl:call-template>

										<xsl:call-template name="suppliedF">
											<xsl:with-param name="pos" select="$pos"/>
											<xsl:with-param name="currentMap" select="$currentMap"/>
										</xsl:call-template>

										<xsl:choose>
											<xsl:when test="contains(., 'empty')">
												<xsl:value-of select="''"/>
											</xsl:when>
											<xsl:otherwise>
												<!--<value-of select="." disable-output-escaping="yes"/>-->
												<xsl:value-of select="replace(., '&amp;', '«')"/>
											</xsl:otherwise>
										</xsl:choose>

									</f>
								</xsl:if>
							</xsl:for-each>
						</fb>
					</harm>
				</when>
				<otherwise/>
			</choose>
		</for-each>
	</template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="pos"/>
		<xd:param name="currentMap"/>
		<xd:param name="measureEl"/>
		<xd:param name="lastStaff"/>
		<xd:param name="tstamp"/>
	</xd:doc>
	<template name="extender">
		<param name="pos"/>
		<param name="currentMap"/>
		<param name="measureEl"/>
		<param name="lastStaff"/>
		<param name="tstamp"/>

		<variable name="extender" select="map:get($currentMap, 'extender')[position() = $pos]"/>

		<if test="$extender = 'true'">
			<attribute name="extender" select="$extender"/>
			<attribute name="tstamp2" select="map:get($currentMap, 'tstamp2')[position() = $pos]"/>

			<!--find value for @startid:-->
			<variable name="correspEl" select="$measureEl//*[(local-name() = ('note', 'rest')) and (ancestor::mei:staff/@n = $lastStaff) and @tstamp = $tstamp]/@xml:id/string()"/>
			<attribute name="startid" select="concat('#', $correspEl)"/>
		</if>

	</template>


	<xd:doc>
		<xd:desc/>
		<xd:param name="currentMap"/>
		<xd:param name="pos"/>
	</xd:doc>
	<template name="suppliedF">
		<param name="currentMap"/>
		<param name="pos"/>

		<variable name="supplied" select="map:get($currentMap, 'supplied')"/>

		<variable name="valuesSupp">
			<choose>
				<when test="contains($supplied, ';')">
					<value-of select="
							for $n in tokenize(normalize-space($supplied),
							';')
							return
								normalize-space($n)"/>
				</when>
				<otherwise>
					<value-of select="normalize-space($supplied)"/>
				</otherwise>
			</choose>
		</variable>

		<choose>
			<when test="
					(some $n in $valuesSupp
						satisfies contains($n, 'f1')) and ($pos = 1)">
				<attribute name="supplyME" select="'yes'"/>
			</when>
			<when test="
					(some $n in $valuesSupp
						satisfies contains($n, 'f2')) and ($pos = 2)">
				<attribute name="supplyME" select="'yes'"/>
			</when>
			<when test="
					(some $n in $valuesSupp
						satisfies contains($n, 'f3')) and ($pos = 3)">
				<attribute name="supplyME" select="'yes'"/>
			</when>
		</choose>

	</template>


	<variable name="ELs" select="'harm', 'fb', 'f'"/>
	<xd:doc>
		<xd:desc>adds IDs to the new elements.</xd:desc>
	</xd:doc>
	<template match="*[local-name() = ($ELs) and not(@xml:id)]" mode="addIDs">
		<copy>
			<attribute name="xml:id">
				<variable as="xs:string" name="uniqueId">
					<value-of select="xs:integer(substring(generate-id(), 4)) * 3"/>
				</variable>
				<value-of select="concat(local-name(), '_', $uniqueId)"/>
			</attribute>
			<apply-templates mode="#current" select="@*, node()"/>
		</copy>
	</template>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="*[@supplyME]" mode="supply">

		<supplied xmlns="http://www.music-encoding.org/ns/mei">
			<xsl:attribute name="resp">#NMA-editors</xsl:attribute>
			<xsl:attribute name="xml:id" select="concat('supplied_', substring-after(@xml:id, '_'))"/>
			<xsl:copy>
				<xsl:apply-templates select="@*, node()"/>
			</xsl:copy>
		</supplied>

	</template>


	<xd:doc>
		<xd:desc>Raises a message which contains an XPath to the harm elements where a 'supplied' has to be inserted.</xd:desc>
		<xd:param name="node"/>
	</xd:doc>
	<template name="suppliedMsg">
		<param name="node"/>

		<!--creates a list of IDs which have @supplied-->
		<variable name="suppliedHarms" select="
				for $n in $node//*[@supplied]
				return
					concat('&quot;', $n/@xml:id, '&quot;')"/>

		<!--XPath/creation helper : if there are more then one ID, they should get a comma afterwards, except the last one-->
		<variable name="concatSupplHarms">
			<choose>
				<when test="count($suppliedHarms) = 1">
					<value-of select="$suppliedHarms"/>
				</when>
				<otherwise>
					<for-each select="$suppliedHarms">
						<choose>
							<when test="position() != last()">
								<value-of select="concat(., ',')"/>
							</when>
							<otherwise>
								<value-of select="."/>
							</otherwise>
						</choose>
					</for-each>
				</otherwise>
			</choose>
		</variable>
		<if test="$concatSupplHarms != ''">
			<message>Add 'supplied' here: <value-of select="concat('id((', $concatSupplHarms, '))')"/></message>
		</if>
	</template>

	<xd:doc>
		<xd:desc>Deletes the @supplied which was needed to locate the harm elements.</xd:desc>
	</xd:doc>
	<template match="@supplied | @supplyME" mode="cleanUp"/>



	<variable name="currentStylesheet" select="doc('')"/>
</stylesheet>
