<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    <xsl:template match="engineeringSchool">
        <html>
            <head>
                <title>MonsieurMosser</title>
            </head>
            <body>
            </body>
            Date de retour : <xsl:apply-templates select="teachers/teacher[name='Mosser']">
        </xsl:apply-templates>
            Email mosser : <xsl:value-of select="teachers/teacher[name='Mosser']/email"/>
            <xsl:text>

            </xsl:text>

            <xsl:variable name="idTeacherMosser">
                <xsl:apply-templates select="teachers">
                </xsl:apply-templates>
            </xsl:variable>
            <xsl:variable name="coursesMosser">
                <xsl:apply-templates select="department[attribute::label='SI']/promotion">
                    <xsl:with-param name="idTeacherMosser" select="$idTeacherMosser"/>
                </xsl:apply-templates>
            </xsl:variable>
            <xsl:variable name="coursesMosserTotal">
                <xsl:apply-templates select="lectures">
                    <xsl:with-param name="lecturesMosser" select="$coursesMosser"/>
                </xsl:apply-templates>
            </xsl:variable>
            <xsl:value-of select="$coursesMosserTotal"/>
        </html>
    </xsl:template>
    <xsl:template match="teachers">
        <xsl:for-each select="teacher">
            <xsl:if test="name='Mosser'">
                <xsl:value-of select="idTeacher"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="department[attribute::label='SI']/promotion">
        <xsl:param name="idTeacherMosser"/>

        <xsl:for-each select="lectures/lectureRef">
            <xsl:if test="teacherList/teacherref=$idTeacherMosser">
                <xsl:value-of select="./attribute::ref-lecture"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="lectures">
        <xsl:param name="lecturesMosser"/>
        <xsl:for-each select="lecture">
            <xsl:if test="contains($lecturesMosser,string(attribute::name))">
                <xsl:choose>
                    <xsl:when test="maintenue='true'">
                        <xsl:value-of select="attribute::name"/> maintenue
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="attribute::name"/> pas maintenue
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="teachers/teacher[name='Mosser']">
        <xsl:value-of select="returnDate"/>
    </xsl:template>
</xsl:stylesheet>