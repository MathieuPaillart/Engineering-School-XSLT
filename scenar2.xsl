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
					<xsl:variable name="type" select="'meilleur'" />
					<xsl:apply-templates select="//engineeringSchool" >
						<xsl:with-param name="type" select="$type"/>
					</xsl:apply-templates>
				</blockquote>
			</div>
			<div>
				<h1>Voici la liste des étudiants méritants de chaque filière :</h1>
				<blockquote>
					<xsl:variable name="type" select="'meritant'" />
					<xsl:apply-templates select="//engineeringSchool" >
						<xsl:with-param name="type" select="$type"/>
					</xsl:apply-templates>
				</blockquote>
			</div>
			<div>
				<h1>Voici l'étudiant ayant la meilleure moyenne toutes filières confondues :</h1>
				<blockquote>
					<xsl:apply-templates select="//engineeringSchool/students">
						<xsl:with-param name="studRefs" select="$allStudents"/>
					</xsl:apply-templates>
				</blockquote>
			</div>
		</body>
	</html>
  </xsl:template>

  <xsl:template match="engineeringSchool">
	<xsl:param name="type"/>
	<xsl:for-each select="department">
		<b><xsl:text>Filière : </xsl:text><xsl:value-of select="@label"/><xsl:text> : </xsl:text></b>
		<xsl:apply-templates>
			<xsl:with-param name="type" select="$type"/>
		</xsl:apply-templates>
	</xsl:for-each>
  </xsl:template>

  <xsl:template match="promotion">
	<xsl:param name="type"/>
	<i><xsl:text>Promotion : </xsl:text><xsl:value-of select="@annee"/><xsl:text>ème année </xsl:text></i>
	<xsl:variable name="students">
		<xsl:for-each select="promotionStudents/studentref">
			<xsl:variable name="ref" select="." />
			<xsl:value-of select="." /><xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:variable>
	<xsl:apply-templates select="//engineeringSchool/students">
				<xsl:with-param name="studRefs" select="$students"/>
				<xsl:with-param name="type" select="$type"/>
			</xsl:apply-templates>
  </xsl:template>
  
  <xsl:template name="promoMoyenne">
	<xsl:param name="studs"/>
	<xsl:text>Moyenne de la promotion : </xsl:text><xsl:value-of select="@annee"/>
	<xsl:value-of select="round(sum(student[contains($studs, idStudent)]/moyenne)div(count(student[contains($studs, idStudent)]/moyenne)))"/>
	<xsl:text>/20</xsl:text>
  </xsl:template>
 
  
  <xsl:template match="engineeringSchool/students">
	<xsl:param name="studRefs"/>
	<xsl:param name="type"/>
	
	<xsl:choose>
		<xsl:when test="$type='meilleur'">
			<xsl:call-template name="promoMoyenne">
				<xsl:with-param name="studs" select="$studRefs"/>
			</xsl:call-template>
			<xsl:for-each select="student[contains($studRefs, idStudent)]">
				<xsl:sort data-type="number" select="moyenne" order="ascending"/>
				<xsl:if test="position() = last()">    
					<xsl:value-of select="firstName"/><xsl:text> </xsl:text><xsl:value-of select="name"/><xsl:text> avec une moyenne de </xsl:text><xsl:value-of select="moyenne"/><xsl:text>/20</xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="student[contains($studRefs, idStudent)]">
				<xsl:sort data-type="number" select="habsences" order="ascending"/>
				<xsl:if test="position() = 1">    
					<xsl:value-of select="firstName"/><xsl:text> </xsl:text><xsl:value-of select="name"/><xsl:text> avec </xsl:text><xsl:value-of select="habsences"/><xsl:text>heures d'absences et une moyenne de </xsl:text><xsl:value-of select="moyenne"/><xsl:text> /20</xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
</xsl:stylesheet>