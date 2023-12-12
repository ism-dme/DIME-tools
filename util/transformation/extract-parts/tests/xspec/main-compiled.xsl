<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- user-provided library module(s) -->
   <xsl:import href="file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/lib/test-helper.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/C:/Users/sapov/AppData/Roaming/com.oxygenxml/extensions/v26.0/frameworks/com.oxygenxml.xspec.XSpecSupportFramework/xspec.support-2.2.6/src/common/runtime-utils.xsl"/>
   <xsl:global-context-item use="absent"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/main.xspec</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}is-external"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="true()"/>
   <xsl:variable xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 name="Q{urn:x-xspec:compile:impl}thread-aware"
                 as="xs:boolean"
                 select="(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name') eq 'SAXON') and starts-with(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version'), 'EE ')"
                 static="yes"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}logical-processor-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware"
                 select="Q{java:java.lang.Runtime}getRuntime() =&gt; Q{java:java.lang.Runtime}availableProcessors()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}thread-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 select="1"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware =&gt; not()"/>
   <xsl:param xmlns:dme="http://www.mozarteum.at/ns/dme"
              xmlns:mei="http://www.music-encoding.org/ns/mei"
              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
              xmlns:x="http://www.jenitennison.com/xslt/xspec"
              name="Q{}P_XSPEC_TEST"
              select="true()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e5-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/code-snippets.xml')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}code-snippets"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e5-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e6-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/550-003_mm_8-21.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K550-003_mm_8-21"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e6-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e7-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/550-004_m86.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K550-004_m86"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e7-doc ! ( / )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e8-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/dmeref_551-001_m93.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}dmeref_551-001_m93"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e8-doc ! ( / )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e9-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/621-23_m187_flutes.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K621-23"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e9-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e10-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/dmeedtA_165-001_m1.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K165-001_edtA"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e10-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e11-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/527-07_mm4-5_8-9_fagotti.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K527-07_mm4-5_8-9_fagotti"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e11-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e12-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/527-07_mm41-50.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K527-07_mm41-50"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e12-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e14-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/dmeref_551-001_m23_m313.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}dmeref_551-001_m23_m313"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e14-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e15-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/550-003_Trio_m42.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K550-003_Trio_m42"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e15-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e16-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/551-002_m51.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K551-002_m51"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e16-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e17-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/dmeedtA_165-001_m28.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}dmeedtA_165-001_m28"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e17-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e18-doc"
                 as="document-node()"
                 select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/550-001.mei')"/>
   <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                 name="Q{}K550-001"
                 as="document-node()"
                 select="$Q{urn:x-xspec:compile:impl}variable-d76e18-doc ! ( test-helper:remove-whitespace-only-text(/) )"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}saxon-config"
                 as="empty-sequence()"/>
   <!-- the main template to run the suite -->
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}main"
                 as="empty-sequence()">
      <xsl:context-item use="absent"/>
      <!-- info message -->
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version')"/>
      </xsl:message>
      <!-- set up the result document (the report) -->
      <xsl:result-document format="Q{{http://www.jenitennison.com/xslt/xspec}}xml-report-serialization-parameters">
         <xsl:element name="report" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/main.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 4">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xb7530ad0-30de-34e1-8635-0e2bb8a09c6c"/>
                  </xsl:when>
                  <xsl:when test=". eq 2">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xe8b19f66-335f-35cc-8eb7-f7e4281c5cc9"/>
                  </xsl:when>
                  <xsl:when test=". eq 3">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xb5bc1e61-ac9f-36f8-b4be-426053f955f8"/>
                  </xsl:when>
                  <xsl:when test=". eq 4">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd265298d-5aee-3c6a-b286-9a4ad4555473"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xb7530ad0-30de-34e1-8635-0e2bb8a09c6c"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>scoreDef</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xb7530ad0-30de-34e1-8635-0e2bb8a09c6c</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/scoreDef.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>scoreDef</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3e9abd3a-3ccd-3aa4-b1a1-530811c5f48f"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd98c5002-4869-38a5-9954-71adbf45a09e"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3e9abd3a-3ccd-3aa4-b1a1-530811c5f48f"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract Oboe II ( |2.2| )</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3e9abd3a-3ccd-3aa4-b1a1-530811c5f48f</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/scoreDef.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract Oboe II ( |2.2| )</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e21-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e21-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeref_551-001_m93</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d82e0"
                       select="$dmeref_551-001_m93"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d82e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d82e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d82e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3e9abd3a-3ccd-3aa4-b1a1-530811c5f48f-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3e9abd3a-3ccd-3aa4-b1a1-530811c5f48f-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>staffGrp with no staffDef is deleted.</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e24"
                    select="$code-snippets//dme:output//dme:item[@n=1]/mei:scoreDef"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="//mei:scoreDef"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="//mei:scoreDef"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('scoreDef Extract Oboe II ( |2.2| ) staffGrp with no staffDef is deleted.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e24, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3e9abd3a-3ccd-3aa4-b1a1-530811c5f48f-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>staffGrp with no staffDef is deleted.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">//mei:scoreDef</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e24"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd98c5002-4869-38a5-9954-71adbf45a09e"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract Oboe II, Corni, Violino I ( |2.2|4|7| )</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd98c5002-4869-38a5-9954-71adbf45a09e</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/scoreDef.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract Oboe II, Corni, Violino I ( |2.2|4|7| )</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e26-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|4|7|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e26-doc ! ( node() )"/>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}variable-d76e28-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/data/dmeref_551-001_m93.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{}dmeref_551-001_m93"
                       select="$Q{urn:x-xspec:compile:impl}variable-d76e28-doc ! ( / )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeref_551-001_m93</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d96e0"
                       select="$dmeref_551-001_m93"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d96e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d96e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d96e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd98c5002-4869-38a5-9954-71adbf45a09e-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
            <xsl:with-param name="Q{}dmeref_551-001_m93" select="$Q{}dmeref_551-001_m93"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd98c5002-4869-38a5-9954-71adbf45a09e-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:param name="Q{}dmeref_551-001_m93" as="item()*" required="yes"/>
      <xsl:message>Oboe: @symbol=none, Corni: symbol=bracket, Violino: parent staffGrp deleted, @symbol=none</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e30"
                    select="$code-snippets//dme:output/dme:item[@n=2]/mei:scoreDef"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="//mei:scoreDef"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="//mei:scoreDef"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('scoreDef Extract Oboe II, Corni, Violino I ( |2.2|4|7| ) Oboe: @symbol=none, Corni: symbol=bracket, Violino: parent staffGrp deleted, @symbol=none'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e30, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd98c5002-4869-38a5-9954-71adbf45a09e-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Oboe: @symbol=none, Corni: symbol=bracket, Violino: parent staffGrp deleted, @symbol=none</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">//mei:scoreDef</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e30"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xe8b19f66-335f-35cc-8eb7-f7e4281c5cc9"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>File output.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xe8b19f66-335f-35cc-8eb7-f7e4281c5cc9</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/global.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>File output.</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 1">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xcc599558-ad67-3ba4-8c6f-7566a7c08ae8"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xcc599558-ad67-3ba4-8c6f-7566a7c08ae8"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..When all available parts are selected for extraction, the file should not be processed.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xcc599558-ad67-3ba4-8c6f-7566a7c08ae8</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/global.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>When all available parts are selected for extraction, the file should not be processed.</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 4">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x102c6bf8-daf4-3e4a-a10d-08b1661a13e2"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xbf1ee52e-2202-3fe2-b1e2-97f41663378b"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x4ddd8362-8714-3789-864a-4129574ec765"/>
               </xsl:when>
               <xsl:when test=". eq 4">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x39b0c5fa-fa18-3bd6-a000-51974675ccce"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x102c6bf8-daf4-3e4a-a10d-08b1661a13e2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract Oboi (|2|)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x102c6bf8-daf4-3e4a-a10d-08b1661a13e2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/global.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract Oboi (|2|)</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e36-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|3|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e36-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K527-07_mm4-5_8-9_fagotti</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d117e0"
                       select="$K527-07_mm4-5_8-9_fagotti"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d117e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="template" namespace="">main</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="'initial-template'" select="QName('', 'main')"/>
               </xsl:map>
            </xsl:variable>
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d117e0">
               <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                             as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)"
                             select="Q{http://www.w3.org/2005/xpath-functions/map}put($Q{urn:x-xspec:compile:impl}transform-options, 'global-context-item', .)"/>
               <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x102c6bf8-daf4-3e4a-a10d-08b1661a13e2-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x102c6bf8-daf4-3e4a-a10d-08b1661a13e2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>No output as all parts are requested.</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e40"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e40, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x102c6bf8-daf4-3e4a-a10d-08b1661a13e2-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>No output as all parts are requested.</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e40"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xbf1ee52e-2202-3fe2-b1e2-97f41663378b"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract all avaialable parts (|1|2|3|4|5|6|7|8|9|)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xbf1ee52e-2202-3fe2-b1e2-97f41663378b</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/global.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract all avaialable parts (|1|2|3|4|5|6|7|8|9|)</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e42-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|1|2|3|4|5|6|7|8|9|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e42-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-003_mm_8-21</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d127e0"
                       select="$K550-003_mm_8-21"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d127e0"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="template" namespace="">main</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="'initial-template'" select="QName('', 'main')"/>
               </xsl:map>
            </xsl:variable>
            <xsl:for-each select="$Q{urn:x-xspec:compile:impl}context-d127e0">
               <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                             as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)"
                             select="Q{http://www.w3.org/2005/xpath-functions/map}put($Q{urn:x-xspec:compile:impl}transform-options, 'global-context-item', .)"/>
               <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xbf1ee52e-2202-3fe2-b1e2-97f41663378b-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xbf1ee52e-2202-3fe2-b1e2-97f41663378b-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>No output as all parts are requested.</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e46"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e46, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xbf1ee52e-2202-3fe2-b1e2-97f41663378b-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>No output as all parts are requested.</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e46"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x4ddd8362-8714-3789-864a-4129574ec765"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract @staff=10 (not available in MEI)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x4ddd8362-8714-3789-864a-4129574ec765</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/global.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract @staff=10 (not available in MEI)</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e48-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|10|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e48-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-003_mm_8-21</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d136e0"
                       select="$K550-003_mm_8-21"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d136e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d136e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d136e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x4ddd8362-8714-3789-864a-4129574ec765-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x4ddd8362-8714-3789-864a-4129574ec765-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>The file was not processed.</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e52"
                    select="$K550-003_mm_8-21"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e52, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x4ddd8362-8714-3789-864a-4129574ec765-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>The file was not processed.</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e52"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x39b0c5fa-fa18-3bd6-a000-51974675ccce"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract @staff=4,10 (10 is not available in MEI)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x39b0c5fa-fa18-3bd6-a000-51974675ccce</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/global.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract @staff=4,10 (10 is not available in MEI)</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e54-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|4|10|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e54-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-003_mm_8-21</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d144e0"
                       select="$K550-003_mm_8-21"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d144e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d144e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d144e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x39b0c5fa-fa18-3bd6-a000-51974675ccce-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x39b0c5fa-fa18-3bd6-a000-51974675ccce-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>4th staff was extracted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e58" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="//mei:staff/@n[.=4] =&gt; boolean()"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="//mei:staff/@n[.=4] =&gt; boolean()"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in x:expect ('File output. When all available parts are selected for extraction, the file should not be processed. Extract @staff=4,10 (10 is not available in MEI) 4th staff was extracted'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x39b0c5fa-fa18-3bd6-a000-51974675ccce-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>4th staff was extracted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">//mei:staff/@n[.=4] =&gt; boolean()</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e58"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xb5bc1e61-ac9f-36f8-b4be-426053f955f8"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Events</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xb5bc1e61-ac9f-36f8-b4be-426053f955f8</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Events</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 9">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xfa407e6e-8095-3843-b7fb-866bb3bba414"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x35560711-15fd-36b4-b50a-10d16de2960b"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8ad352eb-7a66-301f-8464-27285bc3176a"/>
               </xsl:when>
               <xsl:when test=". eq 4">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x31d3ef2a-1868-3520-aeef-8bd3ba025c44"/>
               </xsl:when>
               <xsl:when test=". eq 5">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x93418efb-6b5a-3d66-9cbb-17a6b1018744"/>
               </xsl:when>
               <xsl:when test=". eq 6">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x76e349ae-6f65-319a-ad3e-b57c7e8373f2"/>
               </xsl:when>
               <xsl:when test=". eq 7">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd8a647df-d92b-3d48-9579-5ed67d054ec0"/>
               </xsl:when>
               <xsl:when test=". eq 8">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x4122cef0-8f07-33d4-a28a-25abb894f5a9"/>
               </xsl:when>
               <xsl:when test=". eq 9">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc3ae82f0-f1b1-3d84-81ec-8574b68aa57f"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xfa407e6e-8095-3843-b7fb-866bb3bba414"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..layer@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xfa407e6e-8095-3843-b7fb-866bb3bba414</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>layer@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e62-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|3.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e62-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K527-07_mm41-50</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d162e0"
                       select="$K527-07_mm41-50"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d162e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d162e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d162e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xfa407e6e-8095-3843-b7fb-866bb3bba414-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xfa407e6e-8095-3843-b7fb-866bb3bba414-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>All descendants are copied, @n is changed to '1'</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e65-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="layer" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                              xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="n"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                              xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="layer_28959b"/>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="accid"
                                 namespace=""
                                 select="'', ''"
                                 separator="s"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dots"
                                 namespace=""
                                 select="'', ''"
                                 separator="1"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e4796"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="4"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="2"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="g"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="1"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_28965"/>
               </xsl:element>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e65"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e65-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_28959b')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_28959b')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events layer@sameas All descendants are copied, @n is changed to '1''): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e65, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xfa407e6e-8095-3843-b7fb-866bb3bba414-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All descendants are copied, @n is changed to '1'</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_28959b')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e65"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x35560711-15fd-36b4-b50a-10d16de2960b"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..note@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x35560711-15fd-36b4-b50a-10d16de2960b</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>note@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e69-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|5.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e69-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeref_551-001_m93</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d176e0"
                       select="$dmeref_551-001_m93"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d176e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d176e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d176e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x35560711-15fd-36b4-b50a-10d16de2960b-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x35560711-15fd-36b4-b50a-10d16de2960b-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>All descendants are copied, @n is changed to '1'</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e72-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:note" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="dur"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="oct"
                              namespace=""
                              select="'', ''"
                              separator="5"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="pname"
                              namespace=""
                              select="'', ''"
                              separator="d"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="3"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="note_49950"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e72"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e72-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="//mei:layer[@n=1]/id('note_49950')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="//mei:layer[@n=1]/id('note_49950')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events note@sameas All descendants are copied, @n is changed to '1''): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e72, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x35560711-15fd-36b4-b50a-10d16de2960b-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All descendants are copied, @n is changed to '1'</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">//mei:layer[@n=1]/id('note_49950')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e72"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8ad352eb-7a66-301f-8464-27285bc3176a"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..beam@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8ad352eb-7a66-301f-8464-27285bc3176a</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>beam@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e75-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|1.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e75-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K621-23</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d190e0"
                       select="$K621-23"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d190e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d190e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d190e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8ad352eb-7a66-301f-8464-27285bc3176a-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8ad352eb-7a66-301f-8464-27285bc3176a-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>All descendants are copied, beam@xml:id is preserved.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e78-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="beam" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                              xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="beam_2241"/>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e775"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="16"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="6"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="d"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="2.5"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_2208"/>
               </xsl:element>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="accid"
                                 namespace=""
                                 select="'', ''"
                                 separator="s"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e777"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="32"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="6"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="c"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="2.625"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_2211"/>
               </xsl:element>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e779"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="32"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="5"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="b"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="2.6875"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_2214"/>
                  <xsl:element name="supplied" namespace="http://www.music-encoding.org/ns/mei">
                     <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                     <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                     <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    name="xml:id"
                                    namespace="http://www.w3.org/XML/1998/namespace"
                                    select="'', ''"
                                    separator="supplied_2214"/>
                     <xsl:element name="accid" namespace="http://www.music-encoding.org/ns/mei">
                        <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                        <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                        <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                        <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="accid"
                                       namespace=""
                                       select="'', ''"
                                       separator="n"/>
                        <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                       name="xml:id"
                                       namespace="http://www.w3.org/XML/1998/namespace"
                                       select="'', ''"
                                       separator="accid_2214"/>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e781"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="32"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="5"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="a"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="2.75"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_2217"/>
               </xsl:element>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e784"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="32"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="5"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="g"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="2.8125"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_2220"/>
               </xsl:element>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="accid"
                                 namespace=""
                                 select="'', ''"
                                 separator="s"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e786"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="32"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="5"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="f"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="2.875"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_2223"/>
               </xsl:element>
               <xsl:element name="note" namespace="http://www.music-encoding.org/ns/mei">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="doxml.id"
                                 namespace=""
                                 select="'', ''"
                                 separator="d28e788"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="dur"
                                 namespace=""
                                 select="'', ''"
                                 separator="32"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="oct"
                                 namespace=""
                                 select="'', ''"
                                 separator="5"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="pname"
                                 namespace=""
                                 select="'', ''"
                                 separator="e"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="tstamp"
                                 namespace=""
                                 select="'', ''"
                                 separator="2.9375"/>
                  <xsl:attribute xmlns="http://www.music-encoding.org/ns/mei"
                                 xmlns:dme="http://www.mozarteum.at/ns/dme"
                                 xmlns:mei="http://www.music-encoding.org/ns/mei"
                                 xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                 xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                 name="xml:id"
                                 namespace="http://www.w3.org/XML/1998/namespace"
                                 select="'', ''"
                                 separator="note_2226"/>
               </xsl:element>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e78"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e78-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="//mei:layer[@n=1]/id('beam_2241')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="//mei:layer[@n=1]/id('beam_2241')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events beam@sameas All descendants are copied, beam@xml:id is preserved.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e78, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8ad352eb-7a66-301f-8464-27285bc3176a-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All descendants are copied, beam@xml:id is preserved.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">//mei:layer[@n=1]/id('beam_2241')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e78"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x31d3ef2a-1868-3520-aeef-8bd3ba025c44"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..rest@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x31d3ef2a-1868-3520-aeef-8bd3ba025c44</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>rest@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e90-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e90-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K527-07_mm41-50</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d204e0"
                       select="$K527-07_mm41-50"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d204e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d204e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d204e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x31d3ef2a-1868-3520-aeef-8bd3ba025c44-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x31d3ef2a-1868-3520-aeef-8bd3ba025c44-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@dur from the pointed test is copied, @sameas deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e93-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:rest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="doxml.id"
                              namespace=""
                              select="'', ''"
                              separator="d28e4035"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="dur"
                              namespace=""
                              select="'', ''"
                              separator="8"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1.5"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="rest_25491"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e93"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e93-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('staff_25446')/mei:layer[@n='1']/id('rest_25491')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('staff_25446')/mei:layer[@n='1']/id('rest_25491')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events rest@sameas @dur from the pointed test is copied, @sameas deleted'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e93, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x31d3ef2a-1868-3520-aeef-8bd3ba025c44-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@dur from the pointed test is copied, @sameas deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('staff_25446')/mei:layer[@n='1']/id('rest_25491')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e93"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x93418efb-6b5a-3d66-9cbb-17a6b1018744"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..mRest</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x93418efb-6b5a-3d66-9cbb-17a6b1018744</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>mRest</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e96-doc" as="document-node()">
            <xsl:document>
               <xsl:text>|4.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e96-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-004_m86</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d218e0"
                       select="$K550-004_m86"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d218e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d218e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d218e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x93418efb-6b5a-3d66-9cbb-17a6b1018744-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x93418efb-6b5a-3d66-9cbb-17a6b1018744-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@ploc, @oloc are deleted.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e99" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('mRest_40248')[@ploc and @oloc] =&gt; boolean() =&gt; not()"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('mRest_40248')[@ploc and @oloc] =&gt; boolean() =&gt; not()"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in x:expect ('Events mRest @ploc, @oloc are deleted.'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x93418efb-6b5a-3d66-9cbb-17a6b1018744-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@ploc, @oloc are deleted.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('mRest_40248')[@ploc and @oloc] =&gt; boolean() =&gt; not()</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e99"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x76e349ae-6f65-319a-ad3e-b57c7e8373f2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..rest</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x76e349ae-6f65-319a-ad3e-b57c7e8373f2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>rest</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="template" namespace="">layer.descendants</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
                  <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
                  <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
                  <xsl:attribute name="name" namespace="">els</xsl:attribute>
                  <xsl:attribute name="select" namespace="">$K550-003_mm_8-21//id('rest_14148')</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                          xmlns:mei="http://www.music-encoding.org/ns/mei"
                          xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}els"
                          select="$K550-003_mm_8-21//id('rest_14148')"/>
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="'template-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'els')" select="$Q{}els"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:map-entry key="'initial-template'" select="QName('', 'layer.descendants')"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x76e349ae-6f65-319a-ad3e-b57c7e8373f2-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x76e349ae-6f65-319a-ad3e-b57c7e8373f2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>@ploc, @oloc are deleted.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e103-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:rest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="doxml.id"
                              namespace=""
                              select="'', ''"
                              separator="d28e2076"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="dur"
                              namespace=""
                              select="'', ''"
                              separator="4"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="rest_14148"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e103"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e103-doc ! ( node() )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e103, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x76e349ae-6f65-319a-ad3e-b57c7e8373f2-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@ploc, @oloc are deleted.</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e103"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd8a647df-d92b-3d48-9579-5ed67d054ec0"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..mSpace</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd8a647df-d92b-3d48-9579-5ed67d054ec0</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>mSpace</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e106-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|3.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e106-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K527-07_mm4-5_8-9_fagotti</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d241e0"
                       select="$K527-07_mm4-5_8-9_fagotti"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d241e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d241e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d241e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd8a647df-d92b-3d48-9579-5ed67d054ec0-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd8a647df-d92b-3d48-9579-5ed67d054ec0-expect2">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd8a647df-d92b-3d48-9579-5ed67d054ec0-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>mRest is created</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e109-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:mRest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="mrest_5166"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e109"
                    as="element(mei:mRest)"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e109-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_5133b')/*"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_5133b')/*"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events mSpace mRest is created'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e109, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd8a647df-d92b-3d48-9579-5ed67d054ec0-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>mRest is created</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_5133b')/*</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e109"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd8a647df-d92b-3d48-9579-5ed67d054ec0-expect2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>mSpace is deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e111" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_5133b')/mei:mSpace =&gt;  boolean() =&gt; not()"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_5133b')/mei:mSpace =&gt;  boolean() =&gt; not()"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in x:expect ('Events mSpace mSpace is deleted'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd8a647df-d92b-3d48-9579-5ed67d054ec0-expect2</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>mSpace is deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_5133b')/mei:mSpace =&gt;  boolean() =&gt; not()</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e111"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x4122cef0-8f07-33d4-a28a-25abb894f5a9"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..space</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x4122cef0-8f07-33d4-a28a-25abb894f5a9</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>space</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e113-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e113-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K527-07_mm41-50</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d263e0"
                       select="$K527-07_mm41-50"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d263e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d263e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d263e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x4122cef0-8f07-33d4-a28a-25abb894f5a9-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x4122cef0-8f07-33d4-a28a-25abb894f5a9-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>rest is created</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e116-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:rest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="dur"
                              namespace=""
                              select="'', ''"
                              separator="4"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="rest_25493"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e116"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e116-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="(id('layer_25479')/mei:rest)[2]"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="(id('layer_25479')/mei:rest)[2]"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events space rest is created'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e116, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x4122cef0-8f07-33d4-a28a-25abb894f5a9-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>rest is created</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">(id('layer_25479')/mei:rest)[2]</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e116"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xc3ae82f0-f1b1-3d84-81ec-8574b68aa57f"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..multiRest</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xc3ae82f0-f1b1-3d84-81ec-8574b68aa57f</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>multiRest</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x07ebe602-2944-3b95-a37e-8725bd893823"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract staff.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xea643030-afa6-38d3-b815-c6cc086ce3bb</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract staff.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e120-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|1|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e120-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-001</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d280e0"
                       select="$K550-001"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d280e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d280e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d280e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect2">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect3">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect4">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>multiRest is created</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e123-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:multiRest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="num"
                              namespace=""
                              select="'', ''"
                              separator="13"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="..."/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e123"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e123-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_9372')/mei:*"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_9372')/mei:*"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events multiRest Extract staff. multiRest is created'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e123, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xea643030-afa6-38d3-b815-c6cc086ce3bb-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>multiRest is created</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_9372')/mei:*</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e123"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>multiRest is created</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e125-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:multiRest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="num"
                              namespace=""
                              select="'', ''"
                              separator="7"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="..."/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e125"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e125-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_19728')/mei:*"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_19728')/mei:*"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events multiRest Extract staff. multiRest is created'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e125, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xea643030-afa6-38d3-b815-c6cc086ce3bb-expect2</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>multiRest is created</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_19728')/mei:*</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e125"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect3"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>measure is deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e128" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('m110_k550_001') =&gt; not()"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('m110_k550_001') =&gt; not()"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in x:expect ('Events multiRest Extract staff. measure is deleted'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xea643030-afa6-38d3-b815-c6cc086ce3bb-expect3</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>measure is deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('m110_k550_001') =&gt; not()</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e128"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xea643030-afa6-38d3-b815-c6cc086ce3bb-expect4"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>mRest is preserved.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e129-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:mRest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="mRest_108726"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e129"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e129-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_108720')/mei:*"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_108720')/mei:*"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events multiRest Extract staff. mRest is preserved.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e129, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xea643030-afa6-38d3-b815-c6cc086ce3bb-expect4</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>mRest is preserved.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_108720')/mei:*</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e129"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x07ebe602-2944-3b95-a37e-8725bd893823"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract layer.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x07ebe602-2944-3b95-a37e-8725bd893823</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/events.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract layer.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e132-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e132-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-001</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d322e0"
                       select="$K550-001"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d322e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d322e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d322e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x07ebe602-2944-3b95-a37e-8725bd893823-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x07ebe602-2944-3b95-a37e-8725bd893823-expect2">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x07ebe602-2944-3b95-a37e-8725bd893823-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>multiRest is created</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e135-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:multiRest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="num"
                              namespace=""
                              select="'', ''"
                              separator="15"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="..."/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e135"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e135-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_9402')/mei:*"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_9402')/mei:*"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events multiRest Extract layer. multiRest is created'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e135, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x07ebe602-2944-3b95-a37e-8725bd893823-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>multiRest is created</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_9402')/mei:*</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e135"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x07ebe602-2944-3b95-a37e-8725bd893823-expect2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>multiRest is created</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e137-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:multiRest" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="num"
                              namespace=""
                              select="'', ''"
                              separator="8"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="..."/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e137"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e137-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('layer_160812')/mei:*"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('layer_160812')/mei:*"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('Events multiRest Extract layer. multiRest is created'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e137, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x07ebe602-2944-3b95-a37e-8725bd893823-expect2</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>multiRest is created</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('layer_160812')/mei:*</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e137"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd265298d-5aee-3c6a-b286-9a4ad4555473"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>ControlEvents</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd265298d-5aee-3c6a-b286-9a4ad4555473</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>ControlEvents</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 6">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xf61b2049-8237-34d0-b4b6-324f1354e0e9"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x42fee937-6f9a-3372-a498-84cd0e94e474"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xa6f20b01-6d60-36e5-8eb3-b89ff90aa0f1"/>
               </xsl:when>
               <xsl:when test=". eq 4">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x21867e2e-4a4b-3e19-9cef-ea9be6d1c8dc"/>
               </xsl:when>
               <xsl:when test=". eq 5">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x96e0309f-cd15-341d-9fe0-2cd2611cdbf9"/>
               </xsl:when>
               <xsl:when test=". eq 6">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x7a3afd3d-5ac3-392b-b473-2f564a2f5a67"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xf61b2049-8237-34d0-b4b6-324f1354e0e9"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Directives</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xf61b2049-8237-34d0-b4b6-324f1354e0e9</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Directives</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x2850dd54-249a-3e2d-8a26-5628eb33a2c6"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x23b12080-a341-3e02-8932-66c2ec1b93bd"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x2850dd54-249a-3e2d-8a26-5628eb33a2c6"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Repeat instruction</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x2850dd54-249a-3e2d-8a26-5628eb33a2c6</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Repeat instruction</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x23db0002-5f42-3687-b4ed-4fbff1e578c3"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x48578527-b1ca-37f1-832c-f6b43457b1ae"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x23db0002-5f42-3687-b4ed-4fbff1e578c3"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Lowest staff</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x23db0002-5f42-3687-b4ed-4fbff1e578c3</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Lowest staff</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e147-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|8|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e147-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-003_Trio_m42</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d355e0"
                       select="$K550-003_Trio_m42"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d355e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d355e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d355e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x23db0002-5f42-3687-b4ed-4fbff1e578c3-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x23db0002-5f42-3687-b4ed-4fbff1e578c3-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@staff unchanged</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e150" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('dir_31398')/@staff[.=8] =&gt;  boolean() "
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('dir_31398')/@staff[.=8] =&gt;  boolean() "
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Directives Repeat instruction Lowest staff @staff unchanged'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x23db0002-5f42-3687-b4ed-4fbff1e578c3-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@staff unchanged</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('dir_31398')/@staff[.=8] =&gt;  boolean() </xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e150"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x48578527-b1ca-37f1-832c-f6b43457b1ae"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Third staff, second layer.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x48578527-b1ca-37f1-832c-f6b43457b1ae</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Third staff, second layer.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e152-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|3.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e152-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-003_Trio_m42</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d371e0"
                       select="$K550-003_Trio_m42"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d371e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d371e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d371e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x48578527-b1ca-37f1-832c-f6b43457b1ae-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x48578527-b1ca-37f1-832c-f6b43457b1ae-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@staff updated</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e155" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('dir_31398')/@staff[.=3] =&gt;  boolean() "
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('dir_31398')/@staff[.=3] =&gt;  boolean() "
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Directives Repeat instruction Third staff, second layer. @staff updated'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x48578527-b1ca-37f1-832c-f6b43457b1ae-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@staff updated</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('dir_31398')/@staff[.=3] =&gt;  boolean() </xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e155"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x23b12080-a341-3e02-8932-66c2ec1b93bd"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Dir 'a 2'</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x23b12080-a341-3e02-8932-66c2ec1b93bd</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Dir 'a 2'</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xab216494-965c-3e03-915e-4fa62af36915"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x31e92699-dc2b-3397-9940-f762c0f9737c"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xab216494-965c-3e03-915e-4fa62af36915"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract second Oboe.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xab216494-965c-3e03-915e-4fa62af36915</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract second Oboe.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e158-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e158-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-003_mm_8-21</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d390e0"
                       select="$K550-003_mm_8-21"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d390e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d390e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d390e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xab216494-965c-3e03-915e-4fa62af36915-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xab216494-965c-3e03-915e-4fa62af36915-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>Deleted.</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e161"
                    select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('dir_9918')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('dir_9918')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Directives Dir 'a 2' Extract second Oboe. Deleted.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e161, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xab216494-965c-3e03-915e-4fa62af36915-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Deleted.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('dir_9918')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e161"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x31e92699-dc2b-3397-9940-f762c0f9737c"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract Oboi (complete staff).</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x31e92699-dc2b-3397-9940-f762c0f9737c</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract Oboi (complete staff).</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e163-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e163-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K550-003_mm_8-21</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d406e0"
                       select="$K550-003_mm_8-21"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d406e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d406e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d406e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x31e92699-dc2b-3397-9940-f762c0f9737c-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x31e92699-dc2b-3397-9940-f762c0f9737c-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>Preserved.</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:mei="http://www.music-encoding.org/ns/mei"
                    xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d76e166"
                    select="$K550-003_mm_8-21/id('dir_9918')"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('dir_9918')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('dir_9918')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Directives Dir 'a 2' Extract Oboi (complete staff). Preserved.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e166, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x31e92699-dc2b-3397-9940-f762c0f9737c-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Preserved.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('dir_9918')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e166"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x42fee937-6f9a-3372-a498-84cd0e94e474"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Ties</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x42fee937-6f9a-3372-a498-84cd0e94e474</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Ties</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x6ea078cb-6e3e-357f-bca4-6ffa9f247555"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x0a3056e4-cb37-33d9-ad2b-2010bc84bb1e"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x6ea078cb-6e3e-357f-bca4-6ffa9f247555"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..References point to notes inside layer@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x6ea078cb-6e3e-357f-bca4-6ffa9f247555</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>References point to notes inside layer@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e170-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e170-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="expand-text" namespace="">no</xsl:attribute>
               <xsl:attribute name="select" namespace="">$K550-003_mm_8-21</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d425e0"
                       select="$K550-003_mm_8-21"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d425e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d425e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d425e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x6ea078cb-6e3e-357f-bca4-6ffa9f247555-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x6ea078cb-6e3e-357f-bca4-6ffa9f247555-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>References swaped.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e173-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:tie" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="endid"
                              namespace=""
                              select="'', ''"
                              separator="#note_10308"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="startid"
                              namespace=""
                              select="'', ''"
                              separator="#note_10002"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="tie_10218"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e173"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e173-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('tie_10218')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('tie_10218')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Ties References point to notes inside layer@sameas References swaped.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e173, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x6ea078cb-6e3e-357f-bca4-6ffa9f247555-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>References swaped.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('tie_10218')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e173"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x0a3056e4-cb37-33d9-ad2b-2010bc84bb1e"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..@endid points to a note inside beam@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x0a3056e4-cb37-33d9-ad2b-2010bc84bb1e</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@endid points to a note inside beam@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e176-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|1.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e176-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="expand-text" namespace="">no</xsl:attribute>
               <xsl:attribute name="select" namespace="">$K621-23</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d440e0"
                       select="$K621-23"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d440e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d440e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d440e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x0a3056e4-cb37-33d9-ad2b-2010bc84bb1e-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x0a3056e4-cb37-33d9-ad2b-2010bc84bb1e-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>References swaped.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e179-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:tie" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="endid"
                              namespace=""
                              select="'', ''"
                              separator="#note_2208"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="startid"
                              namespace=""
                              select="'', ''"
                              separator="#note_2238"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="tie_2699"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e179"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e179-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('tie_2699')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('tie_2699')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Ties @endid points to a note inside beam@sameas References swaped.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e179, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x0a3056e4-cb37-33d9-ad2b-2010bc84bb1e-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>References swaped.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('tie_2699')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e179"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xa6f20b01-6d60-36e5-8eb3-b89ff90aa0f1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Fermatas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xa6f20b01-6d60-36e5-8eb3-b89ff90aa0f1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Fermatas</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x22a99b96-c963-34c7-b87a-0a465cd53d5f"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xd16458df-a2d2-381a-a7fa-751c9c530d9e"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x22a99b96-c963-34c7-b87a-0a465cd53d5f"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..@startid.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x22a99b96-c963-34c7-b87a-0a465cd53d5f</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@startid.</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 4">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xb707d185-e214-345f-8b52-2daed75e34c4"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x5ff77e45-5e30-31cd-a8ca-df12656d5938"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xfe45c0eb-4095-33bf-821f-f7cea7e84036"/>
               </xsl:when>
               <xsl:when test=". eq 4">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x6da42bae-9823-30b4-99d5-5d3642314bc6"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xb707d185-e214-345f-8b52-2daed75e34c4"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Extract first layer</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xb707d185-e214-345f-8b52-2daed75e34c4</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Extract first layer</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e185-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.1|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e185-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeref_551-001_m23_m313</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d461e0"
                       select="$dmeref_551-001_m23_m313"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d461e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d461e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d461e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xb707d185-e214-345f-8b52-2daed75e34c4-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xb707d185-e214-345f-8b52-2daed75e34c4-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@layer is deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e188-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:fermata" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="doxml.id"
                              namespace=""
                              select="'', ''"
                              separator="d27e2927"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="startid"
                              namespace=""
                              select="'', ''"
                              separator="#note_20238"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="fermata_20472"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e188"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e188-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_20472')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_20472')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @startid. Extract first layer @layer is deleted'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e188, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xb707d185-e214-345f-8b52-2daed75e34c4-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@layer is deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_20472')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e188"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x5ff77e45-5e30-31cd-a8ca-df12656d5938"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Fermata points to a first layer note, second layer is extracted.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x5ff77e45-5e30-31cd-a8ca-df12656d5938</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Fermata points to a first layer note, second layer is extracted.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e191-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e191-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeref_551-001_m23_m313</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d477e0"
                       select="$dmeref_551-001_m23_m313"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d477e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d477e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d477e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x5ff77e45-5e30-31cd-a8ca-df12656d5938-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x5ff77e45-5e30-31cd-a8ca-df12656d5938-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@startid is changed @layer deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e194-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:fermata" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="doxml.id"
                              namespace=""
                              select="'', ''"
                              separator="d27e2927"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="startid"
                              namespace=""
                              select="'', ''"
                              separator="#note_20250"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="fermata_20472"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e194"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e194-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_20472')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_20472')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @startid. Fermata points to a first layer note, second layer is extracted. @startid is changed @layer deleted'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e194, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x5ff77e45-5e30-31cd-a8ca-df12656d5938-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@startid is changed @layer deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_20472')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e194"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xfe45c0eb-4095-33bf-821f-f7cea7e84036"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..note@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xfe45c0eb-4095-33bf-821f-f7cea7e84036</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>note@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e197-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e197-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K527-07_mm41-50</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d493e0"
                       select="$K527-07_mm41-50"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d493e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d493e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d493e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xfe45c0eb-4095-33bf-821f-f7cea7e84036-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xfe45c0eb-4095-33bf-821f-f7cea7e84036-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@startid is changed, @layer deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e200-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:fermata" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="doxml.id"
                              namespace=""
                              select="'', ''"
                              separator="d28e4740"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="startid"
                              namespace=""
                              select="'', ''"
                              separator="#note_28941"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="fermata_29205"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e200"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e200-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_29205')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_29205')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @startid. note@sameas @startid is changed, @layer deleted'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e200, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xfe45c0eb-4095-33bf-821f-f7cea7e84036-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@startid is changed, @layer deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_29205')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e200"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x6da42bae-9823-30b4-99d5-5d3642314bc6"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..layer@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x6da42bae-9823-30b4-99d5-5d3642314bc6</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>layer@sameas</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e203-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|3.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e203-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K527-07_mm41-50</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d509e0"
                       select="$K527-07_mm41-50"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d509e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d509e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d509e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x6da42bae-9823-30b4-99d5-5d3642314bc6-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x6da42bae-9823-30b4-99d5-5d3642314bc6-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@startid is preserved, @layer deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e206-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:fermata" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="doxml.id"
                              namespace=""
                              select="'', ''"
                              separator="d28e4794"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="3"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="startid"
                              namespace=""
                              select="'', ''"
                              separator="#note_28965"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="fermata_29217"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e206"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e206-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_29217')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_29217')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @startid. layer@sameas @startid is preserved, @layer deleted'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e206, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x6da42bae-9823-30b4-99d5-5d3642314bc6-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@startid is preserved, @layer deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_29217')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e206"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xd16458df-a2d2-381a-a7fa-751c9c530d9e"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..@tstamp</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xd16458df-a2d2-381a-a7fa-751c9c530d9e</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@tstamp</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x9bf6b757-4786-3ede-8ddd-4d1d8586c113"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8f9d3621-7533-39e8-99be-236eef9ce333"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x9bf6b757-4786-3ede-8ddd-4d1d8586c113"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Oboe I., first layer.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x9bf6b757-4786-3ede-8ddd-4d1d8586c113</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Oboe I., first layer.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e210-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.1|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e210-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeref_551-001_m23_m313</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d528e0"
                       select="$dmeref_551-001_m23_m313"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d528e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d528e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d528e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x9bf6b757-4786-3ede-8ddd-4d1d8586c113-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x9bf6b757-4786-3ede-8ddd-4d1d8586c113-expect2">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x9bf6b757-4786-3ede-8ddd-4d1d8586c113-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@staff is changed to '2'.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e213-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:fermata" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="place"
                              namespace=""
                              select="'', ''"
                              separator="above"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="5"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="fermata_167136"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e213"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e213-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_167136')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_167136')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @tstamp Oboe I., first layer. @staff is changed to '2'.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e213, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x9bf6b757-4786-3ede-8ddd-4d1d8586c113-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@staff is changed to '2'.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_167136')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e213"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x9bf6b757-4786-3ede-8ddd-4d1d8586c113-expect2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>Second fermata is deleted!</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e215" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_167148') =&gt;  boolean() =&gt; not()"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_167148') =&gt;  boolean() =&gt; not()"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @tstamp Oboe I., first layer. Second fermata is deleted!'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x9bf6b757-4786-3ede-8ddd-4d1d8586c113-expect2</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Second fermata is deleted!</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_167148') =&gt;  boolean() =&gt; not()</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e215"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8f9d3621-7533-39e8-99be-236eef9ce333"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Oboe I., first layer and Fagotti.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8f9d3621-7533-39e8-99be-236eef9ce333</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Oboe I., first layer and Fagotti.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e217-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.1|3|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e217-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeref_551-001_m23_m313</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d554e0"
                       select="$dmeref_551-001_m23_m313"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d554e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d554e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d554e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8f9d3621-7533-39e8-99be-236eef9ce333-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8f9d3621-7533-39e8-99be-236eef9ce333-expect2">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8f9d3621-7533-39e8-99be-236eef9ce333-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@staff is changed to '2', @layer deleted</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e220-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:fermata" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="part"
                              namespace=""
                              select="'', ''"
                              separator="%all"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="place"
                              namespace=""
                              select="'', ''"
                              separator="above"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="5"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="fermata_167136"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e220"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e220-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_167136')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_167136')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @tstamp Oboe I., first layer and Fagotti. @staff is changed to '2', @layer deleted'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e220, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8f9d3621-7533-39e8-99be-236eef9ce333-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@staff is changed to '2', @layer deleted</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_167136')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e220"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8f9d3621-7533-39e8-99be-236eef9ce333-expect2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>Second fermata is preserved, @staff changed to 3.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e222-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:fermata" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="part"
                              namespace=""
                              select="'', ''"
                              separator="%all"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="place"
                              namespace=""
                              select="'', ''"
                              separator="below"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="3"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="5"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="fermata_167148"/>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e222"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e222-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('fermata_167148')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('fermata_167148')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents Fermatas @tstamp Oboe I., first layer and Fagotti. Second fermata is preserved, @staff changed to 3.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e222, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8f9d3621-7533-39e8-99be-236eef9ce333-expect2</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Second fermata is preserved, @staff changed to 3.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('fermata_167148')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e222"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x21867e2e-4a4b-3e19-9cef-ea9be6d1c8dc"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..tempo</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x21867e2e-4a4b-3e19-9cef-ea9be6d1c8dc</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>tempo</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 1">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3c6a5269-1f34-352d-afc6-8d864b0a05ab"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3c6a5269-1f34-352d-afc6-8d864b0a05ab"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..@part</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3c6a5269-1f34-352d-afc6-8d864b0a05ab</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@part</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x51cc8b87-b1aa-3b2c-9514-c6d153c2391d"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc9218632-6fa1-3f43-b8f1-f8c85d8909a7"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x51cc8b87-b1aa-3b2c-9514-c6d153c2391d"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..One part is extracted.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x51cc8b87-b1aa-3b2c-9514-c6d153c2391d</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>One part is extracted.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e228-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.1|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e228-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K165-001_edtA</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d586e0"
                       select="$K165-001_edtA"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d586e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d586e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d586e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x51cc8b87-b1aa-3b2c-9514-c6d153c2391d-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x51cc8b87-b1aa-3b2c-9514-c6d153c2391d-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@part is deleted, @staff=2.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e231-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:tempo" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="midi.bpm"
                              namespace=""
                              select="'', ''"
                              separator="116"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="place"
                              namespace=""
                              select="'', ''"
                              separator="above"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="tempo01-A"/>
               <xsl:text>Allegro</xsl:text>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e231"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e231-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('tempo01-A')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('tempo01-A')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents tempo @part One part is extracted. @part is deleted, @staff=2.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e231, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x51cc8b87-b1aa-3b2c-9514-c6d153c2391d-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@part is deleted, @staff=2.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('tempo01-A')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e231"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xc9218632-6fa1-3f43-b8f1-f8c85d8909a7"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..1+ parts are extracted.</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xc9218632-6fa1-3f43-b8f1-f8c85d8909a7</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>1+ parts are extracted.</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e235-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|2.1|3|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e235-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K165-001_edtA</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d602e0"
                       select="$K165-001_edtA"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d602e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d602e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d602e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc9218632-6fa1-3f43-b8f1-f8c85d8909a7-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xc9218632-6fa1-3f43-b8f1-f8c85d8909a7-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>@part is preserved, @staff=2.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e238-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:tempo" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="midi.bpm"
                              namespace=""
                              select="'', ''"
                              separator="116"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="part"
                              namespace=""
                              select="'', ''"
                              separator="%all"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="place"
                              namespace=""
                              select="'', ''"
                              separator="above"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="tempo01-A"/>
               <xsl:text>Allegro</xsl:text>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e238"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e238-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('tempo01-A')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('tempo01-A')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents tempo @part 1+ parts are extracted. @part is preserved, @staff=2.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e238, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xc9218632-6fa1-3f43-b8f1-f8c85d8909a7-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@part is preserved, @staff=2.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('tempo01-A')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e238"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x96e0309f-cd15-341d-9fe0-2cd2611cdbf9"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..dynam</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x96e0309f-cd15-341d-9fe0-2cd2611cdbf9</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>dynam</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e243-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|1.2|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e243-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$dmeedtA_165-001_m28</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d618e0"
                       select="$dmeedtA_165-001_m28"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d618e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d618e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d618e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x96e0309f-cd15-341d-9fe0-2cd2611cdbf9-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x96e0309f-cd15-341d-9fe0-2cd2611cdbf9-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>dynam@tsamp: @layer deleted.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e246-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:dynam" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="1"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="dynam_8283a-A"/>
               <xsl:text>pia:</xsl:text>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e246"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e246-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('dynam_8283a-A')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('dynam_8283a-A')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents dynam dynam@tsamp: @layer deleted.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e246, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x96e0309f-cd15-341d-9fe0-2cd2611cdbf9-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>dynam@tsamp: @layer deleted.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('dynam_8283a-A')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e246"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x7a3afd3d-5ac3-392b-b473-2f564a2f5a67"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..dynam</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x7a3afd3d-5ac3-392b-b473-2f564a2f5a67</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/tests/modules/controlEvents.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>dynam</xsl:text>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}param-d76e250-doc"
                       as="document-node()">
            <xsl:document>
               <xsl:text>|3.1|</xsl:text>
            </xsl:document>
         </xsl:variable>
         <xsl:variable name="Q{}P_REQUESTED_PARTS"
                       select="$Q{urn:x-xspec:compile:impl}param-d76e250-doc ! ( node() )"/>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="select" namespace="">$K551-002_m51</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:mei="http://www.music-encoding.org/ns/mei"
                       xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d632e0"
                       select="$K551-002_m51"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d632e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable name="Q{urn:x-xspec:compile:impl}transform-options"
                          as="map(Q{http://www.w3.org/2001/XMLSchema}string, item()*)">
               <xsl:map>
                  <xsl:map-entry key="'delivery-format'" select="'raw'"/>
                  <xsl:map-entry key="'stylesheet-location'">file:/C:/Users/sapov/Documents/dime-mei-tools/util/transformation/extract-parts/main.xsl</xsl:map-entry>
                  <xsl:map-entry key="'stylesheet-params'">
                     <xsl:map>
                        <xsl:map-entry key="QName('', 'P_XSPEC_TEST')" select="$Q{}P_XSPEC_TEST"/>
                        <xsl:map-entry key="QName('', 'P_REQUESTED_PARTS')" select="$Q{}P_REQUESTED_PARTS"/>
                     </xsl:map>
                  </xsl:map-entry>
                  <xsl:if test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config =&gt; exists()">
                     <xsl:choose>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of element(Q{http://saxon.sf.net/ns/configuration}configuration)"/>
                        <xsl:when test="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config instance of document-node(element(Q{http://saxon.sf.net/ns/configuration}configuration))"/>
                        <xsl:otherwise>
                           <xsl:message terminate="yes">ERROR: $Q{http://www.jenitennison.com/xslt/xspec}saxon-config does not appear to be a Saxon configuration</xsl:message>
                        </xsl:otherwise>
                     </xsl:choose>
                     <xsl:map-entry key="'cache'" select="false()"/>
                     <xsl:map-entry key="'vendor-options'">
                        <xsl:map>
                           <xsl:map-entry key="QName('http://saxon.sf.net/', 'configuration')"
                                          select="$Q{http://www.jenitennison.com/xslt/xspec}saxon-config"/>
                        </xsl:map>
                     </xsl:map-entry>
                  </xsl:if>
                  <xsl:map-entry key="if ($Q{urn:x-xspec:compile:impl}context-d632e0 instance of node()) then 'source-node' else 'initial-match-selection'"
                                 select="$Q{urn:x-xspec:compile:impl}context-d632e0"/>
               </xsl:map>
            </xsl:variable>
            <xsl:sequence select="transform($Q{urn:x-xspec:compile:impl}transform-options)?output"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x7a3afd3d-5ac3-392b-b473-2f564a2f5a67-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{}P_REQUESTED_PARTS" select="$Q{}P_REQUESTED_PARTS"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x7a3afd3d-5ac3-392b-b473-2f564a2f5a67-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{}P_REQUESTED_PARTS" as="item()*" required="yes"/>
      <xsl:message>Replace @startid with @tstamp.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e253-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="mei:dynam" namespace="http://www.music-encoding.org/ns/mei">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="doxml.id"
                              namespace=""
                              select="'', ''"
                              separator="d27e6406"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="staff"
                              namespace=""
                              select="'', ''"
                              separator="3"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="tstamp"
                              namespace=""
                              select="'', ''"
                              separator="2"/>
               <xsl:attribute xmlns:dme="http://www.mozarteum.at/ns/dme"
                              xmlns:mei="http://www.music-encoding.org/ns/mei"
                              xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                              xmlns:x="http://www.jenitennison.com/xslt/xspec"
                              name="xml:id"
                              namespace="http://www.w3.org/XML/1998/namespace"
                              select="'', ''"
                              separator="dynam_34566"/>
               <xsl:text>p</xsl:text>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d76e253"
                    select="$Q{urn:x-xspec:compile:impl}expect-d76e253-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                                xmlns:mei="http://www.music-encoding.org/ns/mei"
                                xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                                xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                select="id('dynam_34566')"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:dme="http://www.mozarteum.at/ns/dme"
                             xmlns:mei="http://www.music-encoding.org/ns/mei"
                             xmlns:test-helper="x-urn:tutorial:helper:ws-only-text:test-helper"
                             xmlns:x="http://www.jenitennison.com/xslt/xspec"
                             select="id('dynam_34566')"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in x:expect ('ControlEvents dynam Replace @startid with @tstamp.'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d76e253, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x7a3afd3d-5ac3-392b-b473-2f564a2f5a67-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Replace @startid with @tstamp.</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="x:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="mei">http://www.music-encoding.org/ns/mei</xsl:namespace>
               <xsl:namespace name="test-helper">x-urn:tutorial:helper:ws-only-text:test-helper</xsl:namespace>
               <xsl:attribute name="test" namespace="">id('dynam_34566')</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d76e253"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
