<?xml version="1.0" encoding="UTF-8"?>
<stylesheet version="3.0" xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/">
  <character-map name="entities">
    <output-character character="&#8198;" string="&amp;#8198;"/>
    <output-character character="&#8194;" string="&amp;#8194;"/>
    <output-character character="&#8195;" string="&amp;#8195;"/>
    <output-character character="&#8211;" string="&amp;#8211;"/>
    <output-character character="&#160;" string="&amp;#160;"/>
    <output-character character="&#xea5c;" string="&amp;#xea5c;"/>
    <output-character character="&#xe263;" string="&amp;#xe263;"/>
    <output-character character="&#xea56;" string="&amp;#xea56;"/>
    <output-character character="&#x1D10B;" string="&amp;#x1D10B;"/>
    <output-character character="&#324;" string="&amp;#324;"/>
    <output-character character="«" string="&amp;"/>
  </character-map>

  <output encoding="UTF-8" indent="yes" method="xml" use-character-maps="entities"/>
  <strip-space elements="*"/>


  <template match="node() | @*" mode="#all" >
    <copy>
      <apply-templates mode="#current" select="node() | @*"/>
    </copy>
    
  </template>

</stylesheet>
