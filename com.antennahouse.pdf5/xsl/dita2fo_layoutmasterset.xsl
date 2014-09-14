<?xml version='1.0' encoding="UTF-8" ?>
<!--
****************************************************************
DITA to XSL-FO Stylesheet
Module: Generate fo:layout-master-set.
Copyright © 2009-2011 Antenna House, Inc. All rights reserved.
Antenna House is a trademark of Antenna House, Inc.
URL    : http://www.antennahouse.com/
E-mail : info@antennahouse.com
****************************************************************
-->
<xsl:stylesheet version="2.0" 
 xmlns:fo="http://www.w3.org/1999/XSL/Format" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ahf="http://www.antennahouse.com/names/XSLT/Functions/Document"
 exclude-result-prefixes="ahf" 
>

    <!-- 
     function:	generate layout master set
     param:		none
     return:	fo:layout-master-set
     note:		none
    -->
    
    <xsl:template name="genLayoutMasterSet">
    	<fo:layout-master-set>
    		<xsl:call-template name="genSimplePageMaster"/>
    		<xsl:call-template name="genPageSequenceMaster"/>
    	</fo:layout-master-set>
    </xsl:template>
    
    <!-- 
     function:	generate simple-page master
     param:		none
     return:	fo:simple-page-master
     note:		none
    -->
    <xsl:template name="genSimplePageMaster">
        <xsl:call-template name="genSpmCommon"/>
        <xsl:call-template name="genSpmCover"/>
        <xsl:call-template name="genSpmFrontmatter"/>
        <xsl:call-template name="genSpmChapter"/>
        <xsl:call-template name="genSpmGlossaryList"/>
        <xsl:call-template name="genSpmIndex"/>
        <xsl:call-template name="genSpmBackmatter"/>
    </xsl:template>
    
    <xsl:template name="genSpmCommon">    
        <!-- Common page -->
        <fo:simple-page-master master-name="pmsCommon">
            <xsl:copy-of select="ahf:getAttributeSet('atsCommonPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsCommonRegionBody')"/>
            </fo:region-body>
        	<fo:region-before>
                <xsl:copy-of select="ahf:getAttributeSet('atsCommonRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end>
                <xsl:copy-of select="ahf:getAttributeSet('atsCommonRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after>
                <xsl:copy-of select="ahf:getAttributeSet('atsCommonRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start>
                <xsl:copy-of select="ahf:getAttributeSet('atsCommonRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    </xsl:template>
    
    <xsl:template name="genSpmCover">
        <!-- Cover Page -->
        <fo:simple-page-master master-name="pmsCover">
            <xsl:copy-of select="ahf:getAttributeSet('atsCoverPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsCoverRegionBody')"/>
            </fo:region-body>
        	<fo:region-after>
                <xsl:copy-of select="ahf:getAttributeSet('atsCoverRegionAfter')"/>
            </fo:region-after>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsCoverBlank">
            <xsl:copy-of select="ahf:getAttributeSet('atsCommonPage')"/>
        	<fo:region-body region-name="rgnCoverBlankBody">
                <xsl:copy-of select="ahf:getAttributeSet('atsCommonRegionBody')"/>
            </fo:region-body>
        </fo:simple-page-master>
    
    </xsl:template>
    
    <xsl:template name="genSpmFrontmatter">
        <!-- Front matter Page -->
        <fo:simple-page-master master-name="pmsFrontmatterLeft">
            <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnFrontmatterBeforeLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end>
                <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnFrontmatterAfterLeft">
                 <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start region-name="rgnFrontmatterStartLeft">
                 <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsFrontmatterRight">
            <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnFrontmatterBeforeRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end   region-name="rgnFrontmatterEndRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnFrontmatterAfterRight">
                 <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start>
                 <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsFrontmatterBlank">
            <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterPage')"/>
        	<fo:region-body region-name="rgnFrontmatterBlankBody">
                <xsl:copy-of select="ahf:getAttributeSet('atsFrontmatterRegionBody')"/>
            </fo:region-body>
        </fo:simple-page-master>
    
    </xsl:template>
    
    <xsl:template name="genSpmChapter">    
        <!-- Chapter Page -->
        <fo:simple-page-master master-name="pmsChapterLeft">
            <xsl:copy-of select="ahf:getAttributeSet('atsChapterPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnChapterBeforeLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionBefore')"/>
            </fo:region-before>
            <fo:region-end region-name="rgnChapterEndLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnChapterAfterLeft">
                 <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start region-name="rgnChapterStartLeft">
                 <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsChapterRight">
            <xsl:copy-of select="ahf:getAttributeSet('atsChapterPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnChapterBeforeRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end region-name="rgnChapterEndRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnChapterAfterRight">
                 <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start>
                 <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsChapterBlank">
            <xsl:copy-of select="ahf:getAttributeSet('atsChapterPage')"/>
        	<fo:region-body region-name="rgnChapterBlankBody">
                <xsl:copy-of select="ahf:getAttributeSet('atsChapterRegionBody')"/>
            </fo:region-body>
        </fo:simple-page-master>
    
    </xsl:template>
    
    <xsl:template name="genSpmGlossaryList">
        <!-- Glossary list page -->
        <fo:simple-page-master master-name="pmsGlossaryListLeft">
            <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnGlossaryListBeforeLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end>
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnGlossaryListAfterLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start region-name="rgnGlossaryListLeftStart">
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsGlossaryListRight">
            <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnGlossaryListBeforeRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end region-name="rgnGlossaryListEndRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnGlossaryListAfterRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start>
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsGlossaryListBlank">
            <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListPage')"/>
        	<fo:region-body region-name="rgnGlossaryListBlankBody">
                <xsl:copy-of select="ahf:getAttributeSet('atsGlossaryListBlankRegionBody')"/>
            </fo:region-body>
        </fo:simple-page-master>
    
    </xsl:template>
    
    <xsl:template name="genSpmIndex">
        <!-- Index page -->
        <fo:simple-page-master master-name="pmsIndexLeft">
            <xsl:copy-of select="ahf:getAttributeSet('atsIndexPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnIndexBeforeLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end>
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnIndexAfterLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start region-name="rgnIndexLeftStart">
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsIndexRight">
            <xsl:copy-of select="ahf:getAttributeSet('atsIndexPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnIndexBeforeRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end region-name="rgnIndexEndRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnIndexAfterRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start>
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsIndexBlank">
            <xsl:copy-of select="ahf:getAttributeSet('atsIndexPage')"/>
        	<fo:region-body region-name="rgnIndexBlankBody">
                <xsl:copy-of select="ahf:getAttributeSet('atsIndexBlankRegionBody')"/>
            </fo:region-body>
        </fo:simple-page-master>
    
    </xsl:template>
    
    <xsl:template name="genSpmBackmatter">    
        <!-- Backmatter Page -->
        <fo:simple-page-master master-name="pmsBackmatterLeft">
            <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnBackmatterBeforeLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end>
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnBackmatterAfterLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start region-name="rgnBackmatterStartLeft">
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsBackmatterRight">
            <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterPage')"/>
        	<fo:region-body>
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionBody')"/>
            </fo:region-body>
        	<fo:region-before region-name="rgnBackmatterBeforeRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionBefore')"/>
            </fo:region-before>
        	<fo:region-end  region-name="rgnBackmatterEndRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionEnd')"/>
            </fo:region-end>
        	<fo:region-after region-name="rgnBackmatterAfterRight">
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionAfter')"/>
            </fo:region-after>
        	<fo:region-start>
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionStart')"/>
            </fo:region-start>
        </fo:simple-page-master>
    
        <fo:simple-page-master master-name="pmsBackmatterBlank">
            <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterPage')"/>
        	<fo:region-body region-name="rgnBackmatterBlankBody">
                <xsl:copy-of select="ahf:getAttributeSet('atsBackmatterRegionBody')"/>
            </fo:region-body>
        </fo:simple-page-master>
    
    </xsl:template>
    
    <!-- 
     function:	generate page-sequence master
     param:		none
     return:	fo:page-sequence-master
     note:		
    -->
    <xsl:template name="genPageSequenceMaster">
        <xsl:call-template name="genPsmCover"/>
        <xsl:call-template name="genPsmFrontmatter"/>
        <xsl:call-template name="genPsmChapter"/>
        <xsl:call-template name="genPsmGlossaryList"/>
        <xsl:call-template name="genPsmIndex"/>
        <xsl:call-template name="genPsmBackmatter"/>
    </xsl:template>
    
    <xsl:template name="genPsmCover">
        <!-- Cover -->
        <fo:page-sequence-master master-name="pmsPageSeqCover">
        	<fo:repeatable-page-master-alternatives>
        		<fo:conditional-page-master-reference master-reference="pmsCover" 
                                                      odd-or-even="any" 
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsCoverBlank" 
                                                      odd-or-even="any"  
                                                      page-position="any"
                                                      blank-or-not-blank="blank"/>
        	</fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
    </xsl:template>
    
    <xsl:template name="genPsmFrontmatter">
        <!-- Front matter -->
        <fo:page-sequence-master master-name="pmsPageSeqFrontmatter">
        	<fo:repeatable-page-master-alternatives>
        		<fo:conditional-page-master-reference master-reference="pmsFrontmatterLeft" 
                                                      odd-or-even="even"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsFrontmatterRight" 
                                                      odd-or-even="odd"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsFrontmatterBlank" 
                                                      odd-or-even="any"  
                                                      page-position="any"
                                                      blank-or-not-blank="blank"/>
        	</fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
    </xsl:template>
    
    <xsl:template name="genPsmChapter">
        <!-- Chapter -->
        <fo:page-sequence-master master-name="pmsPageSeqChapter">
        	<fo:repeatable-page-master-alternatives>
        		<fo:conditional-page-master-reference master-reference="pmsChapterLeft" 
                                                      odd-or-even="even"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsChapterRight" 
                                                      odd-or-even="odd" 
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsChapterBlank" 
                                                      odd-or-even="any"  
                                                      page-position="any"
                                                      blank-or-not-blank="blank"/>
        	</fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
    </xsl:template>
    
    <xsl:template name="genPsmGlossaryList">
        <!-- Glossary list -->
        <fo:page-sequence-master master-name="pmsPageSeqGlossaryList">
        	<fo:repeatable-page-master-alternatives>
        		<fo:conditional-page-master-reference master-reference="pmsGlossaryListLeft" 
                                                      odd-or-even="even"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsGlossaryListRight" 
                                                      odd-or-even="odd"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsGlossaryListBlank" 
                                                      odd-or-even="any"  
                                                      page-position="any"
                                                      blank-or-not-blank="blank"/>
        	</fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
    </xsl:template>
    
    <xsl:template name="genPsmIndex">
        <!-- Index -->
        <fo:page-sequence-master master-name="pmsPageSeqIndex">
        	<fo:repeatable-page-master-alternatives>
        		<fo:conditional-page-master-reference master-reference="pmsIndexLeft" 
                                                      odd-or-even="even"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsIndexRight" 
                                                      odd-or-even="odd"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsIndexBlank" 
                                                      odd-or-even="any"  
                                                      page-position="any"
                                                      blank-or-not-blank="blank"/>
        	</fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
    </xsl:template>
    
    <xsl:template name="genPsmBackmatter">
        <!-- Backmatter -->
        <fo:page-sequence-master master-name="pmsPageSeqBackmatter">
        	<fo:repeatable-page-master-alternatives>
        		<fo:conditional-page-master-reference master-reference="pmsBackmatterLeft" 
                                                      odd-or-even="even"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsBackmatterRight" 
                                                      odd-or-even="odd"  
                                                      page-position="any"
                                                      blank-or-not-blank="not-blank"/>
        		<fo:conditional-page-master-reference master-reference="pmsBackmatterBlank" 
                                                      odd-or-even="any"  
                                                      page-position="any"
                                                      blank-or-not-blank="blank"/>
        	</fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
    </xsl:template>

</xsl:stylesheet>
