<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xsl:include href="orig/revisionDesc.xsl"/>
	<xsl:include href="orig/perfRes.xsl"/>
	<xsl:include href="orig/appInfo.xsl"/>
	<xsl:include href="processPlaceholders.xsl"/>
	<xsl:include href="insertFromDatabase.xsl"/>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="meiHead" mode="meiHead">
		<!--takes the <meiHead> from Werk-header and replaces several elements with those from the transformed file-->
		<xsl:variable name="origHead">
			<xsl:apply-templates mode="copyFromOrig" select="dme:inputHead()"/>
		</xsl:variable>

		<xsl:variable name="processPlaceholders">
			<xsl:apply-templates mode="processPlaceholders" select="$origHead"/>
		</xsl:variable>
		
		<xsl:variable name="insertFromDatabase">
			<xsl:apply-templates mode="insertFromDatabase" select="$processPlaceholders"/>
		</xsl:variable>
		<xsl:copy-of select="$insertFromDatabase"/>
	</xsl:template>

	<!--				the perfMedium element will be replaced by the respective element from the transformed file-->


</xsl:stylesheet>
