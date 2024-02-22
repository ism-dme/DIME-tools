<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:i>Swaps the layers in the second &lt;staff&gt;.</xd:i> </xd:p>
			<xd:p>Developed for the specific case of piano music: after dox2mei has swapped layers No. 6 and 7 which should correspond to the layers No. 1 and 2</xd:p>			
			<xd:p>
				<xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:b>Created on: </xd:b>2020-10-12<xd:ul>
					<xd:li>
						<xd:i>Versions</xd:i>: <xd:ul>
							<xd:li>2021-07-08 : <xd:i>1.0.1</xd:i>(add restriction for layers@n=6,7)</xd:li>
							<xd:li>2020-10-12 : <xd:i>1.0.0</xd:i></xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<include href="../../lib/basic.xsl"/>


  <template match="staff[@n = 2][count(layer) > 1][descendant::layer[@n[.=6]]and descendant::layer[@n[.=7]]]">
		<copy>
			<apply-templates select="@*"/>
			<layer n="1" xmlns="http://www.music-encoding.org/ns/mei">
				<xsl:attribute name="xml:id" select="./layer[@n = 6]/@xml:id"/>
				<xsl:apply-templates select="./layer[@n = 7]/*"/>

			</layer>
			<layer n="2" xmlns="http://www.music-encoding.org/ns/mei">
				<xsl:attribute name="xml:id" select="./layer[@n = 7]/@xml:id"/>
				<xsl:apply-templates select="./layer[@n = 6]/*"/>
			</layer>
			<apply-templates select="./layer[not(@n = (1, 2, 6, 7))]"/>

		</copy>
	</template>
	
</stylesheet>
