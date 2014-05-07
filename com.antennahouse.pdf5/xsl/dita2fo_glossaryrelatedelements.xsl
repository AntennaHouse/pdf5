<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Glossary related elements stylesheet
Copyright © 2009-2010 Antenna House, Inc. All rights reserved.
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
     function:	abbreviated-form template
     param:	    prmTopicRef, prmNeedId
     return:	fo:basic-link
     note:		none
     -->
    
    <xsl:template match="*[contains(@class,' abbrev-d/abbreviated-form ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="topicRefKey"  select="string(@keyref)" as="xs:string"/>
        <xsl:message>$topicRefKey=<xsl:value-of select="$topicRefKey"/></xsl:message>
        <xsl:variable name="topicRef"     select="key('topicrefByKey', $topicRefKey)[1]" as="element()?"/>
        <xsl:variable name="href"         select="substring-after($topicRef/@href,'#')"/>
        <xsl:message>$href=<xsl:value-of select="$href"/></xsl:message>
        <xsl:variable name="topicElement" select="key('topicById', $href)[1]" as="element()?"/>
        <!-- get topic's oid -->
        <xsl:variable name="topicOidAtr" select="ahf:getIdAtts($topicElement,$topicRef,true())" as="attribute()*"/>
        <xsl:variable name="topicOid" select="string($topicOidAtr[1])" as="xs:string"/>
    
        <xsl:variable name="abbreviatedFormCount" as="xs:integer">
            <xsl:number select="."
                        level="any"
                        count="*[contains(@class,' abbrev-d/abbreviated-form ')][string(@keyref)=$topicRefKey]"
                        from="*[contains(@class, ' topic/topic ')][generate-id(parent::*)=$rootId]"/>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="not(contains($topicElement/@class,' glossentry/glossentry '))">
                <fo:basic-link internal-destination="{$topicOid}">
                    <xsl:copy-of select="ahf:getAttributeSet('atsXref')"/>
                    <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                    <xsl:copy-of select="ahf:getFoProperty(.)"/>
                    <xsl:apply-templates select="$topicElement/*[contains(@class, ' topic/title ')]">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="false()"/>
                    </xsl:apply-templates>
                </fo:basic-link>
            </xsl:when>
            <xsl:when test="$abbreviatedFormCount le 1">
                <xsl:variable name="glossSurfaceFormElem"
                              select="$topicElement
                                     /*[contains(@class, ' glossentry/glossBody ')]
                                     /*[contains(@class, ' glossentry/glossSurfaceForm ')]"
                              as="element()*"/>
                <xsl:choose>
                    <xsl:when test="exists($glossSurfaceFormElem)">
                        <fo:basic-link internal-destination="{$topicOid}">
                            <xsl:copy-of select="ahf:getAttributeSet('atsXref')"/>
                            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                            <xsl:copy-of select="ahf:getFoProperty(.)"/>
                            <xsl:apply-templates select="$glossSurfaceFormElem[1]/node()">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                <xsl:with-param name="prmNeedId"   select="false()"/>
                            </xsl:apply-templates>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:basic-link internal-destination="{$topicOid}">
                            <xsl:copy-of select="ahf:getAttributeSet('atsXref')"/>
                            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                            <xsl:copy-of select="ahf:getFoProperty(.)"/>
                            <xsl:apply-templates select="$topicElement/*[contains(@class, ' glossentry/glossterm  ')]">
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                <xsl:with-param name="prmNeedId"   select="false()"/>
                            </xsl:apply-templates>
                        </fo:basic-link>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="glossAltElem" as="element()">
                    <xsl:variable name="glossAcronymElem"
                                  select="$topicElement
                                        /*[contains(@class, ' glossentry/glossBody ')]
                                        /*[contains(@class, ' glossentry/glossAlt ')]
                                          [ahf:checkGlossStatus(.)]
                                        /*[contains(@class, ' glossentry/glossAcronym ')]"
                                  as="element()*"/>
                    <xsl:variable name="glossglossAbbreviationElem"
                                  select="$topicElement
                                        /*[contains(@class, ' glossentry/glossBody ')]
                                        /*[contains(@class, ' glossentry/glossAlt ')]
                                          [ahf:checkGlossStatus(.)]
                                        /*[contains(@class, ' glossentry/glossAbbreviation ')]"
                                  as="element()*"/>
                    <xsl:choose>
                        <xsl:when test="exists($glossAcronymElem)">
                            <xsl:sequence select="$glossAcronymElem[1]"/>
                        </xsl:when>
                        <xsl:when test="exists($glossglossAbbreviationElem)">
                            <xsl:sequence select="$glossglossAbbreviationElem[1]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="$topicElement/*[contains(@class, ' glossentry/glossterm ')]"/>
                        </xsl:otherwise>
    			                </xsl:choose>
                </xsl:variable>
                <fo:basic-link internal-destination="{$topicOid}">
                    <xsl:copy-of select="ahf:getAttributeSet('atsXref')"/>
                    <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                    <xsl:copy-of select="ahf:getFoProperty(.)"/>
                    <xsl:apply-templates select="$glossAltElem/node()">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="false()"/>
                    </xsl:apply-templates>
                </fo:basic-link>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:function name="ahf:checkGlossStatus" as="xs:boolean">
        <xsl:param name="prmGlossAlt" as="element()"/>
        <xsl:choose>
            <xsl:when test="$prmGlossAlt/*[contains(@class, ' glossentry/glossStatus ')]/@value eq 'prohibited'">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when test="$prmGlossAlt/*[contains(@class, ' glossentry/glossStatus ')]/@value eq 'obsolute'">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="true()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>