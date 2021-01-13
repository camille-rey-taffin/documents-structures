<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs office meta dc text xsl"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    version="2.0">
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <!--La variable repertoire doit correspondre au chemin (ici relatif) du répertoire contenant le meta.xml lié au content.xml sur lequel s'opère la transformation-->
    <xsl:variable name="repertoire">input/input_decompresse/Wuthering-Heights</xsl:variable>
    <xsl:variable name="meta_doc" select="document(concat($repertoire,'/meta.xml'))/office:document-meta/office:meta"/>
    
    <xsl:template match="office:document-content"> 
        <xsl:processing-instruction name="xml-model"> href="../schema/tei_minimal.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0" </xsl:processing-instruction>
        <TEI>
            <xsl:call-template name="Header"/>
            <text>
            <xsl:apply-templates/>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template name="Header">
        <teiHeader>
            <fileDesc>
                <titleStmt>
                    <title>
                        <xsl:value-of select="$meta_doc/meta:user-defined[@meta:name='Titre']"/>
                    </title>
                    <author>
                        <xsl:value-of select="$meta_doc/meta:user-defined[@meta:name='Auteur']"/>
                    </author>
                </titleStmt>
                <publicationStmt>
                    <distributor/>
                    <availability>
                        <licence>
                            <xsl:attribute name="target"><xsl:value-of select="$meta_doc/meta:user-defined[@meta:name='Licence']"/></xsl:attribute>
                        </licence>
                    </availability>
                    <date>
                        <xsl:value-of select="$meta_doc/meta:user-defined[contains(@meta:name,'Date') and contains(@meta:name,'publication')]"/>
                    </date>
                </publicationStmt>
                <sourceDesc>
                    <bibl>
                        <xsl:attribute name="source"><xsl:value-of select="$meta_doc/meta:user-defined[@meta:name='Source']"/></xsl:attribute>
                    </bibl>
                </sourceDesc>
            </fileDesc>
            <encodingDesc>
                <projectDesc>
                    <p>
                        <xsl:value-of select="$meta_doc/meta:user-defined[@meta:name='Description']"/>
                    </p>
                </projectDesc>
            </encodingDesc>
            <profileDesc>
                <creation>
                    <date>
                        <xsl:value-of select="$meta_doc/meta:user-defined[@meta:name='Date de la source']"/>
                    </date>
                </creation>
            </profileDesc>
        </teiHeader>
    </xsl:template>
    
    <xsl:template match="office:body">
        <body>
            <xsl:apply-templates select="office:text/text:p[@text:style-name='Title']" />
            <!--t Test pour gérer le cas d'un fichier qui commence directement avec des titres de niveau"2" sans aucun titre de niveau 1 (wuthering heights) -->
            <xsl:choose>
                <xsl:when test="office:text/text:h[@text:outline-level='1']">
                    <xsl:apply-templates select="office:text/text:h[@text:outline-level='1']"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="office:text/text:h[@text:outline-level='2']"/>
                </xsl:otherwise>
            </xsl:choose>
        </body>
    </xsl:template>
    
    <xsl:template match="text:p">
        <xsl:choose>
            <xsl:when test="@text:style-name='Title'">
                <head>
                    <xsl:apply-templates/>
                </head>
            </xsl:when>
            <xsl:when test="@text:style-name='citation'">
                <quote>
                    <xsl:apply-templates/>
                </quote>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="text:span">
        <xsl:choose>
            <xsl:when test="@text:style-name='gras'">
                <hi rend="bold">
                    <xsl:apply-templates/>
                </hi>
            </xsl:when>
            <xsl:when test="@text:style-name='italique'">
                <hi rend="italic">
                    <xsl:apply-templates/>
                </hi>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="text:h">
        <xsl:variable name="header-id" select="generate-id(.)"/>
        <xsl:variable name="header-niveau" select="@text:outline-level"/>
        <div>
            <xsl:attribute name="n"><xsl:value-of select="./@text:outline-level"/></xsl:attribute>
            <head>
                <xsl:value-of select="."/>
            </head>
            <!--Ma solution pour transformer la structure plate en structure hiérarchique - dans la <div>, : 
                traiter tous les éléments <text:p> jusqu'au prochain élément "text:h" 
                (ce qui revient à traiter tous les éléments <text:p> dont le <text:h> courant est le preceding <text:h> le plus proche)-->
            <xsl:apply-templates select="following-sibling::text:p[generate-id(preceding-sibling::text:h[1]) = $header-id]" />
            <!--Traiter tous les prochains éléments <text:h> de niveau directement supérieur (n+1), et dont le <text:h> courant est le preceding <text:h> de niveau n le plus proche-->
            <xsl:apply-templates select="following-sibling::text:h[number(@text:outline-level)=number($header-niveau)+1 and (generate-id(preceding-sibling::text:h[@text:outline-level=$header-niveau][1]) = $header-id)]" />
        </div>
    </xsl:template>
    
</xsl:stylesheet>
