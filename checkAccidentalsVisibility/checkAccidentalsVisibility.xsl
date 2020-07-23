<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
		<desc>
			<p>
				<i>Changes the visibility of the accidentals (@accid => @accid.ges) for notes of the same pitch as their preceding note which is placed in the same octave and &lt;layer&gt; according to the following rules:</i>
			</p>
			<p>
				<ul>
					<li>If the checked (context) note<ul>
							<li>is not a grace note</li>
							<li>is not a second tied note</li>
							<li>does not have a cautional accident (@func='caution')</li>
						</ul>
					</li>
					<li>If before the context note exists a preceding note which<ul>
							<li>is placed in the same &lt;layer&gt;</li>
							<li>is not a grace note</li>
							<li>is not a second tied note</li>
							<li>has same @pname- and @oct-values</li>
							<li>has same @accid- or @accid.ges-values except<ul>
									<li>for the context note/@accid != "n": there are no naturals inbetween</li>
									<li>for the context note/@accid = "n": there are no other accidentals inbetween</li>
								</ul>
							</li>
						</ul>
					</li>
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
			<p>
				<p><i>Current version</i>: <b id="version">1.1.1</b>. For more info see changeLog.</p>
				<b>Author: </b>Oleksii Sapov</p>
		</desc>
	</doc>

	<include href="../lib/basic.xsl"/>
	<include href="modules/extractMainVersion.xsl"/>
	<include href="modules/checkContextNote.xsl"/>
	<include href="modules/changeAccid.xsl"/>
	<import href="changeLog.xsl"/>

	<param as="xs:string?" name="type"/>
	<param as="xs:string" name="fileName"/>



	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<template match="/">

		<variable name="changeAccid">
			<apply-templates mode="changeAccid" select="."/>
		</variable>


		<call-template name="comparisonFileDOXconvX">
			<with-param name="changeAccid" select="$changeAccid"/>
		</call-template>

		<copy-of select="$changeAccid"/>
	</template>

	<xd:doc>
		<xd:desc>Used as part of the DOXconvX.xsl only.</xd:desc>
		<xd:param name="changeAccid"/>
	</xd:doc>
	<template name="comparisonFileDOXconvX">
		<param name="changeAccid"/>

		<if test="$type = 'DOXconvX'">
			<variable name="folder" select="substring($fileName, 8, 7) || '_track-changes\'"/>
			<result-document href="{$folder || '8_' || 'checkAccidentalsVisibility.xml'}" indent="yes" method="xml">
				<copy-of select="$changeAccid"/>
			</result-document>
		</if>
	</template>

</stylesheet>
