<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml"/>
 
	<xsl:template match="/">
		<chalets>
			<xsl:for-each select="//engineeringSchool/department/promotion">
				<chalet>
					<students>
						<apply-templates select="//promotionStudents" />
					</students>
				</chalet>
			</xsl:for-each>	
		</chalets>
	</xsl:template>
	
	<xsl:template match="promotionStudents">
		<xsl:variable name="studFromPromo">
			<xsl:for-each select="studentref">  
				<xsl:value-of select="."/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:value-of select="$studFromPromo"/>
		<xsl:apply-templates>
			<xsl:with-param name="studRefs" select="$studFromPromo"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="students">
		<xsl:param name="studRefs"/>
		<xsl:for-each select="student[contains($studRefs, idStudent)]">   
			<b><xsl:text>Prénom : </xsl:text></b><xsl:value-of select="firstName"/>
			<b><xsl:text>Nom : </xsl:text></b><xsl:value-of select="name"/>
			<b><xsl:text>Numéro de téléphone : </xsl:text></b><xsl:value-of select="phoneNumber"/>
			<b><xsl:text>Email : </xsl:text></b><xsl:value-of select="email"/>
		</xsl:for-each>
	</xsl:template>
</xsl:transform>