<?xml version="1.0" encoding="UTF-8" ?>
<!--
**************************************************************
DITA to XSL-FO Stylesheet
Get attributeset,variable and instream-object from temporary 
tree.
**************************************************************
File Name : dita2fo_styleget.xsl
**************************************************************
Copyright © 2009 2009 Antenna House, Inc. All rights reserved.
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
      ======================================================================================
      FO style defninition file (default_style.xml, [lang-code]_style.xml) related template.
      ======================================================================================
    -->
    
    <!-- 
     function:	Get attribute
     param:		prmAttrSetName
     return:	Attribute node
     note:		Attribute-set is concatination of main style and alternate style.
                2011-07-20 t.makita
                Change error processing not to stop when $prmAttrSetName is not found.
                2014-09-13 t.makita
    -->
    <xsl:function name="ahf:getAttributeSet" as="attribute()*">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
    
    	<xsl:variable name="normalizedAtrSetName" select="normalize-space($prmAttrSetName)"/>
    	
        <xsl:for-each select="tokenize($normalizedAtrSetName, '[\s]+')">
            <xsl:variable name="elementName" select="string(.)"/>
            <xsl:choose>
                <xsl:when test="empty($glStyleDefs/*[name() eq $elementName])">
                    <xsl:call-template name="warningContinue">
                        <xsl:with-param name="prmMes">
                            <xsl:value-of select="ahf:replace($stMes005,('%attrsetname','%file'),($elementName,$allStyleDefFile))"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:sequence select="()"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- Error occures in some cases in Saxon 9.1 -->
                    <!--xsl:sequence select="$glStyleDefs/*[name() eq $elementName]/@*"/-->
                    <xsl:for-each select="$glStyleDefs/*[name() eq $elementName]">
                        <xsl:for-each select="./@*">
                            <xsl:attribute name="{name()}" select="string(.)"/>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <!-- 
     function:	Get CSS style string
     param:		prmStyleName
     return:	CSS style string
     note:		Change error processing not to stop when $prmAttrSetName is not found.
                2014-09-13 t.makita
    -->
    <xsl:function name="ahf:getCssStyle" as="xs:string">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
        
        <xsl:choose>
            <xsl:when test="not($glStyleDefs/*[name() eq $prmAttrSetName])">
                <xsl:call-template name="warningContinue">
                    <xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes025,('%style','%file'),($prmAttrSetName,$allStyleDefFile))"/>
                    </xsl:with-param>
                </xsl:call-template>
                <xsl:sequence select="''"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="styles" select="$glStyleDefs/*[name() eq $prmAttrSetName][position() eq last()]/@*" as="attribute()*"/>
                <xsl:sequence select="ahf:attributeToCss($styles)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="ahf:attributeToCss" as="xs:string">
        <xsl:param name="prmAttributes" as="attribute()*"/>
    
        <xsl:variable name="first" select="subsequence($prmAttributes,1,1)" as="attribute()*"/>
        <xsl:variable name="restString" select="if (empty(subsequence($prmAttributes,2))) then '' else  (ahf:attributeToCss(subsequence($prmAttributes,2)))" as="xs:string"/>
    
        <xsl:variable name="firstString">
            <xsl:choose>
                <xsl:when test="empty($first)">
                    <xsl:value-of select="''"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="name" select="name($first)"/>
                    <xsl:variable name="value" select="string($first)"/>
                    <xsl:value-of select="$name"/>
                    <xsl:text>:</xsl:text>
                    <xsl:value-of select="$value"/>
                    <xsl:text>;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat($firstString, $restString)"/>
    </xsl:function>
    
    <!-- 
     function:	Get attribute
     param:		prmAttrSetName, prmAttrName
     return:	attribute node
     note:		Change error processing not to stop when $prmAttrSetName is not found.
                2014-09-13 t.makita
    -->
    <xsl:function name="ahf:getAttribute" as="attribute()?">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
    	<xsl:param name="prmAttrName" as="xs:string"/>
    
        <xsl:choose>
            <xsl:when test="empty($glStyleDefs/*[name() eq $prmAttrSetName])">
                <xsl:call-template name="warningContinue">
                    <xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes006,('%attrsetname','%file'),($prmAttrSetName,$allStyleDefFile))"/>
                    </xsl:with-param>
                </xsl:call-template>
                <xsl:sequence select="()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="string($glStyleDefs/*[name() eq $prmAttrSetName]/attribute::node()[name() eq $prmAttrName][position() eq last()])">
                    <xsl:attribute name="{$prmAttrName}" select="string(.)"/>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- 
     function:	Get attribute value
     param:		prmAttrSetName, prmAttrName
     return:	attribute value
     note:		Change error processing not to stop when $prmAttrSetName is not found.
                2014-09-13 t.makita
    -->
    <xsl:function name="ahf:getAttributeValue" as="xs:string">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
    	<xsl:param name="prmAttrName" as="xs:string"/>

        <xsl:choose>
            <xsl:when test="not ($glStyleDefs/*[name() eq $prmAttrSetName])">
                <xsl:call-template name="warningContinue">
                    <xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes006,('%attrsetname','%file'),($prmAttrSetName,$allStyleDefFile))"/>
                    </xsl:with-param>
                </xsl:call-template>
                <xsl:sequence select="''"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="string($glStyleDefs/*[name() eq $prmAttrSetName][position() eq last()]/attribute::node()[name() eq $prmAttrName])"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- 
     function:	Get variable value
     param:		prmVarName
     return:	Variable value
     note:		Change error processing not to stop when $prmAttrSetName is not found.
                2014-09-13 t.makita
    -->
    <xsl:function name="ahf:getVarValue" as="xs:string">
    	<xsl:param name="prmVarName" as="xs:string"/>
        
        <xsl:choose>
        	<xsl:when test="empty($glVarDefs/*[name() eq $prmVarName])">
        		<xsl:call-template name="warningContinue">
        			<xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes008,('%var','%file'),($prmVarName,$allStyleDefFile))"/>
        			</xsl:with-param>
        		</xsl:call-template>
        	    <xsl:sequence select="''"/>
        	</xsl:when>
    		<xsl:otherwise>
    			<xsl:sequence select="string($glVarDefs/*[name() eq $prmVarName][position() eq last()]/text())"/>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:function>
    
    
    <!-- 
     function:	Get instream object 
     param:		prmObjName
     return:	instream object 
     note:		Change error processing not to stop when $prmAttrSetName is not found.
                2014-09-13 t.makita
    -->
    <xsl:function name="ahf:getInstreamObject" as="element()*">
    	<xsl:param name="prmObjName" as="xs:string"/>
        
        <xsl:choose>
            <xsl:when test="empty($glInstreamObjects/*[name() eq $prmObjName])">
                <xsl:call-template name="warningContinue">
                    <xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes009,('%objname','%file'),($prmObjName,$allStyleDefFile))"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$glInstreamObjects/*[name() eq $prmObjName][position() eq last()]/*"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    <!-- 
     function:	Get instream object replacing text
     param:		prmVarName, prmSrcStr, prmDstStr
     return:	instream object replacing text
     note:		none
    -->
    <xsl:function name="ahf:getInstreamObjectTextReplace" as="element()*">
    	<xsl:param name="prmObjName" as="xs:string"/>
    	<xsl:param name="prmSrcStr" as="xs:string"/>
    	<xsl:param name="prmDstStr" as="xs:string"/>
    
        <xsl:variable name="srcInstreamObject" select="ahf:getInstreamObject($prmObjName)"/>
        <xsl:variable name="dstInstreamObject">
            <xsl:apply-templates select="$srcInstreamObject" mode="INSTREAM_REPLACE_TEXT">
            	<xsl:with-param name="prmSrcStr" select="$prmSrcStr"/>
            	<xsl:with-param name="prmDstStr" select="$prmDstStr"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:sequence select="$dstInstreamObject/*"/>
    </xsl:function>
    
    <xsl:template match="svg:*" mode="INSTREAM_REPLACE_TEXT">
    	<xsl:param name="prmSrcStr" as="xs:string"/>
    	<xsl:param name="prmDstStr" as="xs:string"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="INSTREAM_REPLACE_TEXT">
            	<xsl:with-param name="prmSrcStr" select="$prmSrcStr"/>
            	<xsl:with-param name="prmDstStr" select="$prmDstStr"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*" mode="INSTREAM_REPLACE_TEXT">
    	<xsl:param name="prmSrcStr" as="xs:string"/>
    	<xsl:param name="prmDstStr" as="xs:string"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="INSTREAM_REPLACE_TEXT">
            	<xsl:with-param name="prmSrcStr" select="$prmSrcStr"/>
            	<xsl:with-param name="prmDstStr" select="$prmDstStr"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" mode="INSTREAM_REPLACE_TEXT">
    	<xsl:param name="prmSrcStr" as="xs:string"/>
    	<xsl:param name="prmDstStr" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="contains(.,$prmSrcStr)">
                <xsl:value-of select="replace(.,$prmSrcStr,$prmDstStr)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
     function:	Get formatting object 
     param:		prmObjName
     return:	Formatting object 
     note:		Newly added on 2011-08-18 t.makita
        		Change error processing not to stop when $prmAttrSetName is not found.
                2014-09-13 t.makita
     
    -->
    <xsl:function name="ahf:getFormattingObject" as="element()*">
    	<xsl:param name="prmObjName" as="xs:string"/>
    
        <xsl:choose>
            <xsl:when test="empty($glFormattingObjects/*[name() eq $prmObjName])">
                <xsl:call-template name="warningContinue">
                    <xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes010,('%objname','%file'),($prmObjName,$allStyleDefFile))"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$glFormattingObjects/*[name() eq $prmObjName][position() eq last()]/*"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- end of stylesheet -->
</xsl:stylesheet>
