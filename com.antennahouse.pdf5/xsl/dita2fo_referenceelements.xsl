<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Reference elements stylesheet
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
    <!-- NOTE: reference/reference is implemented in dita2fo_topicelements.xsl as topic/title.
               reference/refbody is implemented in dita2fo_topicelements.xsl as topic/body.
               reference/refsyn is implemented in dita2fo_topicelements.xsl as topic/section. 
     -->
    
    <!-- 
     function:	properties template
     param:	    prmTopicRef, prmNeedId
     return:	fo:table
     note:		
     -->
    <xsl:template match="*[contains(@class, ' reference/properties ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="properties" select="."/>
        <xsl:variable name="keyCol" select="ahf:getKeyCol(.)" as="xs:integer"/>
        <xsl:if test="@expanse='page' or @expanse='column'">
            <xsl:text disable-output-escaping="yes">&lt;fo:block start-indent="0mm" end-indent="0mm"&gt;</xsl:text>
        </xsl:if>
        <fo:table>
            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTable')"/>
            <xsl:copy-of select="ahf:getDisplayAtts(.,'atsPropertyTable')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:if test="@relcolwidth">
                <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableFixed')"/>
                <xsl:call-template name="processRelColWidth">
                    <xsl:with-param name="prmRelColWidth" select="string(@relcolwidth)"/>
                    <xsl:with-param name="prmTable" select="$properties"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:apply-templates select="*[contains(@class,' reference/prophead ')]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                <xsl:with-param name="prmKeyCol" select="$keyCol"/>
            </xsl:apply-templates>
            <fo:table-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableBody')"/>
                <xsl:apply-templates select="*[contains(@class,' reference/property ')]">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    <xsl:with-param name="prmKeyCol" select="$keyCol"/>
                </xsl:apply-templates>
            </fo:table-body>
        </fo:table>
        <xsl:if test="@expanse='page' or @expanse='column'">
            <xsl:text disable-output-escaping="yes">&lt;/fo:block&gt;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    <!-- 
     function:	prophead template
     param:	    prmTopicRef, prmNeedId, prmKeyCol
     return:	fo:table-header
     note:		prophead is optional.
                proptypehd, propvaluehd, propvaluehd are all optional.
                This stylesheet apply bold for prophead if properties/@keycol is not defined.
     -->
    <xsl:template match="*[contains(@class, ' reference/prophead ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
        
        <fo:table-header>
            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableHeader')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <fo:table-row>
                <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableRow')"/>
                <!-- proptypehd -->
                <fo:table-cell>
                    <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableHeaderCell')"/>
                    <xsl:choose>
                        <xsl:when test="$prmKeyCol = 1">
                            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableKeyCol')"/>
                        </xsl:when>
                        <xsl:when test="$prmKeyCol != 0">
                            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableNoKeyCol')"/>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates select="*[contains(@class, ' reference/proptypehd ')]">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:apply-templates>
                </fo:table-cell>
                <!-- propvaluehd -->
                <fo:table-cell>
                    <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableHeaderCell')"/>
                    <xsl:choose>
                        <xsl:when test="$prmKeyCol = 2">
                            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableKeyCol')"/>
                        </xsl:when>
                        <xsl:when test="$prmKeyCol != 0">
                            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableNoKeyCol')"/>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates select="*[contains(@class, ' reference/propvaluehd ')]">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:apply-templates>
                </fo:table-cell>
                <!-- propvaluehd -->
                <fo:table-cell>
                    <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableHeaderCell')"/>
                    <xsl:choose>
                        <xsl:when test="$prmKeyCol = 3">
                            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableKeyCol')"/>
                        </xsl:when>
                        <xsl:when test="$prmKeyCol != 0">
                            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableNoKeyCol')"/>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:apply-templates select="*[contains(@class, ' reference/propdeschd ')]">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:apply-templates>
                </fo:table-cell>
            </fo:table-row>
        </fo:table-header>
    </xsl:template>
    
    <!-- 
     function:	proptypehd template
     param:	    prmTopicRef, prmNeedId
     return:	proptypehd contents (fo:block)
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' reference/proptypehd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	propvaluehd template
     param:	    prmTopicRef, prmNeedId
     return:	propvaluehd contents (fo:block)
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' reference/propvaluehd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	propdeschd template
     param:	    prmTopicRef, prmNeedId
     return:	propdeschd contents (fo:block)
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' reference/propdeschd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	property template
     param:	    prmTopicRef, prmNeedId, prmKeyCol
     return:	fo:table-row
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' reference/property ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
        
        <fo:table-row>
            <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableRow')"/>
            <!-- proptype -->
            <fo:table-cell>
                <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableBodyCell')"/>
                <xsl:choose>
                    <xsl:when test="$prmKeyCol = 1">
                        <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableKeyCol')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableNoKeyCol')"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="*[contains(@class, ' reference/proptype ')]">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:table-cell>
            <!-- propvalue -->
            <fo:table-cell>
                <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableBodyCell')"/>
                <xsl:choose>
                    <xsl:when test="$prmKeyCol = 2">
                        <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableKeyCol')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableNoKeyCol')"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="*[contains(@class, ' reference/propvalue ')]">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:table-cell>
            <!-- propdesc -->
            <fo:table-cell>
                <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableBodyCell')"/>
                <xsl:choose>
                    <xsl:when test="$prmKeyCol = 3">
                        <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableKeyCol')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="ahf:getAttributeSet('atsPropertyTableNoKeyCol')"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="*[contains(@class, ' reference/propdesc ')]">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
    <!-- 
     function:	proptype template
     param:	    prmTopicRef, prmNeedId
     return:	proptype contents (fo:block)
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' reference/proptype ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	propvalue template
     param:	    prmTopicRef, prmNeedId
     return:	propvalue contents (fo:block)
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' reference/propvalue ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	propdesc template
     param:	    prmTopicRef, prmNeedId
     return:	propdesc contents (fo:block)
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' reference/propdesc ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>


</xsl:stylesheet>