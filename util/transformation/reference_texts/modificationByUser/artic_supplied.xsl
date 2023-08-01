<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd mei math uuid dme" version="3.0" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:uuid="java:java.util.UUID" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p>
				<xd:i>Makes articulation supplied for defined measure(s), staff(s) and @artic values, e.g.: </xd:i>
				<xd:ul>
					<xd:li>From</xd:li>
					<xd:li><![CDATA[<note xml:id="note_d1e2750-B1" pname="b" oct="3" dur="8" artic="spicc" accid.ges="f" tstamp="1"/>]]></xd:li>
					<xd:li>TO</xd:li>
					<xd:li>
						<![CDATA[  <note xml:id="note_d1e2750-B1" pname="b" oct="3" dur="8" accid.ges="f" tstamp="1">
                        <supplied xml:id="supplied_d1e2750-B1" resp="#NMA-editors">
                          <artic xml:id="artic_d1e2750-B1" artic="spicc"/>
                        </supplied>
                      </note>]]></xd:li>
				</xd:ul>
				<xd:ul>
					<xd:li>
						<xd:b>Notes: </xd:b>
						<xd:ul>
							<xd:li>measure numbers like '10A' are not preccessed (NB: ignore 'transformation problems' message.</xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
			<xd:p>
				<xd:b>User Guide: </xd:b>
				<xd:i>Parameters are set via dialog box (use oxygen scenario)</xd:i>
			</xd:p>
			<xd:p><xd:b>Created on: </xd:b>April 5, 2018</xd:p>
			<xd:p><xd:b>Author: </xd:b>Oleksii Sapov</xd:p>
			<xd:p>
				<xd:ul>
					<xd:li>
						<xd:b>Updates:</xd:b>
						<xd:ul>
							<xd:li>Nov 22, 2018</xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>


	<!--##################### PARAMETERS ######################-->
	<!--Number of the measure to start (including)-->
	<xsl:param as="xs:string" name="a.mdivID"/>
	<xsl:param as="xs:integer" name="aa.greater_equal"/>
	<!--Number of ther measure to end (including)-->
	<xsl:param as="xs:integer" name="b.less_equal"/>
	<xsl:param as="xs:string" name="c.staff_n"/>
	<xsl:param as="xs:string" name="d.artic"/>
	<xsl:param as="xs:string" name="e.resp"/>
	<!--######################################################-->
	<!--  <xsl:variable name="staffs" select="
      for $n in tokenize($c.staff_n, ',')
      return
        xs:integer($n)" as="xs:integer+"/>
-->

	<xsl:include href="../../lib/basic.xsl"/>
	<xsl:variable as="xs:string+" name="staffs" select="tokenize($c.staff_n, ',')"/>


	<xd:doc>
		<xd:desc/>
	</xd:doc>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xd:doc>
		<xd:desc>supply artic</xd:desc>
	</xd:doc>
	<xsl:template match="mei:mdiv[@xml:id = $a.mdivID]//mei:staff[@n = $staffs]//mei:note[(@artic = $d.artic) and (ancestor::mei:measure[(@n >= $aa.greater_equal) and (@n &lt;= $b.less_equal)])]">
		<xsl:variable name="note_ID" select="substring-after(@xml:id, '_')"/>
		<note xmlns="http://www.music-encoding.org/ns/mei">
			<xsl:if test=".[@xml:id]">
				<xsl:attribute name="xml:id" select="@xml:id"/>
			</xsl:if>
			<xsl:if test=".[@doxml.id]">
				<xsl:attribute name="doxml.id" select="@doxml.id"/>
			</xsl:if>
			<xsl:attribute name="pname" select="@pname"/>
			<xsl:attribute name="oct" select="@oct"/>
			<xsl:attribute name="dur" select="@dur"/>
			<xsl:if test=".[@accid]">
				<xsl:attribute name="accid" select="@accid"/>
			</xsl:if>
			<xsl:if test=".[@accid.ges]">
				<xsl:attribute name="accid.ges" select="@accid.ges"/>
			</xsl:if>
			<xsl:if test=".[@tstamp]">
				<xsl:attribute name="tstamp" select="@tstamp"/>
			</xsl:if>
			<xsl:if test=".[@stem.dir]">
				<xsl:attribute name="stem.dir" select="@stem.dir"/>
			</xsl:if>
			<!--just in case there would be any other attributes-->
			<xsl:apply-templates select="@* except (@xml:id, @doxml.id, @pname, @oct, @dur, @accid, @accid.ges, @tstamp, @stem.dir, @artic), node()"/>
			<supplied>
				<xsl:variable name="suppliedID" select="concat('supplied_', $note_ID)"/>
				<xsl:attribute name="xml:id" select="$suppliedID"/>
				<xsl:attribute name="resp" select="$e.resp"/>
				<artic>
					<xsl:variable name="articID" select="concat('artic_', $note_ID)"/>
					<xsl:attribute name="xml:id" select="$articID"/>
					<xsl:attribute name="artic" select="@artic"/>
				</artic>
			</supplied>
		</note>
		<xsl:message>'<xsl:value-of select="@xml:id"/>' got a supplied artic</xsl:message>

	</xsl:template>
	<xd:doc>
		<xd:desc>
			<xd:p>
				<xd:ul>
					<xd:li>
						<xd:b>Parameters for oxygen scenario:</xd:b>
						<xd:ul>
							<xd:li><xd:b>a.mdivID:</xd:b> ${ask('mdiv @xml:id', generic, 'mdiv_123')}</xd:li>
							<xd:li><xd:b>aa.greater_equal:</xd:b> ${ask('start measure @n', generic, '1')}</xd:li>
							<xd:li><xd:b>b.less_equal:</xd:b> ${ask('end measure @n', generic, '1')}</xd:li>
							<xd:li><xd:b>c.staff_n:</xd:b> ${ask('staff @n (multiple input possible; comma separated, no spaces)', generic, '1,2')}</xd:li>
							<xd:li><xd:b>d.artic:</xd:b> ${ask('articulation to match', generic, 'spicc')}</xd:li>
							<xd:li><xd:b>e.resp:</xd:b> ${ask('@resp', editable_combobox, ('#NMA-editors':'#NMA-editors';'#DME-editors':'#DME-editors'), '#NMA-editors')}</xd:li>
						</xd:ul>
					</xd:li>
				</xd:ul>
			</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:mode on-no-match="shallow-copy"/>
</xsl:stylesheet>
