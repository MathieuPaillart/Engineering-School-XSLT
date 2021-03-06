<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common">
    <xsl:template match="engineeringSchool">
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
        <xsl:text>

        </xsl:text>
        <xsl:variable name="ref">
            <!-- On récupère tous les professeurs d'infos -->
            <xsl:for-each select="../department/promotion/lectures/lectureRef">
                <xsl:if test="attribute::ref-lecture='info'">
                    <xsl:value-of select="teacherList/teacherref"/>
                    <xsl:text>,</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>

            <xsl:for-each select="teacher">
                <!--On regarde juste tous les professeurs qui ont plus de 30 ans et qui sont professeurs d'infos -->
                <xsl:if test="(2018-number(substring(DoB,(string-length(DoB))-1,string-length(DoB)))-1900)>30 and contains($ref,idTeacher)">
                   <xsl:value-of select="name"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="email"/>
                <xsl:text>

                </xsl:text>
            </xsl:if>
        </xsl:for-each>

    </xsl:template>
    <xsl:template match="lectures"/>
    <xsl:template match="students"/>
    <xsl:template match="department"/>
    <!-- On ne veut pas afficher cela donc on enlève le template par défaut -->
</xsl:stylesheet>