<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template match="staff" mode="step_one">
    <choose>
      <when test="
          some $staff in $REQ_STAVES_EXTRACT_LAYERS
            satisfies $staff = @n">
        <copy>
          <apply-templates select="@*"/>
          <!--Special case for K. 550-->
          <if test="app">
            <call-template name="versionsCase">
              <with-param name="staffN" select="@n"/>
            </call-template>
          </if>
          <apply-templates mode="layer" select="layer[@n = map:get(dme:requested-staves-layers(), current()/@n)]"/>
        </copy>
      </when>
      <when test="
          some $staff in $REQ_STAVES_COMPLETE
            satisfies $staff = @n">
        <copy-of select="."/>
      </when>
    </choose>
  </template>


  <xd:doc>
    <xd:desc/>
    <xd:param name="staffN"/>
  </xd:doc>
  <xsl:template name="versionsCase">
    <xsl:param name="staffN"/>

    <xsl:variable name="IDsecondPart" select="substring-after(@xml:id, '_')"/>
    <app xmlns="http://www.music-encoding.org/ns/mei">
      <!--<xsl:attribute name="xml:id" select="'app_' || $IDsecondPart"/>-->
      <xsl:apply-templates select="app/@*"/>
      <xsl:variable name="currApp" select="app"/>

      <!--If app would have more variants-->
      <xsl:for-each select="1 to count($currApp/child::*)">
        <xsl:variable name="counter" select=". cast as xs:integer"/>
        <xsl:variable name="child" select="($currApp/child::*)[$counter]"/>
        <xsl:element name="{$child/name()}">
          <xsl:apply-templates select="$child/@*"/>
          <xsl:apply-templates mode="layer" select="$child/layer[@n = map:get(dme:requested-staves-layers(), $staffN)]"/>
        </xsl:element>
      </xsl:for-each>
    </app>

  </xsl:template>



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
          <choose>
            <when test="(local-name() = 'mSpace') and (@type = 'rest')">
              <mRest xmlns="http://www.music-encoding.org/ns/mei">
                <xsl:attribute name="xml:id">
                  <xsl:choose>
                    <xsl:when test="contains(@xml:id, '_')">
                      <xsl:sequence select="'mrest_' || substring-after(@xml:id, '_')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:copy select="@xml:id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates mode="#current" select="@* except (@type, @xml:id)"/>
              </mRest>

            </when>
            <when test="(local-name() = 'space') and (@type = 'rest')">
              <rest xmlns="http://www.music-encoding.org/ns/mei">
                <xsl:attribute name="xml:id">
                  <xsl:choose>
                    <xsl:when test="contains(@xml:id, '_')">
                      <xsl:sequence select="'rest_' || substring-after(@xml:id, '_')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:copy select="@xml:id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates mode="#current" select="@* except (@type, @xml:id)"/>
              </rest>
            </when>
            <otherwise>
              <copy-of select="functx:remove-attributes(., $events.attributes2remove)"/>
            </otherwise>
          </choose>

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
    <copy-of select="dme:add-mei-attributes($pointedEl, $attrsQNames, $vals)"/>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="create.first.layer">
    <attribute name="n" select="'1'"/>
    <attribute name="xml:id" select="@xml:id"/>
    <apply-templates select="@* except (@n, @xml:id)"/>
  </template>



  <xd:doc>
    <xd:desc/>
    <xd:param name="pDocNode"/>
  </xd:doc>
  <template name="calculate.multirest.measures">
    <param name="pDocNode"/>

    <variable as="element()*" name="firstMeasureMrest" select="
        $pDocNode//measure[descendant::mRest and
        not((preceding-sibling::measure)[last()][descendant::mRest])]"/>


    <iterate select="$firstMeasureMrest">
      <param as="xs:integer" name="pCounter" select="1"/>
      <param name="pMeasuresToDelete" select="[]"/>
      <param name="pMeasuresToConvert" select="map {}"/>

      <on-completion>
        <config xmlns="http://www.mozarteum.at/ns/dme">
          <measuresToDelete>
            <xsl:value-of select="$pMeasuresToDelete"/>
          </measuresToDelete>
          <xsl:for-each select="map:keys($pMeasuresToConvert)">
            <measuresToConvert count="{map:get($pMeasuresToConvert, current())}" id="{.}"/>
          </xsl:for-each>

        </config>
      </on-completion>

      <variable as="element(dme:measure)" name="mrestsCount">
        <call-template name="mrests.count"/>
      </variable>


      <choose>
        <when test="$mrestsCount/@count > 4">
          <next-iteration>
            <with-param name="pCounter" select="$pCounter + 1"/>
            <with-param name="pMeasuresToDelete" select="array:append($pMeasuresToDelete, $mrestsCount/@ids)"/>
            <with-param name="pMeasuresToConvert" select="map:put($pMeasuresToConvert, @xml:id, $mrestsCount/@count)"/>
          </next-iteration>
        </when>
        <otherwise>
          <next-iteration>
            <with-param name="pCounter" select="$pCounter + 1"/>
            <with-param name="pMeasuresToDelete" select="$pMeasuresToDelete"/>
            <with-param name="pMeasuresToConvert" select="$pMeasuresToConvert"/>
          </next-iteration>
        </otherwise>
      </choose>
    </iterate>
  </template>


  <xd:doc>
    <xd:desc/>
  </xd:doc>
  <template name="mrests.count">
    <iterate select="following-sibling::measure">
      <param as="xs:integer" name="pCounter" select="1"/>
      <param name="pMeasureIds" select="[]"/>

      <on-completion>
        <measure count="{$pCounter}" ids="{$pMeasureIds}" xmlns="http://www.mozarteum.at/ns/dme"/>
      </on-completion>
      <choose>
        <when test="descendant::mRest">
          <variable as="xs:integer" name="newCounter" select="$pCounter + 1"/>
          <next-iteration>
            <with-param name="pCounter" select="$newCounter"/>
            <with-param name="pMeasureIds" select="array:append($pMeasureIds, @xml:id)"/>
          </next-iteration>
        </when>
        <otherwise>
          <sequence>
            <measure count="{$pCounter}" ids="{$pMeasureIds}" xmlns="http://www.mozarteum.at/ns/dme"/>
          </sequence>
          <break/>
        </otherwise>
      </choose>
    </iterate>
  </template>


  <xd:doc>
    <xd:desc/>
    <xd:param name="pMultiRestMeasures"/>
  </xd:doc>
  <template match="measure[.//mRest]" mode="step_two">
    <param as="element()?" name="pMultiRestMeasures" tunnel="yes"/>

    <variable as="attribute()" name="measureId" select="@xml:id"/>
    <variable as="element()?" name="itemMeasureToConvert" select="$pMultiRestMeasures//dme:measuresToConvert[@id = $measureId]"/>

    <choose>
      <when test="($pMultiRestMeasures//dme:measuresToDelete => tokenize()) = @xml:id"/>
      <when test="$itemMeasureToConvert">
        <copy>
          <variable as="xs:integer" name="lastMeasureN" select="xs:integer($itemMeasureToConvert/@count) + xs:integer(@n) - 1"/>
          <variable as="xs:string" name="newMeasuresRange" select="
              @n || '-' ||
              xs:string($lastMeasureN)"/>
          <attribute name="n" select="$newMeasuresRange"/>
          <attribute name="xml:id">
            <choose>
              <when test="contains(@xml:id, '_')">
                <sequence select="'mm' || $newMeasuresRange || '_' || substring-after(@xml:id, '_')"/>
              </when>
              <otherwise>
                <sequence select="@xml:id"/>
              </otherwise>
            </choose>
          </attribute>
          <apply-templates mode="#current" select="@* except (@xml:id, @n), node()"/>
        </copy>
      </when>
      <otherwise>
        <copy>
          <apply-templates select="@*, node()"/>
        </copy>
      </otherwise>
    </choose>
  </template>



  <xd:doc>
    <xd:desc/>
    <xd:param name="pMultiRestMeasures"/>
  </xd:doc>
  <template match="mRest" mode="step_two">
    <param as="element()?" name="pMultiRestMeasures" tunnel="yes"/>

    <variable as="attribute()" name="ancestorMeasureId" select="ancestor::measure/@xml:id"/>
    <variable as="element()?" name="itemMeasureToConvert" select="$pMultiRestMeasures//dme:measuresToConvert[@id = $ancestorMeasureId]"/>

    <choose>
      <when test="$itemMeasureToConvert">
        <element name="multiRest" namespace="http://www.music-encoding.org/ns/mei">
          <apply-templates select="@*"/>
          <attribute name="num" select="
              $itemMeasureToConvert/@count"/>
        </element>
      </when>
      <otherwise>
        <copy-of select="."/>
      </otherwise>
    </choose>

  </template>




</stylesheet>
