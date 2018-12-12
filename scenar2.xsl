<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
	<xsl:variable name="allStudents">
		<xsl:for-each select="//engineeringSchool/students/student">
			<xsl:value-of select="idStudent" />
		</xsl:for-each>
	</xsl:variable>
	<html>
		<body>
			<div>
				<h1>Voici la liste des meilleurs étudiants de chaque filière :</h1>
				<blockquote>
					<xsl:apply-templates select="//engineeringSchool" />
				</blockquote>
			</div>
			<div>
				<h1>Voici la liste des élèves méritants de chaque filière :</h1>
				<blockquote>
					<xsl:apply-templates select="//engineeringSchool" />
				</blockquote>
			</div>
			<div>
				<h1>Voici l'étudiant ayant la meilleure moyenne toutes filières confondues :</h1>
				<blockquote>
					<xsl:apply-templates select="//engineeringSchool/students" >
						<xsl:with-param name="studRefs" select="$allStudents"/>
					</xsl:apply-templates>
				</blockquote>
			</div>
		</body>
	</html>
  </xsl:template>

  <xsl:template match="engineeringSchool">
	<xsl:for-each select="department">
		<xsl:apply-templates />
	</xsl:for-each>
  </xsl:template>

  <xsl:template match="promotion">
	<xsl:value-of select="@label"/><xsl:text> </xsl:text>
	<xsl:variable name="students">
		<xsl:for-each select="promotionStudents/studentref">
			<xsl:variable name="ref" select="." />
			<xsl:value-of select="." /><xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:variable>
	<xsl:apply-templates select="//engineeringSchool/students">
		<xsl:with-param name="studRefs" select="$students"/>
	</xsl:apply-templates>
	<br/>
  </xsl:template>
  
  <xsl:template match="engineeringSchool/students">
	<xsl:param name="studRefs"/>
		<xsl:for-each select="student[contains($studRefs, idStudent)]">
			<xsl:sort data-type="number" select="./moyenne" order="ascending"/>
			<xsl:if test="position() = last()">    
				<xsl:value-of select="firstName"/><xsl:text> </xsl:text><xsl:value-of select="name"/><xsl:text> avec une moyenne de </xsl:text><xsl:value-of select="moyenne"/><xsl:text>/20</xsl:text><br/>
			</xsl:if>
		</xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>