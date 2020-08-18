<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<ns prefix="mei" uri="http://www.music-encoding.org/ns/mei"/>
	<pattern abstract="true" id="checkAttributeValue">
		<title>Issue a warning if an attribute has different value.</title>
		<parameters xmlns="http://oxygenxml.com/ns/schematron/params">
			<parameter>
				<name>element</name>
				<desc>Specifies the parent element of the attribute. Example: 'mei:note'</desc>
			</parameter>
			<parameter>
				<name>attribute</name>
				<desc>Specifies the attribute to check for content. Example: 'accid'</desc>
			</parameter>
			<parameter>
				<name>attrValue</name>
				<desc>Specifies the value of the attribute. Example: 'n'</desc>
			</parameter>
			<parameter>
				<name>phase</name>
				<desc>refTexts_meiHead, refTexts_music, altTexts_meiHead, altTexts_music</desc>
			</parameter>
			<parameter>
				<name>message</name>
				<desc>Additional message</desc>
			</parameter>
		</parameters>

		<rule context="$element">
			<!--			If there are multiple attribute values, they will be delimited by 'three dashes'-->
			<let name="items" value="
					if (contains('$attrValue', '---')) then
						tokenize('$attrValue', '---')
					else
						'$attrValue'"/>
			<!--			If attribute value has additional explanation, it'll be enclosed into [[...]]-->
			<let name="values" value="
					if (some $n in $items
						satisfies contains($n, '[[')) then
						for $n in $items
						return
							substring-before($n, '[[')
					else
						$items
					"/>
			<let name="beautifiedValues" value="
					for $n in $values
					return
						concat('&quot;', $n, '&quot;')"/>
			<assert role="warning" sqf:fix="addAttribute" test="some $n in $values satisfies
						@$attribute[. = $n]">It is recommended to have @$attribute=[ <value-of select="$beautifiedValues"/> ] on &lt; <name/> /&gt;$message </assert>
		</rule>
	</pattern>
	<pattern abstract="true" id="maxAttributeValueDescendants">
		<title>The attribute value of element has to be the highest value of the same attribute of the defined descendants. E.g. chord/@dots and note/@dots</title>
		<parameters xmlns="http://oxygenxml.com/ns/schematron/params">
			<parameter>
				<name>element</name>
				<desc>The parent element of the attribute. Example: 'mei:note'</desc>
			</parameter>
			<parameter>
				<name>attribute</name>
				<desc>The attribute to check. Example: 'dots'</desc>
			</parameter>
			<parameter>
				<name>descendants</name>
				<desc>name of the descendant elements</desc>
			</parameter>
			<parameter>
				<name>phase</name>
				<desc>Type: refTexts_meiHead, refTexts_music, altTexts_meiHead, altTexts_music</desc>
			</parameter>
		</parameters>

		<rule context="$element">
			<report role="warning" sqf:fix="maxAttribute" test="not(@$attribute) and $descendants">It is recommended to have @$attribute on &lt;<name/>/&gt;</report>
		</rule>
	</pattern>
	<pattern abstract="true" id="minAttributeValueDescendants">
		<title>The attribute value of element has to be the lowest value of the same attribute of the defined descendants. E.g. chord/@dur and note/@dur.</title>
		<parameters xmlns="http://oxygenxml.com/ns/schematron/params">
			<parameter>
				<name>element</name>
				<desc>The parent element of the attribute. Example: 'mei:note'</desc>
			</parameter>
			<parameter>
				<name>attribute</name>
				<desc>The attribute to check. Example: 'dur'</desc>
			</parameter>
			<parameter>
				<name>descendants</name>
				<desc>name of the descendant elements. E.g.: 'mei:note'</desc>
			</parameter>
			<parameter>
				<name>phase</name>
				<desc>Type: refTexts_meiHead, refTexts_music, altTexts_meiHead, altTexts_music</desc>
			</parameter>
		</parameters>

		<rule context="$element">
			<report role="warning" sqf:fix="minAttribute" test="not(@$attribute) and $descendants">It is recommended to have @$attribute on &lt;<name/>/&gt;</report>
		</rule>
	</pattern>
	<pattern abstract="true" id="matchesAttributeValue">
		<title>The attribute value of the element has to match the pattern defined in the regular expression.</title>
		<parameters xmlns="http://oxygenxml.com/ns/schematron/params">
			<parameter>
				<name>element</name>
				<desc>The parent element of the attribute. Example: 'mei:note'</desc>
			</parameter>
			<parameter>
				<name>attribute</name>
				<desc>The attribute to check. Example: 'dur'</desc>
			</parameter>
			<parameter>
				<name>RegEx</name>
				<desc>Regular expression to match.</desc>
			</parameter>
			<parameter>
				<name>phase</name>
				<desc>Type: refTexts_meiHead, refTexts_music, altTexts_meiHead, altTexts_music</desc>
			</parameter>
		</parameters>

		<rule context="$element">
			<assert role="warning" test="matches(	@$attribute , ('^' || '$RegEx' || '$'))">The @$attribute on &lt;<name/>/&gt; has to match the regular expression $RegEx.</assert>
		</rule>
	</pattern>


	<sqf:fixes xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		<sqf:fix id="addAttribute" use-for-each="1 to count($items)">
			<sqf:param abstract="true" name="attribute"/>
			<sqf:param abstract="true" name="attrValue"/>
			<let name="explanations" value="
					if (some $n in $items
						satisfies contains($n, '[[')) then
						for $n in $items
						return
							substring-before(substring-after($n, '[['), ']]')
					else
						()"/>
			<sqf:description>
				<sqf:title>Add @$attribute=" <value-of select="$values[$sqf:current]"/> "</sqf:title>
				<sqf:p>
					<value-of select="$explanations[$sqf:current]"/>
				</sqf:p>
			</sqf:description>
			<sqf:replace match="@$attribute" node-type="attribute" select="$values[$sqf:current]" target="$attribute" use-when="@$attribute"/>
			<sqf:add node-type="attribute" select="$values[$sqf:current]" target="$attribute" use-when="not(@$attribute)"/>
		</sqf:fix>
		<!--////////-->
		<sqf:fix id="maxAttribute">
			<sqf:param abstract="true" name="attribute"/>
			<sqf:description>
				<sqf:title>add @$attribute</sqf:title>
			</sqf:description>
			<let name="maxValue" value="max(descendant::node()//@$attribute)"/>
			<sqf:add node-type="attribute" select="$maxValue" target="$attribute"/>
		</sqf:fix>
		<!--////////-->
		<sqf:fix id="minAttribute">
			<sqf:param abstract="true" name="attribute"/>
			<sqf:description>
				<sqf:title>add @$attribute</sqf:title>
			</sqf:description>
			<let name="minValue" value="min(descendant::node()//@$attribute)"/>
			<sqf:add node-type="attribute" select="$minValue" target="$attribute"/>
		</sqf:fix>
	</sqf:fixes>

</schema>
