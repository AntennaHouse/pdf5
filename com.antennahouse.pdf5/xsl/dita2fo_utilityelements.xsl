<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Utility elements stylesheet
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
         Almost of DITA utility elements are for HTML output.
         XSL 1.1 cannot support these functions.
     -->
    
    <!-- 
     function:	imagemap template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    
    <xsl:template match="*[contains(@class,' ut-d/imagemap ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsImageMap')"/>
            <xsl:copy-of select="ahf:getDisplayAtts(.,'atsImageMap')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	area template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		none
     -->
    
    <xsl:template match="*[contains(@class,' ut-d/area ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:wrapper>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:wrapper>
    </xsl:template>
    
    <!-- 
     function:	shape template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		none
     -->
    <xsl:template match="*[contains(@class,' ut-d/shape ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:wrapper>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <!-- ignore contents -->
        </fo:wrapper>
    </xsl:template>
    
    <!-- 
     function:	coords template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		none
     -->
    <xsl:template match="*[contains(@class,' ut-d/coords ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:wrapper>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <!-- ignore contents -->
        </fo:wrapper>
    </xsl:template>
    
    <!-- 
     function:	area/xref template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		none
     -->
    <xsl:template match="*[contains(@class,' ut-d/area ')]/*[contains(@class,' topic/xref ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <fo:wrapper>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <!-- ignore xref -->
        </fo:wrapper>
    </xsl:template>

</xsl:stylesheet>