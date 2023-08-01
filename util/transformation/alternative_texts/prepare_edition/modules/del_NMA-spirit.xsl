<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei math uuid dme" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on: </xd:b>July 20, 2018</xd:p>
			<xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:p>
					<xd:b>Description:</xd:b>
					<xd:ul>
						<xd:li>Extracts the value from &lt;choice>/&lt;corr> <xd:a docid="app-choice">[⬇]</xd:a>, &lt;app>/&lt;lem> <xd:a docid="app">[⬇]</xd:a>, &lt;supplied> , &lt;body>//&lt;rend>, &lt;body>//&lt;ref><xd:a docid="supplied">[⬇]</xd:a></xd:li>
						<xd:li>Deletes <xd:ul>
								<xd:li>all &lt;pb>, &lt;sb>, &lt;surface>, &lt;body>//&lt;annot>, @lform [<xd:a docid="pb_sb">⬇</xd:a>]</xd:li>
								<xd:li>all @doxml.id, &lt;measure>/@facs<xd:a docid="doxml">[⬇</xd:a>]</xd:li>
								<xd:li>Elements which refers to an element in orig/rdg [<xd:a docid="orig-rdg">⬇</xd:a>]</xd:li>
								<xd:li><xd:a docid="meiHead">meiHead</xd:a> (is replaced by minimal)</xd:li>
							</xd:ul>
						</xd:li>
					</xd:ul>
				</xd:p>
			</xd:p>
		</xd:desc>
	</xd:doc>
  
	<!--<xsl:variable name="orig-rdg" select="*[ancestor::orig or ancestor::rdg]/@xml:id"/>-->


	<xd:doc id="orig-rdg">
		<xd:desc/>
	</xd:doc>
	<!--<xsl:template match="*[(@startid = $orig-rdg) or (@endid = $orig-rdg)]" mode="del_NMA-spirit"/>-->

	<xd:doc id="app-choice">
		<xd:desc/>
	</xd:doc>
<!--	<xsl:template match="choice | app" mode="del_NMA-spirit">
		<xsl:apply-templates mode="#current" select="(corr | lem | reg)/child::node()"/>
	</xsl:template>-->

	<xd:doc id="supplied">
		<xd:desc/>
	</xd:doc>
<!--	<xsl:template match="body//(rend | ref)" mode="del_NMA-spirit">
		<xsl:apply-templates mode="#current" select="child::node()"/>
	</xsl:template>-->

	<xd:doc id="pb_sb">
		<xd:desc/>
	</xd:doc>
  <!--  | annot-->
	<xsl:template match="pb | sb | surface" mode="del_NMA-spirit"/>

	<xd:doc id="doxml">
		<xd:desc/>
	</xd:doc>
	<xsl:template match="@doxml.id | measure//@facs | @lform" mode="del_NMA-spirit"/>

	<xd:doc>
		<xd:desc id="meiHead"/>
	</xd:doc>
	<xsl:template match="meiHead" mode="del_NMA-spirit">
		<xsl:copy-of select="$meiHead"/>
	</xsl:template>

	<xsl:variable name="meiHead">
		<meiHead meiversion="4.0.1" xmlns="http://www.music-encoding.org/ns/mei">
			<fileDesc xmlns="http://www.music-encoding.org/ns/mei">
				<titleStmt xmlns="http://www.music-encoding.org/ns/mei">
					<title label="NMA digital" type="unit" xmlns="http://www.music-encoding.org/ns/mei">
						<xsl:value-of select="$newFileName"/>
					</title>
				</titleStmt>
				<pubStmt/>
			</fileDesc>
		</meiHead>
	</xsl:variable>



</xsl:stylesheet>
