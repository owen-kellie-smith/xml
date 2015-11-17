<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output omit-xml-declaration="yes" indent="yes"/>
<xsl:strip-space elements="*"/>

<mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/ http://www.mediawiki.org/xml/export-0.10.xsd" version="0.10" xml:lang="en-gb">
  <page>
    <title>CT1 S2015</title>
    <ns>0</ns>
    <id>10</id>
    <revision>
      <model>wikitext</model>
      <format>text/x-wiki</format>
      <text xml:space="preserve" bytes="107">{{Exam
|Title=Financial Mathematics
|Examiner=Institute and Faculty of Actuaries
|Date=30-September-2015
}}</text>
      <sha1>hd0m8xdii1j6jd2p14yl92pppn8mflr</sha1>
    </revision>
  </page>
  <page>
    <title>CT1 A2015</title>
    <revision>
      <minor/>
      <model>wikitext</model>
      <format>text/x-wiki</format>
      <text xml:space="preserve" bytes="103">{{Exam
|Title=Financial Mathematics
|Examiner=Institute and Faculty of Actuaries
|Date=20-April-2015
}}</text>
    </revision>
  </page>
</mediawiki>

<xsl:template match="/">
<my-xml>
<xsl:apply-templates select="schedule/events" />
</my-xml>
</xsl:template>

<xsl:template match="events">
	<xsl:apply-templates select="event">
   <xsl:sort select="//schedule/times/timeslot[session = current()/session]/start" order="ascending"/>
   <xsl:sort select="placecode" data-type="number" order="ascending"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="events" mode="table">
  <table border="1">
   <thead>
    <tr>
      <th>Session</th>
      <th>Title</th>
      <th>Start</th>
    </tr>
   </thead>
   <tbody>
	<xsl:apply-templates select="event" mode="table">
   <xsl:sort select="//schedule/times/timeslot[session = current()/session]/start" order="ascending"/>
   <xsl:sort select="placecode" data-type="number" order="ascending"/>
	 </xsl:apply-templates>
   </tbody>
  </table>
</xsl:template>

<xsl:template match="event">
		<xsl:apply-templates select="title"/>
		<xsl:choose>
      <xsl:when test="category = 'Plenary'">
				<xsl:apply-templates select="session" mode="Plenary"/>
      </xsl:when>
      <xsl:otherwise>
				<xsl:apply-templates select="session"/>
      </xsl:otherwise>
		</xsl:choose>
    <xsl:comment>
			<xsl:choose>
        <xsl:when test="count(speaker) > 1">Speakers</xsl:when>
        <xsl:otherwise>Speaker</xsl:otherwise>
    	</xsl:choose>
    </xsl:comment>
 
			<ul><xsl:apply-templates select="speaker"/></ul>
		<xsl:apply-templates select="abstract"/>
<hr/>
</xsl:template>

<xsl:template match="event" mode="table">
    <tr>
          <td ><xsl:value-of select="session"/><xsl:value-of select="placecode"/></td>
		<xsl:choose>
      <xsl:when test="category = 'Plenary'">
          <td class="plenary">
	<xsl:element name="a">
		<xsl:attribute name="name">top-<xsl:value-of select="title"/> 
		</xsl:attribute>
		</xsl:element>
		<xsl:element name="a">
		<xsl:attribute name="href">#<xsl:value-of select="title"/> 
		</xsl:attribute>
					<xsl:value-of select="title"/> 
		</xsl:element>
        	<xsl:if test="count(speaker) > 0">
  		(<xsl:for-each select="speaker" >
			<xsl:value-of select="name"/>
			<xsl:apply-templates select="affiliation"/>
        			<xsl:if test="position()!=last()">, 
        			</xsl:if>
  		</xsl:for-each >)
		</xsl:if>
	</td>
      </xsl:when>
      <xsl:otherwise>
          <td>
	<xsl:element name="a">
		<xsl:attribute name="name">top-<xsl:value-of select="title"/> 
		</xsl:attribute>
		</xsl:element>
		<xsl:element name="a">
		<xsl:attribute name="href">#<xsl:value-of select="title"/> 
		</xsl:attribute>
					<xsl:value-of select="title"/> 
		</xsl:element>
          </td>
      </xsl:otherwise>
		</xsl:choose>
    <td ><xsl:apply-templates select="//schedule/times/timeslot[session = current()/session]/start"/></td>
    </tr>
</xsl:template>

<xsl:template match="session"  mode="Plenary">
  <span class="remarkable">Plenary session: 
  <xsl:value-of select="."/><xsl:value-of select="../placecode"/></span>
	<xsl:variable name="sess" select="." />
  <xsl:apply-templates select="//schedule//times//timeslot[session = $sess]" />
  <br />
</xsl:template>

<xsl:template match="session" >
  Workshop: 
  <xsl:value-of select="."/><xsl:value-of select="../placecode"/>
	<xsl:variable name="sess" select="." />
  <xsl:apply-templates select="//schedule//times//timeslot[session = $sess]" />
  <br />
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
	<xsl:element name="a">
		<xsl:attribute name="name"><xsl:value-of select="."/> 
		</xsl:attribute>
		<xsl:element name="a">
		<xsl:attribute name="href">#top-<xsl:value-of select="."/></xsl:attribute>
<h3><xsl:value-of select="."/></h3>
		</xsl:element>
		</xsl:element>
</xsl:template>

<xsl:template match="abstract"  >
<xsl:apply-templates/>
  <br />
</xsl:template>

<xsl:template match="p"  >
   <div><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="ul"  >
<ul><xsl:apply-templates/></ul>
</xsl:template>

<xsl:template match="ol"  >
<ol><xsl:apply-templates/></ol>
</xsl:template>

<xsl:template match="li"  >
   <li><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="speaker"  >
<li><xsl:value-of select="name"/><xsl:apply-templates select="affiliation"/></li>
</xsl:template>


<xsl:template match="affiliation"  ><xsl:apply-templates select="role"/><xsl:apply-templates select="corporation"/></xsl:template>

<xsl:template match="role"  >, <xsl:value-of select="."/></xsl:template>

<xsl:template match="corporation"  >, <xsl:value-of select="."/></xsl:template>

</xsl:stylesheet> 
