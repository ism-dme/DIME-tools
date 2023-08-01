<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <template name="if_accid_n">
    <param name="doxmlNote" tunnel="yes"/>

    <variable as="element()?" name="second_tied_note">
      <call-template name="secondTiedNote">
        <with-param name="doxmlNote" select="$doxmlNote"/>
      </call-template>
    </variable>

    <choose>
      <!--Assuming that the doxml note does not have @accid-->
      <when test="$doxmlNote/@accid.explicit[. = 'true']">
        <sequence select="'true'"/>
      </when>
      <when test="$second_tied_note">
        <variable as="xs:string" name="first_tied_note_accid_n">
          <call-template name="checkPrevDoxmlNotes_if_accid_n">
            <with-param name="doxmlNote" select="$second_tied_note" tunnel="yes"/>
          </call-template>
        </variable>

        <choose>
          <when test="contains($first_tied_note_accid_n, 'true')">
            <sequence select="'true'"/>
          </when>
          <otherwise>
            <sequence select="'false'"/>
          </otherwise>
        </choose>

      </when>
      <otherwise>
        <call-template name="checkPrevDoxmlNotes_if_accid_n"/>
      </otherwise>
    </choose>
  </template>

  <template name="checkPrevDoxmlNotes_if_accid_n">
    <param name="doxmlNote" tunnel="yes"/>

    <variable as="element()*" name="doxmlPrecedingLines">
      <call-template name="T.doxmlPrecedingLines"/>
    </variable>
    
    <variable as="element()?" name="second_tied_note">
      <call-template name="secondTiedNote">
        <with-param name="doxmlNote" select="$doxmlNote"/>
      </call-template>
    </variable>
    


    <choose>      
      <when test="$doxmlNote/@accid.explicit">
        <sequence select="'true'"/>
      </when>
      <when test="$second_tied_note">
        
        <variable as="xs:string" name="first_tied_note_accid_n">
          <call-template name="checkPrevDoxmlNotes_if_accid_n">
            <with-param name="doxmlNote" select="$second_tied_note" tunnel="yes"/>
          </call-template>
        </variable>
        
        <choose>
          <when test="contains($first_tied_note_accid_n, 'true')">
            <sequence select="'true'"/>
          </when>
          <otherwise>
            <sequence select="'false'"/>
          </otherwise>
        </choose>
      </when>
      <!--First note in the measure-->
      <when test="empty($doxmlPrecedingLines)">
        <sequence select="'false'"/>
      </when>           
      <otherwise>
        <variable as="map(xs:string, xs:string)" name="doxmlNote.params">
          <call-template name="storeParams">
            <with-param as="element()*" name="el" select="$doxmlNote"/>
          </call-template>
        </variable>

        <variable as="xs:string+" name="iterate_if_accid_n">
          <call-template name="iterate_if_accid_n">
            <with-param as="node()*" name="doxmlPrecedingLines" select="$doxmlPrecedingLines"/>
            <with-param name="doxmlNote.params" select="$doxmlNote.params"/>
          </call-template>
        </variable>
        <sequence select="$iterate_if_accid_n[last()]"/>
      </otherwise>
    </choose>
  </template>

  <template name="iterate_if_accid_n">
    <param as="node()*" name="doxmlPrecedingLines"/>
    <param as="map(xs:string, xs:string)" name="doxmlNote.params"/>

    <iterate select="$doxmlPrecedingLines">

      <variable as="map(xs:string, xs:string?)" name="paramsPreceding">
        <call-template name="storeParams">
          <with-param name="el" select="."/>
        </call-template>
      </variable>

      <variable as="xs:boolean" name="samePitchOct">
        <call-template name="T.samePitchOct">
          <with-param name="paramsCurrent" select="$doxmlNote.params"/>
          <with-param name="paramsPreceding" select="$paramsPreceding"/>
        </call-template>
      </variable>

      <choose>
        <when test="$samePitchOct">
          <variable name="precedingAccid" select="map:get($paramsPreceding, 'accid')"/>

          <choose>
            <when test="$precedingAccid = ''">
              <choose>
                <when test="@accid.explicit[. = 'true']">
                  <value-of select="'true'"/>
                  <break/>
                </when>
                <when test="$precedingAccid = ''">

                  <variable as="xs:string" name="if_accid_n">
                    <call-template name="if_accid_n">
                      <with-param name="doxmlNote" select="." tunnel="yes"/>
                    </call-template>
                  </variable>

                  <choose>
                    <when test="contains($if_accid_n, 'true')">
                      <value-of select="'true'"/>
                    </when>
                    <otherwise>
                      <value-of select="'false'"/>
                    </otherwise>
                  </choose>
                  <break/>
                </when>
                <otherwise>
                  <!--@accid-->
                  <value-of select="'true'"/>
                  <break/>
                </otherwise>
              </choose>
            </when>
            <otherwise>
              <!--@accid-->
              <value-of select="'true'"/>
              <break/>
            </otherwise>
          </choose>
        </when>
        <otherwise>
          <sequence select="'false'"/>
        </otherwise>
      </choose>
    </iterate>
  </template>

</stylesheet>
