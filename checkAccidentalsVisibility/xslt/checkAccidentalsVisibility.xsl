<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:i>Changes the visibility of the accidentals (@accid => @accid.ges) for notes of the same pitch as their preceding note which is placed in the same octave and &lt;layer&gt; according to the following rules:</xd:i>
			</xd:p>
			<xd:p>
				<xd:ul>
					<xd:li>If the checked (context) note<xd:ul>
							<xd:li>is not a grace note</xd:li>
							<xd:li>is not a second tied note</xd:li>
							<xd:li>does not have a cautional accident (@func='caution')</xd:li>
						</xd:ul>
					</xd:li>
					<xd:li>If before the context note exists a preceding note which<xd:ul>
							<xd:li>is placed in the same &lt;layer&gt;</xd:li>
							<xd:li>is not a grace note</xd:li>
							<xd:li>is not a second tied note</xd:li>
							<xd:li>has same @pname- and @oct-values</xd:li>
							<xd:li>has same @accid- or @accid.ges-values except<xd:ul>
									<xd:li>for the context note/@accid != "n": there are no naturals inbetween</xd:li>
									<xd:li>for the context note/@accid = "n": there are no other accidentals inbetween</xd:li>
								</xd:ul>
							</xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>Notes:</xd:b>
				<xd:ul>
					<xd:li>It is assumed that the given values for @accid are correct.</xd:li>
					<xd:li>If &lt;note&gt; contains &lt;app&gt; or &lt;choice&gt;, the @accid-/@accid.ges-values are taken from &lt;lem&gt; or &lt;corr&gt; respectively. In absence of those, the value is derived from the first child node.</xd:li>
					<xd:li>There are few cases when a note may have two accidentals. For instance, after f/@accid="x" may happen f/accid/@accid="n" accid/@accid="s". In such cases the @accid is always preserved. When the note is not a context note but a compared note the comparing value is taken from the last &lt;accid&gt;.</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>Sep 26, 2018, version 1.0<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>19.10.2018: <xd:i>1.0.1</xd:i></xd:li>
							<xd:li>20.09.2019: <xd:i>1.1.0</xd:i></xd:li>
							<xd:li>18.02.2020: <xd:i>1.1.1</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
		</xd:desc>
	</xd:doc>

	<xsl:include href="modules/basic.xsl"/>
	<xsl:include href="modules/extractMainVersion.xsl"/>
	<xsl:include href="modules/checkContextNote.xsl"/>
	<xsl:include href="modules/changeAccid.xsl"/>


	<xsl:variable as="xs:string*" name="checkAccidentalsVisibility">
		<xsl:variable name="extractMainVersion">
			<xsl:apply-templates mode="extractMainVersion" select="."/>
		</xsl:variable>
		<xsl:apply-templates mode="checkAccidentalsVisibility" select="$extractMainVersion//@accid"/>
	</xsl:variable>

	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="/">
		<xsl:apply-templates mode="changeAccid" select="."/>
	</xsl:template>

</xsl:stylesheet>
