<xsl:template name="section-new-cover">
    <fo:block>
        <fo:block xsl:use-attribute-sets="class-h1">
            <xsl:call-template name="element-image-logo" />
        </fo:block>
        <fo:block>
            <xsl:text>Dear</xsl:text>
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
            <xsl:text>:</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <!--<xsl:text>Dear </xsl:text>
            <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
            <xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
            -->
        </fo:block>
        <fo:block xsl:use-attribute-sets="class-paragraph">Thank you for requesting your Equifax credit report. Your credit report contains information received primarily from companies which have granted you credit. Great care has been taken to report this information correctly. Please help us in achieving even greater accuracy by reviewing all of the enclosed material carefully.
        </fo:block>
        <fo:block xsl:use-attribute-sets="class-paragraph">If there are items you believe to be incorrect, you may

            <fo:list-block xsl:use-attribute-sets="list-format"  space-before="5pt">
                <fo:list-item padding-top="5pt">
                    <fo:list-item-label>
                        <fo:block font-weight="bold" margin-left="20px">&#x2022;</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block margin-left="25px">Initiate an investigation request via the Internet 24 hours a day, 7 days a week at:</fo:block>
                        <fo:block font-weight="bold" margin-left="45px">www.investigate.equifax.com</fo:block>
                        <xsl:text>&#xA;</xsl:text>
                    </fo:list-item-body>
                </fo:list-item>
                <fo:list-item padding-top="5pt">
                    <fo:list-item-label>
                        <fo:block font-weight="bold" margin-left="20px">&#x2022;</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block margin-left="25px">Please mail the dispute information to:</fo:block>
                        <fo:block font-weight="bold" margin-left="45px">Equifax Information Services LLC</fo:block>
                        <fo:block font-weight="bold" margin-left="45px">P.O. Box 740241</fo:block>
                        <fo:block font-weight="bold" margin-left="45px">Atlanta, GA 30374</fo:block>
                        <xsl:text>&#xA;</xsl:text>
                    </fo:list-item-body>
                </fo:list-item>
                <fo:list-item padding-top="5pt">
                    <fo:list-item-label>
                        <fo:block font-weight="bold" margin-left="20px">&#x2022;</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block margin-left="25px">Call us at <fo:inline font-weight="bold">866-349-5186</fo:inline></fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </fo:list-block>
        </fo:block>
        <fo:block xsl:use-attribute-sets="class-paragraph">
            Please note, when you provide documents, including a letter, to Equifax as part of your dispute, the documents may be submitted to one or more companies whose information are the subject of your dispute.
        </fo:block>
        <fo:block xsl:use-attribute-sets="class-paragraph">
            You have the right to request and obtain a copy of your credit score. To obtain a copy of your credit score, please call our automated ordering system at: <fo:inline font-weight="bold">1-877-SCORE-11.</fo:inline>
        </fo:block>
    </fo:block>

</xsl:template>