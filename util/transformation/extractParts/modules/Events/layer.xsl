<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <variable name="events.attributes2remove" select="('stem.dir', 'stem.sameas', 'ploc', 'oloc')"/>

  <xd:doc>
    <xd:desc>
      <xd:p>Resolves layer[@sameas] or processes layer::descendants.</xd:p>
    </xd:desc>
  </xd:doc>
  <template match="layer" mode="layer">
    <choose>
      <when test="@sameas">
        <variable name="sameas.ref.el" select="substring-after(@sameas, '#') => id()"/>
        <copy-of select="functx:add-or-update-attributes($sameas.ref.el, xs:QName('xml:id'), @xml:id)"/>
      </when>
      <when test="descendant::node()">
        <copy>
          <call-template name="create.first.layer"/>
          <call-template name="layer.descendants">
            <with-param name="els" select="node()"/>
          </call-template>
        </copy>
      </when>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Resolves @sameas. Original attributes from the 'pointer' are preserved. Attributes defined in $events.attributes2remove are deleted. Recursive template.</xd:p>
    </xd:desc>
    <xd:param name="els"/>
  </xd:doc>
  <template name="layer.descendants">
    <param name="els"/>

    <for-each select="$els">
      <choose>
        <when test="@sameas and not(node())">
          <variable as="element()" name="resolved.el">
            <call-template name="v.resolved.el"/>
          </variable>
          <copy-of select="functx:remove-attributes($resolved.el, $events.attributes2remove)"/>
        </when>
        <!--Assumes node().-->
        <when test="@sameas">
          <copy>
            <variable name="sameas.ref.el" select="substring-after(@sameas, '#') => id()"/>
            <variable name="current.attrs" select="@* except @sameas"/>
            <variable name="sameas.ref.el.attrs" select="$sameas.ref.el/@*[not(local-name() = ($events.attributes2remove, $current.attrs/local-name()))]"/>
            <copy-of select="$current.attrs"/>
            <copy-of select="$sameas.ref.el.attrs"/>
            <call-template name="layer.descendants">
              <with-param name="els" select="node()"/>
            </call-template>
          </copy>
        </when>
        <when test="node()">
          <copy>
            <apply-templates select="@*[not(local-name() = $events.attributes2remove)]"/>
            <call-template name="layer.descendants">
              <with-param name="els" select="node()"/>
            </call-template>
          </copy>
        </when>
        <!--Do not process text nodes.-->
        <when test=". instance of element()">
          <copy-of select="functx:remove-attributes(., $events.attributes2remove)"/>
        </when>
        <otherwise>
          <copy-of select="."/>
        </otherwise>
      </choose>
    </for-each>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Returns referenced element. Replaces the attribute values or adds the attributes from the pointer element.</xd:p>
    </xd:desc>
  </xd:doc>
  <template name="v.resolved.el">
    <variable name="pointedEl" select="id(substring-after(@sameas, '#'))"/>
    <!--Attributes which will be preserved-->
    <variable name="attrs" select="@*[local-name() != 'sameas']"/>
    <variable as="xs:QName*" name="attrsQNames">
      <for-each select="$attrs">
        <sequence select="xs:QName(name())"/>
      </for-each>
    </variable>
    <variable as="xs:string*" name="vals">
      <for-each select="$attrs">
        <sequence select="string()"/>
      </for-each>
    </variable>
    <copy-of select="functx:add-or-update-attributes($pointedEl, $attrsQNames, $vals)"/>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="create.first.layer">
    <attribute name="n" select="'1'"/>
    <attribute name="xml:id" select="@xml:id"/>
    <apply-templates select="@* except (@n, @xml:id)"/>
  </template>

</stylesheet>
