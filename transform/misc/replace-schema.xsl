<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">



  <include href="../lib/basic.xsl"/>

  <xd:doc>
    <xd:desc>Replace schema association path relative to absolute </xd:desc>
  </xd:doc>
  <template match="processing-instruction('xml-model')">
    <variable as="xs:string" name="meiVersion" select="/mei/@meiversion"/>
    <variable as="map(*)" name="versionsMap" select="
        map {
          '4.0.1': '4.0',
          '3.0.0': '3.0'
        }"/>

    <variable as="xs:string" name="schemaVersion">
      <try>
        <sequence select="map:get($versionsMap, $meiVersion)"/>
        <catch>
          <sequence select="'NaN'"/>
        </catch>
      </try>
    </variable>

    <variable as="xs:string" name="schemaBasePath">https://raw.githubusercontent.com/ism-dme/DIME-tools/main/schemas/mei-DME-</variable>

    <variable name="newSchemaAssociation">
      <choose>
        <when test="not($schemaVersion = 'NaN')">
          <value-of select="$schemaBasePath || $schemaVersion || '.rng'"/>
        </when>
        <otherwise>
          <message>MEI version was not recognized!</message>
        </otherwise>
      </choose>
    </variable>

    <variable as="xs:string" name="schemaTypensRelaxNg" select="'http://relaxng.org/ns/structure/1.0'"/>
    <variable as="xs:string" name="schemaTypensReSchematron" select="'http://purl.oclc.org/dsdl/schematron'"/>
    <choose>
      <when test="contains(., $schemaTypensRelaxNg)">
        <processing-instruction name="xml-model" select="('href=&quot;' || $newSchemaAssociation || '&quot;', 'type=&quot;application/xml&quot;', 'schematypens=&quot;' || $schemaTypensRelaxNg || '&quot;')"/>
      </when>
      <when test="contains(., $schemaTypensReSchematron)">
        <processing-instruction name="xml-model" select="('href=&quot;' || $newSchemaAssociation || '&quot;', 'type=&quot;application/xml&quot;', 'schematypens=&quot;' || $schemaTypensReSchematron || '&quot;')"/>
      </when>
      <otherwise>
        <message>Unrecognized schematypens!</message>
      </otherwise>
    </choose>




  </template>

</stylesheet>
