<?xml version="1.0" encoding="UTF-8"?>
<!--Do not edit this file directly! This file is generated automatically by processing  styleguide.ditamap. If you want to change the rules, edit the corresponding sections 
marked with audience="rules" in the corresponding topic files.-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:functx="http://www.functx.com"
        queryBinding="xslt2">
   <ns prefix="mei" uri="http://www.music-encoding.org/ns/mei"/>
   <phase id="refTexts_music">
      <active pattern="annot_1"/>
      <active pattern="annot_2"/>
      <active pattern="supplied_1"/>
      <active pattern="chord_1"/>
      <active pattern="chord_2"/>
      <active pattern="chord_3"/>
      <active pattern="mRest_1"/>
      <active pattern="facsimile_1"/>
      <active pattern="hairpin_1"/>
      <active pattern="corr_1"/>
		    <active pattern="n"/>
		    <active pattern="clef"/>
		    <active pattern="dur"/>
		    <active pattern="xmlID"/>
		    <active pattern="dynam"/>
		    <active pattern="stem.sameas"/>
		    <active pattern="slur.staff"/>
		    <active pattern="sameAs"/>
		    <active pattern="slur-tie"/>
	  </phase>
   <phase id="altTexts_music">
      <active pattern="annot_1"/>
      <active pattern="annot_3"/>
      <active pattern="supplied_1"/>
      <active pattern="unclear_1"/>
      <active pattern="unclear_2"/>
      <active pattern="chord_1"/>
      <active pattern="chord_2"/>
      <active pattern="chord_3"/>
      <active pattern="mRest_1"/>
      <active pattern="hairpin_1"/>
      <active pattern="corr_1"/>
		    <active pattern="clef"/>
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
   <phase id="refTexts_meiHead">
      <active pattern="work_identifier"/>
   </phase>
   <phase id="altTexts_meiHead">
      <active pattern="work_identifier"/>
   </phase>
   <phase id="checkReferences">
      <active pattern="checkReferences_"/>
   </phase>
   <include href="library.sch#checkAttributeValue"/>
   <include href="library.sch#attributeValueDescendants"/>
   <include href="library.sch#matchesAttributeValue"/>
   <include href="quickFix-library.xml"/>
   <include href="unique_rules.sch#slur-tie"/>
   <include href="unique_rules.sch#sameAs"/>
   <include href="unique_rules.sch#slur.staff"/>
   <include href="unique_rules.sch#stem.sameas"/>
   <include href="unique_rules.sch#xmlID"/>
   <include href="unique_rules.sch#dur"/>
   <include href="unique_rules.sch#clef"/>
   <include href="unique_rules.sch#unclear-cert.reason"/>
   <include href="unique_rules.sch#reg-type.resp"/>
   <include href="unique_rules.sch#n"/>
   <include href="unique_rules.sch#work_identifier"/>
   <include href="unique_rules.sch#lb"/>
   <include href="unique_rules.sch#measure_id"/>
   <include href="unique_rules.sch#dynam"/>
   <include href="unique_rules.sch#checkReferences_"/>
   <!--Generated from topics/annotation.dita.-->
   <pattern id="annot_1"
            is-a="checkAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/annotation.html">
      <param name="element" value="mei:body//mei:annot[@plist]"/>
      <param name="attribute" value="type"/>
      <param name="attrValue"
             value="appGrp[[]]---choiceGrp[[]]---suppGrp[[]]---handshift[[]]"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
      <param name="message"
             value=" (for annot used as grouping device with @plist)."/>
   </pattern>
   <!--Generated from topics/annotation.dita.-->
   <pattern id="annot_2"
            is-a="checkAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/annotation.html">
      <param name="element" value="mei:body//mei:annot[not(@plist)]"/>
      <param name="attribute" value="type"/>
      <param name="attrValue"
             value="NMA-note[[]]---DME-comment[[]]---DME-observation[[]]---DME-reference[[]]"/>
      <param name="phase" value="refTexts_music"/>
      <param name="message" value=" (for annot used as text with no @plist)."/>
   </pattern>
   <!--Generated from topics/annotation.dita.-->
   <pattern id="annot_3"
            is-a="checkAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/annotation.html">
      <param name="element" value="mei:body//mei:annot[not(@plist)]"/>
      <param name="attribute" value="type"/>
      <param name="attrValue"
             value="DME-comment[[]]---DME-observation[[]]---DME-reference[[]]"/>
      <param name="phase" value="altTexts_music"/>
      <param name="message" value=" (for annot used as text with no @plist)."/>
   </pattern>
   <!--Generated from topics/supplied.dita.-->
   <pattern id="supplied_1"
            is-a="matchesAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/supplied.html">
      <param name="element" value="mei:supplied"/>
      <param name="attribute" value="resp"/>
      <param name="RegEx" value="(#NMA-editors)|(#DME-editors)"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
   </pattern>
   <!--Generated from topics/unclear.dita.-->
   <pattern id="unclear_1"
            is-a="checkAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/unclear.html">
      <param name="element" value="mei:unclear[mei:slur | mei:tie]"/>
      <param name="attribute" value="reason"/>
      <param name="attrValue"
             value="ambiguous_start[[explanation test]]---ambiguous_ending[[]]---split[[]]---system_break[[]]---ambiguous_start ambiguous_ending[[]]---illegible[[]]"/>
      <param name="phase" value="altTexts_music"/>
      <param name="message" value="."/>
   </pattern>
   <!--Generated from topics/unclear.dita.-->
   <pattern id="unclear_2"
            is-a="checkAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/unclear.html">
      <param name="element" value="mei:unclear[mei:note]"/>
      <param name="attribute" value="reason"/>
      <param name="attrValue" value="pitch[[]]---duration[[]]---illegible[[]]"/>
      <param name="phase" value="altTexts_music"/>
      <param name="message" value="."/>
   </pattern>
   <!--Generated from topics/chord.dita.-->
   <pattern id="chord_1"
            is-a="attributeValueDescendants"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/chord.html">
      <param name="element" value="mei:chord[not(@sameas) or not(@copyof)]"/>
      <param name="attribute" value="dur"/>
      <param name="descendants"
             value="(descendant::mei:note or descendant::mei:rest)"/>
      <param name="fence" value="min"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
   </pattern>
   <!--Generated from topics/chord.dita.-->
   <pattern id="chord_2"
            is-a="matchesAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/chord.html">
      <param name="element" value="mei:chord[not(@sameas) or not(@copyof)]"/>
      <param name="attribute" value="tstamp"/>
      <param name="RegEx" value="\d(\.(\d){1,7})?"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
   </pattern>
   <!--Generated from topics/chord.dita.-->
   <pattern id="chord_3"
            is-a="attributeValueDescendants"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/chord.html">
      <param name="element" value="mei:chord[not(@sameas) or not(@copyof)]"/>
      <param name="attribute" value="dots"/>
      <param name="descendants"
             value="(descendant::mei:note[@dots] or descendant::mei:rest[@dots])"/>
      <param name="fence" value="max"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
   </pattern>
   <!--Generated from topics/mrest.dita.-->
   <pattern id="mRest_1"
            is-a="checkAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/mrest.html">
      <param name="element" value="mei:mRest"/>
      <param name="attribute" value="tstamp"/>
      <param name="attrValue" value="1"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
      <param name="message" value="."/>
   </pattern>
   <!--Generated from topics/facsimile.dita.-->
   <pattern id="facsimile_1"
            is-a="matchesAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/facsimile.html">
      <param name="element" value="mei:facsimile"/>
      <param name="attribute" value="decls"/>
      <param name="RegEx" value="#digital_image[\d]?"/>
      <param name="phase" value="refTexts_music"/>
   </pattern>
   <!--Generated from topics/hairpin.dita.-->
   <pattern id="hairpin_1"
            is-a="matchesAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/hairpin.html">
      <param name="element" value="*[@tstamp2]"/>
      <param name="attribute" value="tstamp2"/>
      <param name="RegEx" value="([0-9]+m\s*\+\s*)[0-9]+(\.?[0-9]*)?"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
   </pattern>
   <!--Generated from topics/corr.dita.-->
   <pattern id="corr_1"
            is-a="matchesAttributeValue"
            see="file:///D:/development/DIME/dime-tools_documentation/schematron/webhelp-responsive/topics/corr.html">
      <param name="element" value="mei:corr"/>
      <param name="attribute" value="resp"/>
      <param name="RegEx" value="(#NMA-editors)|(#DME-editors)"/>
      <param name="phase" value="refTexts_music, altTexts_music"/>
   </pattern>
</schema>
