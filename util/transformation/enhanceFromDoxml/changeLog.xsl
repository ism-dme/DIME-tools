<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs dme functx dita mei map array" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <b>Versions</b>:
      <p>
        <b>1.2.3</b> (2023-01-24) <ul>
          <li>slurs_ties: add alternative XPath for @endid in non-piano scores.</li>
        </ul>
      </p><p>
        <b>1.2.2</b> (2021-06-23)<ul>
          <li>module keySigs_accidentals: add support for @accid.ges="n". Extende this module with Stylesheet <i>secondTiedNote.xsl</i>, which should be chained in the transformation scenario afterwards.</li>
        </ul>
      </p>
      <p>
        <b>1.2.1</b> (2021-05-31)<ul>
          <li>Minor bug correction (var $sharps).</li>
        </ul>
      </p>
      <b>Versions</b>: <p>
        <b>1.2.0</b> (2020-04-13)<ul>
          <li>Add modules: chordPointers, del_curvedir</li>
          <li>slurs_ties: improve recognition of @emdid</li>
        </ul>
      </p><p>
        <b>1.1.0</b> (2020-04-09)<ul>
          <li>Add <b>keySigs_accidentals</b> module.</li>
        </ul>
      </p>
      <p>
        <b>1.0.1</b> (2020-01-20)<ul>
          <li>Make it working not for piano only.</li>
        </ul>
      </p>
      <b>Versions</b>: <p>
        <b>1.0.0</b> (2020-12-02) <ul>
          <li>Initial: &lt;slur&gt;s and &lt;tie&gt;s are added.</li>
        </ul>
      </p>
    </desc>
  </doc>

</stylesheet>
