<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Garages</title>
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <link rel="stylesheet" href="css/custom.css" />
                <link rel="stylesheet" href="css/uikit.min.css" />

                <script src="js/uikit.min.js"></script>
                <script src="js/uikit-icons.min.js"></script>
            </head>
            <body>
                <div class="uk-container">
                    <ul uk-accordion="">
                        <xsl:apply-templates select="GARAGES/GARAGE"/>
                    </ul>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE">
            <li>
                <a class="uk-accordion-title" href="#"><xsl:value-of select="NAAM"></xsl:value-of></a>
                <div class="uk-accordion-content">
                <div class="uk-column-1-3">
                    <table class="uk-table">
                        <caption>Adresgegevens:</caption>
                        <tbody>
                            <tr>
                                <td class="t_select">Straat</td>
                                <td class="t_value"><xsl:value-of select="ADRESGEGEVENS/STRAAT"></xsl:value-of></td>
                            </tr>
                            <tr>
                                <td class="t_select">Huisnummer</td>
                                <td class="t_value"><xsl:value-of select="ADRESGEGEVENS/HUISNUMMER"></xsl:value-of></td>
                            </tr>
                            <tr>
                                <td class="t_select">Postcode</td>
                                <td class="t_value"><xsl:value-of select="ADRESGEGEVENS/POSTCODE"></xsl:value-of></td>
                            </tr>
                            <tr>
                                <td class="t_select">Plaats</td>
                                <td class="t_value"><xsl:value-of select="ADRESGEGEVENS/PLAATS"></xsl:value-of>, <xsl:value-of select="ADRESGEGEVENS/PROVINCIE"></xsl:value-of></td>
                            </tr>
                            <tr>
                                <td class="t_select">Telefoonnummer</td>
                                <td class="t_value"><xsl:value-of select="TELEFOONNUMMER"></xsl:value-of></td>
                            </tr>
                            <tr>
                                <td class="t_select">E-mail</td>
                                <td class="t_value"><xsl:value-of select="EMAIL"></xsl:value-of></td>
                            </tr>
                        </tbody>
                    </table>

                    <table class="uk-table">
                        <caption>Werkzaamheden:</caption>
                        <tbody>

                            <xsl:for-each select="WERKPLAATS/WERKZAAMHEDEN/*">
                                <tr>
                                <td class="t_select, lowerCase"><xsl:value-of select="name()"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                    <div>
                        <xsl:if test="boolean(CERTIFICATEN/BOVAG)"><img src="img/BOVAG.jpeg" class="img_cert"/></xsl:if>
                        <xsl:if test="boolean(CERTIFICATEN/RDW)"><img src="img/RDW.jpeg" class="img_cert"/></xsl:if>
                    </div>

                </div>
                    <hr class="uk-divider-icon"/>
                        <div class="uk-column-1-2">
                            <xsl:apply-templates select="VERKOOP/OPENINGSTIJDEN"/>
                            <xsl:apply-templates select="WERKPLAATS/OPENINGSTIJDEN"/>
                        </div>
                    <hr class="uk-divider-icon"/>
                </div>
            </li>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/VERKOOP/OPENINGSTIJDEN|GARAGES/GARAGE/WERKPLAATS/OPENINGSTIJDEN">
                    <table class="uk-table">
                        <caption class="lowerCase">Openingstijden: <xsl:value-of select="name(..)"/></caption>
                        <tbody>

                            <xsl:for-each select="MAANDAG|DINSDAG|WOENSDAG|DONDERDAG|VRIJDAG|ZATERDAG|ZONDAG">
                                <tr>
                                    <td class="t_select"><xsl:value-of select="name()"></xsl:value-of></td>
                                    <td class="t_value, lowerCase">
                                        <xsl:for-each select="OPENING|SLUITING">
                                            <xsl:if test="(position() mod 2) = 1 and position() != 1">
                                                <br/>
                                            </xsl:if>
                                            <xsl:choose>
                                                <xsl:when test="name() = 'OPENING'">
                                                    <xsl:value-of select="text()"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    - <xsl:value-of select="text()"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </xsl:for-each>
                            
                        </tbody>
                    </table>
    </xsl:template>
</xsl:stylesheet>