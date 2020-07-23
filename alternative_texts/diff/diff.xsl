<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.mozarteum.at/ns/dme">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:b>Description:</xd:b> The system of stylesheets compares two type of editions of the same musical work: <xd:i>Reference Text</xd:i> and <xd:i>Alternative Text</xd:i>. The base file (<xd:i>RT</xd:i>) and the compared file (<xd:i>AT</xd:i>) are defined in the diff.dita by the editor.</xd:p>
			<xd:p>diff-DIME outputs three files:<xd:ul>
					<xd:li>diff-proposals_{}.csv</xd:li>
					<xd:li>possible-errors_{}.csv</xd:li>
					<xd:li>app-diff_{}.xml (used as input for the rendering in the DIME user interface MoVi).</xd:li>
				</xd:ul></xd:p>
			<xd:p>The diff-list_{}.csv contains pairs of IDs of the elements which are diferent or are present/absent in the editions. It is meant to be edited manually by the editors based on the diff-proposals, possible-errors and their decisions.</xd:p>
			<xd:p><xd:b>Algorithm</xd:b>: <xd:ul>
					<xd:li>Two sequences of the elements - 'base' and 'compared' - are generated due to the constraints, e.g. children of &lt;rdg/>, &lt;orig/> are excluded. The constraints are defined in the diff-config.xml and in the dme:excludeEls().</xd:li>
					<xd:li>Thre are three basic comparison cases:<xd:ul>
							<xd:li>There exists a corresponding pair of the elements in both files. Subsequently, further comparison is performed by the dme:edition-equal()</xd:li>
							<xd:li>'base' element has no corresponding item</xd:li>
							<xd:li>'compared' element has no corresponding item</xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>Notes:</xd:b>
				<xd:ul>
					<xd:li>It is assumed that diff-list_{}.csv is stored in a 'diff' subfolder.</xd:li>
					<xd:li>Using a transformation scenario in Oxygen set <xd:i>XML URL</xd:i> and <xd:i>XSL URL</xd:i> to ${currentFileURL}.<xd:ul/>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>July 13, 2018, version 1.0.0<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>17.08.2018: <xd:i>1.0.1</xd:i></xd:li>
							<xd:li>06.09.2018: <xd:i>1.1.0</xd:i></xd:li>
							<xd:li>20.12.2018: <xd:i>1.2.0</xd:i></xd:li>
							<xd:li>30.04.2019: <xd:i>1.3.0</xd:i></xd:li>
							<xd:li>13.05.2019: <xd:i>1.4.0</xd:i></xd:li>
							<xd:li>22.05.2019: <xd:i>1.5.0</xd:i></xd:li>
							<xd:li>28.05.2019: <xd:i>1.6.0</xd:i></xd:li>
							<xd:li>08.11.2019: <xd:i>1.6.1</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<!--TODO:
	|| 
	||
	-->
	<xsl:param name="config"/>

	<xsl:include href="modules/compare.xsl"/>
	<xsl:include href="modules/create-csv.xsl"/>
	<xsl:include href="modules/create_app-diff.xsl"/>

	<!--=====================	Paths to the input files and the document nodes =====================-->
	<!--<xsl:variable as="document-node()" name="diffInput" select="doc('diff-DIME.xml')"/>-->
	<xsl:variable name="parameters" select="doc($config)/id('diff')/dme:parameters"/>
	<xsl:variable as="map(xs:string, xs:string)" name="diffInputVals">
		<xsl:map>
			<xsl:map-entry key="'baseFile'" select="$parameters//dme:file[@class = 'base']/string(@file)"/>
			<xsl:map-entry key="'comparedFile'" select="$parameters//dme:file[@class = 'compare']/string(@file)"/>
		</xsl:map>
	</xsl:variable>
	<xsl:variable as="document-node()" name="baseDocNode" select="doc(map:get($diffInputVals, 'baseFile'))"/>
	<xsl:variable as="document-node()" name="comparedDocNode" select="doc(map:get($diffInputVals, 'comparedFile'))"/>
	<xsl:variable name="diffBaseURI" select="replace(base-uri($baseDocNode), $baseFileName, '/diff/')"/>
	<xsl:variable name="diffListPATH" select="concat($diffBaseURI, 'diff-list_', $KV-Movement, $edtType, '.csv')"/>
	<xsl:variable name="diffList" select="unparsed-text-lines($diffListPATH, 'UTF-8')"/>
	<xsl:variable as="document-node()" name="elementsList" select="doc('./modules/diff-config.xml')"/>
	<!--=====================	Paths to the input files and the document nodes =====================-->
	<!--	File names and the edition type   -->
	<xsl:variable name="baseFileName" select="tokenize(map:get($diffInputVals, 'baseFile'), '/')[last()]"/>
	<xsl:variable name="comparedFileName" select="tokenize(map:get($diffInputVals, 'comparedFile'), '/')[last()]"/>
	<xsl:variable as="xs:string" name="edtType" select="concat('-', substring-after(tokenize($comparedFileName, '_')[1], 'dmeedt'))"/>
	<xsl:variable name="KV-Movement" select="substring-before(substring-after($baseFileName, '_'), '_')"/>
	<!--	*****  -->

	<!--*****-->
	<xsl:variable as="xs:string" name="appDiffPATH" select="concat($diffBaseURI, 'app-diff_', $KV-Movement, '.xml')"/>
	<xd:doc scope="component">
		<xd:desc>The output files.</xd:desc>
	</xd:doc>
	<xsl:template match="/">
		<xsl:variable as="xs:string" name="proposalsPATH" select="concat($diffBaseURI, 'diff-proposals_', $KV-Movement, $edtType, '.csv')"/>

		<xsl:result-document href="{$proposalsPATH}" indent="yes" method="text">
			<xsl:copy-of select="$diffProposals"/>
		</xsl:result-document>

		<xsl:variable as="xs:string" name="notAutoPATH" select="concat($diffBaseURI, 'possible-errors_', $KV-Movement, $edtType, '.csv')"/>
		<xsl:result-document href="{$notAutoPATH}" indent="yes" method="text">
			<xsl:copy-of select="$possibleErrors"/>
		</xsl:result-document>

		<xsl:result-document href="{$appDiffPATH}" indent="yes" method="xml">
			<xsl:copy-of select="$appDiff"/>
		</xsl:result-document>
		<xsl:message>Created/updated the following files: 
			<xsl:value-of select="$proposalsPATH"/>, 
			<xsl:value-of select="$notAutoPATH"/>,
			<xsl:value-of select="$appDiffPATH"/>
