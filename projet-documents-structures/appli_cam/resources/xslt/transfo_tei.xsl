<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/tei:TEI">
        <html>
            <xsl:apply-templates/>
        </html>
    </xsl:template>
    <xsl:template match="tei:teiHeader">
        <table class="table table-striped">
            <tbody>
                <tr>
                    <th>Titre</th>
                    <td>
                        <xsl:value-of select=".//tei:title"/>
                    </td>
                </tr>
                <tr>
                    <th>Autheur</th>
                    <td>
                        <xsl:value-of select=".//tei:author"/>
                    </td>
                </tr>
                <tr>
                    <th>Licence</th>
                    <td>
                        <a href="{.//tei:licence/@target}">
                            <xsl:value-of select=".//tei:licence/@target"/>
                        </a>
                    </td>
                </tr>
                <tr>
                    <th>Date de Publication</th>
                    <td>
                        <xsl:value-of select=".//tei:publicationStmt/tei:date"/>
                    </td>
                </tr>
                <tr>
                    <th>Source</th>
                    <td>
                        <a href="{.//tei:bibl/@source}">
                            <xsl:value-of select=".//tei:bibl/@source"/>
                        </a>
                    </td>
                </tr>
                <tr>
                    <th>Description</th>
                    <td>
                        <xsl:value-of select=".//tei:projectDesc/tei:p"/>
                    </td>
                </tr>
                <tr>
                    <th>Date de la source</th>
                    <td>
                        <xsl:value-of select=".//tei:creation/tei:date"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="./parent::tei:body">
                <h2>
                    <xsl:apply-templates/>
                </h2>
            </xsl:when>
            <xsl:when test="./parent::*/@n='1'">
                <h3>
                    <xsl:apply-templates/>
                </h3>
            </xsl:when>
            <xsl:when test="./parent::*/@n='2'">
                <h4>
                    <xsl:apply-templates/>
                </h4>
            </xsl:when>
            <xsl:when test="./parent::*/@n='3'">
                <h5>
                    <xsl:apply-templates/>
                </h5>
            </xsl:when>
            <xsl:otherwise>
                <h5>
                    <xsl:apply-templates/>
                </h5>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p style="text-align: justify">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend='italic'">
                <i>
                    <xsl:apply-templates/>
                </i>
            </xsl:when>
            <xsl:when test="@rend='bold'">
                <b>
                    <xsl:apply-templates/>
                </b>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:quote">
        <span style="color:grey">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>