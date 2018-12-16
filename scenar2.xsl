<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
	<!-- 
	Créer une variable contenant tous les id de tous les étudiants de l'école
	-->
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
					<!-- 
					Créer une variable contenant un simple texte indiquant quel type de recherche
					nous voulons faire dans une autre template, ici c'est la recherche du meilleur 
					étudiant donc nous lui donnons la valeur "meilleur"
					-->
					<xsl:variable name="type" select="'meilleur'" />
					<!-- 
					La variable précédemment créée est appliquée en paramètre de l'appelle à la template
					-->
					<xsl:apply-templates select="//engineeringSchool" >
						<xsl:with-param name="type" select="$type"/>
					</xsl:apply-templates>
				</blockquote>
			</div>
			<div>
				<h1>Voici la liste des étudiants méritants de chaque filière :</h1>
				<blockquote>
					<!-- 
					Comme précédemment créer une variable contenant un simple texte indiquant quel 
					type de recherche faire dans une autre template, ici c'est la recherche du plus méritant 
					étudiant donc nous lui donnons la valeur "meritant"
					-->
					<xsl:variable name="type" select="'meritant'" />
					<!-- 
					La variable précédemment créée est appliquée en paramètre de l'appelle à la template
					-->
					<xsl:apply-templates select="//engineeringSchool" >
						<xsl:with-param name="type" select="$type"/>
					</xsl:apply-templates>
				</blockquote>
			</div>
			<div>
				<h1>Voici l'étudiant ayant la meilleure moyenne toutes filières confondues :</h1>
				<blockquote>
					<!-- 
					Nous réutilisons la toute première variable créer, contenant l'ensemble des id des 
					étudiants pour la passer en paramètre de la template
					-->
					<xsl:apply-templates select="//engineeringSchool/students">
						<xsl:with-param name="studRefs" select="$allStudents"/>
					</xsl:apply-templates>
				</blockquote>
			</div>
		</body>
	</html>
  </xsl:template>

	<!-- 
	Cette template itère sur chaque département de l'école, affiche son label puis applique une 
	autre template en lui donnant le paramètre "type" qui lui a été passé depuis la template "/"
	-->
  <xsl:template match="engineeringSchool">
	<xsl:param name="type"/>
	<xsl:for-each select="department">
		<b><xsl:text>Filière : </xsl:text><xsl:value-of select="@label"/><xsl:text> : </xsl:text></b>
		<xsl:apply-templates>
			<xsl:with-param name="type" select="$type"/>
		</xsl:apply-templates>
	</xsl:for-each>
  </xsl:template>

  <!-- 
	Cette template permet d'itérer sur chacune des promotions d'un département
	-->
  <xsl:template match="promotion">
	<xsl:param name="type"/>
	<!-- Elle affiche l'année de la promotion -->
	<i><xsl:text>Promotion : </xsl:text><xsl:value-of select="@annee"/><xsl:text>ème année </xsl:text></i>
	<!-- Puis rassemble dans une variable l'ensemble des id des étudiants de cette promotion -->
	<xsl:variable name="students">
		<xsl:for-each select="promotionStudents/studentref">
			<xsl:variable name="ref" select="." />
			<xsl:value-of select="." /><xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:variable>
	<!-- Elle appelle ensuite une autre template à laquelle elle transfert le type et la variable précédemment
	créée en paramètre
	-->
	<xsl:apply-templates select="//engineeringSchool/students">
		<xsl:with-param name="studRefs" select="$students"/>
		<xsl:with-param name="type" select="$type"/>
	</xsl:apply-templates>
  </xsl:template>
  
  <!-- Cette template sert à afficher la moyenne de la promotion -->
  <xsl:template name="promoMoyenne">
	<!-- Elle récupère l'ensemble des étudiants de la promotion par paramètre -->
	<xsl:param name="studs"/>
	<xsl:text>Moyenne de la promotion : </xsl:text><xsl:value-of select="@annee"/>
	<!-- Elle va récupérer parmis tous les étudiants dont l'id correspond fais parti de "studs" leur moyenne et en calculer
	la moyenne de la promo
	-->
	<xsl:value-of select="round(sum(student[contains($studs, idStudent)]/moyenne)div(count(student[contains($studs, idStudent)]/moyenne)))"/>
	<xsl:text>/20</xsl:text>
  </xsl:template>
 
  
  <xsl:template match="engineeringSchool/students">
	<xsl:param name="studRefs"/>
	<xsl:param name="type"/>
	<!-- Elle effectue un choix en fonction du type qui a été transmis en paramètre -->
	<xsl:choose>
		<!-- Ainsi lorsque l'on cherche le meilleur étudiant -->
		<xsl:when test="$type='meilleur'">
			<!-- On affiche la moyenne générale de sa promotion -->
			<xsl:call-template name="promoMoyenne">
				<xsl:with-param name="studs" select="$studRefs"/>
			</xsl:call-template>
			<!-- Puis on va itérer dans la liste des étudiants pour chercher ceux appartenant à cette promotion
			en les triant par moyenne ascendente
			-->
			<xsl:for-each select="student[contains($studRefs, idStudent)]">
				<xsl:sort data-type="number" select="moyenne" order="ascending"/>
				<!-- Le dernier de la liste sera affiché -->
				<xsl:if test="position() = last()">    
					<xsl:value-of select="firstName"/><xsl:text> </xsl:text><xsl:value-of select="name"/><xsl:text> avec une moyenne de </xsl:text><xsl:value-of select="moyenne"/><xsl:text>/20</xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:when>
		<!-- Aurement -->
		<xsl:otherwise>
			<!-- On va itérer dans la liste des étudiants pour chercher ceux appartenant à cette promotion
			en les triant par heures d'absences ascendentes
			-->
			<xsl:for-each select="student[contains($studRefs, idStudent)]">
				<xsl:sort data-type="number" select="habsences" order="ascending"/>
				<xsl:if test="position() = 1"> 
					<!-- Le premier de la liste sera affiché -->				
					<xsl:value-of select="firstName"/><xsl:text> </xsl:text><xsl:value-of select="name"/><xsl:text> avec </xsl:text><xsl:value-of select="habsences"/><xsl:text>heures d'absences et une moyenne de </xsl:text><xsl:value-of select="moyenne"/><xsl:text> /20</xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
</xsl:stylesheet>