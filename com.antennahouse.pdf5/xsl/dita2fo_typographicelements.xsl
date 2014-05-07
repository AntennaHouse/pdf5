<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Typographic elements stylesheet
Copyright © 2009-2009 Antenna House, Inc. All rights reserved.
Antenna House is a trademark of Antenna House, Inc.
URL    : http://www.antennahouse.com/
E-mail : info@antennahouse.com
****************************************************************
-->
<xsl:stylesheet version="2.0" 
 xmlns:fo="http://www.w3.org/1999/XSL/Format" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:ahf="http://www.antennahouse.com/names/XSLT/Functions/Document"
 exclude-result-prefixes="xs ahf"
>

    <!-- 
     function:	b template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' hi-d/b ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsB')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	i template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' hi-d/i ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsI')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	u template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' hi-d/u ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsU')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	tt template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' hi-d/tt ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsTt')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	sup template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' hi-d/sup ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsSup')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	sub template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' hi-d/sub ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsSub')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>


</xsl:stylesheet>