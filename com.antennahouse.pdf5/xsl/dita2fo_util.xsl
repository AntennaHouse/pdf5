<?xml version="1.0" encoding="UTF-8" ?>
<!--
**************************************************************
DITA to XSL-FO Stylesheet
Utility Templates
**************************************************************
File Name : dita2fo_util.xsl
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
    ===============================================
     Utility Templates
    ===============================================
    -->
    
    <!--
    ===============================================
     Error processing
    ===============================================
    -->
    <!-- 
     function:	Error Exit routine
     param:		prmMes: message body
     return:	none
     note:		none
    -->
    <xsl:template name="errorExit">
    	<xsl:param name="prmMes" required="yes" as="xs:string"/>
    	<xsl:message terminate="yes"><xsl:value-of select="$prmMes"/></xsl:message>
    </xsl:template>
    
    
    <!-- 
     function:	Warning display routine
     param:		prmMes: message body
     return:	none
     note:		none
    -->
    <xsl:template name="warningContinue">
    	<xsl:param name="prmMes" required="yes" as="xs:string"/>
    	<xsl:message terminate="no"><xsl:value-of select="$prmMes"/></xsl:message>
    </xsl:template>
    
    
    <!-- 
     function:	topicref count template
     param:		prmTopicRef
     return:	topicref count that have same @href
     note:		none
    -->
    <xsl:function name="ahf:countTopicRef" as="xs:integer">
        <xsl:param name="prmTopicRef" as="element()"/>
        
        <xsl:variable name="href" select="string($prmTopicRef/@href)" as="xs:string"/>
        <xsl:variable name="topicRefCount" as="xs:integer">
            <xsl:number select="$prmTopicRef"
                        level="any"
                        count="*[contains(@class,' map/topicref ')][string(@href)=$href]"
                        from="*[contains(@class,' map/map ')]"
                        format="1"/>
        </xsl:variable>
        <xsl:sequence select="$topicRefCount"/>
    </xsl:function>
    
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
    -->
    <xsl:function name="ahf:getAttributeSet" as="attribute()*">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
    
    	<xsl:variable name="normalizedAtrSetName" select="normalize-space($prmAttrSetName)"/>
    	
        <xsl:for-each select="tokenize($normalizedAtrSetName, '[\s]+')">
            <xsl:variable name="elementName" select="string(.)"/>
        	<xsl:if test="not ($glStyleDefs/*[name() eq $elementName])">
        		<xsl:call-template name="errorExit">
        			<xsl:with-param name="prmMes">
        				<xsl:value-of select="ahf:replace($stMes005,('%attrsetname','%file'),($elementName,$allStyleDefFile))"/>
        			</xsl:with-param>
        		</xsl:call-template>
        	</xsl:if>
        	<!-- Error occures in some cases in Saxon 9.1 -->
    		<!--xsl:sequence select="$glStyleDefs/*[name() eq $elementName]/@*"/-->
    		<xsl:for-each select="$glStyleDefs/*[name() eq $elementName]">
    			<xsl:for-each select="./@*">
    				<xsl:attribute name="{name()}" select="string(.)"/>
    			</xsl:for-each>
    		</xsl:for-each>
        </xsl:for-each>
    </xsl:function>
    
    <!-- 
     function:	Get CSS style string
     param:		prmStyleName
     return:	CSS style string
     note:		none
    -->
    <xsl:function name="ahf:getCssStyle" as="xs:string">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
    
    	<xsl:if test="not($glStyleDefs/*[name() eq $prmAttrSetName])">
    		<xsl:call-template name="errorExit">
    			<xsl:with-param name="prmMes">
    				<xsl:value-of select="ahf:replace($stMes025,('%style','%file'),($prmAttrSetName,$allStyleDefFile))"/>
    			</xsl:with-param>
    		</xsl:call-template>
    	</xsl:if>
    
        <xsl:variable name="styles" select="$glStyleDefs/*[name() eq $prmAttrSetName][position() eq last()]/@*" as="attribute()*"/>
    
        <xsl:sequence select="ahf:attributeToCss($styles)"/>
    
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
                    <xsl:choose>
                        <xsl:when test="contains($value, ' ')">
                            <xsl:text>'</xsl:text>
                            <xsl:value-of select="$value"/>
                            <xsl:text>';</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$value"/>
                            <xsl:text>;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat($firstString, $restString)"/>
    </xsl:function>
    
    <!-- 
     function:	Get attribute
     param:		prmAttrSetName, prmAttrName
     return:	attribute node
     note:		none
    -->
    <xsl:function name="ahf:getAttribute" as="attribute()?">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
    	<xsl:param name="prmAttrName" as="xs:string"/>
    
    	<xsl:if test="not ($glStyleDefs/*[name() eq $prmAttrSetName])">
    		<xsl:call-template name="errorExit">
    			<xsl:with-param name="prmMes">
    				<xsl:value-of select="ahf:replace($stMes006,('%attrsetname','%file'),($prmAttrSetName,$allStyleDefFile))"/>
    			</xsl:with-param>
    		</xsl:call-template>
    	</xsl:if>
    	<xsl:for-each select="string($glStyleDefs/*[name() eq $prmAttrSetName]/attribute::node()[name() eq $prmAttrName][position() eq last()])">
    		<xsl:attribute name="{$prmAttrName}" select="string(.)"/>
    	</xsl:for-each>
    </xsl:function>
    
    <!-- 
     function:	Get attribute value
     param:		prmAttrSetName, prmAttrName
     return:	attribute value
     note:		none
    -->
    <xsl:function name="ahf:getAttributeValue" as="xs:string">
    	<xsl:param name="prmAttrSetName" as="xs:string"/>
    	<xsl:param name="prmAttrName" as="xs:string"/>
    
    	<xsl:if test="not ($glStyleDefs/*[name() eq $prmAttrSetName])">
    		<xsl:call-template name="errorExit">
    			<xsl:with-param name="prmMes">
    				<xsl:value-of select="ahf:replace($stMes006,('%attrsetname','%file'),($prmAttrSetName,$allStyleDefFile))"/>
    			</xsl:with-param>
    		</xsl:call-template>
    	</xsl:if>
    	<xsl:sequence select="string($glStyleDefs/*[name() eq $prmAttrSetName][position() eq last()]/attribute::node()[name() eq $prmAttrName])"/>
    </xsl:function>
    
    
    <!-- 
     function:	Get variable value
     param:		prmVarName
     return:	Variable value
     note:		none
    -->
    <xsl:function name="ahf:getVarValue" as="xs:string">
    	<xsl:param name="prmVarName" as="xs:string"/>
        
        <xsl:choose>
        	<xsl:when test="not ($glVarDefs/*[name() eq $prmVarName])">
        		<xsl:call-template name="errorExit">
        			<xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes008,('%var','%file'),($prmVarName,$allStyleDefFile))"/>
        			</xsl:with-param>
        		</xsl:call-template>
        	</xsl:when>
            <!-- Commented because $glVarDefs has multiple same entries.
                 2011-07-20 t.makita
             -->
        	<!--xsl:when test="count($glVarDefs/*[name()=$prmVarName]) &gt; 1">
        		<xsl:call-template name="errorExit">
        			<xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes020,('%var','%file'),($prmVarName,$styleDefFile))"/>
        			</xsl:with-param>
        		</xsl:call-template>
        	</xsl:when>
        	<xsl:when test="count($glAltVarDefs/*[name()=$prmVarName]) &gt; 1">
        		<xsl:call-template name="errorExit">
        			<xsl:with-param name="prmMes">
                        <xsl:value-of select="ahf:replace($stMes021,('%var','%file'),($prmVarName,$altStyleDefFile))"/>
        			</xsl:with-param>
        		</xsl:call-template>
        	</xsl:when>
    		<xsl:when test="$glAltVarDefs/*[name()=$prmVarName]">
        		<xsl:sequence select="string($glAltVarDefs/*[name()=$prmVarName][1]/text())"/>
    		</xsl:when-->
    		<xsl:otherwise>
    			<xsl:sequence select="string($glVarDefs/*[name() eq $prmVarName][position() eq last()]/text())"/>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:function>
    
    
    <!-- 
     function:	Get instream object 
     param:		prmObjName
     return:	instream object 
     note:		none
    -->
    <xsl:function name="ahf:getInstreamObject" as="element()*">
    	<xsl:param name="prmObjName" as="xs:string"/>
    
    	<xsl:if test="not ($glInstreamObjects/*[name() eq $prmObjName])">
    		<xsl:call-template name="errorExit">
    			<xsl:with-param name="prmMes">
    				<xsl:value-of select="ahf:replace($stMes009,('%objname','%file'),($prmObjName,$allStyleDefFile))"/>
    			</xsl:with-param>
    		</xsl:call-template>
    	</xsl:if>
    	<xsl:sequence select="$glInstreamObjects/*[name() eq $prmObjName][position() eq last()]/*"/>
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
    -->
    <xsl:function name="ahf:getFormattingObject" as="element()*">
    	<xsl:param name="prmObjName" as="xs:string"/>
    
    	<xsl:if test="not ($glFormattingObjects/*[name() eq $prmObjName])">
    		<xsl:call-template name="errorExit">
    			<xsl:with-param name="prmMes">
    				<xsl:value-of select="ahf:replace($stMes010,('%objname','%file'),($prmObjName,$allStyleDefFile))"/>
    			</xsl:with-param>
    		</xsl:call-template>
    	</xsl:if>
    	<xsl:sequence select="$glFormattingObjects/*[name() eq $prmObjName][position() eq last()]/*"/>
    </xsl:function>
    
    <!-- 
      ============================================
         String utility
      ============================================
    -->
    <!--
    function: String Utility
    param: see below
    note: return the sub-string before or after of the LAST delimiter
    -->
    <xsl:template name="substringBeforeLast">
    	<xsl:param name="prmSrcString" required="yes" as="xs:string"/>
    	<xsl:param name="prmDlmString" required="yes" as="xs:string"/>
    	
    	<xsl:variable name="substringBefore" select="substring-before($prmSrcString, $prmDlmString)"/>
    	<xsl:variable name="substringAfter" select="substring-after($prmSrcString, $prmDlmString)"/>
    	<xsl:choose>
    		<xsl:when test="contains($substringAfter, $prmDlmString)">
    			<xsl:variable name="restResult">
    				<xsl:call-template name="substringBeforeLast">
    					<xsl:with-param name="prmSrcString" select="$substringAfter"/>
    					<xsl:with-param name="prmDlmString" select="$prmDlmString"/>
    				</xsl:call-template>
    			</xsl:variable>
    			<xsl:value-of select="concat($substringBefore, $prmDlmString, $restResult)"/>
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:value-of select="$substringBefore"/>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:template>
    
    <xsl:function name="ahf:substringAfterLast" as="xs:string">
    	<xsl:param name="prmSrcString" as="xs:string"/>
    	<xsl:param name="prmDlmString" as="xs:string"/>
    	
    	<xsl:variable name="substringBefore" select="substring-before($prmSrcString, $prmDlmString)"/>
    	<xsl:variable name="substringAfter" select="substring-after($prmSrcString, $prmDlmString)"/>
    	<xsl:choose>
    		<xsl:when test="not(contains($prmSrcString, $prmDlmString))">
    			<xsl:sequence select="$prmSrcString"/>
    		</xsl:when>
    		<xsl:when test="contains($substringAfter, $prmDlmString)">
    			<xsl:sequence select="ahf:substringAfterLast($substringAfter, $prmDlmString)"/>
    		</xsl:when>
    		<xsl:otherwise>
    			<xsl:sequence select="$substringAfter"/>
    		</xsl:otherwise>
    	</xsl:choose>
    </xsl:function>
    
    <!--
        function: Convert back-slash to slash
        param: prmString
        note: Result string
    -->
    <xsl:function name="ahf:bsToSlash" as="xs:string">
        <xsl:param name="prmStr" as="xs:string"/>
        <xsl:sequence select="translate($prmStr,'&#x005C;','/')"/>
    </xsl:function>
    
    <!--
        function: Safe replace function
        param: prmStr,prmSrc,prmDst
        note: Result string
    -->
    <xsl:function name="ahf:safeReplace" as="xs:string">
        <xsl:param name="prmStr" as="xs:string"/>
        <xsl:param name="prmSrc" as="xs:string"/>
        <xsl:param name="prmDst" as="xs:string"/>
        <xsl:sequence select="replace($prmStr,$prmSrc,ahf:bsToSlash($prmDst))"/>
    </xsl:function>
    
    <!--
        function: Multiple replace function
        param: prmStr,prmSrc,prmDst
        note: Result string
    -->
    <xsl:function name="ahf:replace" as="xs:string">
        <xsl:param name="prmStr" as="xs:string"/>
        <xsl:param name="prmSrc" as="xs:string+"/>
        <xsl:param name="prmDst" as="xs:string+"/>
    
        <xsl:variable name="firstResult" select="ahf:safeReplace($prmStr,$prmSrc[1],$prmDst[1])" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="exists($prmSrc[2]) and exists($prmDst[2])">
                <xsl:sequence select="ahf:replace($firstResult,subsequence($prmSrc,2),subsequence($prmDst,2))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$firstResult"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
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
    
    
    <!-- 
      ============================================
         Other functions
      ============================================
    -->
    <!-- 
     function:	Make hexadecimal string from positive integer
     param:		prmNumber
     return:	Hexadecimal string
     note:		
     -->
    <xsl:function name="ahf:intToHexString" as="xs:string">
        <xsl:param name="prmValue" as="xs:integer"/>
    
        <xsl:variable name="quotient"  select="$prmValue idiv 16" as="xs:integer"/>
        <xsl:variable name="remainder" select="$prmValue mod 16"  as="xs:integer"/>
        
        <xsl:variable name="quotientString" select="if ($quotient &gt; 0) then (ahf:intToHexString($quotient)) else ''" as="xs:string"/>
        <xsl:variable name="remainderString" as="xs:string">
            <xsl:choose>
                <xsl:when test="($remainder &gt;= 0) and ($remainder &lt;= 9)">
                    <xsl:value-of select="format-number($remainder, '0')"/>
                </xsl:when>
                <xsl:when test="$remainder = 10">
                    <xsl:value-of select="'A'"/>
                </xsl:when>
                <xsl:when test="$remainder = 11">
                    <xsl:value-of select="'B'"/>
                </xsl:when>
                <xsl:when test="$remainder = 12">
                    <xsl:value-of select="'C'"/>
                </xsl:when>
                <xsl:when test="$remainder = 13">
                    <xsl:value-of select="'D'"/>
                </xsl:when>
                <xsl:when test="$remainder = 14">
                    <xsl:value-of select="'E'"/>
                </xsl:when>
                <xsl:when test="$remainder = 15">
                    <xsl:value-of select="'F'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="''"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat($quotientString, $remainderString)"/>
    </xsl:function>
    
    <!-- 
     function:	Make hexadecimal string from codepoint sequence
     param:		prmCodePoint
     return:	Hexadecimal string
     note:		
     -->
    <xsl:function name="ahf:codepointToHexString" as="xs:string">
        <xsl:param name="prmCodePoint" as="xs:integer*"/>
    
        <xsl:choose>
            <xsl:when test="empty($prmCodePoint)">
                <xsl:sequence select="''"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="first" select="ahf:intToHexString($prmCodePoint[1])" as="xs:string"/>
                <xsl:variable name="paddingCount" select="string-length($first) mod 4"/>
                <xsl:variable name="paddingZero" select="if ($paddingCount gt 0) then string-join(for $i in 1 to $paddingCount return '0','') else ''"/>
                <xsl:variable name="rest"  select="ahf:codepointToHexString(subsequence($prmCodePoint,2))" as="xs:string"/>
                <xsl:sequence select="concat($paddingZero, $first, $rest)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- 
     function:	Make hexadecimal string from string
     param:		prmString
     return:	Hexadecimal string
     note:		
     -->
    <xsl:function name="ahf:stringToHexString" as="xs:string">
        <xsl:param name="prmString" as="xs:string"/>
    
        <xsl:variable name="codePoints" select="string-to-codepoints($prmString)" as="xs:integer*"/>
        <xsl:sequence select="ahf:codepointToHexString($codePoints)"/>
    </xsl:function>
    
    
    <!-- 
     function:	Get numeric part of numeric property
     param:		prmProperty
     return:	number
     note:		
     -->
    <xsl:function name="ahf:getPropertyNu" as="xs:double">
        <xsl:param name="prmProperty" as="xs:string"/>
        
        <xsl:variable name="propertyNu" select="replace($prmProperty,'[\p{L}]','')"/>
        <xsl:choose>
            <xsl:when test="string(number($propertyNu))=$NaN">
                <xsl:call-template name="warningContinue">
                    <xsl:with-param name="prmMes" 
                     select="ahf:replace($stMes400,('%val'),($prmProperty))"/>
                </xsl:call-template>
                <xsl:sequence select="number(1.0)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="number($propertyNu)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- 
     function:	Get unit part of numeric property
     param:		prmProperty
     return:	unit string
     note:		
     -->
    <xsl:function name="ahf:getPropertyUnit" as="xs:string">
        <xsl:param name="prmProperty" as="xs:string"/>
        <xsl:sequence select="replace($prmProperty,'[\.\p{Nd}]','')"/>
    </xsl:function>
    
    <!--
     function:	Get calculated the property value with specified ratio
     param:		prmProperty, prmRatio
     return:	calculated property string
     note:		
     -->
    <xsl:function name="ahf:getPropertyRatio" as="xs:string">
        <xsl:param name="prmProperty" as="xs:string"/>
        <xsl:param name="prmRatio"    as="xs:double"/>
    
        <!--xsl:variable name="propertyValue" select="ahf:getPropertyNu($prmProperty)" as="xs:double"/>
        <xsl:variable name="propertyUnit"  select="ahf:getPropertyUnit($prmProperty)" as="xs:string"/>
        <xsl:variable name="calculatedValue" select="$propertyValue * $prmRatio" as="xs:double"/>
        <xsl:sequence select="concat(string($calculatedValue), $propertyUnit)"/-->
        
        <xsl:sequence select="concat('(',$prmProperty, ') * ',string($prmRatio))"/>
        
    </xsl:function>
    
    
    
    <!-- end of stylesheet -->
</xsl:stylesheet>
