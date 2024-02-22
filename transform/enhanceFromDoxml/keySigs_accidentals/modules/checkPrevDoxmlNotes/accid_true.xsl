<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">
  <include href="if_accid_n.xsl"/>

  <template name="accid_true">
    <param as="element()*" name="doxmlNote" tunnel="yes"/>

    <variable as="map(xs:string, xs:string)" name="doxmlNote.params">
      <call-template name="storeParams">
        <with-param as="element()*" name="el" select="$doxmlNote"/>
      </call-template>
    </variable>


    <variable as="xs:string*" name="iterate">
      <call-template name="iterate">
        <with-param name="doxmlNote.params" select="$doxmlNote.params"/>
      </call-template>
    </variable>
    <sequence select="$iterate[last()]"/>
    
  </template>

  <template name="iterate">
    <param as="node()*" name="doxmlPrecedingLines" tunnel="yes"/>
    <param as="map(xs:string, xs:string)" name="doxmlNote.params"/>
    <param as="xs:string" name="mode" tunnel="yes"/>

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
            <when test="$mode = 'keySigAccid'">
              <choose>
                <when test="not($precedingAccid = '')">
                  <!--should be @accid.ges-->
                  <value-of select="'false'"/>
                  <break/>
                </when>
                <when test="$precedingAccid = ''">
                  <!--should be @accid-->
                  <value-of select="'true'"/>
                  <break/>
                </when>
              </choose>
            </when>
            <when test="$mode = 'keySigNoAccid'">
              <choose>
                <when test="not($precedingAccid = '')">
                  <!--@accid="n"-->
                  <value-of select="'true'"/>
                  <break/>
                </when>
                <when test="$precedingAccid = ''">
                  <!--@accid.ges="n"-->
                  <value-of select="'false'"/>
                  <break/>
                </when>
              </choose>
            </when>
            <when test="$mode = 'doxmlNoteHasAccid'">
              <choose>
                <when test="$precedingAccid = map:get($doxmlNote.params, 'accid')">
                  <!--@accid.ges-->
                  <value-of select="'false'"/>
                  <break/>
                </when>
                <otherwise>
                  <!--@accid-->
                  <value-of select="'true'"/>
                  <break/>
                </otherwise>
              </choose>
            </when>
            <when test="$mode = 'doxmlNoteHasNOAccid'">
              <choose>
                <when test="$precedingAccid = '' and @accid.explicit[. = 'true']">
                  <value-of select="'false_accidgesn'"/>
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
                      <value-of select="'false_accidgesn'"/>
                    </when>
                    <otherwise>
                      <value-of select="'false'"/>
                    </otherwise>
                  </choose>
                  <break/>
                </when>
                <otherwise>
                  <!--@accid will remain or @accid='n' will be inserted depending it the note has @accid or not-->
                  <value-of select="'true'"/>
                  <break/>
                </otherwise>
              </choose>
            </when>
          </choose>
        </when>
        <otherwise>
          <choose>
            <when test="$mode = 'keySigAccid'">
              <value-of select="'false'"/>
            </when>
            <when test="$mode = 'keySigNoAccid'">
              <value-of select="'true'"/>
            </when>
            <when test="$mode = 'doxmlNoteHasAccid'">
              <value-of select="'true'"/>
            </when>
            <when test="$mode = 'doxmlNoteHasNOAccid'">
              <value-of select="'false'"/>
            </when>
          </choose>
        </otherwise>
      </choose>
    </iterate>

  </template>


  <template name="storeParams">
    <param as="element()*" name="el"/>

    <map>
      <map-entry key="'pname'" select="$el/string(@pname)"/>
      <map-entry key="'oct'" select="$el/string(@oct)"/>
      <map-entry key="'accid'" select="$el/string(@accid)"/>
    </map>
  </template>


  <template name="T.samePitchOct">
    <param as="map(xs:string, xs:string)" name="paramsCurrent"/>
    <param as="map(xs:string, xs:string)" name="paramsPreceding"/>

    <variable as="xs:boolean+" name="checkEveryAttr">
      <for-each select="'pname', 'oct'">
        <variable name="paramsCurrentVal" select="map:get($paramsCurrent, .)"/>
        <variable name="paramsPrecedingVal" select="map:get($paramsPreceding, .)"/>

        <choose>
          <when test="($paramsCurrentVal = '') or ($paramsPrecedingVal = '')">
            <value-of select="false()"/>
          </when>
          <otherwise>
            <sequence select="
                if ($paramsCurrentVal = $paramsPrecedingVal) then
                  true()
                else
                  false()"/>
          </otherwise>
        </choose>
      </for-each>
    </variable>

    <sequence>
      <choose>
        <when test="
            every $a in $checkEveryAttr
              satisfies $a = true()">
          <value-of select="true()"/>
        </when>
        <otherwise>
          <value-of select="false()"/>
        </otherwise>
      </choose>
    </sequence>

  </template>
</stylesheet>
