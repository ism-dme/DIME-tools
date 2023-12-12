<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd mei dme map" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <include href="checkPrecedingNotes.xsl"/>

  <xd:doc>
    <xd:desc>
      <xd:p>Checks if the note is a grace note, has cautional accident, has two accidentals (e.g. natural and b) or is a second tied note.</xd:p>
      <xd:p>Returns a sequence of @xml:ids (string) of the elements, where the @accid must be changed.</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="
    body//@accid[not(some $a in $accid.explicit
    satisfies $a = ancestor::note/@doxml.id)][not(parent::accid/@func[. = 'caution'] or ancestor::note[@grace])]" mode="checkAccidentalsVisibility">

    <variable as="xs:string*" name="allTiedNotes">
      <call-template name="allTiedNotes"/>
    </variable>

    <variable as="xs:boolean" name="change">
      <choose>
        <when test="count(../ancestor::note//accid) > 1 (:if there are more then one accid:)">
          <sequence select="false()"/>
        </when>
        <when test="
            (:if it is a tied note:)
            if (some $a in $allTiedNotes
              satisfies (ancestor::note/@xml:id) = $a) then
              true()
            else
              false()">
          <sequence select="true()"/>
        </when>
        <otherwise>
          <call-template name="checkPrecedingNotes">
            <with-param name="allTiedNotes" select="$allTiedNotes" tunnel="yes"/>
          </call-template>
        </otherwise>
      </choose>
    </variable>

    <if test="$change">
      <value-of select="ancestor::*[@xml:id][1]/string(@xml:id)"/>
    </if>
  </template>

  <xd:doc>
    <xd:desc>Returns a sequence of @xml:ids of all second tied notes except those which first tied note is placed in the same &lt;layer&gt;.</xd:desc>
  </xd:doc>
  <template name="allTiedNotes">
    <variable name="body" select="ancestor::body"/>
    <for-each select="$body//tie">

      <variable name="startid" select="substring(@startid, 2)"/>
      <variable name="endid" select="substring(@endid, 2)"/>
      <variable name="startidLayer" select="$body//*[@xml:id = $startid]/ancestor::layer/@xml:id"/>
      <variable name="endidLayer" select="$body//*[@xml:id = $endid]/ancestor::layer/@xml:id"/>
      <if test="not($startidLayer = $endidLayer)">
        <sequence select="$endid"/>
      </if>
    </for-each>
  </template>


</stylesheet>
