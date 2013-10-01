<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet
Module: Common templates
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
 xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
 xmlns:ahf="http://www.antennahouse.com/names/XSLT/Functions/Document"
 exclude-result-prefixes="xs ahf" 
>
    <!-- =======================
          Debug templates
         =======================
     -->
    
    <!-- 
     function:	General template for debug
     param:	    prmTopicRef, prmNeedId
     return:	debug message
     note:		
     -->
    <xsl:template match="*" priority="-3">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:call-template name="warningContinue">
            <xsl:with-param name="prmMes"
             select="ahf:replace($stMes001,('%elem','%file'),(name(.),@xtrf))"/>
        </xsl:call-template>
        <xsl:apply-templates>
            <xsl:with-param name="prmTopicRef"    select="$prmTopicRef"/>
            <xsl:with-param name="prmNeedId"      select="$prmNeedId"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- =======================
          Text-only templates
         =======================
     -->
    
    <!-- * -->
    <xsl:template match="*" mode="TEXT_ONLY">
        <xsl:apply-templates mode="TEXT_ONLY"/>
    </xsl:template>
    
    <!-- text -->
    <xsl:template match="text()" mode="TEXT_ONLY">
        <xsl:param name="prmGetIndextermKey" required="no" tunnel="yes" as="xs:boolean" select="false()"/>
        <xsl:param name="prmGetIndexSeeKey" required="no" tunnel="yes" as="xs:boolean" select="false()"/>
        <xsl:choose>
            <xsl:when test="$prmGetIndextermKey">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:when test="$prmGetIndexSeeKey">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- fn -->
    <xsl:template match="*[contains(@class,' topic/fn ')]" mode="TEXT_ONLY">
    </xsl:template>
    
    <!-- tm -->
    <xsl:variable name="tmSymbolTmText"      select="ahf:getVarValue('Tm_Symbol_Tm_Text')"/>
    <xsl:variable name="tmSymbolRegText"     select="ahf:getVarValue('Tm_Symbol_Reg_Text')"/>
    <xsl:variable name="tmSymbolServiceText" select="ahf:getVarValue('Tm_Symbol_Service_Text')"/>
    
    <xsl:template match="*[contains(@class,' topic/tm ')]" mode="TEXT_ONLY">
        <xsl:apply-templates mode="TEXT_ONLY"/>
        <xsl:choose>
            <xsl:when test="@tmtype='tm'">
                <xsl:value-of select="$tmSymbolTmText"/>
            </xsl:when>
            <xsl:when test="@tmtype='reg'">
                <xsl:value-of select="$tmSymbolRegText"/>
            </xsl:when>
            <xsl:when test="@tmtype='service'">
                <xsl:value-of select="$tmSymbolServiceText"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- data-about -->
    <xsl:template match="*[contains(@class,' topic/data-about ')]" mode="TEXT_ONLY">
    </xsl:template>
    
    <!-- data -->
    <xsl:template match="*[contains(@class,' topic/data ')]" mode="TEXT_ONLY">
    </xsl:template>
    
    <!-- foreign -->
    <xsl:template match="*[contains(@class,' topic/foreign ')]" mode="TEXT_ONLY">
    </xsl:template>
    
    <!-- unknown -->
    <xsl:template match="*[contains(@class,' topic/unknown ')]" mode="TEXT_ONLY">
    </xsl:template>
    
    <!-- no-topic-nesting -->
    <xsl:template match="*[contains(@class,' topic/no-topic-nesting ')]" mode="TEXT_ONLY">
    </xsl:template>
    
    <!-- indexterm is coded in dita2fo_indexcommon.xsl -->
    
    <!-- required-cleanup -->
    <xsl:template match="*[contains(@class,' topic/required-cleanup ')]" mode="TEXT_ONLY">
        <xsl:if test="$pOutputRequiredCleanup">
            <xsl:value-of select="$requiredCleanupTitlePrefix"/>
            <xsl:if test="string(@remap)">
                <xsl:value-of select="$requiredCleanupRemap"/>
                <xsl:value-of select="@remap"/>
            </xsl:if>
            <xsl:value-of select="$requiredCleanupTitleSuffix"/>
            <xsl:apply-templates  mode="TEXT_ONLY"/>
        </xsl:if>
    </xsl:template>
    
    <!-- state -->
    <xsl:template match="*[contains(@class,' topic/state ')]" mode="TEXT_ONLY">
        <xsl:value-of select="@name"/>
        <xsl:text>=</xsl:text>
        <xsl:value-of select="@value"/>
    </xsl:template>
    
    <!-- boolean -->
    <xsl:template match="*[contains(@class,' topic/boolean ')]" mode="TEXT_ONLY">
        <xsl:value-of select="@state"/>
    </xsl:template>
    
    <!-- ========================
          Get contenst as inline
         ========================
     -->
    <!-- 
     function:	Get target contents copy as inline
     param:		none
     return:	fo:inline
     note:		** DOES NOT GENERATE @id & PROCESS INDEXTERM. **
     -->
    <xsl:template match="*" mode="GET_CONTENTS">
        <fo:inline>
            <xsl:copy-of select="ahf:getUnivAtts(.,(),false())"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="()"/>
                <xsl:with-param name="prmNeedId"   select="false()"/>
                <xsl:with-param name="prmGetContent" tunnel="yes" select="true()"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	Generate blank page block
     param:		none
     return:	blank page fo:block
     note:		none
     -->
    <xsl:template name="makeBlankBlock">
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsBlankPageBlock')"/>
            <fo:inline-container>
                <xsl:copy-of select="ahf:getAttributeSet('atsBlankPageInlineContainerBlock')"/>
                <fo:block>
                     <xsl:copy-of select="ahf:getAttributeSet('atsBlankPageInlineBlock')"/>
                </fo:block>
            </fo:inline-container>
            <fo:inline>
                <xsl:copy-of select="ahf:getAttributeSet('atsBlankPageInlineTextBlock')"/>
                <xsl:value-of select="$cBlankPageTitle"/>
            </fo:inline>
            <fo:inline-container>
                <xsl:copy-of select="ahf:getAttributeSet('atsBlankPageInlineContainerBlock')"/>
                <fo:block>
                     <xsl:copy-of select="ahf:getAttributeSet('atsBlankPageInlineBlock')"/>
                </fo:block>
            </fo:inline-container>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	Generate prefix of title
     param:		prmTopicRef
     return:	prefix of title
     note:		none
     -->
    <xsl:template name="genTitlePrefix">
        <xsl:param name="prmTopicRef" required="yes" as="element()"/>
    
        <!-- Who is my ancestor? -->
        <xsl:choose>
            <xsl:when test="$isBookMap">
                <xsl:choose>
                    <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/frontmatter ')]">
                        <!-- frontmatter -->
                        <xsl:value-of select="''"/>
                    </xsl:when>
                    <xsl:when test="$prmTopicRef/ancestor-or-self::*[contains(@class, ' bookmap/part ')]">
                        <!-- part -->
                        <xsl:call-template name="genPartTitlePrefix">
                            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                            <xsl:with-param name="prmStart" select="true()"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$prmTopicRef/ancestor-or-self::*[contains(@class, ' bookmap/chapter ')]">
                        <!-- chapter -->
                        <xsl:call-template name="genChapterTitlePrefix">
                            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                            <xsl:with-param name="prmStart" select="true()"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$prmTopicRef/ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]">
                        <!-- appendix -->
                        <xsl:call-template name="genAppendixTitlePrefix">
                            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                            <xsl:with-param name="prmStart" select="true()"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/backmatter ')]">
                        <!-- backmatter -->
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
                <xsl:call-template name="genMapTitlePrefix">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	Generate prefix of title for part
     param:		prmTopicRef,prmStart
     return:	title string
     note:		
     -->
    <xsl:template name="genPartTitlePrefix">
        <xsl:param name="prmTopicRef" required="yes" as="element()"/>
        <xsl:param name="prmStart" required="yes" as="xs:boolean"/>
        
        <xsl:variable name="isPart" select="boolean(contains($prmTopicRef/@class, ' bookmap/part '))"/>
        <!--xsl:variable name="isNoToc" select="boolean($prmTopicRef/@toc='no')"/-->
        <xsl:variable name="isNoToc" select="ahf:isTocNo($prmTopicRef)"/>
        <xsl:variable name="upperTopicCount" select="count($prmTopicRef/ancestor-or-self::*[contains(@class, ' map/topicref ')])"/>
        
        <xsl:variable name="currentNumber">
            <xsl:choose>
                <xsl:when test="$isPart">
                    <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' bookmap/part ')]) + 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="siblingCount">
                        <!--xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(@toc='no')])"/-->
                        <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(ahf:isTocNo(.))])"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$isNoToc">
                            <xsl:value-of select="$siblingCount"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$siblingCount + 1"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="upperNumber">
            <xsl:choose>
                <xsl:when test="not($prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')])">
                    <xsl:value-of select="''"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="ancestorTopicRef" select="$prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')][1]"/>
                    <xsl:call-template name="genPartTitlePrefix">
                        <xsl:with-param name="prmTopicRef" select="$ancestorTopicRef"/>
                        <xsl:with-param name="prmStart" select="false()"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$isPart">
                <xsl:choose>
                    <xsl:when test="$prmStart and $pAddPartToTitle">
                        <xsl:choose>
                            <xsl:when test="not(string(normalize-space($cPartTitleSuffix)))">
                                <!-- Suffix is only space -->
                                <xsl:value-of select="concat($cPartTitlePrefix,
                                                             $currentNumber,
                                                             $cTitlePrefixSeparator,
                                                             $cPartTitleSuffix)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Suffix is character -->
                                <xsl:value-of select="concat($cPartTitlePrefix,
                                                             $currentNumber,
                                                             $cPartTitleSuffix)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($currentNumber,$cTitlePrefixSeparator)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 2">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:when>
            <xsl:when test="$upperTopicCount = 3">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 4">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- 
     function:	Generate prefix of title for chapter
     param:		prmTopicRef,prmStart
     return:	title string
     note:
     -->
    <xsl:template name="genChapterTitlePrefix">
        <xsl:param name="prmTopicRef" required="yes" as="element()"/>
        <xsl:param name="prmStart" required="yes" as="xs:boolean"/>
        
        <xsl:variable name="isChapter" select="boolean(contains($prmTopicRef/@class, ' bookmap/chapter '))"/>
        <!--xsl:variable name="isNoToc" select="boolean($prmTopicRef/@toc='no')"/-->
        <xsl:variable name="isNoToc" select="ahf:isTocNo($prmTopicRef)"/>
        <xsl:variable name="upperTopicCount" select="count($prmTopicRef/ancestor-or-self::*[contains(@class, ' map/topicref ')])"/>
        
        <xsl:variable name="currentNumber">
            <xsl:choose>
                <xsl:when test="$isChapter">
                    <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' bookmap/chapter ')]) + 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="siblingCount">
                        <!--xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(@toc='no')])"/-->
                        <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(ahf:isTocNo(.))])"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$isNoToc">
                            <xsl:value-of select="$siblingCount"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$siblingCount + 1"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="upperNumber">
            <xsl:choose>
                <xsl:when test="not($prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')])">
                    <xsl:value-of select="''"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="ancestorTopicRef" select="$prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')][1]"/>
                    <xsl:call-template name="genChapterTitlePrefix">
                        <xsl:with-param name="prmTopicRef" select="$ancestorTopicRef"/>
                        <xsl:with-param name="prmStart" select="false()"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$isChapter">
                <xsl:choose>
                    <xsl:when test="$prmStart and $pAddPartToTitle">
                        <xsl:choose>
                            <xsl:when test="not(string(normalize-space($cChapterTitleSuffix)))">
                                <!-- Suffix is only space -->
                                <xsl:value-of select="concat($cChapterTitlePrefix,
                                                             $currentNumber,
                                                             $cTitlePrefixSeparator,
                                                             $cChapterTitleSuffix)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Suffix is character -->
                                <xsl:value-of select="concat($cChapterTitlePrefix,
                                                             $currentNumber,
                                                             $cChapterTitleSuffix)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($currentNumber, $cTitlePrefixSeparator)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 2">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 3">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- 
     function:	Generate title prefix of appendix
     param:		prmTopicRef, prmStart
     return:	title string
     note:		
     -->
    <xsl:template name="genAppendixTitlePrefix">
        <xsl:param name="prmTopicRef" required="yes" as="element()"/>
        <xsl:param name="prmStart" required="yes" as="xs:boolean"/>
        
        <xsl:variable name="titlePrefix">
            <xsl:choose>
                <xsl:when test="$prmStart">
                    <xsl:value-of select="$cAppendixTitle"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="isAppendix" select="boolean(contains($prmTopicRef/@class, ' bookmap/appendix '))"/>
        <!--xsl:variable name="isNoToc" select="boolean($prmTopicRef/@toc='no')"/-->
        <xsl:variable name="isNoToc" select="ahf:isTocNo($prmTopicRef)"/>
        <xsl:variable name="upperTopicCount" select="count($prmTopicRef/ancestor-or-self::*[contains(@class, ' map/topicref ')][. &gt;&gt; $prmTopicRef/ancestor::*[contains(@class, ' bookmap/appendix ')]]) + 1"/>
        
        <xsl:variable name="currentNumber">
            <xsl:choose>
                <xsl:when test="$isAppendix">
                    <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' bookmap/appendix ')]) + 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="siblingCount">
                        <!--xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(@toc='no')])"/-->
                        <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(ahf:isTocNo(.))])"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$isNoToc">
                            <xsl:value-of select="$siblingCount"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$siblingCount + 1"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="upperNumber">
            <xsl:choose>
                <xsl:when test="not($prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')])">
                    <xsl:value-of select="''"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="ancestorTopicRef" select="$prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')][1]"/>
                        <xsl:call-template name="genAppendixTitlePrefix">
                        <xsl:with-param name="prmTopicRef" select="$ancestorTopicRef"/>
                        <xsl:with-param name="prmStart" select="false()"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$isAppendix">
                <xsl:value-of select="concat($titlePrefix, $currentNumber, $cTitlePrefixSeparator)"/>
            </xsl:when>
            <xsl:when test="$upperTopicCount &lt;= 1">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="concat($titlePrefix, $upperNumber)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($titlePrefix, $upperNumber, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 2">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="concat($titlePrefix, $upperNumber)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($titlePrefix, $upperNumber, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 3">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="concat($titlePrefix, $upperNumber)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($titlePrefix, $upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="concat($titlePrefix, $upperNumber)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($titlePrefix, $upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- 
     function:	Generate prefix of title for map/topicref
     param:		prmTopicRef
     return:	title string
     note:
     -->
    <xsl:template name="genMapTitlePrefix">
        <xsl:param name="prmTopicRef" required="yes" as="element()"/>
        
        <xsl:variable name="isRoot" select="boolean($prmTopicRef/parent::*[contains(@class, ' map/map ')])"/>
        <!--xsl:variable name="isNoToc" select="boolean($prmTopicRef/@toc='no')"/-->
        <xsl:variable name="isNoToc" select="ahf:isTocNo($prmTopicRef)"/>
        <xsl:variable name="upperTopicCount" select="count($prmTopicRef/ancestor-or-self::*[contains(@class, ' map/topicref ')])"/>
        
        <xsl:variable name="currentNumber">
            <xsl:choose>
                <xsl:when test="$isRoot">
                    <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')]) + 1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="siblingCount">
                        <!--xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(@toc='no')])"/-->
                        <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(ahf:isTocNo(.))])"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$isNoToc">
                            <xsl:value-of select="$siblingCount"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$siblingCount + 1"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="upperNumber">
            <xsl:choose>
                <xsl:when test="not($prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')])">
                    <xsl:value-of select="''"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="ancestorTopicRef" select="$prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')][1]"/>
                    <xsl:call-template name="genMapTitlePrefix">
                        <xsl:with-param name="prmTopicRef" select="$ancestorTopicRef"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$isRoot">
                <xsl:value-of select="concat($currentNumber,$cTitlePrefixSeparator)"/>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 2">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 3">
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$currentNumber=0">
                        <xsl:value-of select="$upperNumber"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- 
     function:	Generate numbering prefix of table/fig title
     param:		prmTopicRef, prmCutLimit
     return:	prefix of title
     note:		none
     -->
    <xsl:function name="ahf:genNumberingPrefix" as="xs:string">
        <xsl:param name="prmTopicRef" as="element()"/>
        <xsl:param name="prmCutLimit" as="xs:integer"/>
        
        <xsl:choose>
            <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/frontmatter ')]">
                <!-- frontmatter is not object of numbering -->
                <xsl:sequence select="''"/>
            </xsl:when>
            <xsl:when test="$prmTopicRef/ancestor::*[contains(@class, ' bookmap/backmatter ')]">
                <!-- backmatter  is not object of numbering -->
                <xsl:sequence select="''"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- generate numbering prefix -->
                <xsl:sequence select="ahf:genNumberingPrefixSub($prmTopicRef, $prmCutLimit)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="ahf:genNumberingPrefixSub" as="xs:string">
        <xsl:param name="prmTopicRef" as="element()"/>
        <xsl:param name="prmCutLimit" as="xs:integer"/>
    
        <xsl:variable name="upperTopicCount" select="count($prmTopicRef/ancestor-or-self::*[contains(@class, ' map/topicref ')])"/>
    
        <xsl:variable name="currentNumber" as="xs:string">
            <xsl:choose>
                <xsl:when test="$upperTopicCount &gt; $prmCutLimit">
                    <xsl:sequence select="''"/>
                </xsl:when>
                <xsl:when test="$upperTopicCount=1">
                    <xsl:choose>
                        <xsl:when test="contains($prmTopicRef/@class, ' bookmap/part ')">
                            <xsl:sequence select="string(count($prmTopicRef/preceding-sibling::*[contains(@class, ' bookmap/part ')]) + 1)"/>
                        </xsl:when>
                        <xsl:when test="contains($prmTopicRef/@class, ' bookmap/chapter ')">
                            <xsl:sequence select="string(count($prmTopicRef/preceding-sibling::*[contains(@class, ' bookmap/chapter ')]) + 1)"/>
                        </xsl:when>
                        <xsl:when test="contains($prmTopicRef/@class, ' bookmap/appendix ')">
                            <xsl:sequence select="string(count($prmTopicRef/preceding-sibling::*[contains(@class, ' bookmap/appendix ')]) + 1)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="string(count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')]) + 1)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="siblingCount">
                        <!--xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(@toc='no')])"/-->
                        <xsl:value-of select="count($prmTopicRef/preceding-sibling::*[contains(@class, ' map/topicref ')][not(ahf:isTocNo(.))])"/>
                    </xsl:variable>
                    <xsl:choose>
                        <!--xsl:when test="boolean($prmTopicRef/@toc='no')"-->
                        <xsl:when test="ahf:isTocNo($prmTopicRef)">
                            <xsl:sequence select="if ($siblingCount=0) then '' else string($siblingCount)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="string($siblingCount + 1)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="upperNumber" as="xs:string">
            <xsl:choose>
                <xsl:when test="not($prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')])">
                    <xsl:sequence select="''"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="ancestorTopicRef" select="$prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')][1]"/>
                    <xsl:sequence select="ahf:genNumberingPrefixSub($ancestorTopicRef, $prmCutLimit)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$upperTopicCount &gt; $prmCutLimit">
                <xsl:sequence select="$upperNumber"/>
            </xsl:when>
            <xsl:when test="not($prmTopicRef/ancestor::*[contains(@class, ' map/topicref ')])">
                <xsl:sequence select="concat($currentNumber,$cTitlePrefixSeparator)"/>
            </xsl:when>
            <xsl:when test="$upperTopicCount = 2">
                <xsl:sequence select="if ($currentNumber='') then $upperNumber else concat($upperNumber, $currentNumber)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="if ($currentNumber='') then $upperNumber else concat($upperNumber, $cTitlePrefixSeparator, $currentNumber)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <!-- 
     function:	Generate Thumb index 
     param:		none
     return:	
     note:		
     -->
    <xsl:template name="genThumbIndex">
        <xsl:param name="prmId" required="yes" as="xs:string"/>
        <xsl:param name="prmClass" required="yes" as="xs:string"/>
        
        <xsl:choose>
            <xsl:when test="$prmId=''">
                <xsl:for-each select="$thumbIndexMap/*[@class=$prmClass]">
                    <xsl:call-template name="genThumbIndexMain"/>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="$thumbIndexMap/*[@id=$prmId]">
                    <xsl:call-template name="genThumbIndexMain"/>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	Generate Thumb index main
     param:		none (current is $thumIndexMap/*)
     return:	Thumb index fo:block
     note:		
     -->
    <xsl:template name="genThumbIndexMain">
    
        <xsl:variable name="offset" select="concat(string((@index -1) * 10),'mm')"/>
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexBlock')"/>
            <fo:inline-container>
                <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexPaddingInlineContainer1')"/>
            </fo:inline-container>
            <fo:inline-container width="{$offset}"/>
            <fo:inline-container>
                <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexInlineContainer')"/>
                <fo:block-container>
                    <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexBlockContainer')"/>
                    <fo:block>
                        <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexColor')"/>
                        <xsl:value-of select="@label"/>
                    </fo:block>
                </fo:block-container>
            </fo:inline-container>
            <fo:inline-container>
                <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexPaddingInlineContainer2')"/>
            </fo:inline-container>
            <fo:inline-container>
                <fo:block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexTitleBlock')"/>
                    <fo:inline>
                        <xsl:copy-of select="ahf:getAttributeSet('atsThumbIndexTitleInline')"/>
                        <xsl:value-of select="@title"/>
                    </fo:inline>
                </fo:block>
            </fo:inline-container>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	Get topic title generation mode
     param:		prmTopicRref
     return:	cRoundBulletTitleMode, cSquareBulletTitleMode, cNoRestrictionTitleMode
     note:		
     -->
    <xsl:function name="ahf:getTitleMode" as="xs:integer">
        <xsl:param name="prmTopicRef" as="element()"/>
        <xsl:param name="prmTopicContent" as="element()?"/>
        
        <!--xsl:variable name="isNoToc" select="boolean($prmTopicRef/@toc='no')"/-->
        <xsl:variable name="isNoToc" select="ahf:isTocNo($prmTopicRef)"/>
        <!--xsl:variable name="hasNoTocAncestor" select="boolean($prmTopicRef/ancestor::*[contains(@class,' map/topicref ')][@toc='no'])"/-->
        <xsl:variable name="hasNoTocAncestor" select="boolean($prmTopicRef/ancestor::*[contains(@class,' map/topicref ')][ahf:isTocNo(.)])"/>
        <xsl:variable name="isNestedTopic" as="xs:boolean">
            <xsl:choose>
                <xsl:when test="empty($prmTopicContent)">
                    <xsl:sequence select="false()"/>
                </xsl:when>
                <xsl:when test="$prmTopicContent/ancestor::*[contains(@class, ' topic/topic ')]">
                    <xsl:sequence select="true()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:sequence select="false()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$hasNoTocAncestor">
                <xsl:value-of select="$cRoundBulletTitleMode"/>
            </xsl:when>
            <xsl:when test="$isNoToc">
                <xsl:choose>
                    <xsl:when test="$isNestedTopic">
                        <xsl:value-of select="$cRoundBulletTitleMode"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$cSquareBulletTitleMode"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$isNestedTopic">
                        <xsl:value-of select="$cSquareBulletTitleMode"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$cNoRestrictionTitleMode"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- =====================================
          indexterm related common template
         ===================================== -->
    
    <!-- 
     function:	Process indexterm in metadata
     param:		prmTopicRef, prmTopicContent
     return:	call indexterm template and make index-key or start FO object
     note:		This template should be called from the beginning of topic/title template.
                Changed to allow empty($prmTopicContent) 2011-07-25 t.makita
                The indexterm must be exist before (<<) the $lastTopicRef. 
                Otherwise it will be ignored by FO processor. 
                This template ignores if <indexterm> exists aftre the $lastTopicRef.
                2012-03-29 t.makita
     -->
    <xsl:template name="processIndextermInMetadata">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
        
        <xsl:if test="$prmTopicRef &lt;&lt; $lastTopicRef or $prmTopicRef is $lastTopicRef">
            <!-- Make @index-key and start FO object for topicref/topicmeta/keywords/indexterm 
                 $prmTopicRef must be () because indexterm exists in topicref/topicmeta.
                 It does not exists in topic pointed by topicref.
             -->
            <xsl:choose>
                <xsl:when test="exists($prmTopicContent)">
                    <xsl:choose>
                        <xsl:when test="$prmTopicContent/ancestor::*[contains(@class,' topic/topic ')]"/>
                        <xsl:otherwise>
                            <xsl:apply-templates select="$prmTopicRef/child::*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]">
                                <xsl:with-param name="prmTopicRef" select="()"/>
                                <xsl:with-param name="prmNeedId" select="false()"/>
                                <xsl:with-param name="prmMakeKeyAndStart" tunnel="yes" select="true()"/>
                            </xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>            
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$prmTopicRef/child::*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]">
                        <xsl:with-param name="prmTopicRef" select="()"/>
                        <xsl:with-param name="prmNeedId" select="false()"/>
                        <xsl:with-param name="prmMakeKeyAndStart" tunnel="yes" select="true()"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        
            <!-- Make @index-key and start FO object for topic/prolog/metadata/keywords/indexterm -->
            <xsl:if test="exists($prmTopicContent)">
                <xsl:apply-templates select="$prmTopicContent/child::*[contains(@class, ' topic/prolog ')]/child::*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId" select="false()"/>
                    <xsl:with-param name="prmMakeKeyAndStart" tunnel="yes" select="true()"/>
                </xsl:apply-templates>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <!-- 
     function:	Process indexterm in metadata
     param:		prmTopicRef, prmTopicContent
     return:	call indexterm template and make fo:index-range-end FO object
     note:		This template should be called from the end of topicref.
     -->
    <xsl:template name="processIndextermInMetadataEnd">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()?"/>
        
        <xsl:variable name="indextermRangeEnd" as="element()*">
            <!-- topicref/topicmeta/keywords/indexterm -->
            <xsl:apply-templates select="$prmTopicRef/child::*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]">
                <xsl:with-param name="prmTopicRef" select="()"/>
                <xsl:with-param name="prmNeedId" select="false()"/>
                <xsl:with-param name="prmMakeEnd" tunnel="yes" select="true()"/>
            </xsl:apply-templates>
        
            <!-- topic/prolog/metadata/keywords/indexterm -->
            <xsl:if test="exists($prmTopicContent)">
                <xsl:apply-templates select="$prmTopicContent/descendant-or-self::*[contains(@class,' topic/topic ')]/child::*[contains(@class, ' topic/prolog ')]/child::*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId" select="false()"/>
                    <xsl:with-param name="prmMakeEnd" tunnel="yes" select="true()"/>
                </xsl:apply-templates>
            </xsl:if>
            
            <xsl:if test="exists($prmTopicContent)">
                <!-- Make fo:index-range-end FO object for topic/prolog/metadata/keywords/indexterm 
                     that has @start but has no corresponding @end indexterm
                 -->
                <xsl:apply-templates select="$prmTopicContent/descendant-or-self::*[contains(@class,' topic/topic ')]/child::*[contains(@class, ' topic/prolog ')]/child::*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId" select="false()"/>
                    <xsl:with-param name="prmMakeComplementEnd" tunnel="yes" select="true()"/>
                    <xsl:with-param name="prmRangeElem" tunnel="yes" select="$prmTopicRef"/><!-- Special! -->
                </xsl:apply-templates>
            </xsl:if>
            
            <!-- Make fo:index-range-end FO object for topicref/topicmeta/keywords/indexterm 
                 that has @start but has no corresponding @end indexterm
             -->
            <xsl:if test="$prmTopicRef is $lastTopicRef">
                <xsl:for-each select="$map/descendant::*[contains(@class,' map/topicref ')]">
                    <xsl:variable name="topicRef" select="."/>
                    <xsl:apply-templates select="$topicRef/child::*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]">
                        <xsl:with-param name="prmTopicRef" select="$topicRef"/>
                        <xsl:with-param name="prmNeedId" select="false()"/>
                        <xsl:with-param name="prmMakeComplementEnd" tunnel="yes" select="true()"/>
                        <xsl:with-param name="prmRangeElem" tunnel="yes" select="$map"/>
                   </xsl:apply-templates>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>
    
        <xsl:if test="exists($indextermRangeEnd)">
            <fo:block-container>
                <xsl:copy-of select="$indextermRangeEnd"/>
            </fo:block-container>
        </xsl:if>
        
        
    </xsl:template>
    
    <!-- 
        function:	Complement indexterm[@end] in topic body portion
        param:		prmTopicRef, prmTopicContent
        return:	    call indexterm template and make fo:index-range-end FO object
        note:		This template should be called from the end of topic.
    -->
    <xsl:template name="processIndextermInTopicEnd">
        <xsl:param name="prmTopicRef"     required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()"/>
        
        <xsl:variable name="indextermRangeEnd" as="element()*">
            <!-- topic/title -->
            <xsl:apply-templates select="$prmTopicContent/child::*[contains(@class, ' topic/title ')]//*[contains(@class, ' topic/indexterm ')]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId" select="false()"/>
                <xsl:with-param name="prmMakeComplementEnd" tunnel="yes" select="true()"/>
                <xsl:with-param name="prmRangeElem" tunnel="yes" select="$prmTopicContent"/>
            </xsl:apply-templates>
            
            <!-- topic/shortdesc,abstract -->
            <xsl:apply-templates select="$prmTopicContent/child::*[contains(@class, ' topic/shortdesc ')]//*[contains(@class, ' topic/indexterm ')]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId" select="false()"/>
                <xsl:with-param name="prmMakeComplementEnd" tunnel="yes" select="true()"/>
                <xsl:with-param name="prmRangeElem" tunnel="yes" select="$prmTopicContent"/>
            </xsl:apply-templates>
    
            <xsl:apply-templates select="$prmTopicContent/child::*[contains(@class, ' topic/abstract ')]//*[contains(@class, ' topic/indexterm ')]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId" select="false()"/>
                <xsl:with-param name="prmMakeComplementEnd" tunnel="yes" select="true()"/>
                <xsl:with-param name="prmRangeElem" tunnel="yes" select="$prmTopicContent"/>
            </xsl:apply-templates>
    
            <!-- topic/body -->
            <xsl:apply-templates select="$prmTopicContent/child::*[contains(@class, ' topic/body ')]//*[contains(@class, ' topic/indexterm ')]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId" select="false()"/>
                <xsl:with-param name="prmMakeComplementEnd" tunnel="yes" select="true()"/>
                <xsl:with-param name="prmRangeElem" tunnel="yes" select="$prmTopicContent"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:if test="exists($indextermRangeEnd)">
            <fo:block-container>
                <xsl:copy-of select="$indextermRangeEnd"/>    
            </fo:block-container>
        </xsl:if>
    </xsl:template>
        
    
    
    <!-- 
     function:	Get topicref from topic
     param:		prmTopicContent
     return:	topicref
     note:		
     -->
    <xsl:function name="ahf:getTopicRef" as="element()?">
        <xsl:param name="prmTopic" as="element()?"/>
    
        <xsl:choose>
            <xsl:when test="empty($prmTopic)">
                <!-- invalid parameter -->
                <xsl:sequence select="()"/>
            </xsl:when>
            <xsl:when test="not(contains($prmTopic/@class, ' topic/topic '))">
                <!-- It is not a topic! -->
                <xsl:sequence select="()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="id" select="$prmTopic/@id" as="xs:string"/>
                <xsl:variable name="topicRef" select="key('topicrefByHref', concat('#',$id), $map)[1]" as="element()?"/>
                <xsl:choose>
                    <xsl:when test="exists($topicRef)">
                        <xsl:sequence select="$topicRef"/>
                    </xsl:when>
                    <xsl:when test="$prmTopic/ancestor::*[contains(@class, ' topic/topic ')]">
                        <!-- search ancestor -->
                        <xsl:sequence select="ahf:getTopicRef($prmTopic/ancestor::*[contains(@class, ' topic/topic ')][position()=last()])"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- not found -->
                        <xsl:sequence select="()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>
