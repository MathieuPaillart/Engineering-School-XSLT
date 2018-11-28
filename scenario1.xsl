<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="enginneringSchool">
        <html>
            <head>
                <title>Licenciement</title>
            </head>
            <body>
            </body>
            <xsl:apply-templates select="teachers">
            </xsl:apply-templates>
        </html>
    </xsl:template>

    <xsl:template match="teachers">
        <xsl:for-each select="teacher">
            <xsl:variable name="length" select="string-length(DoB)"/>
            <xsl:if test="(2018-number(substring(DoB,($length)-1,$length))-1900)>30">
                <xsl:value-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="lectures"/>
    <xsl:template match="department"/>

</xsl:stylesheet>
