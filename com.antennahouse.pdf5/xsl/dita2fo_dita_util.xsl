<?xml version="1.0" encoding="UTF-8" ?>
<!--
**************************************************************
DITA to XSL-FO Stylesheet
Utility Templates
**************************************************************
File Name : dita2fo_dita_util.xsl
**************************************************************
Copyright © 2009 2014 Antenna House, Inc. All rights reserved.
Antenna House is a trademark of Antenna House, Inc.
URL : http://www.antennahouse.co.jp/
**************************************************************
-->

<xsl:stylesheet version="2.0" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
 	xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:ahf="http://www.antennahouse.com/names/XSLT/Functions/Document"
    exclude-result-prefixes="xs ahf" >

    <!--
    ===============================================
     DITA Utility Templates
    ===============================================
    -->
    
    <!-- 
      ============================================
         toc utility
      ============================================
    -->
    <!--
    function: isToc Utility
    param: prmElement
    note: Return boolena that parameter should add toc or not.
    -->
    <xsl:function name="ahf:isToc" as="xs:boolean">
        <xsl:param name="prmValue" as ="element()"/>
        
        <xsl:sequence select="not(ahf:isTocNo($prmValue))"/>
        <!--xsl:choose>
            <xsl:when  test="$prmValue/@toc='yes'">
                <xsl:sequence select="true()"/>
            </xsl:when>
            <xsl:when  test="$prmValue/@toc='no'">
                <xsl:sequence select="false()"/>
            </xsl:when>
            <xsl:when  test="not($prmValue/@toc)">
                <xsl:sequence select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="true()"/>
            </xsl:otherwise>
        </xsl:choose-->
    </xsl:function>
    
    <!-- 
     function:	Check @toc="no" 
     param:		prmTopicRef
     return:	xs:boolean
     note:		
     -->
    <xsl:function name="ahf:isTocNo" as="xs:boolean">
        <xsl:param name="prmTopicRef" as="element()"/>
        <xsl:choose>
            <xsl:when test="$pApplyTocAttr">
                <xsl:choose>
                    <xsl:when test="$prmTopicRef/@toc='no'">
                        <xsl:sequence select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- end of stylesheet -->
</xsl:stylesheet>
