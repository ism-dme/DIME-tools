<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <include href="startid.xsl"/>
  <include href="startid_endid.xsl"/>
  <include href="tstamp.xsl"/>


  <variable as="xs:string*" name="controlEvents">
    <call-template name="get.config.items">
      <with-param name="id" select="'controlEvents'"/>
    </call-template>
  </variable>

  <xd:doc>
    <xd:desc>
      <xd:p>Matches the <xd:i>controlEvents</xd:i> defined in the <xd:i>lists.xml</xd:i>.</xd:p>
      <xd:p>Elements which are assigned to a not requested staff are deleted.</xd:p>
      <xd:p>Elements with no @layer are copied.</xd:p>
      <xd:p>Elements which contains @layer but the value doesn't correspond to the requested layer will be deleted.</xd:p>
      <xd:ul>
        <xd:li>Example 1: dynam[@staff="2" and @layer="1 2"], $parts=|2.1|. The dynam will be processed.</xd:li>
        <xd:li>Example 2: slur[@staff="2" and @layer="2"], $parts=|2.1|. The slur will be deleted.</xd:li>
        <xd:li>Example 3: tie[@staff="2" and not(@layer)], $parts=|2.1|. The tie will be processed.</xd:li>
      </xd:ul>
    </xd:desc>
  </xd:doc>
  <template mode="extract.controlEvents" match="music//*[local-name() = $controlEvents]">

    <choose>
      <when test="@staff = $req.staves.extract.layers">
        <variable as="xs:string*" name="req.layer" select="map:get(dme:requested-staves-layers(), @staff)"/>

        <choose>
          <!--Current @layer is not requested.-->
          <when test="@layer and not(contains(@layer, $req.layer))"/>
          <otherwise>
            <call-template name="pointer.types">
              <with-param name="req.layer" select="$req.layer" tunnel="yes"/>
            </call-template>
          </otherwise>
        </choose>
      </when>
      <when test="@staff = $req.staves.complete">
        <copy-of select="."/>
      </when>
      <otherwise/>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Cases:<xd:ul>
          <xd:li>@tstamp</xd:li>
          <xd:li>@startid only</xd:li>
          <xd:li>@startid and @endid</xd:li>
          <xd:li>In some (exceptional) case, the combinations of @start/@endid with @tstamp/@tstmp2 may exist.</xd:li>
        </xd:ul>
      </xd:p>
    </xd:desc>
    <xd:param name="req.layer"/>
  </xd:doc>
  <template name="pointer.types">
    <param name="req.layer" tunnel="yes"/>

    <choose>
      <when test="@tstamp">
        <if test="boolean(contains(@layer, $req.layer))">
          <call-template name="controlevent.tstamp"/>
        </if>
      </when>
      <when test="@startid and not(@endid)">
        <call-template name="swap.references">
          <with-param name="pointers" select="'startid'" tunnel="yes"/>
        </call-template>
      </when>
      <when test="@startid and @endid">
        <call-template name="swap.references">
          <with-param name="pointers" select="'startid', 'endid'" tunnel="yes"/>
        </call-template>
      </when>
    </choose>
  </template>

  <xd:doc>
    <xd:desc/>
    <xd:param name="pointers"/>
  </xd:doc>
  <template name="swap.references">
    <param name="pointers" tunnel="yes"/>

    <variable as="map(xs:string, xs:string)*" name="refs">
      <call-template name="t.refs"/>
    </variable>

    <choose>
      <when test="count($pointers) = 1 (:The number of the $pointers could be either 1 or 2 :)">
        <call-template name="startid">
          <with-param name="refs" select="$refs" tunnel="yes"/>
        </call-template>
      </when>
      <otherwise>
        <call-template name="two.pointers.case">
          <with-param name="refs" select="$refs" tunnel="yes"/>
        </call-template>
      </otherwise>
    </choose>

  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Returns a map: <xd:ul>
          <xd:li><xd:b>key</xd:b>: current pointer, e.g. 'startid'</xd:li>
          <xd:li><xd:b>value</xd:b>: value of the new reference(s), e.g. 'note_123' or 'note_123,note_456'. Note: multiple values are possible if there exist an app or a choice</xd:li>
        </xd:ul>
      </xd:p>
    </xd:desc>
    <xd:param name="req.layer"/>
    <xd:param name="pointers"/>
  </xd:doc>
  <template name="t.refs">
    <param name="req.layer" tunnel="yes"/>
    <param name="pointers" tunnel="yes"/>

    <variable name="current.body.node" select="ancestor::body" as="element()"/>

    <map>
      <for-each select="@*[local-name() = $pointers]">
        <variable name="referenced.node" select="$global.context.item/id(substring-after(current(), '#'))"/>

        <variable as="xs:boolean" name="swap.required">
          <call-template name="t.swap.required">
            <with-param name="referenced.node" select="$referenced.node"/>
          </call-template>
        </variable>

        <choose>
          <when test="$swap.required">
            <variable as="attribute()*" name="new.references" select="$current.body.node/id($referenced.node/ancestor::staff/@xml:id)//node()[@tstamp = $referenced.node/@tstamp]/@xml:id"/>

            <map-entry key="local-name(.)" select="string-join(($new.references), ',')"/>
          </when>
          <otherwise>
            <map-entry key="local-name(.)" select="substring-after(string(.), '#')"/>
          </otherwise>
        </choose>

      </for-each>
    </map>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Tests if the value of the current pointer should be changed or preserved.</xd:p>
      <xd:p>Returns: 'true' or 'false' as xs:boolean</xd:p>
    </xd:desc>
    <xd:param name="req.layer"/>
    <xd:param name="referenced.node"/>
  </xd:doc>
  <template name="t.swap.required">
    <param name="req.layer" tunnel="yes"/>
    <param name="referenced.node"/>

    <variable as="xs:boolean" name="req.layer.assigned" select="boolean(contains(../@layer, $req.layer)) (:Check if the @layer contains the requested layer value. E.g. for @layer='1' and $parts=|1.2| it will be false().:)"/>

    <choose>
      <when test="$req.layer.assigned">

        <variable as="xs:string" name="referenced.node.layer.n" select="$referenced.node/ancestor::layer/@n/string()"/>
        <variable name="req.layer.sameas" select="
            let $referenced.node.measure.n := $referenced.node/ancestor::measure/@n,
              $curr.staff := ../@staff
            return
              boolean(ancestor::mdiv//measure[@n = $referenced.node.measure.n]/staff[@n = $curr.staff]/layer[@n = $req.layer]/@sameas)"/>

        <variable as="xs:boolean" name="points.req.layer" select="$referenced.node.layer.n = $req.layer"/>
        <choose>
          <!--If the pointer already points to the requested layer or if the requested layer has @sameas, then the current reference should not be changed. -->
          <when test="$points.req.layer or $req.layer.sameas">
            <sequence select="false()"/>
          </when>
          <when test="$referenced.node.layer.n != $req.layer">
            <sequence select="true()"/>
          </when>
        </choose>
      </when>
      <otherwise>
        <sequence select="false()"/>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Copies the node. Replaces the value of the @startid or @endid (could be also the same. Calls the template 'copy'</xd:p>
    </xd:desc>
    <xd:param name="refs"/>
  </xd:doc>
  <template name="replace.reference">
    <param name="refs" tunnel="yes"/>

    <copy>
      <variable name="curr.el" select="."/>
      <for-each select="map:keys($refs)">
        <variable name="curr.key" select="."/>
        <if test="$curr.el/@*[local-name() = $curr.key]">
          <attribute name="{.}" select="
              let $val := map:get($refs, .)
              return
                '#' || $val"/>
        </if>
      </for-each>
      <call-template name="copy.controlevent.attrs"/>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Copies the attributes of the controlEvent with some filtering.</xd:p>
    </xd:desc>
    <xd:param name="req.layer"/>
  </xd:doc>
  <template name="copy.controlevent.attrs">
    <param name="req.layer" tunnel="yes"/>

    <choose>
      <when test="$req.layer != ''">
        <choose>
          <when test="local-name() = 'dir'">
            <apply-templates select="
                @* except (@curvedir, @layer, @startid, @endid), node()
                "/>
          </when>
          <otherwise>
            <apply-templates select="
                @* except (@place, @curvedir, @layer, @startid, @endid), node()"/>
          </otherwise>
        </choose>
      </when>
      <otherwise>
        <apply-templates select="@* except (@startid, @endid), node()"/>
      </otherwise>
    </choose>
  </template>

  <xd:doc>
    <xd:desc>
      <xd:p>Copy all attributes except those depending on the mode, update the @xml:id</xd:p>
      <xd:p>Similar functionality as the template 'copy', but the child nodes are not processed. This is needed in the context of a recursive template.</xd:p>
    </xd:desc>
    <xd:param name="req.layer"/>
    <xd:param name="counter"/>
  </xd:doc>
  <template name="copy.controlevent.attrs.update.id">
    <param name="req.layer" tunnel="yes"/>
    <param name="counter"/>

    <apply-templates select="
        (:when layer is extracted:)
        if ($req.layer != '') then
          (@* except (@place, @curvedir, @layer, @startid, @endid, @xml:id))
        else (:when staff is extracted completely:)
          (@* except (@startid, @endid, @xml:id))
        "/>
    <attribute name="xml:id" select="@xml:id || '-' || $counter"/>
  </template>


</stylesheet>
