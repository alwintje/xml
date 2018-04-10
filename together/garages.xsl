<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Garages</title>
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>

                <link rel="stylesheet" href="css/uikit.min.css"/>
                <link rel="stylesheet" href="css/custom.css"/>
                <script src="js/uikit.min.js"/>
                <script src="js/uikit-icons.min.js"/>
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
            <a class="uk-accordion-title" href="#">
                <xsl:value-of select="NAAM"/>
            </a>
            <div class="uk-accordion-content">
                <div class="uk-child-width-expand@s" uk-grid="">
                    <div>
                        <table class="uk-table">
                            <caption>Adresgegevens:</caption>
                            <tbody>
                                <tr>
                                    <td class="t_select">Straat</td>
                                    <td class="t_value">
                                        <xsl:value-of select="ADRESGEGEVENS/STRAAT"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t_select">Huisnummer</td>
                                    <td class="t_value">
                                        <xsl:value-of select="ADRESGEGEVENS/HUISNUMMER"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t_select">Postcode</td>
                                    <td class="t_value">
                                        <xsl:value-of select="ADRESGEGEVENS/POSTCODE"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t_select">Plaats</td>
                                    <td class="t_value"><xsl:value-of select="ADRESGEGEVENS/PLAATS"/>,
                                        <xsl:value-of select="ADRESGEGEVENS/PROVINCIE"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t_select">Telefoonnummer</td>
                                    <td class="t_value">
                                        <xsl:value-of select="TELEFOONNUMMER"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t_select">E-mail</td>
                                    <td class="t_value">
                                        <xsl:value-of select="EMAIL"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div>
                        <table class="uk-table">
                            <caption>Werkzaamheden:</caption>
                            <tbody>

                                <xsl:for-each select="WERKPLAATS/WERKZAAMHEDEN/*">
                                    <tr>
                                        <td class="t_select, lowerCase">
                                            <xsl:value-of select="name()"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </div>
                    <div>
                        <xsl:if test="boolean(CERTIFICATEN/BOVAG)">
                            <img src="img/BOVAG.jpeg" class="img_cert"/>
                        </xsl:if>
                        <xsl:if test="boolean(CERTIFICATEN/RDW)">
                            <img src="img/RDW.jpeg" class="img_cert"/>
                        </xsl:if>
                    </div>

                </div>
                <hr class="uk-divider-icon"/>
                <div class="uk-grid-large" uk-grid="">
                    <div>
                        <xsl:apply-templates select="VERKOOP/OPENINGSTIJDEN"/>
                    </div>
                    <div>
                        <xsl:apply-templates select="WERKPLAATS/OPENINGSTIJDEN"/>
                    </div>

                </div>
                <hr class="uk-divider-icon"/>
                <div class="uk-list" uk-grid="">
                    <div>
                        <ul uk-accordion="">
                            <h3>Werknemers:</h3>
                            <xsl:apply-templates select="MEDEWERKERS"/>
                        </ul>
                    </div>
                </div>
                <hr class="uk-divider-icon"/>
                <div class="uk-panel uk-panel-scrollable table_height">
                    <table class="uk-table ">
                        <xsl:apply-templates select="VERKOOP/OCCASIONS"/>
                    </table>
                </div>
            </div>
        </li>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/VERKOOP/OPENINGSTIJDEN|GARAGES/GARAGE/WERKPLAATS/OPENINGSTIJDEN">
        <table class="uk-table">
            <caption class="lowerCase">Openingstijden:
                <xsl:value-of select="name(..)"/>
            </caption>
            <tbody>

                <xsl:for-each select="MAANDAG|DINSDAG|WOENSDAG|DONDERDAG|VRIJDAG|ZATERDAG|ZONDAG">
                    <tr>
                        <td class="t_select">
                            <xsl:value-of select="name()"/>
                        </td>
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
                                        -
                                        <xsl:value-of select="text()"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/MEDEWERKERS">
        <xsl:for-each select="MEDEWERKER">
            <li>
                <xsl:value-of select="VOORNAAM"/><xsl:text> </xsl:text><xsl:value-of select="ACHTERNAAM"/>,
                <xsl:value-of select="FUNCTIE/@naam"/>
            </li>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/VERKOOP/OCCASIONS">
        <xsl:for-each select="AUTO">

            <tbody>
                <tr>
                    <td class="t_select">Model</td>
                    <td class="t_value">
                        <xsl:value-of select="@merk"/>
                        <xsl:value-of select="MODEL"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_select">Bouwjaar</td>
                    <td class="t_value">
                        <xsl:value-of select="BOUWJAAR"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_select">Brandstof</td>
                    <td class="t_value">
                        <xsl:value-of select="BRANDSTOF/@naam"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_select">Kenteken</td>
                    <td class="t_value">
                        <xsl:value-of select="@kenteken"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_select">Prijs</td>
                    <td class="t_value">
                        <xsl:value-of select="PRIJS"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_select">APK-verloopdatum</td>
                    <td class="t_value">
                        <xsl:value-of select="APK-VERLOOP-DATUM"/>
                    </td>
                </tr>
                <xsl:if test="position() != last()"></xsl:if>
                <tr style="border-bottom: solid #d3d3d3 1px"></tr>

            </tbody>

        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>