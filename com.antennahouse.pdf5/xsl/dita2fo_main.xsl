<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet
Module: Main control.
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
 exclude-result-prefixes="ahf" 
>
    
    <!-- Plug-in name and version -->
    <xsl:variable name="pluginAuthor" as="xs:string" select="'Antenna House'"/>
    <xsl:variable name="pluginName" as="xs:string" select="'PDF5'"/>
    <xsl:variable name="pluginVersion" as="xs:string" select="'2.1'"/>
    
    <!-- 
     function:	root matching template
     param:		none
     return:	fo:root
     note:		none
     -->
        <!--xsl:call-template name="stlyeDump"/-->
        <!--xsl:call-template name="dumpIndexterm"/-->
        <!--xsl:call-template name="dumpFigureMap"/-->
        <!--xsl:call-template name="dumpTableMap"/-->
        <!--xsl:call-template name="dumpThumbIndexMap"/-->
        <!--xsl:call-template name="dumpFootnoteMap"/-->
    <xsl:template match="/">
        <!--xsl:message select="'$lastTopicRef=',name($lastTopicRef),' class=',string($lastTopicRef/@class),' ohref=',string($lastTopicRef/@ohref)"/>
        -->
        <xsl:message select="concat($pluginAuthor,' ',$pluginName,' plug-in Version: ',$pluginVersion)"/>
        <xsl:call-template name="documentCheck"/>
    	<fo:root>
            <xsl:copy-of select="ahf:getAttributeSet('atsRoot')"/>
            
            <!-- Complement xml:lang -->
            <xsl:attribute name="xml:lang" select="$documentLang"/>
            
            <!-- Generate XSL-FO layoutmaster set -->
            <xsl:call-template name="genLayoutMasterSet"/>
    		
            <!-- Bookmark tree -->
       		<xsl:call-template name="genBookmarkTree"/>
            
            <!-- Make cover -->
            <xsl:call-template name="genCover"/>
            
            <!-- Process main contents -->
            <xsl:choose>
                <xsl:when test="$isBookMap">
                    <xsl:apply-templates select="$map/*[contains(@class, ' bookmap/frontmatter ')]"/>
                    <xsl:apply-templates select="$map/*[contains(@class, ' bookmap/part ') or contains(@class, ' bookmap/chapter ')]"/>
                    <xsl:apply-templates select="$map/*[contains(@class, ' bookmap/appendices ')]/*[contains(@class, ' bookmap/appendix ')]"/>
                    <xsl:apply-templates select="$map/*[contains(@class, ' bookmap/appendix ')]"/>
                    <xsl:apply-templates select="$map/*[contains(@class, ' bookmap/backmatter ')]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$map/*[contains(@class, ' map/topicref ')]"/>
                </xsl:otherwise>
            </xsl:choose>
            
            <!-- Generate index -->
       		<!--xsl:call-template name="genIndex"/-->
    
    		<!--xsl:call-template name="makeDummyContents"/-->
            
    	</fo:root>
    </xsl:template>
    
    
    <!-- 
     function:	Test for dummy output
     param:		none
     return:	fo:page-sequence
     note:		none
     -->
    <xsl:template name="makeDummyContents">
        <fo:page-sequence master-reference="pmsPageSeqChapter">
            <fo:flow flow-name="xsl-region-body">
                <fo:block>
                    Hello World!
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

</xsl:stylesheet>
