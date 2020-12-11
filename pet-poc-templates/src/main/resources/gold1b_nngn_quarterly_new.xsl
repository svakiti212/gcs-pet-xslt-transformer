<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:import
            href="C:/Users/dxd316/Projects/gcs-pet-batch/pet-batch-bom/pet-channel-batch-common/src/main/resources/utils.xsl"/>

    <xsl:output method="xml" encoding="utf-8" indent="yes"/>

    <xsl:template name="gold1b_nngn_quarterly_new">
        <xsl:call-template name="func-gold-header">
            <xsl:with-param name="header-title" select="'EQUIFAX CREDIT WATCH GOLD NNGN'"/>
            <!--xsl:with-param name="header-title" select="resolve-uri('gold1b_nngn_quarterly_new.xsl')"/-->
            <!--xsl:with-param name="header-title" select="system-property('xsl:version')"/-->
            <xsl:with-param name="container-right-margin" select="'7pt'"/>
        </xsl:call-template>
        <fo:block-container margin-top="50pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                <xsl:call-template name="func-formatDate">
                    <xsl:with-param name="date" select="/printableCreditReport/creditReport/generatedDate"/>
                    <xsl:with-param name="mode" select="'mmm dd, yyyy'"/>
                </xsl:call-template>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="15pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                <xsl:text>No News is Good News</xsl:text>
            </fo:block>
            <fo:block xsl:use-attribute-sets="class-paragraph">
                <xsl:text>No key changes have been detected on your Equifax&#174; credit report this quarter.</xsl:text>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="5pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                <xsl:text>Dear </xsl:text>
                <xsl:value-of
                        select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName"/>
                <xsl:text>,
                        </xsl:text>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="10pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
            <xsl:text>Equifax Credit Watch&#8482; Gold monitors your Equifax&#174; credit report and alerts you to key changes that may be a sign of identity theft if you do not recognize this activity. Over the past quarter, we have not detected any key changes to your Equifax credit report. In this case, no news is good news! If key changes are reported, we will notify you via U.S. mail.
            </xsl:text>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="20pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
            <xsl:text>If you have any questions, please call your Equifax Global Consumer Solutions Customer Care Team at &lt;866-640-2273, 9am to 9pm ET Monday through Friday and 9am to 6pm ET Saturday and Sunday&gt; (hours subject to change). Or you may write us at Equifax Consumer Services LLC, &lt;PO Box 105496, Atlanta, GA 30348&gt;.
            </xsl:text>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="10pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                        <xsl:text>Sincerely,
                                  &#133;Your Equifax Customer Care Team
                        </xsl:text>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="10pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                            <xsl:text>Equifax&#174; is a registered trademark, and Equifax Credit Watch&#8482; Gold is a
                            trademark of Equifax
                            &#133;Inc. &#169;2020, Equifax Inc., Atlanta, Georgia. All rights reserved.
                            </xsl:text>
            </fo:block>
        </fo:block-container>
    </xsl:template>
</xsl:stylesheet>

