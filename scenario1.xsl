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
    <xsl:template name="giveRefTeacher">
        <xsl:param name="name">unknown</xsl:param>
        <xsl:for-each select="../lectures/lecture">
            <xsl:if test="attribute::name=$name">
                <xsl:value-of select="attribute::ref-teacher"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="teachers">
        <xsl:text>

        </xsl:text>
        <xsl:variable name="ref">
            <xsl:call-template name="giveRefTeacher">
                <xsl:with-param name="name">info</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:for-each select="teacher">
            <xsl:if test="(2018-number(substring(DoB,(string-length(DoB))-1,string-length(DoB)))-1900)>30 and $ref=(attribute::idTeacher)">
                <xsl:value-of select="email"/>
                <xsl:text>

                </xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="lectures"/>
    <xsl:template match="department"/>
</xsl:stylesheet>
