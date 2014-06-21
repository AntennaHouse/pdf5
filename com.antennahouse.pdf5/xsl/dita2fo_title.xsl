<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet
Module: Generate title module.
Copyright © 2009-2011 Antenna House, Inc. All rights reserved.
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
     function:	Heading generation template for frontmatter
     param:		prmLevel, prmTopicRef, prmTopicContent
     return:	title contents
     note:		
     -->
    <xsl:template name="genFrontmatterTitle">
        <xsl:param name="prmLevel"        required="yes" as="xs:integer"/>
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
        <xsl:param name="prmDefaultTitle" required="no" as="xs:string" tunnel="yes" select="''"/>
        
        <xsl:choose>
            <xsl:when test="exists($prmTopicContent)">
                <xsl:variable name="titleElement" select="$prmTopicContent/*[contains(@class, ' topic/title ')]"/>
                <fo:block>
                	<xsl:choose>
                        <xsl:when test="$prmLevel = 1">
                            <xsl:copy-of select="ahf:getAttributeSet('atsFmHeader1')"/>
                        </xsl:when>
                        <xsl:when test="$prmLevel = 2">
                            <xsl:copy-of select="ahf:getAttributeSet('atsFmHeader2')"/>
                            <xsl:if test="empty($prmTopicRef/preceding-sibling::*[contains(@class,' map/topicref ')]) and $pSupressFirstChildPageBreak">
                                <xsl:copy-of select="ahf:getAttributeSet('atsCancelPageBreak')"/>
                            </xsl:if>
                        </xsl:when>
                	    <xsl:otherwise>
                	        <xsl:copy-of select="ahf:getAttributeSet('atsFmHeader3')"/>
                	    </xsl:otherwise>
                	</xsl:choose>
                    <xsl:copy-of select="ahf:getIdAtts($titleElement,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($titleElement)"/>
                    <xsl:call-template name="processIndextermInMetadata">
                        <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                        <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                    </xsl:call-template>
                    <xsl:apply-templates select="$titleElement">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="true()"/>
                    </xsl:apply-templates>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block>
                	<xsl:choose>
                        <xsl:when test="$prmLevel = 1">
                            <xsl:copy-of select="ahf:getAttributeSet('atsFmHeader1')"/>
                        </xsl:when>
                        <xsl:when test="$prmLevel = 2">
                            <xsl:copy-of select="ahf:getAttributeSet('atsFmHeader2')"/>
                            <xsl:if test="empty($prmTopicRef/preceding-sibling::*[contains(@class,' map/topicref ')]) and $pSupressFirstChildPageBreak">
                                <xsl:copy-of select="ahf:getAttributeSet('atsCancelPageBreak')"/>
                            </xsl:if>
                        </xsl:when>
                	    <xsl:otherwise>
                	        <xsl:copy-of select="ahf:getAttributeSet('atsFmHeader3')"/>
                	    </xsl:otherwise>
                	</xsl:choose>
                    <xsl:copy-of select="ahf:getIdAtts($prmTopicRef,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($prmTopicRef)"/>
                    <xsl:call-template name="processIndextermInMetadata">
                        <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                        <xsl:with-param name="prmTopicContent"  select="$prmTopicContent"/>
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                            <xsl:apply-templates select="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                <xsl:with-param name="prmNeedId"   select="true()"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/@navtitle">
                            <xsl:value-of select="$prmTopicRef/@navtitle"/>        
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$prmDefaultTitle"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	Heading generation template for backmatter
     param:		prmLevel, prmTopicRef, prmTopicContent
     return:	title contents
     note:		Same as frontmatter
     -->
    <xsl:template name="genBackmatterTitle">
        <xsl:param name="prmLevel"        required="yes" as="xs:integer"/>
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
    
        <xsl:call-template name="genFrontmatterTitle">
            <xsl:with-param name="prmLevel" select="$prmLevel"/>
            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- 
     function:	Heading generation template for part/chapter
     param:		prmTopicRef, prmTopicContent
     return:	title contents
     note:		
     -->
    <xsl:template name="genChapterTitle">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
        
        <!-- Nesting level in the bookmap -->
        <xsl:variable name="level" select="count($prmTopicRef/ancestor-or-self::*[contains(@class, ' map/topicref ')])"/>
        <!-- Title prefix -->
        <xsl:variable name="titlePrefix">
            <xsl:call-template name="genTitlePrefix">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            </xsl:call-template>
        </xsl:variable>
    
        <xsl:choose>
            <xsl:when test="exists($prmTopicContent)">
                <xsl:variable name="titleElement" select="$prmTopicContent/child::*[contains(@class, ' topic/title ')]"/>
                <xsl:variable name="title">
                    <xsl:apply-templates select="$titleElement" mode="GET_CONTENTS"/>
                </xsl:variable>
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="$level eq 1">
                            <xsl:choose>
                                <xsl:when test="$pOnlinePdf">
                                    <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead1Online')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead1')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$level eq 2">
                            <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead2')"/>
                            <xsl:if test="empty($prmTopicRef/preceding-sibling::*[contains(@class,' map/topicref ')]) and $pSupressFirstChildPageBreak">
                                <xsl:copy-of select="ahf:getAttributeSet('atsCancelPageBreak')"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead3')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:copy-of select="ahf:getIdAtts($titleElement,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($titleElement)"/>
                    <xsl:if test="$pAddNumberingTitlePrefix">
                        <fo:marker marker-class-name="{$cTitlePrefix}">
                            <fo:inline><xsl:value-of select="$titlePrefix"/></fo:inline>
                        </fo:marker>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="($level eq 1) or ($level eq 2)">
                            <xsl:if test="$pAddNumberingTitlePrefix">
                                <fo:marker marker-class-name="{$cTitlePrefix}">
                                    <fo:inline><xsl:value-of select="$titlePrefix"/></fo:inline>
                                </fo:marker>
                            </xsl:if>
                            <fo:marker marker-class-name="{$cTitleBody}">
                                <fo:inline><xsl:copy-of select="$title"/></fo:inline>
                            </fo:marker>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="makeMarker">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef/parent::node()"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:call-template name="processIndextermInMetadata">
                        <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                        <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                    </xsl:call-template>
                    <xsl:if test="$pAddNumberingTitlePrefix">
                        <xsl:value-of select="$titlePrefix"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:apply-templates select="$titleElement">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="true()"/>
                    </xsl:apply-templates>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="$level eq 1">
                            <xsl:choose>
                                <xsl:when test="$pOnlinePdf">
                                    <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead1Online')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead1')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$level eq 2">
                            <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead2')"/>
                            <xsl:if test="empty($prmTopicRef/preceding-sibling::*[contains(@class,' map/topicref ')]) and $pSupressFirstChildPageBreak">
                                <xsl:copy-of select="ahf:getAttributeSet('atsCancelPageBreak')"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="ahf:getAttributeSet('atsChapterHead3')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:copy-of select="ahf:getIdAtts($prmTopicRef,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($prmTopicRef)"/>
                    <xsl:choose>
                        <xsl:when test="($level eq 1) or ($level eq 2)">
                            <xsl:if test="$pAddNumberingTitlePrefix">
                                <fo:marker marker-class-name="{$cTitlePrefix}">
                                    <fo:inline><xsl:value-of select="$titlePrefix"/></fo:inline>
                                </fo:marker>
                            </xsl:if>
                            <fo:marker marker-class-name="{$cTitleBody}">
                                <fo:inline><xsl:value-of select="$prmTopicRef/@navtitle"/></fo:inline>
                            </fo:marker>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="makeMarker">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef/parent::node()"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:call-template name="processIndextermInMetadata">
                        <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                        <xsl:with-param name="prmTopicContent"  select="$prmTopicContent"/>
                    </xsl:call-template>
                    <xsl:if test="$pAddNumberingTitlePrefix">
                        <xsl:value-of select="$titlePrefix"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                            <xsl:apply-templates select="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                <xsl:with-param name="prmNeedId"   select="true()"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/@navtitle">
                            <xsl:value-of select="$prmTopicRef/@navtitle"/>        
                        </xsl:when>
                    </xsl:choose>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	Heading title template
     param:		prmTopicRef, prmNeedId
     return:	title contents
     note:		
     -->
    <xsl:template match="*[contains(@class, ' topic/title ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:apply-templates>
            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- 
     function:	Heading generation template for appendix
     param:		prmTopicRef, prmTopicContent
     return:	title contents
     note:		
      -->
    <xsl:template name="genAppendixTitle">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
        
        <!-- Nesting level in the bookmap -->
        <xsl:variable name="level" as="xs:integer" select="count($prmTopicRef/ancestor-or-self::*[contains(@class, ' map/topicref ')])"/>
    
        <!-- Title prefix -->
        <xsl:variable name="titlePrefix">
            <xsl:call-template name="genTitlePrefix">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            </xsl:call-template>
        </xsl:variable>
    
        <xsl:choose>
            <xsl:when test="exists($prmTopicContent)">
                <!--title -->
                <xsl:variable name="titleElement" select="$prmTopicContent/child::*[contains(@class, ' topic/title ')]"/>
                <xsl:variable name="title">
                    <xsl:apply-templates select="$titleElement" mode="GET_CONTENTS"/>
                </xsl:variable>
                <fo:block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead1')"/>
                    <xsl:choose>
                        <xsl:when test="$level eq 1">
                            <xsl:choose>
                                <xsl:when test="$pOnlinePdf">
                                    <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead1Online')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead1')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$level eq 2">
                            <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead2')"/>
                            <xsl:if test="empty($prmTopicRef/preceding-sibling::*[contains(@class,' map/topicref ')]) and $pSupressFirstChildPageBreak">
                                <xsl:copy-of select="ahf:getAttributeSet('atsCancelPageBreak')"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead3')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:copy-of select="ahf:getIdAtts($titleElement,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($titleElement)"/>
    
                    <xsl:choose>
                        <xsl:when test="($level eq 1) or ($level eq 2)">
                            <xsl:if test="$pAddNumberingTitlePrefix">
                                <fo:marker marker-class-name="{$cTitlePrefix}">
                                    <fo:inline><xsl:value-of select="$titlePrefix"/></fo:inline>
                                </fo:marker>
                            </xsl:if>
                            <fo:marker marker-class-name="{$cTitleBody}">
                                <fo:inline><xsl:copy-of select="$title"/></fo:inline>
                            </fo:marker>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="makeMarker">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef/parent::node()"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:call-template name="processIndextermInMetadata">
                        <xsl:with-param name="prmTopicRef"     select="$prmTopicRef"/>
                        <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                    </xsl:call-template>
                    <xsl:if test="$pAddNumberingTitlePrefix">
                        <xsl:value-of select="$titlePrefix"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:apply-templates select="$titleElement">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="true()"/>
                    </xsl:apply-templates>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="$level eq 1">
                            <xsl:choose>
                                <xsl:when test="$pOnlinePdf">
                                    <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead1Online')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead1')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$level eq 2">
                            <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead2')"/>
                            <xsl:if test="empty($prmTopicRef/preceding-sibling::*[contains(@class,' map/topicref ')]) and $pSupressFirstChildPageBreak">
                                <xsl:copy-of select="ahf:getAttributeSet('atsCancelPageBreak')"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead3')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:copy-of select="ahf:getIdAtts($prmTopicRef,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($prmTopicRef)"/>
                    <xsl:choose>
                        <xsl:when test="($level eq 1) or ($level eq 2)">
                            <xsl:if test="$pAddNumberingTitlePrefix">
                                <fo:marker marker-class-name="{$cTitlePrefix}">
                                    <fo:inline><xsl:value-of select="$titlePrefix"/></fo:inline>
                                </fo:marker>
                            </xsl:if>
                            <fo:marker marker-class-name="{$cTitleBody}">
                                <fo:inline><xsl:value-of select="$prmTopicRef/@navtitle"/></fo:inline>
                            </fo:marker>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="makeMarker">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef/parent::node()"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:call-template name="processIndextermInMetadata">
                        <xsl:with-param name="prmTopicRef"     select="$prmTopicRef"/>
                        <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                    </xsl:call-template>
                    <xsl:if test="$pAddNumberingTitlePrefix">
                        <xsl:value-of select="$titlePrefix"/>
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                            <xsl:apply-templates select="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                <xsl:with-param name="prmNeedId"   select="true()"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/@navtitle">
                            <xsl:value-of select="$prmTopicRef/@navtitle"/>        
                        </xsl:when>
                    </xsl:choose>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
        function:	Heading generation template for appendices
        param:		prmTopicRef, prmTopicContent
        return:	    title contents
        note:		This template is inttended for appendices[not(@href)] element.
    -->
    <xsl:template name="genAppendicesTitle">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
        
        <fo:block>
            <xsl:choose>
                <xsl:when test="$pOnlinePdf">
                    <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead1Online')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="ahf:getAttributeSet('atsAppendixHead1')"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:copy-of select="ahf:getIdAtts($prmTopicRef,$prmTopicRef,true())"/>
            <xsl:copy-of select="ahf:getLocalizationAtts($prmTopicRef)"/>
            <fo:marker marker-class-name="{$cTitleBody}">
                <xsl:choose>
                    <xsl:when test="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                        <xsl:apply-templates select="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]" mode="GET_CONTENTS">
                            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                            <xsl:with-param name="prmNeedId"   select="false()"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="$prmTopicRef/@navtitle">
                        <xsl:value-of select="$prmTopicRef/@navtitle"/>        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="ahf:getVarValue('Appendices_Title')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:marker>
            <xsl:call-template name="processIndextermInMetadata">
                <xsl:with-param name="prmTopicRef"     select="$prmTopicRef"/>
                <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
            </xsl:call-template>
            <xsl:choose>
                <xsl:when test="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                    <xsl:apply-templates select="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="true()"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="$prmTopicRef/@navtitle">
                    <xsl:value-of select="$prmTopicRef/@navtitle"/>        
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="ahf:getVarValue('Appendices_Title')"></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>
    
    
    
    <!-- 
     function:	Square bullet heading generation 
     param:		prmTopicRef, prmTopicContent
     return:	title contents
     note:		for nested topic/concept/task/reference or toc="no" specified contents
     -->
    <xsl:template name="genSquareBulletTitle">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
    
        <xsl:choose>
            <xsl:when test="exists($prmTopicContent)">
                <xsl:variable name="titleElement" select="$prmTopicContent/child::*[contains(@class, ' topic/title ')]"/>
                <fo:list-block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader4List')"/>
                    <xsl:copy-of select="ahf:getIdAtts($titleElement,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($titleElement)"/>
                    <fo:list-item>
                        <xsl:copy-of select="ahf:getAttributeSet('atsHeader4ListItem')"/>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader4Label')"/>
                                <xsl:call-template name="processIndextermInMetadata">
                                    <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                                    <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                                </xsl:call-template>
                                <fo:inline>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader4LabelInline')"/>
                                    <xsl:value-of select="$cLevel4LabelChar"/>
                                </fo:inline>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader4Body')"/>
                                <xsl:apply-templates select="$titleElement">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                <xsl:with-param name="prmNeedId"   select="true()"/>
                                </xsl:apply-templates>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader4List')"/>
                    <xsl:copy-of select="ahf:getIdAtts($prmTopicRef,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($prmTopicRef)"/>
                    <fo:list-item>
                        <xsl:copy-of select="ahf:getAttributeSet('atsHeader4ListItem')"/>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader4Label')"/>
                                <xsl:call-template name="processIndextermInMetadata">
                                    <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                                    <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                                </xsl:call-template>
                                <fo:inline>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader4LabelInline')"/>
                                    <xsl:value-of select="$cLevel4LabelChar"/>
                                </fo:inline>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader4Body')"/>
                                <xsl:choose>
                                    <xsl:when test="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                                        <xsl:apply-templates select="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                                            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                            <xsl:with-param name="prmNeedId"   select="true()"/>
                                        </xsl:apply-templates>
                                    </xsl:when>
                                    <xsl:when test="$prmTopicRef/@navtitle">
                                        <xsl:value-of select="$prmTopicRef/@navtitle"/>        
                                    </xsl:when>
                                </xsl:choose>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	Round bullet heading generation 
     param:		prmTopicRef, prmTopicContent
     return:	Title contents
     note:
      -->
        <xsl:template name="genRoundBulletTitle">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
        
        <xsl:choose>
            <xsl:when test="exists($prmTopicContent)">
                <xsl:variable name="titleElement" select="$prmTopicContent/child::*[contains(@class, ' topic/title ')]"/>
                <fo:list-block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader5List')"/>
                    <xsl:copy-of select="ahf:getIdAtts($titleElement,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($titleElement)"/>
                    <fo:list-item>
                        <xsl:copy-of select="ahf:getAttributeSet('atsHeader5ListItem')"/>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader5Label')"/>
                                <xsl:call-template name="processIndextermInMetadata">
                                    <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                                    <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                                </xsl:call-template>
                                <fo:inline>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader5LabelInline')"/>
                                    <xsl:value-of select="$cLevel5LabelChar"/>
                                </fo:inline>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader5Body')"/>
                                <xsl:apply-templates select="$titleElement">
                                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                    <xsl:with-param name="prmNeedId"   select="true()"/>
                                </xsl:apply-templates>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader5List')"/>
                    <xsl:copy-of select="ahf:getIdAtts($prmTopicRef,$prmTopicRef,true())"/>
                    <xsl:copy-of select="ahf:getLocalizationAtts($prmTopicRef)"/>
                    <fo:list-item>
                        <xsl:copy-of select="ahf:getAttributeSet('atsHeader5ListItem')"/>
                        <fo:list-item-label end-indent="label-end()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader5Label')"/>
                                <xsl:call-template name="processIndextermInMetadata">
                                    <xsl:with-param name="prmTopicRef"      select="$prmTopicRef"/>
                                    <xsl:with-param name="prmTopicContent" select="$prmTopicContent"/>
                                </xsl:call-template>
                                <fo:inline>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsHeader5LabelInline')"/>
                                    <xsl:value-of select="$cLevel5LabelChar"/>
                                </fo:inline>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block>
                                <xsl:copy-of select="ahf:getAttributeSet('atsHeader5Body')"/>
                                <xsl:choose>
                                    <xsl:when test="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                                        <xsl:apply-templates select="$prmTopicRef/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/navtitle ')]">
                                            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                            <xsl:with-param name="prmNeedId"   select="true()"/>
                                        </xsl:apply-templates>
                                    </xsl:when>
                                    <xsl:when test="$prmTopicRef/@navtitle">
                                        <xsl:value-of select="$prmTopicRef/@navtitle"/>        
                                    </xsl:when>
                                </xsl:choose>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	Generate fo:marker from topichead/topicref element
     param:		prmTopicRef (topichead or topicref)
     return:	fo:marker
     note:		
     -->
    <xsl:template name="makeMarker">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        
        <!-- Title prefix -->
        <xsl:variable name="titlePrefix">
            <xsl:call-template name="genTitlePrefix">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            </xsl:call-template>
        </xsl:variable>
    
        <!-- title -->
        <xsl:variable name="title">
            <xsl:choose>
                <xsl:when test="not($prmTopicRef/@href)">
                    <xsl:value-of select="$prmTopicRef/@navtitle"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="id" select="substring-after($prmTopicRef/@href, '#')"/>
                    <xsl:variable name="topicContent" select="key('topicById', $id)[1]"/>
                    <xsl:apply-templates select="$topicContent/*[contains(@class, ' topic/title ')]" mode="GET_CONTENTS"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
    
        <xsl:if test="$pAddNumberingTitlePrefix">
            <fo:marker marker-class-name="{$cTitlePrefix}">
                <fo:inline><xsl:value-of select="$titlePrefix"/></fo:inline>
            </fo:marker>
        </xsl:if>
        <fo:marker marker-class-name="{$cTitleBody}">
            <fo:inline><xsl:copy-of select="$title"/></fo:inline>
        </fo:marker>
    </xsl:template>

    <!-- 
     function:	Generate prefix of title
     param:		prmTopicRef
     return:	prefix of title 
     note:		none
     -->
    <xsl:template name="genTitlePrefix" as="xs:string">
        <xsl:param name="prmTopicRef" required="yes" as="element()"/>
        
        <xsl:variable name="prefixPart" as="xs:string">
            <xsl:choose>
                <xsl:when test="$isBookMap">
                    <xsl:choose>
                        <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/frontmatter ')]">
                            <xsl:sequence select="''"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/self::*[contains(@class, ' bookmap/part ')]">
                            <xsl:sequence select="$cPartTitlePrefix"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/self::*[contains(@class, ' bookmap/chapter ')]">
                            <xsl:sequence select="$cChapterTitlePrefix"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/self::*[contains(@class, ' bookmap/appendix ')]">
                            <xsl:sequence select="$cAppendixTitle"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/backmatter ')]">
                            <xsl:sequence select="''"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- May be appendice -->
                            <xsl:sequence select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <!-- map -->
                    <xsl:sequence select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="suffixPart" as="xs:string">
            <xsl:choose>
                <xsl:when test="$isBookMap">
                    <xsl:choose>
                        <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/frontmatter ')]">
                            <xsl:sequence select="''"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/self::*[contains(@class, ' bookmap/part ')]">
                            <xsl:sequence select="$cPartTitleSuffix"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/self::*[contains(@class, ' bookmap/chapter ')]">
                            <xsl:sequence select="$cChapterTitleSuffix"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/self::*[contains(@class, ' bookmap/appendix ')]">
                            <xsl:sequence select="''"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/backmatter ')]">
                            <xsl:sequence select="''"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- May be appendice -->
                            <xsl:sequence select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <!-- map -->
                    <xsl:value-of select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="numberPart" as="xs:string">
            <xsl:choose>
                <xsl:when test="$isBookMap">
                    <xsl:choose>
                        <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/frontmatter ')]">
                            <xsl:sequence select="''"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/ancestor-or-self::*[contains(@class, ' bookmap/part ')]">
                            <xsl:sequence select="ahf:genLevelTitlePrefix($prmTopicRef)"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/ancestor-or-self::*[contains(@class, ' bookmap/chapter ')]">
                            <xsl:sequence select="ahf:genLevelTitlePrefix($prmTopicRef)"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]">
                            <xsl:sequence select="ahf:genLevelTitlePrefix($prmTopicRef)"/>
                        </xsl:when>
                        <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/backmatter ')]">
                            <xsl:value-of select="''"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- May be appendice -->
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <!-- map -->
                    <xsl:sequence select="ahf:genLevelTitlePrefix($prmTopicRef)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="result" select="concat($prefixPart,$numberPart,$suffixPart)"/>
        <xsl:sequence select="$result"/>
    </xsl:template>

    <!-- 
     function:	Generate level of topicref
     param:		prmTopicRef
     return:	xs:string 
     note:		none
     -->
    <xsl:function name="ahf:genLevelTitlePrefix" as="xs:string">
        <xsl:param name="prmTopicRef" as="element()"/>
        <xsl:variable name="ancestorOrSelfTopicRef" as="element()*" select="$prmTopicRef/ancestor-or-self::*[contains(@class,' map/topicref ')][not(contains(@class,' bookmap/appendices '))]"/>
        <xsl:variable name="levelString" as="xs:string*" select="ahf:getSibilingTopicrefCount($ancestorOrSelfTopicRef)"/>
        <xsl:sequence select="string-join($levelString,'')"/>
    </xsl:function>

    <!-- 
     function:	Get preceding-sibling topicref count
     param:		prmTopicRef
     return:	xs:string* 
     note:		1. topicref/@toc="no" is not counted.
                2. All topicrefs must be @toc="yes".
     -->
    <xsl:function name="ahf:getSibilingTopicrefCount" as="xs:string*">
        <xsl:param name="prmTopicRefs" as="element()*"/>
        <xsl:choose>
            <xsl:when test="exists($prmTopicRefs[1]) and empty($prmTopicRefs[ahf:isTocNo(.)])">
                <xsl:variable name="topicRef" as="element()" select="$prmTopicRefs[1]"/>
                <xsl:variable name="precedingCount" as="xs:integer">
                    <xsl:choose>
                        <xsl:when test="$topicRef[contains(@class, ' bookmap/part ')]">
                            <xsl:sequence select="count($topicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][contains(@class, ' bookmap/part ')][ahf:isToc(.)])"/>
                        </xsl:when>
                        <xsl:when test="$topicRef[contains(@class, ' bookmap/chapter ')]">
                            <xsl:sequence select="count($topicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][contains(@class, ' bookmap/chapter ')][ahf:isToc(.)])"/>
                        </xsl:when>
                        <xsl:when test="$topicRef[contains(@class, ' bookmap/appendix ')]">
                            <xsl:sequence select="count($topicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][contains(@class, ' bookmap/appendix ')][ahf:isToc(.)])"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="count($topicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][ahf:isToc(.)])"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:sequence select="string($precedingCount + 1)"/>
                <xsl:if test="exists($prmTopicRefs[2])">
                    <xsl:sequence select="$cTitlePrefixSeparator"/>
                </xsl:if>
                <xsl:sequence select="ahf:getSibilingTopicrefCount($prmTopicRefs[position() gt 1])"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>