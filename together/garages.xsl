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
                    <h3>Aantal garages:
                        <xsl:value-of select="count(GARAGES/GARAGE)"/>
                    </h3>
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
                        <table class="uk-table" id="werkzaameheden">
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


                <xsl:if test="boolean(FACILITEITEN)">
                    <hr class="uk-divider-icon"/>
                    <h3>Faciliteiten:</h3>
                    <div class="uk-container">
                        <xsl:if test="boolean(FACILITEITEN/POMPEN)">
                            <xsl:apply-templates select="FACILITEITEN/POMPEN"/>
                        </xsl:if>
                        <xsl:if test="boolean(FACILITEITEN/WASSEN)">
                            <xsl:apply-templates select="FACILITEITEN/WASSEN"/>
                        </xsl:if>
                        <xsl:if test="boolean(FACILITEITEN/WINKEL)">
                            <xsl:apply-templates select="FACILITEITEN/WINKEL"/>
                        </xsl:if>
                    </div>
                </xsl:if>

                <hr class="uk-divider-icon"/>
                <h3>Werknemers:</h3>
                <div class="uk-grid">
                    <xsl:apply-templates select="MEDEWERKERS"/>
                </div>
                <hr class="uk-divider-icon"/>
                <xsl:choose>
                    <xsl:when test="boolean(VERKOOP/NIEUWE-AUTOS)">
                        <xsl:apply-templates select="VERKOOP/NIEUWE-AUTOS"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <h3>Wij verkopen geen nieuwe auto's.</h3>
                    </xsl:otherwise>
                </xsl:choose>
                <hr class="uk-divider-icon"/>
                <xsl:choose>
                    <xsl:when test="boolean(VERKOOP/OCCASIONS)">
                        <xsl:apply-templates select="VERKOOP/OCCASIONS"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <h3>Wij hebben momenteel geen occasions.</h3>
                    </xsl:otherwise>
                </xsl:choose>
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
    <xsl:template match="GARAGES/GARAGE/FACILITEITEN/POMPEN">

        <xsl:for-each select="POMP">
            <table class="uk-table uk-table-striped">
                <tr>
                    <th>Pomp <xsl:value-of select="position()"/></th>
                </tr>
                <xsl:for-each select="BRANDSTOFFEN/BRANDSTOF">
                    <tr>
                        <td><xsl:value-of select="@naam"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </xsl:for-each>

        <table class="uk-table">
            <caption>Prijs voor brandstoffen</caption>
            <tr>
                <xsl:for-each select="BRANDSTOF-PRIJZEN/BRANDSTOF-PRIJS">
                    <th><xsl:value-of select="BRANDSTOF/@naam"/></th>
                </xsl:for-each>
            </tr>
            <tr>
                <xsl:for-each select="BRANDSTOF-PRIJZEN/BRANDSTOF-PRIJS">
                    <td>€<xsl:value-of select="PRIJS"/></td>
                </xsl:for-each>
            </tr>

        </table>

    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/FACILITEITEN/WASSEN">
        <table class="ui-table">
            <xsl:for-each select="WASBOXEN/WASBOX">
                <tr>
                    <td>Wasbox
                        <xsl:value-of select="position()"/>
                    </td>
                    <td>
                        €<xsl:value-of select="PRIJS"/>
                    </td>
                </tr>
            </xsl:for-each>
            <xsl:for-each select="WASSTRATEN/WASSTRAAT">
                <tr>
                    <td>
                        Wasstraat <xsl:value-of select="position()"/>
                    </td>
                    <td>
                        €<xsl:value-of select="PRIJS"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/FACILITEITEN/WINKEL">
        <table class="uk-table uk-table-striped">
            <caption>In de winkel verkopen we:</caption>
            <tbody>
                <xsl:if test="AUTO-ACCESSOIRES">
                    <td>Auto-accessoires</td>
                </xsl:if>
                <xsl:if test="LEVENSMIDDELEN">
                    <td>Levensmiddelen</td>
                </xsl:if>
                <xsl:if test="ROOKWAAR">
                    <td>Rookwaar</td>
                </xsl:if>
                <xsl:if test="TIJDSCHRIFTEN">
                    <td>Tijdschriften</td>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template match="GARAGES/GARAGE/MEDEWERKERS">
        <xsl:for-each select="MEDEWERKER">
            <div class="uk-width-1-2">
                <img onerror="this.src='img/default.jpg';">
                    <xsl:attribute name="src">img/<xsl:value-of select='FOTO/URL'/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">Afbeelding:
                        <xsl:value-of select='FOTO/ALT'/>
                    </xsl:attribute>
                </img>
                <br/>
                <p>
                    <xsl:value-of select="VOORNAAM"/>
                    <xsl:text></xsl:text>
                    <xsl:value-of select="ACHTERNAAM"/>,
                    <xsl:value-of select="FUNCTIE/@naam"/>
                </p>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/VERKOOP/OCCASIONS">
        <h3>Occasions:</h3>
        <div class="uk-panel uk-panel-scrollable table_height">
            <xsl:for-each select="AUTO">
                <div class="uk-width-1-1">
                    <div>
                        <table class="uk-table uk-table-divider">
                            <tbody>
                                <tr>
                                    <td class="t_select">Model</td>
                                    <td class="t_value">
                                        <b>
                                            <xsl:value-of select="@merk"/>
                                        </b>
                                        <xsl:text></xsl:text>
                                        <xsl:value-of select="MODEL"/>
                                    </td>
                                    <td class="t_select">Kenteken</td>
                                    <td class="t_value">
                                        <xsl:value-of select="@kenteken"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t_select">Bouwjaar</td>
                                    <td class="t_value">
                                        <xsl:value-of select="BOUWJAAR"/>
                                    </td>
                                    <td class="t_select">Prijs</td>
                                    <td class="t_value">
                                        <xsl:value-of select="PRIJS"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t_select">Brandstof</td>
                                    <td class="t_value">
                                        <xsl:value-of select="BRANDSTOF/@naam"/>
                                    </td>
                                    <td class="t_select">APK-verloopdatum</td>
                                    <td class="t_value">
                                        <xsl:value-of select="APK-VERLOOP-DATUM"/>
                                    </td>
                                </tr>
                                <xsl:if test="position() != last()"/>
                                <tr style="border-bottom: solid #d3d3d3 1px"/>
                            </tbody>
                        </table>
                    </div>
                </div>
                <h4>Afbeeldingen auto's</h4>
                <div class="uk-grid">
                    <xsl:for-each select="FOTOS/FOTO">
                        <div class="uk-width-1-3">
                            <img onerror="this.src='img/defaultCar.svg';" class="autoFoto">
                                <xsl:attribute name="src">img/<xsl:value-of select='URL'/>
                                </xsl:attribute>
                                <xsl:attribute name="alt">Afbeelding:
                                    <xsl:value-of select='ALT'/>
                                </xsl:attribute>
                            </img>
                        </div>
                        <xsl:if test="position() = last()">
                            <hr id="carLine"/>
                        </xsl:if>
                    </xsl:for-each>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template match="GARAGES/GARAGE/VERKOOP/NIEUWE-AUTOS">
        <h3>Nieuwe auto's:</h3>
        <div class="uk-panel uk-panel-scrollable table_height">
            <xsl:for-each select="AUTO">
                <div class="uk-child-width-1-2@m uk-grid-medium uk-grid-match" uk-grid="">
                    <div>
                        <table class="uk-table ">

                            <tbody>
                                <tr>
                                    <td class="t_select">Model</td>
                                    <td class="t_value">
                                        <b>
                                            <xsl:value-of select="@merk"/>
                                        </b>
                                        <xsl:text></xsl:text>
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
                                <xsl:if test="position() != last()"/>
                                <tr style="border-bottom: solid #d3d3d3 1px"/>
                            </tbody>

                        </table>
                    </div>
                    <h4>Afbeeldingen auto's</h4>
                    <div class="uk-grid">
                        <xsl:for-each select="FOTOS/FOTO">
                            <div class="uk-width-1-3">
                                <img onerror="this.src='img/defaultCar.svg';" class="autoFoto">
                                    <xsl:attribute name="src">img/
                                        <xsl:value-of select='URL'/>
                                    </xsl:attribute>
                                    <xsl:attribute name="alt">Afbeelding:
                                        <xsl:value-of select='ALT'/>
                                    </xsl:attribute>
                                </img>
                            </div>
                            <xsl:if test="position() = last()">
                                <hr id="carLine"/>
                            </xsl:if>
                        </xsl:for-each>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
</xsl:stylesheet>