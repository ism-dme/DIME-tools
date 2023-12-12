<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet -->
   <xsl:import href="file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/checkDurations.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/C:/Users/sapov/AppData/Roaming/com.oxygenxml/extensions/v26.0/frameworks/com.oxygenxml.xspec.XSpecSupportFramework/xspec.support-2.2.6/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/checkDurations.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}is-external"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="false()"/>
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
            <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/checkDurations.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 1">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xe8ba4612-621c-34ea-8935-388635356503"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xe8ba4612-621c-34ea-8935-388635356503"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Main output</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xe8ba4612-621c-34ea-8935-388635356503</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Main output</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 9">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x95ff1ba0-a224-38ac-8386-80a11b1a4e50"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x399b8a4b-8144-34d8-baab-1181ce364e19"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc5dfa061-6a89-342f-a523-65a6f4580899"/>
               </xsl:when>
               <xsl:when test=". eq 4">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x7ce41b05-9d65-3dc6-a2f1-0783bfb8ec23"/>
               </xsl:when>
               <xsl:when test=". eq 5">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x51768405-a558-308f-824f-6e47a523b23f"/>
               </xsl:when>
               <xsl:when test=". eq 6">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x4508b32e-f79c-3e30-b627-c2d9fb4a41b0"/>
               </xsl:when>
               <xsl:when test=". eq 7">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x896827b1-e500-3de5-8ff8-f39d0e26df90"/>
               </xsl:when>
               <xsl:when test=". eq 8">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xe21774c8-dcd9-3839-b0cc-1d564f23509c"/>
               </xsl:when>
               <xsl:when test=". eq 9">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x682c4159-6b9b-3b2b-bb08-80b1913ab9ee"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x95ff1ba0-a224-38ac-8386-80a11b1a4e50"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Metrum 2/4, tuplets (3/2, whole measure and partial)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x95ff1ba0-a224-38ac-8386-80a11b1a4e50</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Metrum 2/4, tuplets (3/2, whole measure and partial)</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_2-4_tuplet_3-2.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d59e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_2-4_tuplet_3-2.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d59e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d59e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d59e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d59e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x95ff1ba0-a224-38ac-8386-80a11b1a4e50-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x95ff1ba0-a224-38ac-8386-80a11b1a4e50-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>All durations are correct.</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e5"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e5, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x95ff1ba0-a224-38ac-8386-80a11b1a4e50-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All durations are correct.</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e5"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x399b8a4b-8144-34d8-baab-1181ce364e19"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Metrtum: 4/4, tuplets (6/4, whole measure and partial)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x399b8a4b-8144-34d8-baab-1181ce364e19</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Metrtum: 4/4, tuplets (6/4, whole measure and partial)</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_4-4_tuplet_6-4.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d67e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_4-4_tuplet_6-4.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d67e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d67e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d67e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d67e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x399b8a4b-8144-34d8-baab-1181ce364e19-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x399b8a4b-8144-34d8-baab-1181ce364e19-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Wrong durations: note_18441 (16 -&gt; 32)</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e8"
                    select="'layer_18360'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e8, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x399b8a4b-8144-34d8-baab-1181ce364e19-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Wrong durations: note_18441 (16 -&gt; 32)</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e8"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xc5dfa061-6a89-342f-a523-65a6f4580899"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Metrum 6/8, tuplets (3/2, whole measure and partial)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xc5dfa061-6a89-342f-a523-65a6f4580899</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Metrum 6/8, tuplets (3/2, whole measure and partial)</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_6-8_triplets.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d75e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_6-8_triplets.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d75e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d75e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d75e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d75e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc5dfa061-6a89-342f-a523-65a6f4580899-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xc5dfa061-6a89-342f-a523-65a6f4580899-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Wrong durations: added @dots=2 (at note_10950)</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e11"
                    select="'layer_11004'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e11, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xc5dfa061-6a89-342f-a523-65a6f4580899-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Wrong durations: added @dots=2 (at note_10950)</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e11"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x7ce41b05-9d65-3dc6-a2f1-0783bfb8ec23"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..@dot</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x7ce41b05-9d65-3dc6-a2f1-0783bfb8ec23</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@dot</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 1">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x9ae62798-0260-3aee-81c5-dda30bf8cc9c"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x9ae62798-0260-3aee-81c5-dda30bf8cc9c"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..+ Metrum change: 6/8 -&gt; 4/4</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x9ae62798-0260-3aee-81c5-dda30bf8cc9c</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>+ Metrum change: 6/8 -&gt; 4/4</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_change_6-8_to_4-4.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d86e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/metrum_change_6-8_to_4-4.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d86e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d86e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d86e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d86e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x9ae62798-0260-3aee-81c5-dda30bf8cc9c-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x9ae62798-0260-3aee-81c5-dda30bf8cc9c-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Wrong durations: one dot is absent (at note_3960)</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e15"
                    select="'layer_3990'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e15, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x9ae62798-0260-3aee-81c5-dda30bf8cc9c-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Wrong durations: one dot is absent (at note_3960)</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e15"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x51768405-a558-308f-824f-6e47a523b23f"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..@sameas</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x51768405-a558-308f-824f-6e47a523b23f</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@sameas</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x80c2a5fa-4fe8-3946-be22-c54ece858322"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xf9fc165a-9981-34a9-938f-bd7b05d7158c"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x80c2a5fa-4fe8-3946-be22-c54ece858322"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..With @dots</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x80c2a5fa-4fe8-3946-be22-c54ece858322</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>With @dots</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@sameas_@dots.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d97e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@sameas_@dots.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d97e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d97e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d97e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d97e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x80c2a5fa-4fe8-3946-be22-c54ece858322-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x80c2a5fa-4fe8-3946-be22-c54ece858322-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>rest_160176 references to a rest with @dots</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e19"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e19, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x80c2a5fa-4fe8-3946-be22-c54ece858322-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>rest_160176 references to a rest with @dots</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e19"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xf9fc165a-9981-34a9-938f-bd7b05d7158c"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Inside tuplet</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xf9fc165a-9981-34a9-938f-bd7b05d7158c</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Inside tuplet</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@sameas_tuplet.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d105e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@sameas_tuplet.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d105e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d105e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d105e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d105e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xf9fc165a-9981-34a9-938f-bd7b05d7158c-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xf9fc165a-9981-34a9-938f-bd7b05d7158c-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>All durations are correct (layer_26862 is the @sameas-in-tuplet-case)</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e22"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e22, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xf9fc165a-9981-34a9-938f-bd7b05d7158c-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All durations are correct (layer_26862 is the @sameas-in-tuplet-case)</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e22"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x4508b32e-f79c-3e30-b627-c2d9fb4a41b0"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..@copyof</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x4508b32e-f79c-3e30-b627-c2d9fb4a41b0</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@copyof</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 2">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xae7d91f2-0c48-31fe-8db8-3974e7612a6b"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x34d08147-79a3-39c8-a122-0ff33e77241e"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xae7d91f2-0c48-31fe-8db8-3974e7612a6b"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..beam@copyof correct</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xae7d91f2-0c48-31fe-8db8-3974e7612a6b</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>beam@copyof correct</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@copyof.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d116e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@copyof.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d116e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d116e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d116e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d116e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xae7d91f2-0c48-31fe-8db8-3974e7612a6b-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xae7d91f2-0c48-31fe-8db8-3974e7612a6b-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>layer_99852 contains beam@copyof</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e26"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e26, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xae7d91f2-0c48-31fe-8db8-3974e7612a6b-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>layer_99852 contains beam@copyof</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e26"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x34d08147-79a3-39c8-a122-0ff33e77241e"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..beam@copyof wrong</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x34d08147-79a3-39c8-a122-0ff33e77241e</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>beam@copyof wrong</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@copyof_wrong.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d124e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/@copyof_wrong.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d124e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d124e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d124e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d124e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x34d08147-79a3-39c8-a122-0ff33e77241e-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x34d08147-79a3-39c8-a122-0ff33e77241e-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>note_99792 was changed from 16 to 32</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e29"
                    select="'layer_99762&#xA;layer_99852'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e29, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x34d08147-79a3-39c8-a122-0ff33e77241e-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>note_99792 was changed from 16 to 32</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e29"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x896827b1-e500-3de5-8ff8-f39d0e26df90"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..app</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x896827b1-e500-3de5-8ff8-f39d0e26df90</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>app</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 1">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xbbc7e7c7-1c45-3cd6-b247-13bec580dbbe"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xbbc7e7c7-1c45-3cd6-b247-13bec580dbbe"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..normal case and @sameas case</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xbbc7e7c7-1c45-3cd6-b247-13bec580dbbe</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>normal case and @sameas case </xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/app.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d135e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/app.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d135e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d135e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d135e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d135e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xbbc7e7c7-1c45-3cd6-b247-13bec580dbbe-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xbbc7e7c7-1c45-3cd6-b247-13bec580dbbe-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Wrong values: (note_57306: 8 -&gt; 16) (note_57444: 8 -&gt; 4)</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e33"
                    select="'layer_57276&#xA;layer_57390'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e33, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xbbc7e7c7-1c45-3cd6-b247-13bec580dbbe-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Wrong values: (note_57306: 8 -&gt; 16) (note_57444: 8 -&gt; 4)</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e33"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xe21774c8-dcd9-3839-b0cc-1d564f23509c"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..artic</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xe21774c8-dcd9-3839-b0cc-1d564f23509c</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>artic</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 1">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8c8f74b6-c9fa-3f3c-991f-a1745496d145"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8c8f74b6-c9fa-3f3c-991f-a1745496d145"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..supplied artic</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8c8f74b6-c9fa-3f3c-991f-a1745496d145</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>supplied artic</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/artic.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d146e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/artic.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d146e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d146e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d146e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d146e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x8c8f74b6-c9fa-3f3c-991f-a1745496d145-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x8c8f74b6-c9fa-3f3c-991f-a1745496d145-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>All values are correct</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e37"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e37, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x8c8f74b6-c9fa-3f3c-991f-a1745496d145-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All values are correct</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e37"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x682c4159-6b9b-3b2b-bb08-80b1913ab9ee"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..graceGrp</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x682c4159-6b9b-3b2b-bb08-80b1913ab9ee</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>graceGrp</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/graceGrp.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d154e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/Documents/dime-mei-tools/util/validation/checkDurations/unit_tests/input/graceGrp.mei')"/>
         <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                       xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d154e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d154e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       as="item()*"
                       select="$Q{urn:x-xspec:compile:impl}context-d154e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d154e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x682c4159-6b9b-3b2b-bb08-80b1913ab9ee-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x682c4159-6b9b-3b2b-bb08-80b1913ab9ee-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>All values are correct</xsl:message>
      <xsl:variable xmlns="http://www.jenitennison.com/xslt/xspec"
                    xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e40"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e40, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x682c4159-6b9b-3b2b-bb08-80b1913ab9ee-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All values are correct</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e40"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
