<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Garages</title>
            </head>
            <body>
                <xsl:for-each select="GARAGES/GARAGE">
                    <xsl:value-of select="NAAM" />
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>