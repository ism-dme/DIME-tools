<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx mei map xl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xd:doc>
    <xd:desc>&lt;staff&gt; in doxml contains @codedval with value corresponding to the instrument name (cf. perf&lt;Res&gt;). In this way these staves can be recognized. DIME guidelines say, that these staves have to have @decals=#uper/#lower which corresponds to the 'hands' declared in the &lt;perfRes&gt;</xd:desc>
  </xd:doc>
  <template match="staff" mode="decls">
    <variable as="xs:boolean" name="piano_staff" select="matches(@codedval, 'ka')"/>

    <copy>
      <if test="$piano_staff">
        <choose>
          <when test="following-sibling::staff[matches(@codedval, 'ka')]">
            <attribute name="decls" select="'#upper'"/>
          </when>
          <otherwise>
            <attribute name="decls" select="'#lower'"/>
          </otherwise>
        </choose>
      </if>
      <apply-templates select="@*, node()"/>
    </copy>
  </template>

</stylesheet>
