<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet
Module: Related-links template
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
 xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
 xmlns:ahf="http://www.antennahouse.com/names/XSLT/Functions/Document"
 exclude-result-prefixes="xs ahf"
>

    <!-- 
     function:	related-links control
     param:		none
     return:	related-links fo objects
     note:		As noted in DITA specification, this stylesheet adopts links that have @role='friend'.
     -->
    <xsl:template match="*[contains(@class, ' topic/related-links ')]">
        <xsl:variable name="linkCount" select="count(descendant::*[contains(@class,' topic/link ')][(@role='friend') or (@role='sibling') or (not(@role))])" as="xs:integer"/>
        <xsl:if test="$linkCount &gt; 0">
            <xsl:call-template name="makeRelatedLink">
                <xsl:with-param name="prmRelatedLinks" select="."/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    
    <!-- 
     function:	Make related-links block
     param:		prmRelatedLinks
     return:	related-links fo objects
     note:		
     -->
    <xsl:template name="makeRelatedLink">
        <xsl:param name="prmRelatedLinks" required="yes" as="element()"/>
        
        <!-- Make related-link title block -->
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsRelatedLinkTitleBeforeBlock')"/>
            <fo:leader>
                <xsl:copy-of select="ahf:getAttributeSet('atsRelatedLinkLeader1')"/>
            </fo:leader>
            <fo:inline>
                <xsl:copy-of select="ahf:getAttributeSet('atsRelatedLinkInline')"/>
                <xsl:value-of select="ahf:getVarValue('Relatedlink_Title')"/>
            </fo:inline>
            <fo:leader>
                <xsl:copy-of select="ahf:getAttributeSet('atsRelatedLinkLeader2')"/>
            </fo:leader>
        </fo:block>
        
        <!-- process link -->
        <xsl:call-template name="processLink">
                <xsl:with-param name="prmRelatedLinks" select="$prmRelatedLinks"/>
        </xsl:call-template>
        
        <!-- Make related-link end block -->
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsRelatedLinkTitleAfterBlock')"/>
            <fo:leader>
                <xsl:copy-of select="ahf:getAttributeSet('atsRelatedLinkLeader3')"/>
            </fo:leader>
        </fo:block>
    </xsl:template>
    
    
    <!-- 
     function:	Process link
     param:		prmRelatedLinks
     return:	reference line contentes
     note:		none
     -->
    <xsl:template name="processLink">
        <xsl:param name="prmRelatedLinks" required="yes" as="element()"/>
        
        <xsl:for-each select="$prmRelatedLinks/descendant::*[contains(@class,' topic/link ')]
                                                            [(@role='friend') or (@role='sibling') or (not(@role))]">
            <xsl:variable name="link" select="." as="element()"/>
            <xsl:variable name="href" select="string($link/@href)" as="xs:string"/>
            <xsl:variable name="ohref" select="string($link/@ohref)" as="xs:string"/>
            <xsl:variable name="xtrf"  select="string($link/@xtrf)" as="xs:string"/>
            <xsl:variable name="linktext" as="node()*">
                <xsl:apply-templates select="$link/linktext" mode="GET_CONTENTS"/>
            </xsl:variable>
            <fo:block>
                <xsl:copy-of select="ahf:getAttributeSet('atsRelatedLinkBlock')"/>
                <fo:inline>
                    <xsl:choose>
                        <xsl:when test="starts-with($href,'#')">
                            <xsl:variable name="id" select="substring-after($href, '#')" as="xs:string"/>
                            <xsl:variable name="topicContent" select="key('topicById', $id, $root)[1]" as="element()?"/>
                            <xsl:variable name="topicRef" select="ahf:getTopicRef($topicContent)" as="element()?"/>
                            <xsl:choose>
                                <xsl:when test="empty($topicContent)">
                                    <xsl:call-template name="warningContinue">
                                        <xsl:with-param name="prmMes"
                                                        select="ahf:replace($stMes062,('%file','%href'),($xtrf,$ohref))"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:when test="empty($topicRef)">
                                    <xsl:call-template name="warningContinue">
                                        <xsl:with-param name="prmMes"
                                                        select="ahf:replace($stMes063,('%file','%href'),($xtrf,$ohref))"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:call-template name="editLinkInside">
                                        <xsl:with-param name="prmTopicRef"     select="$topicRef"/>
                                        <xsl:with-param name="prmTopicContent" select="$topicContent"/>
                                    </xsl:call-template>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="editLinkOutside">
                                <xsl:with-param name="prmHref" select="$href"/>
                                <xsl:with-param name="prmLinktext" select="$linktext"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:inline>
            </fo:block>
        </xsl:for-each>
    </xsl:template>
    
    <!-- 
     function:	Linktext template
     param:	    prmTopicRef, prmNeedId
     return:	linktext contents
     note:		
     -->
    <xsl:template match="*[contains(@class, ' map/linktext ')] | *[contains(@class, ' topic/linktext ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsLinkText')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    
    <!-- 
     function:	Edit reference line for inside link
     param:		prmTopicRef, prmTopicContent
     return:	reference line contentes
     note:		
     -->
    <xsl:template name="editLinkInside">
        <xsl:param name="prmTopicRef" required="yes" as="element()"/>
        <xsl:param name="prmTopicContent" required="yes" as="element()"/>
        
        <!--xsl:variable name="id" select="substring-after($prmTopicRef/@href, '#')" as="xs:string"/>
        <xsl:variable name="topicContents" select="key('topicById', $id, $root)[1]" as="element()"/-->
        <xsl:variable name="topicIdAtr" select="ahf:getIdAtts($prmTopicContent,$prmTopicRef,true())" as="attribute()*"/>
        <xsl:variable name="topicId" select="string($topicIdAtr[1])" as="xs:string"/>
        <xsl:variable name="titleMode" select="ahf:getTitleMode($prmTopicRef,$prmTopicContent)" as="xs:integer"/>
        
        <xsl:variable name="title" as="node()*">
            <xsl:apply-templates select="$prmTopicContent/child::*[contains(@class, ' topic/title ')]" mode="GET_CONTENTS"/>
        </xsl:variable>
    
        <xsl:variable name="titlePrefix" as="xs:string">
            <xsl:choose>
                <xsl:when test="$titleMode=$cSquareBulletTitleMode">
                    <xsl:value-of select="ahf:getVarValue('Level4_Label_Char')"/>
                </xsl:when>
                <xsl:when test="$titleMode=$cRoundBulletTitleMode">
                    <xsl:value-of select="ahf:getVarValue('Level5_Label_Char')"/>
                </xsl:when>
                <xsl:when test="$pAddNumberingTitlePrefix">
                    <xsl:call-template name="genTitlePrefix">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- Generate FO for link line -->
        <xsl:choose>
            <xsl:when test="($titleMode=$cSquareBulletTitleMode) or ($titleMode=$cRoundBulletTitleMode)">
                <!-- Link line for square/round bullet item -->
                <fo:basic-link internal-destination="{$topicId}">
                    <fo:inline font-family="{$cBulletFont}">
                        <xsl:value-of select="$titlePrefix"/>
                    </fo:inline>
                    <xsl:text>&#x2002;</xsl:text>
                    <xsl:copy-of select="$title"/>
                    <xsl:value-of select="$cRelatedlinkPrefix"/>
                    <fo:page-number-citation ref-id="{$topicId}"/>
                    <xsl:value-of select="$cRelatedlinkSuffix"/>
                </fo:basic-link>
            </xsl:when>
            <xsl:otherwise>
                <!-- Link line for normal numbered item -->
                <fo:basic-link internal-destination="{$topicId}">
                    <xsl:value-of select="$titlePrefix"/>
                    <xsl:if test="string($titlePrefix)">
                        <xsl:text>&#x2002;</xsl:text>
                    </xsl:if>
                    <xsl:copy-of select="$title"/>
                    <xsl:value-of select="$cRelatedlinkPrefix"/>
                    <fo:page-number-citation ref-id="{$topicId}"/>
                    <xsl:value-of select="$cRelatedlinkSuffix"/>
                </fo:basic-link>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- 
     function:	Edit link line for outside link
     param:		prmHref, prmLinktext
     return:	reference line contentes
     note:		ADD: Link to PDF named destination
                2010/12/15 t.makita
     -->
    <xsl:template name="editLinkOutside">
        <xsl:param name="prmHref"     required="yes" as="xs:string"/>
        <xsl:param name="prmLinktext" required="yes" as="node()*"/>
        
        <xsl:variable name="href" select="lower-case(normalize-space($prmHref))" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="$href=$cDeadLinkPDF">
                <!-- Evidence of dead link -->
                <xsl:attribute name="color">
                    <xsl:value-of select="$cDeadLinkColor"/>
                </xsl:attribute>
                <xsl:copy-of select="$prmLinktext"/>
            </xsl:when>
            <xsl:when test="contains(lower-case($href),'.pdf#')">
                <!-- Link to PDF named destination -->
                <xsl:variable name="tempHref" as="xs:string" select="replace($prmHref,'#','#nameddest=')"/>
                <fo:basic-link external-destination="{$tempHref}" axf:action-type="gotor">
                    <xsl:value-of select="$prmLinktext"/>
                </fo:basic-link>
            </xsl:when>
            <xsl:otherwise>
                <fo:basic-link external-destination="{$prmHref}">
                    <xsl:copy-of select="$prmLinktext"/>
                </fo:basic-link>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
