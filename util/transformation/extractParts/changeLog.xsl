<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array xsl" version="3.0" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <b>1.2.0</b> (2023-07-31) <ul>
          <li>Improve extraction of scoreDef, #63</li>
          <li>Improve logic for the case when all parts are selected for extraction (MoVi relevant)</li>
          <li>Refactoring and optimization</li>
        </ul>
      </p>
      <p>
        <b>1.1.2</b> (2023-07-17) <ul>
          <li>Refactor file structure and code base.</li>
          <li>Add unit tests for &lt;scoreDef&gt; and minimal running examples</li>
          <li>Change come basic logic</li>
          <li>Refactor and optimize CSS</li>
        </ul>
      </p>
      <p>
        <b>1.1.1</b> (2020-08-20) <ul>
          <li>Add options.xml</li>
        </ul>
      </p>
      <p>
        <b>1.1.0</b> (2020-03-04) <ul>
          <li>Change logic for the mode <i>extractLayer</i> due to the deprecated encoding guidelines for beamed notes.</li>
          <li>Original <i>@doxml:id</i>s are preserved, except for children of the @sameas-elements.</li>
        </ul>
      </p>
      <p>
        <ul>
          <li>2019-12-16: <i>1.0.2</i></li>
          <li>2019-11-22: <i>1.0.1</i></li>
          <li>2019-10-24: <i>1.0.0</i></li>
        </ul>
      </p>
    </desc>
  </doc>

</stylesheet>
