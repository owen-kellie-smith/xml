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
		<xsl:choose>
      <xsl:when test="category = 'Plenary'">
				<xsl:apply-templates select="session" mode="Plenary"/>
      </xsl:when>
      <xsl:otherwise>
				<xsl:apply-templates select="session"/>
      </xsl:otherwise>
		</xsl:choose>
 
			<xsl:apply-templates select="speaker"/>
		<xsl:apply-templates select="abstract"/>
	</text>
    </revision>
  </page>
</xsl:template>


<xsl:template match="session"  mode="Plenary">
  Plenary session: 
  <xsl:value-of select="."/><xsl:value-of select="../placecode"/>
	<xsl:variable name="sess" select="." />
  <xsl:apply-templates select="//schedule//times//timeslot[session = $sess]" />

</xsl:template>

<xsl:template match="session" >
  Workshop: 
  <xsl:value-of select="."/><xsl:value-of select="../placecode"/>
	<xsl:variable name="sess" select="." />
  <xsl:apply-templates select="//schedule//times//timeslot[session = $sess]" />

</xsl:template>

<xsl:template match="timeslot"   >
  from <xsl:value-of select="start"/> to <xsl:value-of select="finish"/>
</xsl:template>

<xsl:template match="start"  >
<xsl:variable name="time" select="translate(string(.),' ','T')"/>
<xsl:variable name="jour" select="substring-before($time,'/')" />
<xsl:variable name="heure" select="substring-after($time,'T')" />
<xsl:value-of select="$jour"/>th 
<xsl:value-of select="$heure"/>
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
* <xsl:value-of select="name"/><xsl:apply-templates select="affiliation"/>
</xsl:template>


<xsl:template match="affiliation"  ><xsl:apply-templates select="role"/><xsl:apply-templates select="corporation"/></xsl:template>

<xsl:template match="role"  >, <xsl:value-of select="."/></xsl:template>

<xsl:template match="corporation"  >, <xsl:value-of select="."/></xsl:template>

</xsl:stylesheet> 
