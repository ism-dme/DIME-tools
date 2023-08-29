<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <template name="controlevent.tstamp">
    <choose>
      <when test="local-name() = 'dir'">
        <variable as="xs:string+" name="dirs.exclude" select="('a 2', 'a&#8198;2', 'a due')"/>
        <choose>
          <when test="(rend/text() | text()) = $dirs.exclude"/>
          <otherwise>
            <copy>
              <call-template name="copy.controlevent.attrs"/>
            </copy>
          </otherwise>
        </choose>
      </when>
      <otherwise>
        <copy>
          <call-template name="copy.controlevent.attrs"/>
        </copy>
      </otherwise>
    </choose>
  </template>


</stylesheet>
