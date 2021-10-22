<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet --><xsl:import href="file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/checkDurations.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/C:/Users/sapov/AppData/Roaming/com.oxygenxml/extensions/v20.1/frameworks/https___www.oxygenxml.com_InstData_Addons_community_updateSite.xml/xspec.support-2.0.0/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:variable>
   <!-- the main template to run the suite -->
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}main"
                 as="empty-sequence()">
      <xsl:context-item use="absent"/>
      <!-- info message --><xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version')"/>
      </xsl:message>
      <!-- set up the result document (the report) -->
      <xsl:result-document xmlns:workaround-for-saxon-bug-4093="http://www.jenitennison.com/xslt/xspec"
                           format="workaround-for-saxon-bug-4093:xml-report-serialization-parameters">
         <xsl:element name="report" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/checkDurations.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario --><xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xe8ba4612-621c-34ea-8935-388635356503"/>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xe8ba4612-621c-34ea-8935-388635356503"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Main output</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xe8ba4612-621c-34ea-8935-388635356503</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Main output</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x95ff1ba0-a224-38ac-8386-80a11b1a4e50"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x399b8a4b-8144-34d8-baab-1181ce364e19"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc5dfa061-6a89-342f-a523-65a6f4580899"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x7ce41b05-9d65-3dc6-a2f1-0783bfb8ec23"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x51768405-a558-308f-824f-6e47a523b23f"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x93056525-df41-3581-89d1-c9f1f1108cac"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x30422724-10d4-3231-b5a2-5ef01a9c7d8c"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x95ff1ba0-a224-38ac-8386-80a11b1a4e50"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Metrum 2/4, tuplets (3/2, whole measure and partial)</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x95ff1ba0-a224-38ac-8386-80a11b1a4e50</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Metrum 2/4, tuplets (3/2, whole measure and partial)</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_2-4_tuplet_3-2.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d50e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_2-4_tuplet_3-2.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d50e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d50e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d50e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d50e0"/>
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
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>All durations are correct.</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e5"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e5, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
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
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e5"/>
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
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Metrtum: 4/4, tuplets (6/4, whole measure and partial)</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_4-4_tuplet_6-4.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d57e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_4-4_tuplet_6-4.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d57e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d57e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d57e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d57e0"/>
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
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>Wrong durations: note_18441 (16 -&gt; 32)</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e8"
                    select="'layer_18360'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e8, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
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
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e8"/>
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
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Metrum 6/8, tuplets (3/2, whole measure and partial)</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_6-8_triplets.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d64e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_6-8_triplets.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d64e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d64e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d64e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d64e0"/>
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
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>Wrong durations: added @dots=2 (at note_10950)</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e11"
                    select="'layer_11004'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e11, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
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
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e11"/>
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
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@dot</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x9ae62798-0260-3aee-81c5-dda30bf8cc9c"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x9ae62798-0260-3aee-81c5-dda30bf8cc9c"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..+ Metrum change: 6/8 -&gt; 4/4</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x9ae62798-0260-3aee-81c5-dda30bf8cc9c</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>+ Metrum change: 6/8 -&gt; 4/4</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_change_6-8_to_4-4.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d73e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/metrum_change_6-8_to_4-4.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d73e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d73e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d73e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d73e0"/>
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
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>Wrong durations: one dot is absent (at note_3960)</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e15"
                    select="'layer_3990'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e15, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
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
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e15"/>
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
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@sameas</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3b8e592b-f17f-383b-9cf6-dadb335f10ea"/>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xf9fc165a-9981-34a9-938f-bd7b05d7158c"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3b8e592b-f17f-383b-9cf6-dadb335f10ea"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..Withe @dots</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3b8e592b-f17f-383b-9cf6-dadb335f10ea</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Withe @dots</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/@sameas_@dots.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d82e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/@sameas_@dots.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d82e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d82e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d82e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d82e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3b8e592b-f17f-383b-9cf6-dadb335f10ea-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3b8e592b-f17f-383b-9cf6-dadb335f10ea-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>rest_160176 references to a rest with @dots</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e19"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e19, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3b8e592b-f17f-383b-9cf6-dadb335f10ea-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>rest_160176 references to a rest with @dots</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e19"/>
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
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Inside tuplet</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/@sameas_tuplet.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d89e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/@sameas_tuplet.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d89e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d89e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d89e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d89e0"/>
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
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>All durations are correct (layer_26862 is the @sameas-in-tuplet-case)</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e22"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e22, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
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
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e22"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x93056525-df41-3581-89d1-c9f1f1108cac"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..app</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x93056525-df41-3581-89d1-c9f1f1108cac</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>app</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc5c4f4b4-43f9-3331-95a0-909496bbb8ed"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xc5c4f4b4-43f9-3331-95a0-909496bbb8ed"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..normal case and @sameas case</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xc5c4f4b4-43f9-3331-95a0-909496bbb8ed</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>normal case and @sameas case </xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/app.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d98e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/app.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d98e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d98e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d98e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d98e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xc5c4f4b4-43f9-3331-95a0-909496bbb8ed-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xc5c4f4b4-43f9-3331-95a0-909496bbb8ed-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>Wrong values: (note_57306: 8 -&gt; 16) (note_57444: 8 -&gt; 4)</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e26"
                    select="'layer_57276&#xA;layer_57390'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e26, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xc5c4f4b4-43f9-3331-95a0-909496bbb8ed-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Wrong values: (note_57306: 8 -&gt; 16) (note_57444: 8 -&gt; 4)</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e26"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x30422724-10d4-3231-b5a2-5ef01a9c7d8c"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..artic</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x30422724-10d4-3231-b5a2-5ef01a9c7d8c</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>artic</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x13f2b96b-a3bd-34fb-9254-6e3170bb8c95"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x13f2b96b-a3bd-34fb-9254-6e3170bb8c95"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..supplied artic</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x13f2b96b-a3bd-34fb-9254-6e3170bb8c95</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/checkDurations.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>supplied artic</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:namespace name="dme">http://www.mozarteum.at/ns/dme</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/artic.mei</xsl:attribute>
               <xsl:attribute name="select" namespace="">/</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d107e0-doc"
                       as="document-node()"
                       select="doc('file:/C:/Users/sapov/DIME/dime-repo_working-set/dev-os/util/validation/checkDurations/unit_tests/input/artic.mei')"/>
         <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                       xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns="http://www.jenitennison.com/xslt/xspec"
                       name="Q{urn:x-xspec:compile:impl}context-d107e0"
                       select="$Q{urn:x-xspec:compile:impl}context-d107e0-doc ! ( / )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d107e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d107e0"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x13f2b96b-a3bd-34fb-9254-6e3170bb8c95-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x13f2b96b-a3bd-34fb-9254-6e3170bb8c95-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context" required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result" required="yes"/>
      <xsl:message>All values are correct</xsl:message>
      <xsl:variable xmlns:dme="http://www.mozarteum.at/ns/dme"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d47e30"
                    select="()"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d47e30, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x13f2b96b-a3bd-34fb-9254-6e3170bb8c95-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>All values are correct</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d47e30"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
