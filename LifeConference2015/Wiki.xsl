<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output omit-xml-declaration="yes" indent="yes"/>

<xsl:preserve-space elements="li"/>
<xsl:strip-space elements="abstract"/>

<xsl:template match="/">
<mediawiki>
<xsl:apply-templates select="schedule/events" />
</mediawiki>
</xsl:template>

<xsl:template match="events">
	<xsl:apply-templates select="event">
   <xsl:sort select="//schedule/times/timeslot[session = current()/session]/start" order="ascending"/>
   <xsl:sort select="placecode" data-type="number" order="ascending"/>
	</xsl:apply-templates>
</xsl:template>


<xsl:template match="event">
  <page>
		<xsl:apply-templates select="title"/>
    <revision>
      <model>wikitext</model>
      <format>text/x-wiki</format>
      <text>
{{event
|category=<xsl:value-of select="category"/>
|session=<xsl:apply-templates select="session"/>
|speakers=<xsl:apply-templates select="speaker"/>
|abstract=<xsl:apply-templates select="abstract"/>
}}
	</text>
    </revision>
  </page>
</xsl:template>


<xsl:template match="session" >
{{session
|place=<xsl:value-of select="."/><xsl:value-of select="../placecode"/>
|start=<xsl:variable name="sess" select="." /><xsl:apply-templates select="//schedule//times//timeslot[session = $sess]/start" />
|finish=<xsl:apply-templates select="//schedule//times//timeslot[session = $sess]/finish" />
}}
</xsl:template>

<xsl:template match="timeslot"   >
  from <xsl:value-of select="start"/> to <xsl:value-of select="finish"/>
</xsl:template>

<xsl:template match="start"  >
<xsl:value-of select="."/> 
</xsl:template>

<xsl:template match="finish"  >
<xsl:value-of select="."/> 
</xsl:template>

<xsl:template match="title" >
    <title><xsl:value-of select="."/></title>
</xsl:template>

<xsl:template match="abstract"  >
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="p"  >
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ul"  >
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="ol"  >
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="li"  >
<xsl:choose>
      <xsl:when test="parent::ol">#</xsl:when>
      <xsl:when test="ancestor::ol">#*</xsl:when>
      <xsl:otherwise>*</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates/>

</xsl:template>

<xsl:template match="speaker"  >
{{speaker
|name=<xsl:value-of select="name"/>
|affiliation=<xsl:apply-templates select="affiliation"/>
|bio=<xsl:apply-templates select="bio"/>
}}</xsl:template>


<xsl:template match="affiliation"  >{{affiliation
|role=<xsl:apply-templates select="role"/>
|corporation=<xsl:apply-templates select="corporation"/>
}}</xsl:template>

<xsl:template match="role"  ><xsl:value-of select="."/></xsl:template>

<xsl:template match="corporation"  ><xsl:value-of select="."/></xsl:template>
<xsl:template match="bio"  ><xsl:value-of select="."/></xsl:template>

</xsl:stylesheet> 
