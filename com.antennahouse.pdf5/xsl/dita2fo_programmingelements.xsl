<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Programming elements stylesheet
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
     function:	apiname template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/apiname ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsApiName')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	codeblock template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		
     -->
    <xsl:template match="*[contains(@class, ' pr-d/codeblock ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsCodeBlock')"/>
            <xsl:copy-of select="ahf:getDisplayAtts(.,'atsCodeBlock')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	codeph template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/codeph ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsCodePh')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	option template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/option ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsOption')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	paramname template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/parmname ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsParamName')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	parml template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/parml ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="doCompact" select="boolean(@compact='yes')" as="xs:boolean"/>
        <fo:wrapper>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                <xsl:with-param name="prmDoCompact"  select="$doCompact"/>
            </xsl:apply-templates>
        </fo:wrapper>
    </xsl:template>
    
    <!-- 
     function:	plentry template
     param:	    prmTopicRef, prmNeedId, prmDoCompact
     return:	fo:block
     note:		none
     -->
    <xsl:variable name="plCompactRatio" select="xs:double(ahf:getVarValue('Pl_Compact_Ratio'))" as="xs:double"/>
    <xsl:variable name="plCompactAttrName"  select="ahf:getVarValue('Pl_Compact_Attr')" as="xs:string"/>
    
    <xsl:template match="*[contains(@class,' pr-d/plentry ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        <xsl:param name="prmDoCompact"   select="false()" as="xs:boolean"/>
        
        <xsl:variable name="compactAttrVal" select="ahf:getAttributeValue('atsPlEntry',$plCompactAttrName)"/>
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsPlEntry')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <!-- apply compact spacing -->
            <xsl:if test="string($compactAttrVal) and $prmDoCompact">
                <xsl:attribute name="{$plCompactAttrName}" 
                               select="ahf:getPropertyRatio($compactAttrVal,$plCompactRatio)"/>
            </xsl:if>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	pt template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/pt ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsPt')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	pd template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/pd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsPd')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	synph template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/synph ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template>
    
    <!--
        syntaxdiagram variables
      -->
    <xsl:variable name="sdOr" select="ahf:getVarValue('Sd_Or')"/>
    <xsl:variable name="sdChoicePrefix" select="ahf:getVarValue('Sd_Choice_Prefix')"/>
    <xsl:variable name="sdChoiceSuffix" select="ahf:getVarValue('Sd_Choice_Suffix')"/>
    <xsl:variable name="sdOptionalPrefix" select="ahf:getVarValue('Sd_Optional_Prefix')"/>
    <xsl:variable name="sdOptionalSuffix" select="ahf:getVarValue('Sd_Optional_Suffix')"/>
    <xsl:variable name="sdFragmentRefPrefix" select="ahf:getVarValue('Sd_Fragment_Ref_Prefix')"/>
    <xsl:variable name="sdFragmentRefSuffix" select="ahf:getVarValue('Sd_Fragment_Ref_Suffix')"/>
    <xsl:variable name="sdNotePrefix" select="ahf:getVarValue('Sd_Note_Prefix')"/>
    <xsl:variable name="sdRepeatPrefix" select="ahf:getVarValue('Sd_Repeat_Prefix')"/>
    <xsl:variable name="sdRepeatSuffix" select="ahf:getVarValue('Sd_Repeat_Suffix')"/>
    <xsl:variable name="sdRequiredSymbol" select="ahf:getVarValue('Sd_Required_Symbol')"/>
    <xsl:variable name="sdOptionalSymbol" select="ahf:getVarValue('Sd_Optional_Symbol')"/>
    
    <!-- 
     function:	syntaxdiagram template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		Syntaxdiagram belongs figure.
     -->
    <xsl:template match="*[contains(@class,' pr-d/syntaxdiagram ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsSyntaxDiagram')"/>
            <xsl:copy-of select="ahf:getDisplayAtts(.,'atsSyntaxDiagram')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:if test="not(@id) and $prmNeedId">
                <xsl:attribute name="id" select="ahf:generateId(.,$prmTopicRef)"/>
            </xsl:if>
            <xsl:apply-templates select="*[not(contains(@class,' topic/title '))]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
            <xsl:if test="descendant::*[contains(@class,' pr-d/synnote ')]">
                <xsl:call-template name="outputSynNote">
                    <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                    <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                </xsl:call-template>
            </xsl:if>
        </fo:block>
        <!-- process title last -->
        <xsl:apply-templates select="*[contains(@class,' topic/title ')]">
            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- 
     function:	Output synnote
     param:	    prmTopicRef, prmNeedId
     return:	fo:list-block
     note:		current is syntaxdiagram.
     -->
    <xsl:template name="outputSynNote">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:list-block>
            <xsl:copy-of select="ahf:getAttributeSet('atsSynNoteListBlock')"/>
            <xsl:for-each select="descendant::*[contains(@class, ' pr-d/synnote ')]">
                <xsl:variable name="synnote" select="."/>
                <fo:list-item>
                    <xsl:copy-of select="ahf:getAttributeSet('atsSynNoteLi')"/>
                    <xsl:if test="position()=1">
                        <xsl:attribute name="space-before" select="'0mm'"/>
                    </xsl:if>
                    <fo:list-item-label end-indent="label-end()"> 
                        <fo:block>
                            <xsl:copy-of select="ahf:getAttributeSet('atsSynNoteLabel')"/>
                            <xsl:choose>
                                <xsl:when test="string(normalize-space($synnote/@callout))">
                                    <xsl:value-of select="normalize-space($synnote/@callout)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$sdNotePrefix"/>
                                    <xsl:number select="."
                                                level="any" 
                                                count="*[contains(@class, ' pr-d/synnote ')][not(@callout)]"
                                                from="*[contains(@class,' pr-d/syntaxdiagram')]"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:copy-of select="ahf:getAttributeSet('atsSynNoteBody')"/>
                            <xsl:copy-of select="ahf:getUnivAtts($synnote,$prmTopicRef,true())"/>
                            <xsl:if test="not($synnote/@id)">
                                <xsl:attribute name="id" select="ahf:generateId($synnote,$prmTopicRef)"/>
                            </xsl:if>
                            <xsl:apply-templates>
                                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                                <xsl:with-param name="prmNeedId"   select="true()"/>
                            </xsl:apply-templates>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>
    
    <!-- syntaxdiagram/title is implementaed as fig/title in dita2fo_bodyelements.xsl -->
    
    <!-- 
     function:	groupseq/groupcomp/groupchoice template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/groupseq ')]
                      |  *[contains(@class,' pr-d/groupcomp ')]
                      |  *[contains(@class,' pr-d/groupchoice ')]"
                  priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <xsl:choose>
            <xsl:when test="parent::*[contains(@class, ' pr-d/syntaxdiagram ')]
                         or parent::*[contains(@class, ' pr-d/fragment ')]">
                <fo:block>
                    <xsl:copy-of select="ahf:getAttributeSet('atsGroup')"/>
                    <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                    <xsl:call-template name="processGroup">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:call-template>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:wrapper>
                    <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                    <xsl:call-template name="processGroup">
                        <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                        <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
                    </xsl:call-template>
                </fo:wrapper>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="processGroup">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="isGroupChoice" select="boolean(contains(@class,' pr-d/groupchoice '))"/>
        <xsl:variable name="isOptional"    select="boolean(@importance='optional')"/>
        <xsl:variable name="hasRepSep"     select="boolean(child::*[contains(@class,' pr-d/repsep ')])"/>
        <xsl:variable name="isRequiredRepsep" 
                      select="if ($hasRepSep) then boolean(child::*[contains(@class,' pr-d/repsep ')]/@importance='required') else false()"/>
        <xsl:variable name="needOr"        select="ahf:sdNeedOr(.)"/>
        
        <xsl:apply-templates select="*[contains(@class,' topic/title ')]">
            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
        </xsl:apply-templates>
        
        <xsl:if test="$needOr">
            <xsl:value-of select="$sdOr"/><!-- | -->
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalPrefix"/><!-- [ -->
        </xsl:if>
        <xsl:if test="$isGroupChoice">
            <xsl:value-of select="$sdChoicePrefix"/><!-- { -->
        </xsl:if>
        <xsl:apply-templates select="child::*[not(contains(@class,' pr-d/repsep '))][not(contains(@class,' topic/title '))]">
            <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
            <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
        </xsl:apply-templates>
        <xsl:if test="$isGroupChoice">
            <xsl:value-of select="$sdChoiceSuffix"/><!-- } -->
        </xsl:if>
        <xsl:if test="$hasRepSep">
            <xsl:value-of select="$sdRepeatPrefix"/><!-- ( -->
            <xsl:apply-templates select="*[contains(@class,' pr-d/repsep ')]"><!-- , (etc) -->
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
            <xsl:if test="$isGroupChoice">
                <xsl:value-of select="$sdChoicePrefix"/><!-- { -->
            </xsl:if>
            <xsl:apply-templates select="child::*[not(contains(@class,' pr-d/repsep '))][not(contains(@class,' topic/title '))]">
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="false()"/>
            </xsl:apply-templates>
            <xsl:if test="$isGroupChoice">
                <xsl:value-of select="$sdChoiceSuffix"/><!-- } -->
            </xsl:if>
            <xsl:value-of select="$sdRepeatSuffix"/><!-- ) -->
            <xsl:choose>
                <xsl:when test="$isRequiredRepsep">
                    <xsl:value-of select="$sdRequiredSymbol"/><!-- + -->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$sdOptionalSymbol"/><!-- * -->
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalSuffix"/><!-- ] -->
        </xsl:if>
    </xsl:template>
    
    <xsl:function name="ahf:sdNeedOr" as="xs:boolean">
        <xsl:param name="prmElement" as="element()"/>
        <xsl:sequence select="$prmElement/parent::*[contains(@class,' pr-d/groupchoice ')] 
                 and  (count($prmElement/preceding-sibling::*[not(contains(@class, ' pr-d/repsep '))]
                                                             [not(contains(@class, ' topic/title '))]) &gt; 0)"/>
    </xsl:function>
    
    
    <!-- 
     function:	fragment template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/fragment ')]" priority="2">
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
    
    
    <!-- fragment/title is implemented as figgroup/title in dita2fo_bodyelements.xsl -->
    <!-- 
     function:	fragment title template for copy contents
     param:	    prmTopicRef
     return:	fo:inline
     note:		The id should not be generated.
     -->
    <!--xsl:template match="*[contains(@class,' pr-d/fragment ')]/*[contains(@class,' topic/title ')]"  mode="GET_TITLE_CONTENT">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <fo:inline>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
    </xsl:template-->
    
    <!-- 
     function:	fragref template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/fragref ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="isOptional"    select="boolean(@importance='optional')"/>
        <xsl:variable name="orgTitle">
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="hasTitle" select="normalize-space($orgTitle)"/>
        <xsl:variable name="fragrefTitle">
            <xsl:choose>
                <xsl:when test="$hasTitle">
                    <xsl:copy-of select="$orgTitle"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="fragmentId" select="substring-after(@href,'/')"/>
                    <xsl:variable name="fragmentElement" select="if (string($fragmentId)) then key('elementById',$fragmentId,ancestor::*[contains(@class, ' pr-d/syntaxdiagram ')])[1] else ()" as="element()?"/>
                    <xsl:variable name="fragmentTitle">
                        <xsl:apply-templates select="$fragmentElement/*[contains(@class, ' topic/title ')]" mode="GET_CONTENTS"/>
                    </xsl:variable>
                    <xsl:copy-of select="$fragmentTitle"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="needOr" select="ahf:sdNeedOr(.)"/>
        
        <xsl:if test="$needOr">
            <xsl:value-of select="$sdOr"/>
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalPrefix"/>
        </xsl:if>
        <fo:inline>
            <xsl:copy-of select="ahf:getLocalizationAtts(.)"/>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:value-of select="$sdFragmentRefPrefix"/>
            <xsl:copy-of select="$fragrefTitle"/>
            <xsl:value-of select="$sdFragmentRefSuffix"/>
        </fo:inline>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalSuffix"/>
        </xsl:if>
    </xsl:template>
    
    <!-- 
     function:	synblk template
     param:	    prmTopicRef, prmNeedId
     return:	fo:wrapper
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/synblk ')]" priority="2">
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
     function:	synnote template
     param:	    prmTopicRef, prmNeedId
     return:	fo:basic-link
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/synnote ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="syntaxDiagramElement" select="ancestor::*[contains(@class,' pr-d/syntaxdiagram ')][1]"/>
        <xsl:choose>
            <xsl:when test="@id">
                <!-- referenced by synnoteref -->
            </xsl:when>
            <xsl:otherwise>
                <!-- stand alone synnote -->
                <xsl:variable name="id" select="ahf:generateId(.,$prmTopicRef)"/>
                <fo:basic-link internal-destination="{$id}">
                    <xsl:copy-of select="ahf:getAttributeSet('atsSynNote')"/>
                    <xsl:choose>
                        <xsl:when test="string(normalize-space(@callout))">
                            <xsl:value-of select="normalize-space(@callout)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$sdNotePrefix"/>
                            <xsl:number select="."
                                        level="any" 
                                        count="*[contains(@class, ' pr-d/synnote ')][not(@callout)]"
                                        from="*[contains(@class,' pr-d/syntaxdiagram')]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:basic-link>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	synnoteref template
     param:	    prmTopicRef, prmNeedId
     return:	fo:basic-link
     note:		referenced synnote must exist in the same sytaxdiagram.
     -->
    <xsl:template match="*[contains(@class,' pr-d/synnoteref ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
        
        <xsl:variable name="href" select="@href"/>
        <xsl:variable name="synNoteId" select="substring-after($href,'/')"/>
        
        <xsl:variable name="syntaxDiagramElement" select="ancestor::*[contains(@class, ' pr-d/syntaxdiagram ')][1]"/>
        <xsl:variable name="synNoteElement" select="if (string($synNoteId)) then key('elementById',$synNoteId,$syntaxDiagramElement)[1] else ()" as="element()?"/>
        
        <xsl:choose>
            <xsl:when test="empty($synNoteElement)">
                <!-- DITA-OT already outputs DOTX032E error in topicpull -->
                <xsl:call-template name="warningContinue">
                    <xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes060,('%file','%trace','%href'),(@xtrf,@xtrc,@ohref))"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <fo:basic-link>
                    <xsl:attribute name="internal-destination">
                        <xsl:variable name="synNoteElemIdAtr" select="ahf:getIdAtts($synNoteElement,$prmTopicRef,true())" as="attribute()*"/>
                        <xsl:value-of select="$synNoteElemIdAtr[1]"/>
                    </xsl:attribute>
                    <xsl:copy-of select="ahf:getAttributeSet('atsSynNote')"/>
                    <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
                    <xsl:choose>
                        <xsl:when test="string(normalize-space($synNoteElement/@callout))">
                            <xsl:value-of select="normalize-space($synNoteElement/@callout)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$sdNotePrefix"/>
                            <xsl:number select="$synNoteElement"
                                        level="any" 
                                        count="*[contains(@class, ' pr-d/synnote ')][not(@callout)]"
                                        from="*[contains(@class,' pr-d/syntaxdiagram')]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:basic-link>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	kwd template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/kwd ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="isOptional"  select="boolean(@importance='optional')"/>
        <xsl:variable name="atsKwd"      select="if (@importance='default') then 'atsKwdDefault' else 'atsKwd'"/>
        <xsl:variable name="needOr"      select="ahf:sdNeedOr(.)"/>
    
        <xsl:if test="$needOr">
            <xsl:value-of select="$sdOr"/>
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalPrefix"/>
        </xsl:if>
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet($atsKwd)"/>
            <xsl:copy-of select="ahf:getLocalizationAtts(.)"/>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalSuffix"/>
        </xsl:if>
    </xsl:template>
    
    
    <!-- 
     function:	var template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/var ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="isOptional"  select="boolean(@importance='optional')"/>
        <xsl:variable name="atsVar"      select="if (@importance='default') then 'atsVarDefault' else 'atsVar'"/>
        <xsl:variable name="needOr"      select="ahf:sdNeedOr(.)"/>
    
        <xsl:if test="$needOr">
            <xsl:value-of select="$sdOr"/><!-- | -->
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalPrefix"/>
        </xsl:if>
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet($atsVar)"/>
            <xsl:copy-of select="ahf:getLocalizationAtts(.)"/>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalSuffix"/>
        </xsl:if>
    </xsl:template>
    
    <!-- 
     function:	oper template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/oper ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="isOptional"  select="boolean(@importance='optional')"/>
        <xsl:variable name="atsOper"      select="if (@importance='default') then 'atsOperDefault' else 'atsOper'"/>
        <xsl:variable name="needOr" select="ahf:sdNeedOr(.)"/>
    
        <xsl:if test="$needOr">
            <xsl:value-of select="$sdOr"/>
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalPrefix"/>
        </xsl:if>
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet($atsOper)"/>
            <xsl:copy-of select="ahf:getLocalizationAtts(.)"/>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalSuffix"/>
        </xsl:if>
    </xsl:template>
    
    <!-- 
     function:	delim template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/delim ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="isOptional"  select="boolean(@importance='optional')"/>
        <xsl:variable name="atsDelim"    select="if (@importance='default') then 'atsDelimDefault' else 'atsDelim'"/>
        <xsl:variable name="needOr"      select="ahf:sdNeedOr(.)"/>
    
        <xsl:if test="$needOr">
            <xsl:value-of select="$sdOr"/>
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalPrefix"/>
        </xsl:if>
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet($atsDelim)"/>
            <xsl:copy-of select="ahf:getLocalizationAtts(.)"/>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalSuffix"/>
        </xsl:if>
    </xsl:template>
    
    <!-- 
     function:	sep template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		none
     -->
    <xsl:template match="*[contains(@class,' pr-d/sep ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="isOptional"  select="boolean(@importance='optional')"/>
        <xsl:variable name="atsSep"      select="if (@importance='default') then 'atsSepDefault' else 'atsSep'"/>
        <xsl:variable name="needOr"      select="ahf:sdNeedOr(.)"/>
    
        <xsl:if test="$needOr">
            <xsl:value-of select="$sdOr"/>
        </xsl:if>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalPrefix"/>
        </xsl:if>
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet($atsSep)"/>
            <xsl:copy-of select="ahf:getLocalizationAtts(.)"/>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:inline>
        <xsl:if test="$isOptional">
            <xsl:value-of select="$sdOptionalSuffix"/>
        </xsl:if>
    </xsl:template>
    
    <!-- 
     function:	repsep template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		@importance is processed in processGroup template.
     -->
    <xsl:template match="*[contains(@class,' pr-d/repsep ')]" priority="2">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getLocalizationAtts(.)"/>
            <xsl:copy-of select="ahf:getIdAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
            <xsl:text> </xsl:text>
        </fo:inline>
    </xsl:template>


</xsl:stylesheet>