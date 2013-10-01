<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Topic elements stylesheet
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

    <!-- topic is implemented in dita2fo_chapter.xsl -->
    <!-- title is implemented in dita2fo_title.xsl -->
    <!-- relatedlink is implemented in dita2fo_relatedlinks.xsl -->
        
    <!-- 
     function:	titlealts template
     param:	    prmTopicRef, prmNeedId
     return:	none
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' topic/titlealts ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    </xsl:template>
    <!-- 
     function:	navtitle template
     param:	    prmTopicRef, prmNeedId
     return:	none
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    </xsl:template>
    
    <!-- 
     function:	searchtitle template
     param:	    prmTopicRef, prmNeedId
     return:	none
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' topic/searchtitle ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    </xsl:template>
    
    <!-- 
     function:	abstract template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block or descendant generated fo objects
     note:		xsl:strip-space is applied for this element.
                Make fo:block unconditionally. (2011-09-07 t.makita)
     -->
    <xsl:template match="*[contains(@class, ' topic/abstract ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsAbstract')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	shortdesc template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block or descendant generated fo objects
     note:		Abstract can contain shortdesc as inline or block level objects.
     -->
    <xsl:template match="*[contains(@class, ' topic/shortdesc ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <xsl:choose>
            <xsl:when test="parent::*[contains(@class, ' topic/abstract ')]">
                <!-- Child of abstract -->
                <fo:wrapper>
                    <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                    <xsl:apply-templates>
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:apply-templates>
                </fo:wrapper>
            </xsl:when>
            <xsl:otherwise>
                <!-- Independent shortdesc -->
                <fo:block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsShortdesc')"/>
                    <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                    <xsl:apply-templates>
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:apply-templates>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	body template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		
     -->
    <xsl:template match="*[contains(@class, ' topic/body ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <xsl:variable name="body" select="."/>
        <fo:wrapper>
            <xsl:copy-of select="ahf:getAttributeSet('atsBody')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
            <!-- Make fo:index-range-end FO object that has @start 
                 but has no corresponding @end indexterm in body.
             -->
            <xsl:apply-templates select="$body//*[contains(@class, ' topic/indexterm ')]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId" select="false()"/>
                <xsl:with-param name="prmMakeComplementEnd" tunnel="yes" select="true()"/>
                <xsl:with-param name="prmRangeElem" tunnel="yes" select="$body"/>
            </xsl:apply-templates>
        </fo:wrapper>
    </xsl:template>
    
    <!-- 
        function:	bodydiv template
        param:	    prmTopicRef, prmNeedId
        return:	    fo:wrapper
        note:       Bodydiv needs no special formattings. (2011-10-25 t.makita)		
    -->
    <xsl:template match="*[contains(@class, ' topic/bodydiv ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <fo:wrapper>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:wrapper>
    </xsl:template>
    
    <!-- 
     function:	Example template
     param:	    prmTopicRef, prmNeedId
     return:	Example contents
     note:		Example has same content model with section
     -->
    <xsl:template match="*[contains(@class, ' topic/example ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsExample')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
        function:	dita template
        param:	    
        return:	    
        note:		"dita" is only a container element.
                    This element will not appear in the merged middle file.
                    2011-10-25 t.makita
    -->

</xsl:stylesheet>