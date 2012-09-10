<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:php="http://php.net/xsl">
    <xsl:variable name="OBJECTSPAGE">
        <xsl:value-of select="$objectsPage"/>
    </xsl:variable>
    <xsl:variable name="PID">
        <xsl:value-of select="$pid"/>
    </xsl:variable>
    <xsl:variable name="RECORDID">
        <xsl:value-of select="substring-after($PID,&quot;:&quot;)"/>
    </xsl:variable>
    <xsl:variable name="USER" select="$userID"/>
    <xsl:variable name="INGESTED" select="$ingested"/>



    <xsl:template match="/">
        <!-- a custom view for the PEI Magazine Content -->
        <div id="islandora-book-view">
            <table class="islandora-book-table">
                <tr>
                    <td>
                        <img>
                            <xsl:attribute name="src"><xsl:copy-of select="$OBJECTSPAGE"
                                    />fedora/repository/<xsl:copy-of select="$PID"/>/TN </xsl:attribute>
                            <xsl:attribute name="style">float: left</xsl:attribute>
                        </img>
                    </td>
                    <td>
                        <table class="islandora-book-table" cellpadding="4" cellspacing="4"
                            width="90%">
                            <!-- Table to hold bib data for journal -->
                            <tr>
                                <td align="right" valign="top" width="15%">
                                    <b>Title: </b>
                                </td>
                                <td valign="top">
                                    <xsl:if test="/mods:mods/mods:titleInfo/mods:nonSort">
                                        <xsl:value-of
                                            select="/mods:mods/mods:titleInfo/mods:nonSort"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="/mods:mods/mods:titleInfo/mods:title"/>
                                    <xsl:if test="/mods:mods/mods:titleInfo/mods:subtitle">
                                        <xsl:text> : </xsl:text>
                                        <xsl:value-of
                                            select="/mods:mods/mods:titleInfo/mods:subTitle"/>
                                    </xsl:if>
                                </td>
                            </tr>
                            <tr>
                                <xsl:if test="/mods:mods/mods:part/mods:date">
                                    <td align="right" valign="top">
                                        <b>Date: </b>
                                    </td>
                                    <td valign="top">
                                        <xsl:value-of select="/mods:mods/mods:part/mods:date"/>
                                    </td>
                                </xsl:if>
                            </tr>
                            <tr>
                                <td align="right" valign="top">
                                    <b>Volume Detail: </b>
                                </td>
                                <td valign="top">
                                    <xsl:value-of
                                        select="/mods:mods/mods:part/mods:detail[@type='volume']/mods:caption"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of
                                        select="/mods:mods/mods:part/mods:detail[@type='volume']/mods:number"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of
                                        select="/mods:mods/mods:part/mods:detail[@type='number']/mods:caption"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of
                                        select="/mods:mods/mods:part/mods:detail[@type='number']/mods:number"
                                    />
                                </td>
                            </tr>
                            <tr>
                                <xsl:if test="/mods:mods/mods:originInfo/mods:place/mods:placeTerm">
                                    <td align="right" valign="top">
                                        <b>Place of Publication: </b>
                                    </td>
                                    <td valign="top">
                                        <xsl:value-of
                                            select="/mods:mods/mods:originInfo/mods:place/mods:placeTerm"
                                        />
                                    </td>
                                </xsl:if>
                            </tr>
                            <tr>
                                <xsl:if test="/mods:mods/mods:originInfo/mods:publisher">
                                    <td align="right" valign="top">
                                        <b>Publisher: </b>
                                    </td>
                                    <td valign="top">
                                        <xsl:value-of
                                            select="/mods:mods/mods:originInfo/mods:publisher"/>
                                    </td>
                                </xsl:if>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <table class="islandora-book-table" cellpadding="4" cellspacing="4" border="1"
                style="border: lightgrey">
                <!-- Table to hold ToC data for journal -->

                <tr>
                    <td align="left" valign="top" colspan="2" style="padding-top:3px;">
                        <p>
                            <h3>Table of Contents</h3>
                        </p>
                    </td>
                </tr>
                <tr style="padding-bottom: 2px;">
                    <td align="right" valign="top" width="10%">
                        <b>Paging</b>
                    </td>
                    <td align="left" valign="top">
                        <b>Article Title</b>
                    </td>
                </tr>

                <xsl:if test="//mods:relatedItem[normalize-space(.) != '']">
                    <xsl:for-each select="//mods:relatedItem[@type='constituent']">
                        <tr>
                            <td align="right" valign="top">
                                <xsl:value-of
                                    select="mods:part/mods:extent[@unit='page']/mods:start"/>
                                <xsl:if test="mods:part/mods:extent[@unit='page']/mods:end">
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of
                                        select="mods:part/mods:extent[@unit='page']/mods:end"/>
                                </xsl:if>
                            </td>
                            <td align="left" valign="top">
                                <xsl:element name="a">
                                    <xsl:attribute name="href"><xsl:copy-of select="$OBJECTSPAGE"
                                            />fedora/repository/<xsl:value-of
                                            select="string(@*[namespace-uri()='http://www.w3.org/1999/xlink'
                                            and local-name()='href'])"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="mods:titleInfo/mods:title"/>
                                    <xsl:if test="mods:titleInfo/mods:subTitle[normalize-space(.) !=
                                        '']">
                                        <xsl:text> : </xsl:text>
                                        <xsl:value-of select="mods:titleInfo/mods:subTitle"/>
                                    </xsl:if>
                                </xsl:element>

                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:if>

            </table>
        </div>
    </xsl:template>
</xsl:stylesheet>
