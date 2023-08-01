<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron"  xmlns:functx="http://www.functx.com" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <ns prefix="mei" uri="http://www.music-encoding.org/ns/mei"/>

  <phase id="refTexts_v3">
    <active pattern="n"/>
    <active pattern="work_identifier"/>
    <active pattern="dur"/>
    <active pattern="xmlID"/>
    <active pattern="dynam"/>
    <active pattern="stem.sameas"/>
    <active pattern="slur.staff"/>
    <active pattern="sameAs"/>
    <active pattern="slur-tie"/>
  </phase>

  <phase id="altTexts_v3">
    <active pattern="work_identifier"/>
    <active pattern="dur"/>
    <active pattern="xmlID"/>
    <active pattern="reg-type.resp"/>
    <active pattern="unclear-cert.reason"/>
    <active pattern="lb"/>
    <active pattern="dynam"/>
    <active pattern="stem.sameas"/>
    <active pattern="slur.staff"/>
    <active pattern="sameAs"/>
    <active pattern="slur-tie"/>
  </phase>

  <phase id="refTexts_v4">
    <active pattern="n"/>
    <active pattern="work_identifier"/>
    <active pattern="dur"/>
    <active pattern="xmlID"/>
    <active pattern="dynam"/>
    <active pattern="stem.sameas"/>
    <active pattern="slur.staff"/>
    <active pattern="sameAs"/>
    <active pattern="slur-tie"/>
  </phase>

  <phase id="altTexts_v4">
    <active pattern="work_identifier"/>
    <active pattern="dur"/>
    <active pattern="xmlID"/>
    <active pattern="reg-type.resp"/>
    <active pattern="unclear-cert.reason"/>
    <active pattern="lb"/>
    <active pattern="dynam"/>
    <active pattern="stem.sameas"/>
    <active pattern="slur.staff"/>
    <active pattern="sameAs"/>
    <active pattern="slur-tie"/>
  </phase>

  <pattern id="slur-tie">
    <rule context="mei:tie">
      <let name="refs" value="
          for $n in (@startid, @endid)
          return
            substring($n, 2)"/>

      <report role="warn" test="id($refs)[descendant::artic or @artic]">This &lt;tie&gt; should be possibly a &lt;slur&gt;, because its reference has &lt;artic&gt; or @artic.</report>
    </rule>

  </pattern>


  <pattern id="sameAs">
    <rule context="(mei:note | mei:rest | mei:mRest | mei:chord)[@sameas][not(ancestor::app)]">
      <let name="sameasVal" value="substring(@sameas, 2)"/>
      <let name="referencedElTstamp" value="id($sameasVal)/@tstamp"/>
      <assert role="error" test="@tstamp = $referencedElTstamp">The @tstamp of the &lt;<name/>&gt; referenced by @sameas must have the same value as the @tstamp of the pointer element.</assert>
    </rule>

    <rule context="mei:music//*[@sameas]">
      <let name="refName" value="substring-after(@sameas, '#') => id(.) => local-name()"/>
      <assert role="error" test="local-name() = $refName">The name of the element with @sameas and the name of the pointed element must match.</assert>
    </rule>
  </pattern>

  <pattern id="slur.staff">
    <rule context="mei:slur | mei:tie">
      <let name="startid.staff" value="
          let $reference := id(substring(@startid, 2))
          return
            if ($reference[@staff]) then
              $reference/@staff
            else
              $reference/ancestor::mei:staff/@n"/>
      <let name="endid.staff" value="
          let $reference := id(substring(@endid, 2))
          return
            if ($reference[@staff]) then
              $reference/@staff
            else
              $reference/ancestor::mei:staff/@n"/>

      <let name="allValsPointer" value="distinct-values(($startid.staff, $endid.staff))"/>
      <let name="staffVals" value="tokenize(@staff, '\s')"/>

      <assert role="warning" test="$staffVals = $allValsPointer">Check the values for <name/>/@staff.</assert>
      
      <let name="startid.note" value="id(substring(@startid, 2))"/>
      <let name="endid.note" value="id(substring(@endid, 2))"/>
      <let name="currentLayerID" value="ancestor::mei:layer/@xml:id"/>
      <report role="warning" test="$startid.note/preceding::mei:note[(@xml:id = $endid.note/@xml:id) and (ancestor::mei:layer/@xml:id = $currentLayerID)]">The note linked by @startid is placed before the note linked by @endid.</report>
    </rule>
 
  </pattern>

  <pattern id="stem.sameas">
    <rule context="@stem.sameas">
      <let name="ref.id" value="substring(., 2)"/>
      <assert role="warning" test="../@tstamp = //mei:note[@xml:id = $ref.id]/@tstamp">The linked notes by @stem.sameas should have the same @tstamp values.</assert>
    </rule>
    <p>The linked notes by @stem.sameas should have the same @tstamp values.</p>
  </pattern>

  <pattern id="xmlID">
    <let name="elementList" value="
        'reg', 'supplied', 'corr', 'unclear', 'artic', 'accid', 'orig',
        'sic', 'choice'"/>
    <rule context="mei:body//*[not(local-name() = ($elementList))]">
      <assert icon="published-editions.png" role="error" test="@xml:id">The element &lt; <name/> > must have an @xml:id.</assert>
      <p>All elements in &lt;body> have @xml:id (Regel für Schema?)</p>
    </rule>
    <rule context="mei:body//*[local-name() = ($elementList)]">
      <assert role="error" sqf:fix="addID" test="@xml:id">
        <name/> must have an @xml:id</assert>
      <sqf:fix id="addID">
        <sqf:description>
          <sqf:title>Add @xml:id</sqf:title>
        </sqf:description>
        <let name="newID" value="
            if ((local-name() = 'accid') or (local-name() = 'artic')) then
              concat(local-name(), '_', substring-after(ancestor::mei:note/@xml:id, '_'))
            else
              concat(local-name(), '_', substring-after(descendant::node()[@xml:id][1]/@xml:id, '_'))"/>
        <sqf:add node-type="attribute" select="$newID" target="xml:id"/>
      </sqf:fix>
    </rule>
    <p>'reg', 'supplied', 'corr', 'unclear', 'artic', 'accid', 'orig', 'sic', 'choice' have @xml:id which is derived form their context node.</p>
  </pattern>
  <pattern id="dur">
    <rule context="mei:note[not(@sameas)] | mei:rest[not(@sameas)]">
      <report role="error" sqf:fix="addDur" test="not(ancestor::mei:chord) and not(@dur)">&lt;<name/>/> must have @dur.</report>
      <let name="currentID" value="@xml:id"/>
      <!--	check if other note/rest have @dots-->
      <let name="otherDots" value="boolean(ancestor::mei:chord//(mei:note | mei:rest)[@dots and (@xml:id != $currentID)])"/>
      <report role="warning" sqf:fix="addDots" test="ancestor::mei:chord and $otherDots and not(@dots)">This &lt;<name/>/> must also have @dots.</report>

      <p>(&lt;note>[not(@sameas)]or &lt;rest>[not(@sameas)]) must have @dur. Optionally: @dots (if other elements in this chord do have).</p>
      <sqf:fix id="addDur">
        <sqf:description>
          <sqf:title>add @dur</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="number(4)" target="dur"/>
      </sqf:fix>
      <sqf:fix id="addDots">
        <sqf:description>
          <sqf:title>add @dots="0"</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="number(0)" target="dots"/>
      </sqf:fix>
    </rule>
  </pattern>
  <!--/////-->


  <pattern id="unclear-cert.reason">
    <rule context="mei:unclear[mei:artic]">
      <let name="values" value="'ambiguous_shape', 'illegible'"/>
      <assert role="warn" sqf:fix="addShape addIllegible" test="@reason[. = $values]">
        <name/> must have @reason = 'ambiguous_shape', 'illegible'</assert>


      <sqf:fix id="addShape">
        <sqf:description>
          <sqf:title>Add @reason="ambiguous_shape"</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="'ambiguous_shape'" target="reason"/>
      </sqf:fix>
      <sqf:fix id="addIllegible">
        <sqf:description>
          <sqf:title>Add @reason="illegible"</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="'illegible'" target="reason"/>
      </sqf:fix>
    </rule>
    <rule context="mei:unclear[mei:dynam]">
      <let name="values" value="'ambiguous_position', 'illegible'"/>
      <assert role="warn" sqf:fix="addShape addIllegible" test="@reason[. = $values]">
        <name/> must have @reason = 'ambiguous_position', 'illegible'</assert>


      <sqf:fix id="addShape">
        <sqf:description>
          <sqf:title>Add @reason="ambiguous_position"</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="'ambiguous_position'" target="reason"/>
      </sqf:fix>
      <sqf:fix id="addIllegible">
        <sqf:description>
          <sqf:title>Add @reason="illegible"</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="'illegible'" target="reason"/>
      </sqf:fix>
    </rule>
  </pattern>

  <pattern id="reg-type.resp">
    <rule context="mei:reg">
      <assert role="warn" sqf:fix="shorthand accid_mod positioning alt_representation doubling alt_notation structural_repetition new_value" test="@type">
        <name/> should have @type</assert>
      <sqf:fix id="shorthand">
        <sqf:description>
          <sqf:title>Add @type="shorthand"</sqf:title>
          <sqf:p>Notationsabbreviaturen f. einzelne musikalische Zeichen, auch Taktwiederholungen.</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'shorthand'" target="type"/>
      </sqf:fix>
      <sqf:fix id="structural_repetition">
        <sqf:description>
          <sqf:title>Add @type="structural_repetition"</sqf:title>
          <sqf:p>Wiederholen/Einfügen von Abschnitten.</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'structural_repetition'" target="type"/>
      </sqf:fix>
      <sqf:fix id="alt_notation">
        <sqf:description>
          <sqf:title>Add @type="alt_notation"</sqf:title>
          <sqf:p>Musik: alternative Schreibweise, z.B. stimmig vs. akkordisch, über Taktstrich übergebundene Note vs. punktierte Note</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'alt_notation'" target="type"/>
      </sqf:fix>
      <sqf:fix id="doubling">
        <sqf:description>
          <sqf:title>Add @type="doubling"</sqf:title>
          <sqf:p>Musik: Doppelung einer Stimme durch eine andere; Notationsabbreviatur, aber eine einzelne Stimme bezogen.</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'doubling'" target="type"/>
      </sqf:fix>
      <sqf:fix id="alt_representation">
        <sqf:description>
          <sqf:title>Add @type="alt_representation"</sqf:title>
          <sqf:p>Text: alternative Schreibweise, aufgelöste Textabbreviatur.</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'alt_representation'" target="type"/>
      </sqf:fix>
      <sqf:fix id="positioning">
        <sqf:description>
          <sqf:title>Add @type="positioning"</sqf:title>
          <sqf:p>Veränderte Position eines Objekts, i.d.R. vertikale Position relativ zum Notensystem (über oder unter der Notenzeile</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'positioning'" target="type"/>
      </sqf:fix>
      <sqf:fix id="accid_mod">
        <sqf:description>
          <sqf:title>Add @type="accid_mod"</sqf:title>
          <sqf:p>Standardisierte Akzidentiensetzung.</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'accid_mod'" target="type"/>
      </sqf:fix>
      <sqf:fix id="new_value">
        <sqf:description>
          <sqf:title>Add @type="YourValue"</sqf:title>
          <sqf:p>Insert user-defined value.</sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="'YourValue'" target="type"/>
      </sqf:fix>
      <assert role="warn" sqf:fix="addResp" test="@resp">
        <name/> should have @resp</assert>
      <sqf:fix id="addResp">
        <sqf:description>
          <sqf:title>Add @resp="#DME-editors"</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="'#DME-editors'" target="resp"/>
      </sqf:fix>
      <!--if child::mei:unclear should have @resp-->
    </rule>
    <p>'reg' should have @type, @resp.</p>
  </pattern>
  <pattern id="n">
    <rule context="mei:pb | mei:ending | mei:mdiv">
      <assert role="error" sqf:fix="addN" test="@n">@n is missing</assert>
      <sqf:fix id="addN">
        <sqf:description>
          <sqf:title>Add @n</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="'YourNumber'" target="n"/>
      </sqf:fix>
    </rule>
    <p>(&lt;pb> or &lt;ending> or &lt;mdiv>) has @n</p>
  </pattern>

  <pattern id="work_identifier">
    <rule context="mei:work">
      <assert role="error" test="mei:identifier"> Work identifier tag is missing!</assert>
    </rule>
    <!--<rule context="mei:work/mei:identifier">
			<assert role="warn" sqf:fix="addWork addMovement" test="@type[. = ('work', 'movement')]">@type is missing. Its should refer either to a complete work (@type="work") or to a movement (@type="movement")! </assert>
			<sqf:fix id="addWork">
				<sqf:description>
					<sqf:title>Add 'work'</sqf:title>
				</sqf:description>
				<sqf:replace match="@type" node-type="attribute" select="'work'" target="type"/>
			</sqf:fix>


			<sqf:fix id="addMovement">
				<sqf:description>
					<sqf:title>Add 'movement'</sqf:title>
				</sqf:description>
				<sqf:replace match="@type" node-type="attribute" select="'movement'" target="type"/>
			</sqf:fix>


			<assert role="warn" sqf:fix="addAuth_ISM-IDW addAuth_GND addKAuth_KV6 addAuth_KVonline" test="@authority">&lt;dentifier> needs @authority</assert>
			<sqf:fix id="addAuth_ISM-IDW">
				<sqf:description>
					<sqf:title>Add authority="ISM-IDW"</sqf:title>
				</sqf:description>
				<sqf:add node-type="attribute" select="'ISM-IDW'" target="authority"/>
			</sqf:fix>


			<sqf:fix id="addAuth_GND">
				<sqf:description>
					<sqf:title>Add authority="GND"</sqf:title>
				</sqf:description>
				<sqf:add node-type="attribute" select="'GND'" target="authority"/>
			</sqf:fix>


			<sqf:fix id="addKAuth_KV6">
				<sqf:description>
					<sqf:title>Add authority="KV6"</sqf:title>
				</sqf:description>
				<sqf:add node-type="attribute" select="'KV6'" target="authority"/>
			</sqf:fix>


			<sqf:fix id="addAuth_KVonline">
				<sqf:description>
					<sqf:title>Add authority="KVonline"</sqf:title>
				</sqf:description>
				<sqf:add node-type="attribute" select="'KVonline'" target="authority"/>
			</sqf:fix>


			<assert role="warn" sqf:fix="addGND addISM-IDW addKV6 addKVonline" test="@authority = ('GND', 'ISM-IDW', 'KV6', 'KVonline')">@authority value be 'ISM-IDW','KV6', 'KVonline' or 'GND'</assert>
			<sqf:fix id="addISM-IDW">
				<sqf:description>
					<sqf:title>Add 'ISM-IDW'</sqf:title>
				</sqf:description>
				<sqf:replace match="@authority" node-type="attribute" select="'ISM-IDW'" target="authority"/>
			</sqf:fix>


			<sqf:fix id="addGND">
				<sqf:description>
					<sqf:title>Add 'GND'</sqf:title>
				</sqf:description>
				<sqf:replace match="@authority" node-type="attribute" select="'GND'" target="authority"/>
			</sqf:fix>


			<sqf:fix id="addKV6">
				<sqf:description>
					<sqf:title>Add 'KV6'</sqf:title>
				</sqf:description>
				<sqf:replace match="@authority" node-type="attribute" select="'KV6'" target="authority"/>
			</sqf:fix>


			<sqf:fix id="addKVonline">
				<sqf:description>
					<sqf:title>Add 'KVonline'</sqf:title>
				</sqf:description>
				<sqf:replace match="@authority" node-type="attribute" select="'KVonline'" target="authority"/>
			</sqf:fix>
			<p>&lt;work> has at least one &lt;identifier>. &lt;identifier> has: @authority with values 'ISM-IDW', 'GND', 'KV6', 'KVonline'. @type with values 'work', 'movement'.</p>
		</rule>-->
  </pattern>


  <pattern id="lb">
    <rule context="mei:body//mei:lb">
      <assert role="warn" sqf:fix="rend" test="./parent::mei:rend">The &lt; <name/> > has to be wrapped in 'rend'.</assert>
      <sqf:fix id="rend">
        <sqf:description>
          <sqf:title>Wrap in rend</sqf:title>
        </sqf:description>
        <sqf:add match="parent::node()" node-type="element" select="descendant::node()" target="rend"/>
        <sqf:delete match=". | ../child::text()"/>
      </sqf:fix>
      <p>The &lt;lb> has to be wrapped in 'rend'.</p>
    </rule>
  </pattern>
  <pattern id="measure_id">
    <rule context="mei:measure">
      <assert test=".[substring-before(substring-after(@xml:id, 'm'), '_') eq @n]">There has to be a number in @xml:id of &lt; <name/> >, e. g. xml:id="m{1}_..." and its value be equal to @n.</assert>
      <p>&lt;measure>/@xml:id: the number, e. g. xml:id="m{1}_..." is equal to @n.</p>
    </rule>
  </pattern>
  <pattern id="dynam">
    <let name="dynamValues" value="'cre', 'scen', 'crescen', 'do', 'scendo'"/>
    <rule context="mei:dynam[. = $dynamValues]">
      <report role="warn" sqf:fix="dynamLabel dynamVgrp" test=".[not(@label) or not(@vgrp)]">
        <name/> with text 'cre', 'scen', 'crescen', 'do', 'scendo' may have @label, @vgrp.</report>
      <sqf:fix id="dynamLabel">
        <sqf:description>
          <sqf:title>Add @label</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="'completeDynamName'" target="label"/>
      </sqf:fix>
      <sqf:fix id="dynamVgrp">
        <sqf:description>
          <sqf:title>Add @vgrp</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="xs:int(1)" target="vgrp"/>
      </sqf:fix>
      <p>&lt;dynam> with text 'cre', 'scen', 'crescen', 'do', 'scendo' has @label, @vgrp.</p>
    </rule>
  </pattern>


  <phase id="checkReferences">
    <active pattern="checkReferences_"/>
  </phase>
  <pattern id="checkReferences_">
    <rule context="(@endid | @startid | @resp | @classcode | @facs | @next | @prev | mei:facsimile/@decls | @data | @plist | mei:music//mei:ref/@target)">
      <let name="IDs" value="ancestor::mei:mei//@xml:id/string()"/>
      <let name="vals" value="tokenize(., '\s')"/>

      <xsl:variable as="xs:integer*" name="test">
        <xsl:for-each select="
            for $val in $vals
            return
              substring-after($val, '#')">
          <xsl:variable name="currentVal" select="."/>
          <xsl:iterate select="$IDs">
            <xsl:choose>
              <xsl:when test=". = $currentVal">
                <xsl:sequence select="xs:int(1)"/>
                <!--		<xsl:break/>-->
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="xs:int(0)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:iterate>
        </xsl:for-each>
      </xsl:variable>
      <!--<assert test="
					every $i in substring-after(., '#')
						satisfies $i = $IDs">
				<name/> =" <value-of select="."/> " points to a @xml:id which wasn't declared.</assert>-->
      <!--			<xsl:for-each select="substring-after(., '#')">
				<xsl:value-of select="."/>
				
			</xsl:for-each>-->

      <report test="sum($test) != count($vals)">
        <name/> =" <value-of select="."/> " points to an @xml:id which wasn't declared. </report>

      <p>The value of (@endid | @startid | @analog | @resp | @classcode | @facs | @next | @prev | mei:facsimile/@decls | @data |@plist) has to point to an existing @xml:id</p>
    </rule>
    <rule context="@analog">
      <let name="IDs" value="ancestor::mei:mei//@xml:id/string()"/>
      <let name="vals" value="tokenize(., '\s')"/>

      <xsl:variable as="xs:integer*" name="test">
        <xsl:for-each select="
            for $val in $vals
            return
              substring-after($val, '#')">
          <xsl:variable name="currentVal" select="."/>
          <xsl:iterate select="$IDs">
            <xsl:choose>
              <xsl:when test=". = $currentVal">
                <xsl:sequence select="xs:int(1)"/>
                <!--		<xsl:break/>-->
              </xsl:when>
              <xsl:otherwise>
                <xsl:sequence select="xs:int(0)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:iterate>
        </xsl:for-each>
      </xsl:variable>
      <let name="exceptions" value="matches(., '(.*:.*)|(#KVonline)')"/>
      <report test="(sum($test) != count($vals)) and not($exceptions)">
        <name/> =" <value-of select="."/> " points to an @xml:id which wasn't declared. </report>
    </rule>
  </pattern>
  <!--	<pattern id="chord">
		<rule context="mei:chord[not(@sameas) or not(@copyof)]">
			<assert test="@dur">@dur required.</assert>
			<report test="(descendant::mei:note[@dots] or descendant::mei:rest[@dots]) and not(@dots)" sqf:fix="dots" role="info">@dots is recommended.</report>
			<sqf:fix id="dots">
				<sqf:description>
					<sqf:title>add @dots</sqf:title>
				</sqf:description>
				<let name="maxDots" value="max(descendant::mei:note/@dots)"/>
				<sqf:add node-type="attribute" target="dots" select="$maxDots"/>
			</sqf:fix>
		</rule>
	</pattern>-->
</schema>
