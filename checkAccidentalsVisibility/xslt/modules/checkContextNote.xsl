<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


	<xsl:include href="checkPrecedingNotes.xsl"/>

	<xd:doc>
		<xd:desc>
			<xd:p>Checks if the note is a grace note, has cautional accident, has two accidentals (e.g. natural and b) or is a second tied note.</xd:p>
			<xd:p>Returns a sequence of @xml:ids (string) of the elements, where the @accid must be changed.</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="body//@accid[not(parent::accid/@func[. = 'caution'] or ancestor::note[@grace])]" mode="checkAccidentalsVisibility">

		<xsl:message>Checking <xsl:value-of select="../@xml:id"/></xsl:message>
		<xsl:variable as="xs:string*" name="allTiedNotes">
			<xsl:call-template name="allTiedNotes"/>
		</xsl:variable>

		<xsl:variable as="xs:boolean" name="change">
			<xsl:choose>
				<xsl:when test="count(../ancestor::note//accid) > 1 (:if there are more then one accid:)">
					<xsl:sequence select="false()"/>
				</xsl:when>
				<xsl:when test="
						(:if it is a tied note:)
						if (some $a in $allTiedNotes
							satisfies (ancestor::note/@xml:id) = $a) then
							true()
						else
							false()">
					<xsl:sequence select="true()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="checkPrecedingNotes">
						<xsl:with-param name="allTiedNotes" select="$allTiedNotes" tunnel="yes"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$change">
			<xsl:value-of select="ancestor::*[@xml:id][1]/string(@xml:id)"/>
		</xsl:if>
	</xsl:template>

	<xd:doc>
		<xd:desc>Returns a sequence of @xml:ids of all second tied notes except those which first tied note is placed in the same &lt;layer&gt;.</xd:desc>
	</xd:doc>
	<xsl:template name="allTiedNotes">
		<xsl:variable name="body" select="ancestor::body"/>
		<xsl:for-each select="$body//tie">

			<xsl:variable name="startid" select="substring(@startid, 2)"/>
			<xsl:variable name="endid" select="substring(@endid, 2)"/>
			<xsl:variable name="startidLayer" select="$body//*[@xml:id = $startid]/ancestor::layer/@xml:id"/>
			<xsl:variable name="endidLayer" select="$body//*[@xml:id = $endid]/ancestor::layer/@xml:id"/>
			<xsl:if test="not($startidLayer = $endidLayer)">
				<xsl:sequence select="$endid"/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
