<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: User interface elements stylesheet
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
     function:	uicontrol template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		
     -->
    <xsl:template match="*[contains(@class,' ui-d/uicontrol ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:if test="parent::*[contains(@class, ' ui-d/menucascade ')]">
            <!-- Child of menucascade -->
            <xsl:if test="preceding-sibling::*[contains(@class, ' ui-d/uicontrol ')]">
                <!-- preceding uicontrol -->
                <fo:inline>
                    <!-- append '&gt;' -->
                    <xsl:value-of select="$cMenuCascadeSymbol"/>
                </fo:inline>
            </xsl:if>
        </xsl:if>
        <!-- Add prefix and suffix for uicontrol -->
        <fo:inline>
            <xsl:value-of select="$cUiControlPrefix"/>
            <fo:inline>
                <xsl:copy-of select="ahf:getAttributeSet('atsUiControl')"/>
                <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                <xsl:copy-of select="ahf:getFoProperty(.)"/>
                <xsl:apply-templates>
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:inline>
            <xsl:value-of select="$cUiControlSuffix"/>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	wintitle template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		
     -->
    <xsl:template match="*[contains(@class,' ui-d/wintitle ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsWinTitle')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    
    <!-- 
     function:	menucascade template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		
     -->
    <xsl:template match="*[contains(@class,' ui-d/menucascade ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsMenuCascade')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	shortcut template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		
     -->
    <xsl:template match="*[contains(@class,' ui-d/shortcut ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsShortcut')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	screen template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		
     -->
    <xsl:template match="*[contains(@class,' ui-d/screen ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsScreen')"/>
            <xsl:copy-of select="ahf:getDisplayAtts(.,'atsScreen')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>


</xsl:stylesheet>