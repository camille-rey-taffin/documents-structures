<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <div class="templates:surround?with=templates/page.html&amp;at=content">
                <!-- Bande masthead-->
                <header class="masthead bg-primary text-white text-center">
                    <div class="container d-flex align-items-center flex-column">
                        <!-- petit avatar Camille-->
                        <img class="masthead-avatar mb-5" src="resources/images/present.png" alt=""/>
                        <!-- Titre-->
                        <h1 class="masthead-heading text-uppercase mb-0">
                            <xsl:value-of select="/page/main_titre"/>
                        </h1>
                        <!-- Division-->
                        <div class="divider-custom divider-light">
                            <div class="divider-custom-line"/>
                            <div class="divider-custom-icon">
                            <i class="fas fa-seedling"/>
                        </div>
                            <div class="divider-custom-line"/>
                        </div>
                        <!-- Sous-titre-->
                        <p class="masthead-subheading font-weight-light mb-0">
                            <xsl:value-of select="/page/sous_titre"/>
                        </p>
                    </div>
                </header>
                <!-- Section principale-->
                <section class="page-section text-black mb-0" id="about">
                    <xsl:apply-templates select="page/partie"/>                
                </section>
        </div>
    </xsl:template>
    
    <xsl:template match="partie">
        <div class="container" style="padding:60px">
            <!-- Titre de la section-->
            <h2 class="page-section-heading text-center text-uppercase text-black">
                <xsl:value-of select="@titre"/>
            </h2>
            <!-- Division-->
            <div class="divider-custom ">
                <div class="divider-custom-line"/>
                <div class="divider-custom-icon">
                    <i class="fas fa-lemon"/>
                </div>
                <div class="divider-custom-line"/>
            </div>
            <xsl:apply-templates/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="titre">
        <br/>
        <xsl:choose>
            <xsl:when test="@n='1'">
                <h2 class="text-center text-black">
                    <xsl:apply-templates/>
                </h2>
            </xsl:when>
            <xsl:when test="@n='2'">
                <h4 class="text-center text-black text-info">
                    <xsl:apply-templates/>
                </h4>
            </xsl:when>
        </xsl:choose>
        <br/>
    </xsl:template>
    
    <xsl:template match="p">
        <div class=" ml-auto">
            <p class="lead" style="text-align: justify">
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="imp">
        <span class="text-danger">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="ital">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="lien">
        <a href="{@source}" target="_blank">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="cadre">
        <iframe width="90%" height="300px" border="5px" src="{@source}">
        </iframe>
        <br/>
    </xsl:template>
    
    <xsl:template match="image">
        <img src="{@source}" class="img-fluid" alt="Responsive image" style="border: 3px solid #555; max-height:400px; width:auto"/>
        <br/>
        <span class="text-secondary">↑<xsl:value-of select="@legende"/>
        </span>
        <br/>
        <br/>
    </xsl:template>
</xsl:stylesheet>