<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet 
Module: Specialization elements stylesheet
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

    <!-- index-base is coded in dita2fo_indexcommon.xsl. (Only skip element.)-->
    <!-- required-cleanup is coded in dita2fo_regacyconversionelements.xsl -->
    
    <!-- 
     function:	data-about
     param:	    prmTopicRef, prmNeedId
     return:	none
     note:		ignore descendant-or-self
     -->
    <xsl:template match="*[contains(@class,' topic/data-about ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    </xsl:template>
    
    <!-- 
     function:	data
     param:	    prmTopicRef, prmNeedId
     return:	none
     note:		ignore descendant-or-self
     -->
    <xsl:template match="*[contains(@class,' topic/data ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    </xsl:template>
    
    <!-- 
     function:	foreign template
     param:	    prmTopicRef,prmNeedId
     return:	If content is MathML or SVG return fo:wrapper & fo:instream-foreign-object
     note:		Added 2011-08-22 t.makita
     -->
    <xsl:template match="*[contains(@class, ' topic/foreign ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <xsl:variable name="childElem" select="child::*[1]" as="element()*"/>
    	<xsl:if test="exists($childElem)">
    		<fo:wrapper>
    	        <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
    		    <xsl:choose>
    			    <xsl:when test="namespace-uri($childElem)='http://www.w3.org/1998/Math/MathML'">
    			    	<!-- Content is MathML -->
    			        <fo:instream-foreign-object content-type="content-type:application/mathml+xml">
    			            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
    			            <xsl:copy-of select="$childElem"/>
    			        </fo:instream-foreign-object>
    			    </xsl:when>
    			    <xsl:when test="namespace-uri($childElem)='http://www.w3.org/2000/svg'">
    			    	<!-- Content is SVG -->
    			        <fo:instream-foreign-object content-type="content-type:image/svg+xml">
    			            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
    			            <xsl:copy-of select="$childElem"/>
    			        </fo:instream-foreign-object>
    			    </xsl:when>
    			</xsl:choose>
    		</fo:wrapper>
    	</xsl:if>
    </xsl:template>
    
    <!-- 
     function:	itemgroup template
     param:	    prmTopicRef, prmNeedId
     return:	fo:block
     note:		none
     -->
    <xsl:template match="*[contains(@class,' topic/itemgroup ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:block>
            <xsl:copy-of select="ahf:getAttributeSet('atsItemGroup')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <xsl:apply-templates>
                <xsl:with-param name="prmTopicRef" select="$prmTopicRef"/>
                <xsl:with-param name="prmNeedId"   select="$prmNeedId"/>
            </xsl:apply-templates>
        </fo:block>
    </xsl:template>
    
    <!-- 
     function:	no-topic-nesting template
     param:	    prmTopicRef, prmNeedId
     return:	none
     note:		none
     -->
    <xsl:template match="*[contains(@class,' topic/no-topic-nesting ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    </xsl:template>
    
    <!-- 
     function:	state template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		return @name=@value inline.
     -->
    <xsl:template match="*[contains(@class,' topic/state ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsState')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <xsl:value-of select="@name"/>
            <xsl:text>=</xsl:text>
            <xsl:value-of select="@value"/>
        </fo:inline>
    </xsl:template>
    
        
    
    <!-- 
     function:	boolean template
     param:	    prmTopicRef, prmNeedId
     return:	fo:inline
     note:		
     -->
    <xsl:template match="*[contains(@class,' topic/boolean ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    
        <fo:inline>
            <xsl:copy-of select="ahf:getAttributeSet('atsBoolean')"/>
            <xsl:copy-of select="ahf:getUnivAtts(.,$prmTopicRef,$prmNeedId)"/>
            <xsl:copy-of select="ahf:getFoStyleAndProperty(.)"/>
            <xsl:value-of select="@state"/>
        </fo:inline>
    </xsl:template>
    
    <!-- 
     function:	Unknown template
     param:	    prmTopicRef, prmNeedId
     return:	None
     note:		
     -->
    <xsl:template match="*[contains(@class,' topic/unknown ')]">
        <xsl:param name="prmTopicRef" required="yes"  as="element()?"/>
        <xsl:param name="prmNeedId"   required="yes"  as="xs:boolean"/>
    </xsl:template>

</xsl:stylesheet>