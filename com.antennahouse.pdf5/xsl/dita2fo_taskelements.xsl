<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Task elements stylesheet
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
 exclude-result-prefixes="ahf"
>
    <!-- NOTE: task/title is coded in dita2fo_title.xsl -->
    <!-- NOTE: task/titlealts is implemented in dita2fo_topic.xsl as topic/titlealts -->
    <!-- NOTE: task/shortdesc is implemented in dita2fo_topic.xsl as topic/shortdesc -->
    <!-- NOTE: task/abstract is implemented in dita2fo_topic.xsl as topic/abstract -->
    <!-- NOTE: task/prolog is implemented in dita2fo_topic.xsl as topic/prolog -->
    <!-- NOTE: task/taskbody is implemented in dita2fo_topic.xsl as topic/body -->
    <!-- NOTE: task/prereq is implemented in dita2fo_topic.xsl as topic/section -->
    <!-- NOTE: task/context is implemented in dita2fo_topic.xsl as topic/section -->
    <!-- NOTE: task/steps is implemented in dita2fo_bodyelemets.xsl as topic/ol -->
    <!-- NOTE: task/steps-informal is implemented in dita2fo_bodyelemets.xsl as topic/section -->
    <!-- NOTE: task/steps-unordered is implemented in dita2fo_bodyelemets.xsl as topic/ul -->
    <!-- NOTE: task/step is implemented in dita2fo_bodyelemets.xsl as topic/li -->
    <!-- NOTE: task/substeps is implemented in dita2fo_bodyelemets.xsl as topic/ol -->
    <!-- NOTE: task/substep is implemented in dita2fo_bodyelemets.xsl as topic/li -->
    <!-- NOTE: task/choices is implemented in dita2fo_bodyelemets.xsl as topic/ul -->
    <!-- NOTE: task/choice is implemented in dita2fo_bodyelemets.xsl as topic/li -->
    
    
    <!-- 
     function:	stepsection template
     param:	    prmTopicRef, prmNeedId
     return:	fo:list-item
     note:		Stepsection appears in the steps/step-unordered. 
                However it must be formatted like section. No list number
                or bullet are needed. (2011-10-24 t.makita)
     -->
    <xsl:template match="*[contains(@class, ' task/stepsection ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:list-item>
            <!-- Set list-item attribute. -->
            <xsl:copy-of select="ahf:getAttributeSet('atsStepSection')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <!-- Discard first space-before -->
            <xsl:if test="not(preceding-sibling::*[contains(@class,' topic/li ')])">
                <xsl:attribute name="{$liSpacingAttr}" select="'0mm'"/>
            </xsl:if>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <fo:list-item-label> 
                <fo:block/>
            </fo:list-item-label>
            <fo:list-item-body start-indent="inherited-property-value(start-indent)">
                <fo:block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsP')"/>
                    <xsl:apply-templates>
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:apply-templates>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    
    <!-- 
     function:	cmd template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' task/cmd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsCmd')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	info template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' task/info ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsInfo')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	stepxmp template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' task/stepxmp ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsStepxmp')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	choicetable template
     param:	    prmTopicRef, prmNeedId
     return:	fo:table
     note:		@keycol default value is defined 1 in DTD.
     -->
    <xsl:template match="*[contains(@class, ' task/choicetable ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="choiceTable" select="."/>
        <xsl:variable name="keyCol" select="ahf:getKeyCol(.)" as="xs:integer"/>
        <xsl:if test="@expanse='page' or @expanse='column'">
            <xsl:text disable-output-escaping="yes">&lt;fo:block start-indent="0mm" end-indent="0mm"&gt;</xsl:text>
        </xsl:if>
        <fo:table-and-caption>
            <xsl:copy-of select="ahf:getFoProperty(.)[name() eq 'text-align']"/>
            <fo:table>
                <xsl:copy-of select="ahf:getAttributeSet('atsChoiceTable')"/>
                <xsl:copy-of select="ahf:getDisplayAtts(.,'atsChoiceTable')"/>
                <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                <xsl:copy-of select="ahf:getFoProperty(.)[name() ne 'text-align']"/>
                <xsl:if test="@relcolwidth">
                    <xsl:copy-of select="ahf:getAttributeSet('atsChoiceTableFixed')"/>
                    <xsl:call-template name="processRelColWidth">
                        <xsl:with-param name="prmRelColWidth" select="string(@relcolwidth)"/>
                        <xsl:with-param name="prmTable" select="$choiceTable"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="*[contains(@class, ' task/chhead ')]">
                        <xsl:apply-templates select="*[contains(@class, ' task/chhead ')]">
                            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                            <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                            <xsl:with-param name="prmKeyCol"   select="$keyCol"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:table-header>
                            <xsl:copy-of select="ahf:getAttributeSet('atsChhead')"/>
                            <fo:table-row>
                                <xsl:copy-of select="ahf:getAttributeSet('atsChheadRow')"/>
                                <fo:table-cell>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsChoptionhd')"/>
                                    <xsl:choose>
                                        <xsl:when test="$keyCol = 1">
                                            <xsl:copy-of select="ahf:getAttributeSet('atsChKeyCol')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:copy-of select="ahf:getAttributeSet('atsChNoKeyCol')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <fo:block>
                                        <xsl:value-of select="$cChoptionhd"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <xsl:copy-of select="ahf:getAttributeSet('atsChdeschd')"/>
                                    <xsl:choose>
                                        <xsl:when test="$keyCol = 2">
                                            <xsl:copy-of select="ahf:getAttributeSet('atsChKeyCol')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:copy-of select="ahf:getAttributeSet('atsChNoKeyCol')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <fo:block>
                                        <xsl:value-of select="$cChdeschd"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                    </xsl:otherwise>
                </xsl:choose>
                
                <fo:table-body>
                    <xsl:copy-of select="ahf:getAttributeSet('atsChbody')"/>
                    <xsl:apply-templates select="*[contains(@class, ' task/chrow ')]">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                        <xsl:with-param name="prmKeyCol"   select="$keyCol"/>
                    </xsl:apply-templates>
                </fo:table-body>
                
            </fo:table>
        </fo:table-and-caption>
        <xsl:if test="@expanse='page' or @expanse='column'">
            <xsl:text disable-output-escaping="yes">&lt;/fo:block&gt;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/chhead ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
    
        <fo:table-header>
            <xsl:copy-of select="ahf:getAttributeSet('atsChhead')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <fo:table-row>
                <xsl:copy-of select="ahf:getAttributeSet('atsChheadRow')"/>
                <xsl:apply-templates>
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    <xsl:with-param name="prmKeyCol"   select="$prmKeyCol"/>
                </xsl:apply-templates>
            </fo:table-row>
        </fo:table-header>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/chhead ')]/*[contains(@class, ' task/choptionhd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
    
        <fo:table-cell>
            <xsl:copy-of select="ahf:getAttributeSet('atsChoptionhd')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:choose>
                <xsl:when test="$prmKeyCol = 1">
                    <xsl:copy-of select="ahf:getAttributeSet('atsChKeyCol')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="ahf:getAttributeSet('atsChNoKeyCol')"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <fo:block>
                <xsl:apply-templates>
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/chhead ')]/*[contains(@class, ' task/chdeschd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
    
        <fo:table-cell>
            <xsl:copy-of select="ahf:getAttributeSet('atsChdeschd')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:choose>
                <xsl:when test="$prmKeyCol = 2">
                    <xsl:copy-of select="ahf:getAttributeSet('atsChKeyCol')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="ahf:getAttributeSet('atsChNoKeyCol')"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <fo:block>
                <xsl:apply-templates>
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/chrow ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
    
        <fo:table-row>
            <xsl:copy-of select="ahf:getAttributeSet('atsChrow')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                <xsl:with-param name="prmKeyCol"   select="$prmKeyCol"/>
            </xsl:apply-templates>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/chrow ')]/*[contains(@class, ' task/choption ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
    
        <fo:table-cell>
            <xsl:copy-of select="ahf:getAttributeSet('atsChoption')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:choose>
                <xsl:when test="$prmKeyCol = 1">
                    <xsl:copy-of select="ahf:getAttributeSet('atsChKeyCol')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="ahf:getAttributeSet('atsChNoKeyCol')"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <fo:block>
                <xsl:apply-templates>
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/chrow ')]/*[contains(@class, ' task/chdesc ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmKeyCol"   required="yes"  as="xs:integer"/>
    
        <fo:table-cell>
            <xsl:copy-of select="ahf:getAttributeSet('atsChdesc')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:choose>
                <xsl:when test="$prmKeyCol = 2">
                    <xsl:copy-of select="ahf:getAttributeSet('atsChKeyCol')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="ahf:getAttributeSet('atsChNoKeyCol')"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <fo:block>
                <xsl:apply-templates>
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:apply-templates>
            </fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <!-- 
     function:	stepresult template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' task/stepresult ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsStepresult')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	tutorialinfo template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' task/tutorialinfo ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsTutorialinfo')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    
    <!-- 
     function:	result template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' task/result ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsResult')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	postreq template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class, ' task/postreq ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsPostreq')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>


</xsl:stylesheet>