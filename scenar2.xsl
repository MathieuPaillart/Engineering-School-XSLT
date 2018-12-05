<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
	<html>
		<body>
			<div>
				<h1>Voici la liste des meilleurs étudiants de chaque filière :</h1>
				<blockquote>
					<p>
						<xsl:copy>
							<xsl:apply-templates select="//engineeringSchool" />
						</xsl:copy>
					</p>
				</blockquote>
			</div>
			<div>
				<h1>Voici la liste des élèves méritants de chaque filière :</h1>
				<blockquote>
					<xsl:apply-templates select="/second" />
				</blockquote>
			</div>
			<div>
				<h1>Voici l'étudiant ayant la meilleure moyenne toutes filières confondues :</h1>
				<blockquote>
					<xsl:apply-templates select="/majorBest" />
				</blockquote>
			</div>
		</body>
	</html>
  </xsl:template>
  
  <xsl:template match="engineeringSchool">
		<xsl:for-each select="department/promotion/promotionStudents">
			<xsl:apply-templates />
		</xsl:for-each>
  </xsl:template>
  
  <xsl:template match="promotionStudents">
		<xsl:for-each select=".">
			<xsl:value-of select="studentref" />
			<!-- <xsl:variable name="$refs" select="studentref" /> -->
			<!-- <xsl:variable name="$studs" select="//students/student[idStudent=$refs]" /> -->
			<!-- <xsl:for-each select="$studs"> -->
				<!-- <xsl:sort data-type="number" select="moyenne" order="ascending"/> -->
				<!-- <xsl:if test="position() = last()">     -->
					<!-- Meilleur élève : <xsl:value-of select="name" /> <xsl:value-of select="firstname" /> avec une moyenne de : <xsl:value-of select="moyenne" /><br /> -->
				<!-- </xsl:if> -->
			<!-- </xsl:for-each> -->
		</xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>