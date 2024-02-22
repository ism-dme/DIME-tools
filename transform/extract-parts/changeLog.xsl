<?xml version="1.0" encoding="UTF-8"?>
<stylesheet exclude-result-prefixes="xs xd dme functx dita mei map array xsl" version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:array="http://www.w3.org/2005/xpath-functions/array" xmlns:dita="http://dita-ot.sourceforge.net" xmlns:dme="http://www.mozarteum.at/ns/dme" xmlns:functx="http://www.functx.com" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.music-encoding.org/ns/mei">

  <doc scope="stylesheet" xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>
        <b>3.0.0</b> (2024-01-24) <ul>
          <li>Use instruments.xml to find instrument names</li>
          <li>Add P_LANGUAGE</li>
          <li>Create a new mechanism for generating instrument names and abbreviations, dme/dime/dime-mei#95.</li>
          <li>If instruments of different groups are present, do not include integers in the &lt;label&gt;, dme/dime/dime-mei#92.</li>
          <li>Update the logic to reflect the updated guidelines for &lt;dir&gt;s, dme/dime/dime-mei-edition#118</li>
        </ul>
      </p>
      <p>
        <b>2.0.0</b> (2023-12-05) <ul>
          <li>When extracting &lt;layer>, delete the @layer attribute for controlEvents with @tstamp, dme/dime/dime-mei#103</li>
          <li>Handle dynamics for asynchronous Events, dme/dime/dime-mei#75</li>
          <li>For dirs 'a 2' and 'Solo' preserve @place=above, dme/dime/dime-mei#72</li>
          <li>Add feature for creating &lt;multiRest&gt;s, (add parameter P_SHRINK_MEASURES) dme/dime/dime-mei#68</li>
        </ul>
      </p>
      <p>
        <b>1.5.1</b> (2023-10-31) <ul>
          <li>Optimize extraction for tempo|dir|fermata@part=%all, dme/dime/dime-mei#66</li>
          <li>Handle requested staff@n that do not exist, dme/dime/dime-mei#102</li>
        </ul>
      </p>
      <p>
        <b>1.5.0</b> (2023-10-11) <ul>
          <li>Convert mSpace and space to mRest and rest, dme/dime/dime-mei#40</li>
          <li>#bugfix: adding of xmlns:ns0 to the copied nodes and attributese, dme/dime/dime-mei#99</li>
          <li>Fermata: swap @startid, delete @layer, *@sameas, @tstamp dme/dime/dime-mei#96, #97, #74, #98</li>
        </ul>
      </p>
      <p>
        <b>1.4.1</b> (2023-09-27) <ul>
          <li>Delete tempo@part="%all" if only one part is extracted, #76.</li>
        </ul>
      </p>
      <p>
        <b>1.4.0</b> (2023-08-29) <ul>
          <li>When extracting single part, delete visual information such as @ploc/@oloc for rests, @stem.sameas/@stem.dir for notes, dime-mei#83.</li>
          <li>Resolve @startid/@endid for beam@sameas descendant, dime-mei#39.</li>
          <li>Update documentation.</li>
          <li>Refactoring and optimization</li>
        </ul>
      </p>
      <p>
        <b>1.3.0</b> (2023-08-02) <ul>
          <li>Include requested parts in the output file name.</li>
          <li>Improve handling of the cases when <i>all</i> or <i>no</i> parts are requested</li>
        </ul>
      </p>
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
