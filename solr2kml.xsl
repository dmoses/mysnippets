<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns="http://www.opengis.net/kml/2.2" version="1.0">
    
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">

        <kml xmlns="http://www.opengis.net/kml/2.2">
            <Document>
                <xsl:apply-templates select="descendant::doc"/>
            </Document>
        </kml>

    </xsl:template>
    
    <xsl:template name="formatDate">
        <xsl:param name="dateTime" />
        <xsl:variable name="date" select="substring-before($dateTime, 'T')" />
        <xsl:variable name="year" select="substring-before($date, '-')" />
        <xsl:variable name="month" select="substring-before(substring-after($date, '-'), '-')" />
        <xsl:variable name="day" select="substring-after(substring-after($date, '-'), '-')" />
        <!-- <xsl:value-of select="concat($day, ' ', $month, ' ', $year)" /> -->
        <xsl:value-of select="concat($year, '-', $month, '-', $day)" />
    </xsl:template>
    
    <xsl:template match="doc">

        <Placemark>
            <name>
                <xsl:value-of select="normalize-space(arr[@name='mods_titleInfo_title_ms'])"/>
            </name>
            <description><xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                <xsl:text disable-output-escaping="yes"><![CDATA[
<p><a href="/islandora/object/]]></xsl:text><xsl:value-of
                    select="normalize-space(str[@name='PID'])"/><xsl:text disable-output-escaping="yes"><![CDATA[" target="_blank">]]></xsl:text><xsl:value-of
                        select="normalize-space(arr[@name='mods_titleInfo_title_ms'])"/><xsl:text
                            disable-output-escaping="yes"><![CDATA[</a></p>]]></xsl:text>
                <xsl:if test="arr[@name='mods_originInfo_publisher_ms']">
                    <xsl:text disable-output-escaping="yes"><![CDATA[
<p>Publisher: ]]></xsl:text><xsl:value-of
                        select="normalize-space(arr[@name='mods_originInfo_publisher_ms'])"/><xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
                </xsl:if>
                <xsl:text disable-output-escaping="yes">
<![CDATA[<p>Date: ]]></xsl:text>
                <!-- <xsl:value-of
                    select="normalize-space(arr[@name='dc.date'])"/> -->
                
                <xsl:call-template name="formatDate">
                    <xsl:with-param name="dateTime"
                        select="/response/result/doc/date[@name='mods_originInfo_dateIssued_dt']" />
                </xsl:call-template>
                <xsl:text disable-output-escaping="yes"><![CDATA[</p>
        
]]></xsl:text>
                <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text></description>
                <Point>
                    <coordinates><xsl:value-of
                        select="normalize-space(arr[@name='mods_subject_cartographics_cartographic_long_ms'])"/><xsl:text>,</xsl:text><xsl:value-of
                            select="normalize-space(arr[@name='mods_subject_cartographics_cartographic_lat_ms'])"/></coordinates>
                </Point>
        </Placemark>
    </xsl:template>
    
</xsl:stylesheet>