</xsl:message>

	</xsl:template>


	<!--elements from both files which are selected for the comparison-->
	<xsl:variable as="xs:string*" name="elsConfig" select="
			for $n in $elementsList//elementsTOcompare/*
			return
				$n/local-name()"/>
	<xsl:variable as="xs:string*" name="exclAncestors" select="
			for $n in $elementsList//excludeAncestors/*
			return
				$n/local-name()"/>

	<!--list of the base and compare elements which are prepared for the comparison-->
	<xsl:variable as="element()*" name="baseEls" select="dme:excludeEls($baseDocNode)"/>
	<xsl:variable as="element()*" name="comparedEls" select="dme:excludeEls($comparedDocNode)"/>


	<xd:doc>
		<xd:desc>Schema association must be deleted otherwise ERROR: a sequence of more than one item is not allowed</xd:desc>
	</xd:doc>
	<xsl:template match="processing-instruction('xml-model')" mode="#all"/>
	<xsl:strip-space elements="*"/>

	<xd:doc>
		<xd:desc>Needs for the cases when the document node is being changed.</xd:desc>
	</xd:doc>
	<xsl:template match="node() | @*" mode="#all">
		<!-- countRdgApp-->
		<xsl:copy>
			<xsl:apply-templates mode="#current" select="node() | @*"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
