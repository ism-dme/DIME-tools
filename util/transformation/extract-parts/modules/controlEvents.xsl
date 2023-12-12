<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <variable as="xs:string*" name="CONTROL_EVENTS">
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
        <xd:li>Example 1: dynam[@staff="2" and @layer="1 2"], $P_REQUESTED_PARTS=|2.1|. The dynam will be processed.</xd:li>
        <xd:li>Example 2: slur[@staff="2" and @layer="2"], $P_REQUESTED_PARTS=|2.1|. The slur will be deleted.</xd:li>
        <xd:li>Example 3: tie[@staff="2" and not(@layer)], $P_REQUESTED_PARTS=|2.1|. The tie will be processed.</xd:li>
      </xd:ul>
    </xd:desc>
  </xd:doc>
  <template match="music//*[local-name() = $CONTROL_EVENTS]" mode="step_two">

    <variable as="xs:string?" name="staff">
      <choose>
        <when test="local-name() = 'fermata'">
          <call-template name="get.fermata.staff"/>
        </when>
        <otherwise>
          <sequence select="@staff/string()"/>
        </otherwise>
      </choose>
    </variable>

    <choose>
      <when test="@part[. = '%all']">
        <call-template name="part.all"/>
      </when>
      <when test="$staff = $REQ_STAVES_EXTRACT_LAYERS">
        <variable as="xs:string*" name="reqLayer" select="map:get(dme:requested-staves-layers(), $staff)"/>
        <choose>
          <!--Current @layer is not requested.-->
          <when test="@layer and not(contains(@layer, $reqLayer))"/>
          <otherwise>
            <call-template name="sort.pointer.types">
              <with-param name="pReqLayer" select="$reqLayer" tunnel="yes"/>
            </call-template>
          </otherwise>
        </choose>
      </when>
      <when test="@staff = $REQ_STAVES_COMPLETE">
        <copy-of select="."/>
      </when>
      <otherwise/>
    </choose>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="part.all">
    <copy>
      <choose>
        <when test="local-name() = 'fermata'">
          <call-template name="fermata.tstamp"/>
        </when>
        <when test="local-name() = ('dir', 'tempo')">
          <!--The '@staff' attribute is updated to the value of the highest staff in the system.-->
          <variable as="xs:string?" name="newStaff" select="min($REQ_STAVES_ANY)"/>
          <call-template name="controlevent.tstamp.copy.attrs">
            <with-param as="xs:string?" name="pStaff" select="$newStaff"/>
          </call-template>
        </when>
      </choose>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Cases:<xd:ul>
          <xd:li>@tstamp</xd:li>
          <xd:li>@startid only</xd:li>
          <xd:li>@startid and @endid</xd:li>
          <xd:li>In some (exceptional) case, a combinations of @start/@endid with @tstamp/@tstmp2 may exist.</xd:li>
        </xd:ul>
      </xd:p>
    </xd:desc>
  </xd:doc>
  <template name="sort.pointer.types">
    <choose>
      <when test="@tstamp">
        <call-template name="controlevent.tstamp"/>
      </when>
      <otherwise>
        <call-template name="swap.references"/>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="swap.references">
    <choose>
      <when test="@startid and not(@endid)">
        <variable as="map(xs:string, xs:string)*" name="refs">
          <call-template name="get.references">
            <with-param name="pointers" select="'startid'"/>
          </call-template>
        </variable>
        <choose>
          <when test="($refs?startid = '') and (local-name() = 'dynam')">
            <call-template name="replace.startid.with.tstamp"/>
          </when>
          <otherwise>
            <call-template name="startid">
              <with-param name="pRefs" select="$refs" tunnel="yes"/>
            </call-template>
          </otherwise>
        </choose>


      </when>
      <when test="@startid and @endid">
        <variable as="map(xs:string, xs:string)*" name="refs">
          <call-template name="get.references">
            <with-param name="pointers" select="'startid', 'endid'"/>
          </call-template>
        </variable>
        <call-template name="two.pointers.case">
          <with-param name="pRefs" select="$refs" tunnel="yes"/>
        </call-template>
      </when>
      <otherwise>
        <message>Unrecognized attributes combination!</message>
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
    <xd:param name="pointers"/>
  </xd:doc>
  <template name="get.references">
    <param name="pointers"/>

    <variable as="element()" name="currentMeiBody" select="ancestor::body"/>

    <map>
      <for-each select="@*[local-name() = $pointers]">
        <variable name="referencedNode" select="$P_GLOBAL_CONTEXT_ITEM/id(substring-after(current(), '#'))"/>

        <variable as="xs:boolean" name="swapRequired">
          <call-template name="swap.required">
            <with-param name="referenced.node" select="$referencedNode"/>
          </call-template>
        </variable>

        <choose>
          <when test="$swapRequired">
            <variable as="attribute()*" name="newTeferences" select="$currentMeiBody/id($referencedNode/ancestor::staff/@xml:id)//node()[@tstamp = $referencedNode/@tstamp]/@xml:id"/>

            <map-entry key="local-name(.)" select="string-join(($newTeferences), ',')"/>
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
    <xd:param name="referenced.node"/>
    <xd:param name="pReqLayer"/>
  </xd:doc>
  <template name="swap.required">
    <param name="pReqLayer" tunnel="yes"/>
    <param name="referenced.node"/>

    <variable as="xs:boolean" name="reqLayerAssigned" select="boolean(contains(../@layer, $pReqLayer)) (:Check if the @layer contains the requested layer value. E.g. for @layer='1' and $parts=|1.2| it will be false().:)"/>

    <choose>
      <when test="$reqLayerAssigned">

        <variable as="xs:string" name="referenced.node.layer.n" select="$referenced.node/ancestor::layer/@n/string()"/>
        <variable name="reqLayerSameas" select="
            let $referenced.node.measure.n := $referenced.node/ancestor::measure/@n,
              $curr.staff := ../@staff
            return
              boolean(ancestor::mdiv//measure[@n = $referenced.node.measure.n]/staff[@n = $curr.staff]/layer[@n = $pReqLayer]/@sameas)"/>

        <variable as="xs:boolean" name="pointsReqLayer" select="$referenced.node.layer.n = $pReqLayer"/>
        <choose>
          <!--If the pointer already points to the requested layer or if the requested layer has @sameas, then the current reference should not be changed. -->
          <when test="$pointsReqLayer or $reqLayerSameas">
            <sequence select="false()"/>
          </when>
          <when test="$referenced.node.layer.n != $pReqLayer">
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
      <xd:p>Copies a node. Updates the value of the @startid or @endid (could also stay same). Calls the template 'copy'</xd:p>
    </xd:desc>

    <xd:param name="pRefs"/>
  </xd:doc>
  <template name="replace.reference">
    <param name="pRefs" tunnel="yes"/>

    <copy>
      <variable name="curr.el" select="."/>
      <for-each select="map:keys($pRefs)">
        <variable name="curr.key" select="."/>
        <if test="$curr.el/@*[local-name() = $curr.key]">
          <attribute name="{.}" select="
              let $val := map:get($pRefs, .)
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
    <xd:param name="pReqLayer"/>
  </xd:doc>
  <template name="copy.controlevent.attrs">
    <param name="pReqLayer" tunnel="yes"/>

    <variable as="xs:boolean" name="reqLayerExists" select="$pReqLayer != ''"/>
    <variable as="xs:boolean" name="isDir" select="local-name() = 'dir'"/>

    <choose>
      <when test="$reqLayerExists">
        <apply-templates select="@* except (@startid, @endid, @curvedir, @layer, @place[not($isDir)]), node()"/>
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
    <xd:param name="counter"/>
    <xd:param name="pReqLayer"/>
  </xd:doc>
  <template name="copy.controlevent.attrs.update.id">
    <param name="pReqLayer" tunnel="yes"/>
    <param name="counter"/>

    <apply-templates select="
        (:when layer is extracted:)
        if ($pReqLayer != '') then
          (@* except (@place, @curvedir, @layer, @startid, @endid, @xml:id))
        else (:when staff is extracted completely:)
          (@* except (@startid, @endid, @xml:id))
        "/>
    <attribute name="xml:id" select="@xml:id || '-' || $counter"/>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>As fermata[@startid] do not have @staff, this should be computed from the pointed Event.</xd:p>
    </xd:desc>
  </xd:doc>
  <template name="get.fermata.staff">
    <variable as="element()?" name="refElement">
      <variable as="xs:string" name="startidPointer" select="substring-after(@startid, '#')"/>
      <sequence select="$P_GLOBAL_CONTEXT_ITEM/id($startidPointer)"/>
    </variable>
    <sequence select="$refElement/ancestor::staff/@n/string()"/>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="replace.startid.with.tstamp">
    <variable as="xs:string" name="startidPointer" select="substring-after(@startid, '#')"/>
    <variable name="refNode" select="$P_GLOBAL_CONTEXT_ITEM/id($startidPointer)"/>

    <copy>
      <attribute name="tstamp" select="$refNode/@tstamp"/>
      <call-template name="copy.controlevent.attrs"/>
    </copy>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>If there are more than one new reference, the template 'clone.node.startid' is called. Otherwise, current @startid is updated</xd:p>
    </xd:desc>
    <xd:param name="pRefs"/>
    <xd:param name="pointers"/>
  </xd:doc>
  <template name="startid">
    <param name="pRefs" tunnel="yes"/>
    <param name="pointers" tunnel="yes"/>

    <variable name="vals" select="
        let $entry := map:get($pRefs, $pointers)
        return
          tokenize($entry, ',')"/>
    <variable name="countVals" select="count($vals)"/>

    <choose>
      <when test="$countVals > 1 (:if more than one new reference for at least one pointer exists:)">
        <variable name="el" select="."/>
        <for-each select="1 to $countVals">
          <call-template name="clone.node.startid">
            <with-param name="pEl" select="$el"/>
            <with-param name="pVals" select="$vals"/>
            <with-param name="pCounter" select="." tunnel="yes"/>
          </call-template>
        </for-each>
      </when>
      <!--if only one value for each pointer exists-->
      <otherwise>
        <call-template name="replace.reference"/>
      </otherwise>
    </choose>
  </template>



  <xd:doc>
    <xd:desc>
      <xd:p>$el is being cloned (case when app, choice, etc. are present). @xml:id is updated with suffix derived from $counter. The values for @startid are updated. If the $el has child nodes they will be processed in the same way recursively.</xd:p>
    </xd:desc>
    <xd:param name="pEl"/>
    <xd:param name="pVals"/>
    <xd:param name="pCounter"/>
    <xd:param name="pRefs"/>
  </xd:doc>
  <template name="clone.node.startid">
    <param name="pEl"/>
    <param name="pVals"/>
    <param name="pCounter" tunnel="yes"/>
    <param name="pRefs" tunnel="yes"/>

    <for-each select="$pEl">
      <copy>

        <call-template name="copy.controlevent.attrs.update.id">
          <with-param name="counter" select="$pCounter"/>
        </call-template>

        <choose>
          <when test="empty($pVals) (:no referenced @xml:id is found:)">
            <attribute name="tstamp" select="
                let $referenced.node := substring-after(@startid, '#')
                return
                  ancestor::music/id($referenced.node)/@tstamp"/>
          </when>
          <otherwise>
            <if test="@startid">
              <attribute name="startid" select="'#' || $pVals[$pCounter]"/>
            </if>
          </otherwise>
        </choose>

        <if test="node()">
          <call-template name="clone.node.startid">
            <with-param name="pEl" select="node()"/>
          </call-template>
        </if>
      </copy>
    </for-each>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Updates @startid and @endid.</xd:p>
      <xd:p>If there are multiple new references, clones the element.</xd:p>
    </xd:desc>

    <xd:param name="pRefs"/>
  </xd:doc>
  <template name="two.pointers.case">
    <param name="pRefs" tunnel="yes"/>

    <variable name="count.vals.startid" select="
        let $t := tokenize(map:get($pRefs, 'startid'), ',')
        return
          count($t)"/>
    <variable name="count.vals.endid" select="
        let $t := tokenize(map:get($pRefs, 'endid'), ',')
        return
          count($t)"/>

    <choose>
      <!--if more than one new reference for at least one pointer exists-->
      <when test="
          let $countVals := sum(($count.vals.startid, $count.vals.endid))
          return
            $countVals > 2">

        <variable name="el" select="."/>
        <variable as="xs:string*" name="pointer.pairs">
          <call-template name="t.pointer.pairs"/>
        </variable>

        <for-each select="1 to ($count.vals.startid * $count.vals.endid)">
          <call-template name="clone.node.two.pointers">
            <with-param name="el" select="$el"/>
            <with-param name="counter" select="."/>
            <with-param name="pointer.pairs" select="$pointer.pairs" tunnel="yes"/>
          </call-template>
        </for-each>

      </when>
      <!--if only one value for each pointer exists-->
      <otherwise>
        <call-template name="replace.reference"/>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Zipps each new reference of the @startid with the correspoindig new reference of the @endid.</xd:p>
      <xd:p>Returns sequence of strings. Example: ("note_123,note_456,", "note_123,note_789")</xd:p>
    </xd:desc>
    <xd:param name="pRefs"/>
  </xd:doc>
  <template name="t.pointer.pairs">
    <param as="map(xs:string, xs:string)*" name="pRefs" tunnel="yes"/>
    <for-each select="
        let $a := map:get($pRefs, 'startid')
        return
          tokenize($a, ',')">
      <variable name="currStartid" select="."/>
      <for-each select="
          let $a := map:get($pRefs, 'endid')
          return
            tokenize($a, ',')">
        <sequence select="string-join(($currStartid, .), ',')"/>
      </for-each>
    </for-each>
  </template>


  <!--TODO: merge with template@name=clone.node.startid-->
  <xd:doc>
    <xd:desc>
      <xd:p>$el is being cloned (case when app, choice, etc. are present). @xml:id is updated with suffix derived from $counter. The values for @startid are updated. If the $el has child nodes they will be processed in the same way recursively.</xd:p>
    </xd:desc>
    <xd:param name="el"/>
    <xd:param name="counter"/>
    <xd:param name="pointer.pairs"/>
  </xd:doc>
  <template name="clone.node.two.pointers">
    <param name="el"/>
    <param name="counter"/>
    <param name="pointer.pairs" tunnel="yes"/>

    <for-each select="$el">
      <copy>
        <!--copy all atributes except @startid, @endid, update the @xml:id-->
        <call-template name="copy.controlevent.attrs.update.id">
          <with-param name="counter" select="$counter"/>
        </call-template>
        <!--update pointers-->
        <variable name="entry" select="$pointer.pairs[$counter]"/>
        <variable name="vals" select="tokenize($entry, ',')"/>
        <if test="@startid">
          <attribute name="startid" select="'#' || $vals[1]"/>
        </if>
        <if test="@endid">
          <attribute name="endid" select="'#' || $vals[2]"/>
        </if>

        <if test="node()">
          <call-template name="clone.node.two.pointers">
            <with-param name="el" select="node()"/>
            <with-param name="counter" select="$counter"/>
          </call-template>
        </if>
      </copy>
    </for-each>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="controlevent.tstamp">
    <choose>
      <when test="local-name() = 'dir'">
        <variable as="xs:string+" name="dirsToDelete" select="('a 2', 'a&#8198;2', 'a due', '1mo')"/>

        <variable name="containingText">
          <variable as="xs:string+" name="containingTextSequence">
            <for-each select="node()">
              <sequence select="."/>
            </for-each>
          </variable>
          <sequence select="string-join($containingTextSequence)"/>
        </variable>

        <choose>
          <when test="(rend/text() | text() | $containingText) = $dirsToDelete"/>
          <otherwise>
            <copy>
              <call-template name="controlevent.tstamp.copy.attrs"/>
            </copy>
          </otherwise>
        </choose>
      </when>
      <otherwise>
        <copy>
          <call-template name="controlevent.tstamp.copy.attrs"/>
        </copy>
      </otherwise>
    </choose>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>Fermatas which are not attached to a particualr event but rather apply to the whole score. For 1+ parts both fermatas are shown, but for one part only one fermata</xd:p>
    </xd:desc>
  </xd:doc>
  <template name="fermata.tstamp">
    <variable as="xs:boolean" name="deleteBelow" select="@place[. = 'below'] and count($REQ_STAVES_ANY) = 1"/>

    <if test="not($deleteBelow)">
      <variable as="xs:string?" name="newStaff" select="
          if (@place[. = 'above']) then
            min($REQ_STAVES_ANY)
          else
            if (@place[. = 'below']) then
              max($REQ_STAVES_ANY)
            else
              ()"/>
      <call-template name="controlevent.tstamp.copy.attrs">
        <with-param as="xs:string?" name="pStaff" select="$newStaff"/>
      </call-template>
    </if>
  </template>


  <xd:doc>
    <xd:desc>
      <xd:p>For all controlEvents, @layer is deleted as this template is called in context of extracting layers.</xd:p>
      <xd:p>In the shared logic for copying attributes for 'tempo' and 'fermata' elements, the original '@staff' attribute should not be copied. Instead, a previously computed parameter is passed. Whether '@part' should be copied or not depends on whether more than one staff is extracted.</xd:p>
    </xd:desc>
    <xd:param name="pStaff">For *@part=%all own pStaff value is passed.</xd:param>
  </xd:doc>
  <template name="controlevent.tstamp.copy.attrs">
    <param as="xs:string" name="pStaff" select="@staff/string()"/>

    <variable as="xs:boolean" name="deleteAttrPart" select="not(count($partsList) > 1)"/>
    <attribute name="staff" select="$pStaff"/>
    <apply-templates select="@* except (@staff, @part[$deleteAttrPart], @layer), node()"/>
  </template>
  
  
  

</stylesheet>
