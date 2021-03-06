<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0"
    xmlns="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:stdf="http://standoff.proposal">

    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>

    <xsl:template match="/">
        <TEI>
            <xsl:apply-templates select="descendant::teiHeader"/>
            <xsl:if test="descendant::annotationGrp">
                <stdf xmlns="http://standoff.proposal">
                    <soHeader/>
                    <annotations>
                        <xsl:apply-templates select="descendant::annotationGrp" mode="inStdf"/>
                    </annotations>
                </stdf>
            </xsl:if>
            <xsl:apply-templates select="descendant::text"/>
        </TEI>
    </xsl:template>

    <xsl:template match="annotationGrp" mode="inStdf">
        <xsl:element name="annotationGrp" namespace="http://standoff.proposal">
            <xsl:attribute name="corresp" select="concat('#',u/@xml:id)"/>
            <xsl:apply-templates select="spanGrp"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="annotationGrp">
        <xsl:apply-templates select="u"/>
    </xsl:template>

    <xsl:template match="u">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@*"/>
            <!-- Chercher les attributs du annotationGrp -->
            <xsl:apply-templates select="../@who"/>
            <xsl:apply-templates select="../@start"/>
            <xsl:apply-templates select="../@end"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
