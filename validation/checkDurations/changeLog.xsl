<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <b>Versions</b>:<p>
        <b>1.1.1</b> (2021-11-25) <ul>
          <li>Improve @copyof and @sameas-support (cases when the pointed element has descendants, e.g. &lt;beam&gt;)</li>
        </ul>
      </p><p>
        <b>1.1.0</b> (2021-10-19) <ul>
          <li>Enable check for &lt;layer>s with &lt;tuplet&gt;s including @sameas-elements</li>
          <li>Exclude &lt;layer>s with &lt;mSpace&gt;, &lt;multiRest&gt;</li>
          <li>Bugfix: when a @sameas-element has @dur (e.g. K. 550 ) the attribute on the element should have a higher priority</li>
          <li>UX improvements: more meaningful filename of the report, add messages if there are no errors, create XPath for &lt;measure&gt;s with @metcon, and &lt;layer&gt;s with &lt;app&gt; or &lt;choice&gt; which can be checked manually</li>
        </ul>
      </p>
      <p>
        <b>1.0.1</b> (30.07.2020) <ul>
          <li>Add @sameas and @copyof support.</li>
        </ul>
      </p>
      <p>
        <b>1.0.0</b> (07.07.2020) <ul>
          <li>Base version.</li>
        </ul>
      </p>
      <p>
        <ul>
          <li>07.07.2020: <i>1.0.0</i></li>
        </ul>
      </p>
    </desc>
  </doc>
</xsl:stylesheet>
