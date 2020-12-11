<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:import
            href="C:/Users/dxd316/Projects/gcs-pet-batch/pet-batch-bom/pet-channel-batch-common/src/main/resources/utils.xsl"/>

    <xsl:output method="xml" encoding="utf-8" indent="yes"/>

    <xsl:template name="gold1b_renewal_letter_new">
        <xsl:call-template name="func-gold-header">
            <xsl:with-param name="header-title" select="'EQUIFAX CREDIT WATCH GOLD RENEWAL LETTER'"/>
        </xsl:call-template>
        <fo:block-container margin-top="20pt">
            <fo:block xsl:use-attribute-sets="class-h2">
                <xsl:text>Thank You</xsl:text>
            </fo:block>
            <fo:block xsl:use-attribute-sets="class-paragraph">
                <xsl:call-template name="func-formatDate">
                    <xsl:with-param name="date" select="/printableCreditReport/creditReport/generatedDate"/>
                    <xsl:with-param name="mode" select="'mmm dd, yyyy'"/>
                </xsl:call-template>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="7pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                <xsl:text>Dear </xsl:text>
                <xsl:value-of
                        select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName"/>
                <xsl:text>:
                        </xsl:text>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="15pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                <xsl:text>Thank you for continuing your subscription to Equifax Credit Watch&#8482; Gold. Enclosed is an updated Equifax&#174; credit report included as part of your subscription.</xsl:text>
            </fo:block>
        </fo:block-container>
        <fo:block-container margin-top="15pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
                            <xsl:text>As a reminder, Equifax Credit Watch&#8482; Gold includes the following benefits:
                            </xsl:text>
            </fo:block>
            <fo:table xsl:use-attribute-sets="class-table">
                <fo:table-column column-width="7%"/>
                <fo:table-column column-width="93%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-h2" text-align="center">
                                •
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-paragraph">
                                <fo:inline font-weight="bold">Credit report monitoring with alerts
                                </fo:inline>
                                &#133;You’ll know if key changes occur to your Equifax credit report,
                                because we’ll be monitoring it and mailing you alerts.
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-h2" text-align="center">
                                •
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-paragraph">
                                <fo:inline font-weight="bold">“No news is good news” letter</fo:inline>
                                &#133;We will notify you if nothing has changed in your Equifax credit
                                report.
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-h2" text-align="center">
                                •
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-paragraph">
                                <fo:inline font-weight="bold">ID Restoration</fo:inline>
                                &#133;Help restore your identity with the help of dedicated specialists.
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-h2" text-align="center">
                                •
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block xsl:use-attribute-sets="class-paragraph">
                                <fo:inline font-weight="bold">Up to $1 MM of identity theft
                                    insurance&#185;
                                </fo:inline>
                                &#133;If you’re a victim of ID theft, we have your back.
                                We provide up to $1 million in coverage for certain out-of-pocket expenses
                                you may face as a result of having your identity stolen.
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block-container>
        <fo:block-container margin-top="30pt">
            <fo:block xsl:use-attribute-sets="class-paragraph">
            <xsl:text>Please thoroughly review your Equifax credit report. If you have any questions, please call your Equifax Global Consumer Solutions Customer Care Team at &lt;866-640-2273, 9am to 9pm ET Monday through Friday and 9am to 6pm ET Saturday and Sunday&gt; (hours subject to change). Or you may write us at Equifax Consumer Services LLC, &lt;PO Box 105496, Atlanta, GA 30348&gt;.
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
                            <xsl:text>&#185;The Identity Theft Insurance benefit is underwritten and administered by American Bankers Insurance Company of Florida, an Assurant company, under group or blanket policies issued to Equifax, Inc., or its respective affiliates for the benefit of its Members.
                                Please refer to the actual policies for terms, conditions, and exclusions of coverage.
                                Coverage may not be available in all jurisdictions.
                            </xsl:text>
            </fo:block>
        </fo:block-container>
    </xsl:template>
</xsl:stylesheet>