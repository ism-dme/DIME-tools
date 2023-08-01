<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs dme functx dita mei map array" version="3.0" xmlns="http://www.oxygenxml.com/ns/doc/xsl" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

	<doc  scope="stylesheet">
		<desc>
      <p><b>ChangeLog</b></p>
      <i>Versions</i>: <p>
        <b>1.1.3</b> (2022-02-11) <ul>
          <li>Basically, revert to the v1.1.1</li>
        </ul>
      </p>
      <p>
        <b>1.1.2</b> (2022-02-04) <ul>
          <li>Add exception: no pointer changes for &lt;slur&gt; if the &lt;chord&gt; has at least one &lt;tie&gt;.</li>
        </ul>
      </p>
      <p>
        <b>1.1.1</b> (11.01.2021) <ul>
          <li>Delete the constraint: <i>If there exist more than one slur which starts/ends from/at chord the note-reference will be preserved.</i></li>
        </ul>
      </p>
      <p>
        <b>1.1.0</b> (07.07.2020) <ul>
          <li>Add same functionality for &lt;dynam&gt;/@startid</li>
          <li>If there exist more than one &lt;slur&gt; which starts/ends from/at &lt;chord&gt; the &lt;note&gt;-reference will be preserved</li>
        </ul>
      </p>
      <p>
        <b>1.0.0</b> (26.06.2020) <ul>
          <li>Initial version</li>
        </ul>
      </p>
      <p>
        <ul>
          <li>07.07.2020: <i>1.1.0</i></li>
          <li>26.06.2020: <i>1.0.0</i></li>
        </ul>
      </p>
    </desc>
	</doc>

</xsl:stylesheet>
