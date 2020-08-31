<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2" xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <ns prefix="mei" uri="http://www.music-encoding.org/ns/mei"/>

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

      <assert role="warning" sqf:fix="addAttributeUserValue" test="matches(@$attribute , ('^' || '$RegEx' || '$'))">The &lt;<name/>&gt; must have @$attribute and match the regular expression $RegEx.</assert>
    </rule>
  </pattern>


  <pattern abstract="true" id="attributeValueDescendants">
    <title>The attribute value of the element has to be the highest or the lowest value of the respective attribute of its descendants.</title>
    <parameters xmlns="http://oxygenxml.com/ns/schematron/params">
      <parameter>
        <name>element</name>
        <desc>The parent element of the attribute. Example: 'mei:note'.</desc>
      </parameter>
      <parameter>
        <name>attribute</name>
        <desc>The local name of the attribute. Example: 'dur'.</desc>
      </parameter>
      <parameter>
        <name>descendants</name>
        <desc>Name of the descendant elements. Example: 'mei:note'.</desc>
      </parameter>
      <parameter>
        <name>fence</name>
        <desc>Values: 'min' / 'max. I.e. the lowest or the highest value of the respective attribute.</desc>
      </parameter>
      <parameter>
        <name>phase</name>
        <desc>refTexts_meiHead, refTexts_music, altTexts_meiHead, altTexts_music</desc>
      </parameter>
    </parameters>
    <rule context="$element">


      <let name="fValue" value="
				if ('$fence' = 'lowest') then
						min(descendant::node()//@$attribute) 
				else
					if ('$fence' = 'highest') then 
							max(descendant::node()//@$attribute) 
				else 
				() "/>


      <report role="warning" sqf:fix="max-min_attribute" test="not(@$attribute) and $descendants or (@$attribute != $fValue) ">It is recommended to have @$attribute on &lt;<name/>/&gt;. Its value must be the $fence value of the @$attribute of the &lt;<name/>/&gt; descendants.</report>
    </rule>
  </pattern>


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
    <sqf:fix id="addAttributeUserValue">
      <sqf:param abstract="true" name="attribute"/>

      <sqf:description>
        <sqf:title>Add @$attribute</sqf:title>
      </sqf:description>
      <sqf:user-entry name="inputAttributeValue">
        <sqf:description>
          <sqf:title>Input the value for the @$attribute.</sqf:title>
        </sqf:description>
      </sqf:user-entry>

      <sqf:add node-type="attribute" select="$inputAttributeValue" target="$attribute"/>
    </sqf:fix>

    <!--////////-->
    <sqf:fix id="max-min_attribute">
      <sqf:param abstract="true" name="attribute"/>
      <sqf:param abstract="true" name="fence"/>
      <sqf:description>
        <sqf:title>Add / update @$attribute</sqf:title>
      </sqf:description>
      <let name="value" value="if ('$fence' = 'lowest') 
        then
        min(descendant::node()//@$attribute)
        else if ('$fence' = 'highest')
        then
        max(descendant::node()//@$attribute)
        else ('fence is not defined') "/>

      <sqf:add node-type="attribute" select="$value" target="$attribute"/>
    </sqf:fix>
  </sqf:fixes>

</schema>
