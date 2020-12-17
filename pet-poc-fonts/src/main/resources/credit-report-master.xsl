<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:pet="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" encoding="utf-8" indent="yes" />

	<xsl:variable name="reportConfirmation" select= "/printableCreditReport/properties/entry/key[text()= 'reportConfirmation']/../value" />
	<xsl:variable name="scoreEnabled" select="/printableCreditReport/properties/entry/key[text()='scoreEnabled']/../value" />
	<xsl:variable name="partnerId" select="/printableCreditReport/properties/entry/key[text()= 'partnerId']/../value" />
	<xsl:variable name="custId" select="/printableCreditReport/properties/entry/key[text()='custId']/../value"/>
	<xsl:variable name="printDelivery" select="/printableCreditReport/properties/entry/key[text()= 'printDelivery']/../value" />

	<xsl:variable name="colorOddRowBG" select="'#F9F9F9'" />
	<!-- LIGHT GRAY -->
	<xsl:variable name="colorEvenRowBG" select="'#FFFFFF'" />
	<!-- WHITE -->
	<xsl:template match="/">

		<xsl:call-template name="addCharacterEntities" />

		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>

				<fo:simple-page-master master-name="cover" page-height="11in" page-width="8.5in" margin-right="35pt" margin-left="35pt" margin-bottom="60pt" margin-top="35pt">
					<fo:region-body margin-top="300pt" />
				</fo:simple-page-master>

				<fo:simple-page-master master-name="normal" page-height="11in" page-width="8.5in" margin-right="35pt" margin-left="35pt" margin-bottom="60pt" margin-top="35pt">
					<fo:region-body margin-top="35pt" margin-bottom="60pt" />
					<fo:region-before extent="10pt" />
					<fo:region-after extent="10pt" />
				</fo:simple-page-master>
				<fo:simple-page-master master-name="ECHK-coverletter" page-height="11in" page-width="8.5in" margin-right="35pt" margin-left="0.875in" margin-bottom="30pt" margin-top="0.0486in">
					<fo:region-body margin-top="10pt" margin-bottom="30pt" />
					<fo:region-after extent="5pt" />
				</fo:simple-page-master>

				<fo:simple-page-master master-name="ECHK-report" page-height="11in" page-width="8.5in" margin-right="35pt" margin-left="35pt" margin-bottom="30pt" margin-top="20pt">
					<fo:region-body margin-top="20pt" margin-bottom="30pt" />
					<fo:region-before extent="8pt" />
					<fo:region-after extent="8pt" />
				</fo:simple-page-master>

			</fo:layout-master-set>
			<!--
			====================================
			COVER SHEET AND REPORT
			====================================
		  -->
			<xsl:choose>
				<xsl:when test="$partnerId='econocheck'">
					<xsl:if test="$printDelivery ='true'">
						<xsl:call-template name="section-ECHK-coverletter"/>
					</xsl:if>
					<xsl:call-template name="section-ECHK-report"/>
				</xsl:when>
				<xsl:when test="$partnerId='lifelock-A'">
					<xsl:call-template name="section-LL-coverletter"/>
					<xsl:call-template name="section-LL-report"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="section-FACTA-coverletter"/>
					<xsl:call-template name="section-FACTA-report"/>
				</xsl:otherwise>
			</xsl:choose>
		</fo:root>
	</xsl:template>


	<!--
		====================================
				FACTA COVER SHEET
		====================================
		-->
	<xsl:template name="section-FACTA-coverletter">
		<fo:page-sequence master-reference="cover">
			<fo:flow flow-name="xsl-region-body">
				<fo:block xsl:use-attribute-sets="class-h1">
					<xsl:call-template name="element-image-logo" />
				</fo:block>
				<fo:block xsl:use-attribute-sets="class-h1">
					<xsl:text>CREDIT REPORT</xsl:text>
				</fo:block>
				<xsl:call-template name="element-hr" />
				<fo:block xsl:use-attribute-sets="class-h2">
					<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
				</fo:block>
				<fo:block xsl:use-attribute-sets="class-h2-highlight">
					<xsl:text>Report Confirmation</xsl:text>
				</fo:block>
				<fo:block xsl:use-attribute-sets="class-h3">
					<xsl:value-of select="$reportConfirmation" />
				</fo:block>
				<fo:block xsl:use-attribute-sets="class-h2">
					<xsl:call-template name="func-formatDate">
						<xsl:with-param name="date" select="/printableCreditReport/creditReport/printableCreditReport" />
						<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
					</xsl:call-template>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<!--
		====================================
		ECONOCHECK COVER LETTER
		====================================
	-->
	<xsl:template name="section-ECHK-coverletter">
		<fo:page-sequence master-reference="ECHK-coverletter" force-page-count="no-force" >
			<!--
				============== COVER LETTER FOOTER ==============
				-->
			<fo:static-content flow-name="xsl-region-after">
				<fo:block text-align="center" xsl:use-attribute-sets="class-footer" linefeed-treatment="preserve">
					<xsl:text>Benefits Service Center&#xA;</xsl:text>
					<xsl:text>3 Gresham Landing, Stockbridge, GA  30281&#xA;</xsl:text>
					<xsl:text>1-877-610-7889</xsl:text>
				</fo:block>
			</fo:static-content>
			<!--
				============== COVER LETTER CONTENT ==============
				-->
			<fo:flow flow-name="xsl-region-body">

				<fo:block space-after="1em" text-align="right" xsl:use-attribute-sets="class-h4">
					<xsl:call-template name="func-formatDate">
						<xsl:with-param name="date" select="/printableCreditReport/creditReport/generatedDate" />
						<xsl:with-param name="mode" select="'mmmx dd, yyyy'" />
					</xsl:call-template>
				</fo:block>
				<fo:block-container position="absolute" top="0.2575in">
					<fo:block text-align="left" xsl:use-attribute-sets="class-h4" linefeed-treatment="preserve">
						<xsl:text>Equifax Consumer Services, Inc. &#xA;</xsl:text>
						<xsl:text>P.O. Box 31639 &#xA;</xsl:text>
						<xsl:text>Tampa, FL 33631-3639 &#xA;</xsl:text>
						<xsl:text> &#xA;</xsl:text>
					</fo:block>
				</fo:block-container>
				<fo:block-container position="absolute" top="1.90625in">
					<fo:block text-align="left" xsl:use-attribute-sets="class-h4" linefeed-treatment="preserve">
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
						<xsl:text>&#160;</xsl:text>
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
						<xsl:text>&#xA;</xsl:text>
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/line1" />
						<xsl:text>&#160;</xsl:text>
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/line2" />
						<xsl:text>&#xA;</xsl:text>
						<xsl:if test="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/line3 !=''">
							<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/line3" />
							<xsl:text>, &#160;</xsl:text>
						</xsl:if>
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/line4" />
						<xsl:text>&#160;</xsl:text>
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/line5" />
					</fo:block>
				</fo:block-container>
				<fo:block-container position="absolute" top="3.1in">
					<fo:block  text-align="left" xsl:use-attribute-sets="class-h4" linefeed-treatment="preserve">
						<xsl:text>Customer ID: &#160;</xsl:text>
						<xsl:value-of select="$custId" />
					</fo:block>
					<fo:block space-after="2em" text-align="left" xsl:use-attribute-sets="class-subhead" linefeed-treatment="preserve">
						<xsl:text>One Bureau Credit Report&#xA;</xsl:text>
					</fo:block>
					<fo:block space-after="1em" text-align="left" xsl:use-attribute-sets="class-h4" linefeed-treatment="preserve">
						<xsl:text>Dear</xsl:text>
						<xsl:text>&#160;</xsl:text>
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
						<xsl:text>&#160;</xsl:text>
						<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
						<xsl:text>,</xsl:text>
						<xsl:text>&#xA;</xsl:text>
					</fo:block>
					<fo:block space-after="1em" xsl:use-attribute-sets="class-paragraph" text-align="justify">
						<xsl:text>You recently requested your credit report, which is made available through your identity theft program with your financial institution.  A confidential copy is enclosed.</xsl:text>
					</fo:block>
					<fo:block space-after="1em" xsl:use-attribute-sets="class-paragraph" text-align="justify">
						<xsl:text>Please review your credit report to be sure it contains accurate information.  If you do not recognize creditors or inquiries against your credit file, it could indicate a potential for identity theft.</xsl:text>
					</fo:block>
					<fo:block space-after="1em" xsl:use-attribute-sets="class-paragraph" text-align="justify">
						<xsl:text> If you feel information in your credit file could be fraudulent, please contact the appropriate credit bureau using the contact information below.</xsl:text>
					</fo:block>
					<fo:block space-before="1em" space-after="2em">
						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="33.3%"/>
							<fo:table-column column-width="33.3%"/>
							<fo:table-column column-width="33.3%"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-footer" linefeed-treatment="preserve">
											<xsl:text>Equifax &#xA;</xsl:text>
											<xsl:text>P.O. Box 740256 &#xA;</xsl:text>
											<xsl:text>Atlanta, GA 30374 &#xA;</xsl:text>
											<xsl:text>1-866-349-5191 &#xA;</xsl:text>
											<xsl:text>https://www.ai.equifax.com </xsl:text>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
					<fo:block space-after="1em" xsl:use-attribute-sets="class-paragraph" text-align="justify">
						<xsl:text>Should you have general questions related to your identity theft protection program, please call 1-877-610-7889, Monday – Friday, 8:30 a.m. – 5:00 p.m. EST.</xsl:text>
					</fo:block>
					<!-- <fo:block space-after="3em" xsl:use-attribute-sets="class-paragraph" text-align="justify">
						<xsl:text>Protecting your identity is our number one priority.&#xA;</xsl:text>
					</fo:block> -->
					<fo:block space-after="1em" text-align="left" xsl:use-attribute-sets="class-paragraph">
						<xsl:text>Sincerely,</xsl:text>
					</fo:block>
					<fo:block text-align="left" xsl:use-attribute-sets="class-h4">
						<xsl:text>Benefits Service Center</xsl:text>
					</fo:block>
				</fo:block-container>
			</fo:flow>
		</fo:page-sequence>
		<fo:page-sequence master-reference="ECHK-coverletter" force-page-count="no-force" >

			<!--
				============== blank page ==============
				-->
			<fo:flow flow-name="xsl-region-body">
				<fo:block text-align="center" xsl:use-attribute-sets="class-h2">

				</fo:block>

			</fo:flow>
		</fo:page-sequence>
	</xsl:template>


	<!--
		====================================
				LL COVER SHEET
		====================================
	 -->
	<xsl:template name="section-LL-coverletter">

	</xsl:template>
	<!--
		====================================
				FACTA CREDIT REPORT
		====================================
	 -->
	<xsl:template name="section-FACTA-report">
		<fo:page-sequence master-reference="normal" initial-page-number="2">

			<!--
					============== HEADER ==============
				-->
			<fo:static-content flow-name="xsl-region-before">
				<fo:block xsl:use-attribute-sets="class-header">
				</fo:block>
			</fo:static-content>

			<!--
					============== FOOTER ==============
				-->
			<fo:static-content flow-name="xsl-region-after">
				<fo:block xsl:use-attribute-sets="class-footer">

					<fo:table>
						<fo:table-column column-width="34%" />
						<fo:table-column column-width="33%" />
						<fo:table-column column-width="33%" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block text-align="left">
										<xsl:call-template name="element-image-logo">
											<xsl:with-param name="width" select="'0.52in'" />
											<xsl:with-param name="height" select="'0.10in'" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-align="center">
										<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
										<xsl:text> </xsl:text>
										<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
										<xsl:text>&#160;|&#160;</xsl:text>
										<xsl:call-template name="func-formatDate">
											<xsl:with-param name="date" select="/printableCreditReport/creditReport/generatedDate" />
											<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-align="right">
										<xsl:text>Page </xsl:text>
										<fo:page-number />
										<xsl:text> of </xsl:text>
										<fo:page-number-citation ref-id="TheVeryLastPage" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>

					<fo:block text-align="right">
						<fo:retrieve-marker retrieve-class-name="footer" />
					</fo:block>

				</fo:block>
			</fo:static-content>

			<!--
					============== CREDIT REPORT SECTIONS ==============
				-->
			<fo:flow flow-name="xsl-region-body">
				<xsl:call-template name="section-new-cover" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-reportSummary" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-revolvingAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-mortgageAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-installmentAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-otherAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-consumerStatements" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-personalInfo" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-inquiries" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-publicRecords" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-collections" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-disputeInfo" />
				<fo:block page-break-before="always"/>
				<xsl:call-template name="section-summaryOfRights"/>
				<!--	<xsl:call-template name="section-remedyingIdentityTheft"/> -->
				<xsl:call-template name="section-statesRights"/>
				<fo:block id="TheVeryLastPage" />
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<!--
		====================================
				ECONOCHECK CREDIT REPORT
		====================================
		-->
	<xsl:template name="section-ECHK-report">
		<fo:page-sequence master-reference="ECHK-report" initial-page-number="1">

			<!--
					============== HEADER ==============
				-->
			<fo:static-content flow-name="xsl-region-before">
				<fo:block xsl:use-attribute-sets="class-header">
				</fo:block>
			</fo:static-content>

			<!--
					============== FOOTER ==============
				-->
			<fo:static-content flow-name="xsl-region-after">
				<fo:block xsl:use-attribute-sets="class-footer">
					<fo:block text-align="right">
						<fo:retrieve-marker retrieve-class-name="footer" />
					</fo:block>
					<fo:block>
						<fo:table width="100%">
							<fo:table-column column-width="80%" />
							<fo:table-column column-width="20%" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="left">
											<xsl:text>&#160;</xsl:text>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="/printableCreditReport/creditReport/generatedDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
											<xsl:text>&#160;</xsl:text>
											<fo:inline font-size="8">One Bureau Credit Report</fo:inline>
											<xsl:text>&#160;</xsl:text>
											<fo:inline font-size="6" font-style="italic">Powered by Equifax</fo:inline>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="right">
											<xsl:text>Page </xsl:text>
											<fo:page-number />
											<xsl:text> of </xsl:text>
											<fo:page-number-citation ref-id="TheVeryLastPage" />
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</fo:block>
			</fo:static-content>

			<!--
					============== CREDIT REPORT SECTIONS ==============
				-->
			<fo:flow flow-name="xsl-region-body">
				<xsl:call-template name="section-reportSummary" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-revolvingAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-mortgageAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-installmentAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-otherAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-consumerStatements" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-personalInfo" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-inquiries" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-publicRecords" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-collections" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-disputeInfo" />
				<fo:block id="TheVeryLastPage" />
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	<!--
		====================================
				LIFELOCK CREDIT REPORT
		====================================
		-->
	<xsl:template name="section-LL-report">
		<fo:page-sequence master-reference="normal" initial-page-number="1">

			<!--
          ============== HEADER ==============
        -->
			<fo:static-content flow-name="xsl-region-before">
				<fo:block xsl:use-attribute-sets="class-header">
				</fo:block>
			</fo:static-content>

			<!--
          ============== FOOTER ==============
         -->
			<fo:static-content flow-name="xsl-region-after">
				<fo:block xsl:use-attribute-sets="class-footer">
					<fo:table width="100%">
						<fo:table-column column-width="34%" />
						<fo:table-column column-width="33%" />
						<fo:table-column column-width="33%" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block text-align="left">
										<xsl:call-template name="element-image-logo">
											<xsl:with-param name="width" select="'0.52in'" />
											<xsl:with-param name="height" select="'0.10in'" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-align="center">
										<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
										<xsl:text>, </xsl:text>
										<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
										<xsl:text>&#160;|&#160;</xsl:text>
										<xsl:call-template name="func-formatDate">
											<xsl:with-param name="date" select="/printableCreditReport/creditReport/generatedDate" />
											<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-align="right">
										<xsl:text>Page </xsl:text>
										<fo:page-number />
										<xsl:text> of </xsl:text>
										<fo:page-number-citation ref-id="TheVeryLastPage" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>

					<fo:block text-align="right">
						<fo:retrieve-marker retrieve-class-name="footer" />
					</fo:block>

				</fo:block>
			</fo:static-content>

			<!--
				============== CREDIT REPORT SECTIONS ==============
			-->
			<fo:flow flow-name="xsl-region-body">
				<xsl:call-template name="section-reportSummary" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-revolvingAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-mortgageAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-installmentAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-otherAccounts" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-consumerStatements" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-personalInfo" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-inquiries" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-publicRecords" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-collections" />
				<fo:block page-break-before="always" />
				<xsl:call-template name="section-disputeInfo" />
				<fo:block id="TheVeryLastPage" />
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>

	<xsl:template name="addCharacterEntities">
		<xsl:text disable-output-escaping="yes">
&lt;!DOCTYPE fo:root [
  &lt;!ENTITY tilde  "&amp;#126;"&gt;
  &lt;!ENTITY florin "&amp;#131;"&gt;
  &lt;!ENTITY elip   "&amp;#133;"&gt;
  &lt;!ENTITY dag    "&amp;#134;"&gt;
  &lt;!ENTITY ddag   "&amp;#135;"&gt;
  &lt;!ENTITY cflex  "&amp;#136;"&gt;
  &lt;!ENTITY permil "&amp;#137;"&gt;
  &lt;!ENTITY uscore "&amp;#138;"&gt;
  &lt;!ENTITY OElig  "&amp;#140;"&gt;
  &lt;!ENTITY lsquo  "&amp;#145;"&gt;
  &lt;!ENTITY rsquo  "&amp;#146;"&gt;
  &lt;!ENTITY ldquo  "&amp;#147;"&gt;
  &lt;!ENTITY rdquo  "&amp;#148;"&gt;
  &lt;!ENTITY bullet "&amp;#149;"&gt;
  &lt;!ENTITY endash "&amp;#150;"&gt;
  &lt;!ENTITY emdash "&amp;#151;"&gt;
  &lt;!ENTITY trade  "&amp;#153;"&gt;
  &lt;!ENTITY oelig  "&amp;#156;"&gt;
  &lt;!ENTITY Yuml   "&amp;#159;"&gt;
  &lt;!ENTITY nbsp   "&amp;#160;"&gt;
  &lt;!ENTITY iexcl  "&amp;#161;"&gt;
  &lt;!ENTITY cent   "&amp;#162;"&gt;
  &lt;!ENTITY pound  "&amp;#163;"&gt;
  &lt;!ENTITY curren "&amp;#164;"&gt;
  &lt;!ENTITY yen    "&amp;#165;"&gt;
  &lt;!ENTITY brvbar "&amp;#166;"&gt;
  &lt;!ENTITY sect   "&amp;#167;"&gt;
  &lt;!ENTITY uml    "&amp;#168;"&gt;
  &lt;!ENTITY copy   "&amp;#169;"&gt;
  &lt;!ENTITY ordf   "&amp;#170;"&gt;
  &lt;!ENTITY laquo  "&amp;#171;"&gt;
  &lt;!ENTITY not    "&amp;#172;"&gt;
  &lt;!ENTITY shy    "&amp;#173;"&gt;
  &lt;!ENTITY reg    "&amp;#174;"&gt;
  &lt;!ENTITY macr   "&amp;#175;"&gt;
  &lt;!ENTITY deg    "&amp;#176;"&gt;
  &lt;!ENTITY plusmn "&amp;#177;"&gt;
  &lt;!ENTITY sup2   "&amp;#178;"&gt;
  &lt;!ENTITY sup3   "&amp;#179;"&gt;
  &lt;!ENTITY acute  "&amp;#180;"&gt;
  &lt;!ENTITY micro  "&amp;#181;"&gt;
  &lt;!ENTITY para   "&amp;#182;"&gt;
  &lt;!ENTITY middot "&amp;#183;"&gt;
  &lt;!ENTITY cedil  "&amp;#184;"&gt;
  &lt;!ENTITY sup1   "&amp;#185;"&gt;
  &lt;!ENTITY ordm   "&amp;#186;"&gt;
  &lt;!ENTITY raquo  "&amp;#187;"&gt;
  &lt;!ENTITY frac14 "&amp;#188;"&gt;
  &lt;!ENTITY frac12 "&amp;#189;"&gt;
  &lt;!ENTITY frac34 "&amp;#190;"&gt;
  &lt;!ENTITY iquest "&amp;#191;"&gt;
  &lt;!ENTITY Agrave "&amp;#192;"&gt;
  &lt;!ENTITY Aacute "&amp;#193;"&gt;
  &lt;!ENTITY Acirc  "&amp;#194;"&gt;
  &lt;!ENTITY Atilde "&amp;#195;"&gt;
  &lt;!ENTITY Auml   "&amp;#196;"&gt;
  &lt;!ENTITY Aring  "&amp;#197;"&gt;
  &lt;!ENTITY AElig  "&amp;#198;"&gt;
  &lt;!ENTITY Ccedil "&amp;#199;"&gt;
  &lt;!ENTITY Egrave "&amp;#200;"&gt;
  &lt;!ENTITY Eacute "&amp;#201;"&gt;
  &lt;!ENTITY Ecirc  "&amp;#202;"&gt;
  &lt;!ENTITY Euml   "&amp;#203;"&gt;
  &lt;!ENTITY Igrave "&amp;#204;"&gt;
  &lt;!ENTITY Iacute "&amp;#205;"&gt;
  &lt;!ENTITY Icirc  "&amp;#206;"&gt;
  &lt;!ENTITY Iuml   "&amp;#207;"&gt;
  &lt;!ENTITY ETH    "&amp;#208;"&gt;
  &lt;!ENTITY Ntilde "&amp;#209;"&gt;
  &lt;!ENTITY Ograve "&amp;#210;"&gt;
  &lt;!ENTITY Oacute "&amp;#211;"&gt;
  &lt;!ENTITY Ocirc  "&amp;#212;"&gt;
  &lt;!ENTITY Otilde "&amp;#213;"&gt;
  &lt;!ENTITY Ouml   "&amp;#214;"&gt;
  &lt;!ENTITY times  "&amp;#215;"&gt;
  &lt;!ENTITY Oslash "&amp;#216;"&gt;
  &lt;!ENTITY Ugrave "&amp;#217;"&gt;
  &lt;!ENTITY Uacute "&amp;#218;"&gt;
  &lt;!ENTITY Ucirc  "&amp;#219;"&gt;
  &lt;!ENTITY Uuml   "&amp;#220;"&gt;
  &lt;!ENTITY Yacute "&amp;#221;"&gt;
  &lt;!ENTITY THORN  "&amp;#222;"&gt;
  &lt;!ENTITY szlig  "&amp;#223;"&gt;
  &lt;!ENTITY agrave "&amp;#224;"&gt;
  &lt;!ENTITY aacute "&amp;#225;"&gt;
  &lt;!ENTITY acirc  "&amp;#226;"&gt;
  &lt;!ENTITY atilde "&amp;#227;"&gt;
  &lt;!ENTITY auml   "&amp;#228;"&gt;
  &lt;!ENTITY aring  "&amp;#229;"&gt;
  &lt;!ENTITY aelig  "&amp;#230;"&gt;
  &lt;!ENTITY ccedil "&amp;#231;"&gt;
  &lt;!ENTITY egrave "&amp;#232;"&gt;
  &lt;!ENTITY eacute "&amp;#233;"&gt;
  &lt;!ENTITY ecirc  "&amp;#234;"&gt;
  &lt;!ENTITY euml   "&amp;#235;"&gt;
  &lt;!ENTITY igrave "&amp;#236;"&gt;
  &lt;!ENTITY iacute "&amp;#237;"&gt;
  &lt;!ENTITY icirc  "&amp;#238;"&gt;
  &lt;!ENTITY iuml   "&amp;#239;"&gt;
  &lt;!ENTITY eth    "&amp;#240;"&gt;
  &lt;!ENTITY ntilde "&amp;#241;"&gt;
  &lt;!ENTITY ograve "&amp;#242;"&gt;
  &lt;!ENTITY oacute "&amp;#243;"&gt;
  &lt;!ENTITY ocirc  "&amp;#244;"&gt;
  &lt;!ENTITY otilde "&amp;#245;"&gt;
  &lt;!ENTITY ouml   "&amp;#246;"&gt;
  &lt;!ENTITY oslash "&amp;#248;"&gt;
  &lt;!ENTITY ugrave "&amp;#249;"&gt;
  &lt;!ENTITY uacute "&amp;#250;"&gt;
  &lt;!ENTITY ucirc  "&amp;#251;"&gt;
  &lt;!ENTITY uuml   "&amp;#252;"&gt;
  &lt;!ENTITY yacute "&amp;#253;"&gt;
  &lt;!ENTITY thorn  "&amp;#254;"&gt;
  &lt;!ENTITY yuml   "&amp;#255;"&gt;
  &lt;!ENTITY euro   "&amp;#x20AC;"&gt;
]&gt;
		</xsl:text>
	</xsl:template>

	<pet:full-import href="fragment/report-summary.xsl" ignore-namespaces="true"/>

	<xsl:template name="section-creditScore">
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Credit Score</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Your credit score and rating are not part of your credit report, but are derived from the information in your file.</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<fo:table xsl:use-attribute-sets="class-table">
					<fo:table-column column-width="40%" />
					<fo:table-column column-width="60%" />
					<fo:table-body>
						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									Credit Score
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="/printableCreditReport/creditReport/providerViews/summary/creditScore/score" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									Score Rating
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:for-each select="/printableCreditReport/creditReport/providerViews/summary/creditScore/scoreRanges">
										<xsl:if test="/printableCreditReport/creditReport/providerViews/summary/creditScore/score &lt;= high and /printableCreditReport/creditReport/providerViews/summary/creditScore/score &gt;= low ">
											<xsl:value-of select="name" />
										</xsl:if>
									</xsl:for-each>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>

				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:text>The Equifax Credit Score is based on a VantageScore model and is not the same as scores used by third parties to assess your creditworthiness.¹</xsl:text>
				</fo:block>

				<fo:table xsl:use-attribute-sets="class-table" border-top="solid 0.1mm black">
					<fo:table-column column-width="50%" />
					<fo:table-column column-width="50%" />
					<fo:table-body>
						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-h4-state">
									<xsl:text>Positive Factors</xsl:text>
								</fo:block>
								<fo:block>
									<xsl:for-each select="/printableCreditReport/creditReport/providerViews/summary/creditScore/scoreReasons">
										<xsl:if test="creditScoreFactorEffect='HELPING'">
											<fo:block xsl:use-attribute-sets="class-paragraph">
												<xsl:variable name="incr" select="position()"/>
												<xsl:call-template name="facta-positive-plus" />
												<xsl:value-of select="description" />
											</fo:block>
										</xsl:if>
									</xsl:for-each>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-h4-state">
									<xsl:text>Negative Factors</xsl:text>
								</fo:block>
								<fo:block>
									<xsl:for-each select="/printableCreditReport/creditReport/providerViews/summary/creditScore/scoreReasons">
										<xsl:if test="creditScoreFactorEffect='HURTING'">
											<fo:block xsl:use-attribute-sets="class-paragraph">
												<xsl:variable name="incr" select="position()" />
												<xsl:call-template name="facta-negative-minus" />
												<xsl:value-of select="description" />
											</fo:block>
										</xsl:if>
									</xsl:for-each>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>

				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:text>¹ The VantageScore provided under the offer described here uses a proprietary credit model designed by VantageScore Solutions, LLC. There are numerous other credit scores and models in the marketplace, including different VantageScores. Please keep in mind third parties may use a different credit score when evaluating your creditworthiness. Also, third parties will take into consideration items other than your credit score or information found in your credit file, such as your income.</xsl:text>
				</fo:block>

			</fo:block>
		</fo:block>

	</xsl:template>

    <pet:full-import href="fragment/cover.xsl"/>

	<xsl:template name="func-reportSummary-itemFormat">
		<xsl:param name="node"/>
		<xsl:param name="accountType"/>
		<xsl:param name="bgColor" />
		<xsl:choose>
			<xsl:when test="$node/totalAccounts = '0' and $node/totalAccountsWithBalance = '0'">
				<xsl:call-template name="section-reportSummary-creditAccount-item">
					<xsl:with-param name="boolean" select="'1'"/>
					<xsl:with-param name="node" select="$node"/>
					<xsl:with-param name="accountType" select="$accountType"/>
					<xsl:with-param name="bgColor" select="$bgColor"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise >
				<xsl:call-template name="section-reportSummary-creditAccount-item">
					<xsl:with-param name="boolean" select="'0'"/>
					<xsl:with-param name="node" select="$node"/>
					<xsl:with-param name="accountType" select="$accountType"/>
					<xsl:with-param name="bgColor" select="$bgColor"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-reportSummary-creditAccount-item">
		<xsl:param name="node" />
		<xsl:param name="bgColor" />
		<xsl:param name="accountType" />
		<xsl:param name="boolean"/>

		<fo:table-row>
			<xsl:attribute name="background-color">
				<xsl:value-of select="$bgColor" />
			</xsl:attribute>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:value-of select="$accountType" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:choose>
						<xsl:when test="not($node/totalAccounts) or string($node/totalAccounts) = 'NaN'">
							<xsl:text/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$node/totalAccounts" />
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:choose>
						<xsl:when test="not($node/totalAccountsWithBalance) or string($node/totalAccountsWithBalance) = 'NaN'">
							<xsl:text/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$node/totalAccountsWithBalance" />
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:call-template name="func-formatReportSummary">
						<xsl:with-param name="amount" select="$node/balance" />
						<xsl:with-param name="boolean" select="$boolean"/>
					</xsl:call-template>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:call-template name="func-formatReportSummary">
						<xsl:with-param name="amount" select="$node/available" />
						<xsl:with-param name="boolean" select="$boolean"/>
					</xsl:call-template>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:call-template name="func-formatReportSummary">
						<xsl:with-param name="amount" select="$node/creditLimit" />
						<xsl:with-param name="boolean" select="$boolean"/>
					</xsl:call-template>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:call-template name="func-formatReportSummaryD2CRatio">
						<xsl:with-param name="ratioAmount" select="$node/debtToCreditRatio" />
						<xsl:with-param name="boolean" select="$boolean"/>
					</xsl:call-template>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block xsl:use-attribute-sets="class-cell">
					<xsl:call-template name="func-formatReportSummary">
						<xsl:with-param name="amount" select="$node/monthlyPaymentAmount" />
						<xsl:with-param name="boolean" select="$boolean"/>
					</xsl:call-template>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>

	</xsl:template>

	<xsl:template name="func-formatReportSummary">
		<xsl:param name="amount" />
		<xsl:param name="boolean"/>
		<xsl:choose>
			<xsl:when test="$boolean = '1' or not($amount) or not($amount/amount) or $amount/currency != 'USD' or string($amount/amount) = 'NaN' ">
				<xsl:text/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($amount/amount,'$#,##0')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-formatReportSummaryD2CRatio">
		<xsl:param name="ratioAmount"/>
		<xsl:param name="boolean"/>
		<xsl:choose>
			<xsl:when test=" $boolean = '1' or not($ratioAmount) or string($ratioAmount) = 'NaN' ">
				<xsl:text/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ratioAmount,'%')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-revolvingAccounts">

		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>2. Revolving Accounts</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>Revolving accounts are those that generally include a credit limit and require a minimum monthly payment, such as credit cards.</xsl:text>
		</fo:block>

		<xsl:choose>
			<xsl:when test="not(/printableCreditReport/creditReport/providerViews/revolvingAccounts)">
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:call-template name="func-no-item">
						<xsl:with-param name="item">Revolving Accounts</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="section-tradeLines">
					<xsl:with-param name="tradeLineSet" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/revolvingAccounts" />
					<xsl:with-param name="prefix" select="'2.'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-mortgageAccounts">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>3. Mortgage Accounts</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>Mortgage accounts are real estate loans that require payment on a monthly basis until the loan is paid off.</xsl:text>
		</fo:block>

		<xsl:choose>
			<xsl:when test="not(/printableCreditReport/creditReport/providerViews/mortgageAccounts)">
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:call-template name="func-no-item">
						<xsl:with-param name="item">Mortgage Accounts</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="section-tradeLines">
					<xsl:with-param name="tradeLineSet" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/mortgageAccounts" />
					<xsl:with-param name="prefix" select="'3.'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-installmentAccounts">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>4. Installment Accounts</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>Installment accounts are loans that require payment on a monthly basis until the loan is paid off, such as auto or student loans.</xsl:text>
		</fo:block>

		<xsl:choose>
			<xsl:when test="not(/printableCreditReport/creditReport/providerViews/installmentAccounts)">
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:call-template name="func-no-item">
						<xsl:with-param name="item">Installment Accounts</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="section-tradeLines">
					<xsl:with-param name="tradeLineSet" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/installmentAccounts" />
					<xsl:with-param name="prefix" select="'4.'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-otherAccounts">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>5. Other Accounts</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>Other accounts are those that are not already identified as Revolving, Mortgage or Installment Accounts such as child support obligations or rental agreements.</xsl:text>
		</fo:block>

		<xsl:choose>
			<xsl:when test="not(/printableCreditReport/creditReport/providerViews/otherAccounts)">
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:call-template name="func-no-item">
						<xsl:with-param name="item">Other Accounts</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="section-tradeLines">
					<xsl:with-param name="tradeLineSet" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/otherAccounts" />
					<xsl:with-param name="prefix" select="'5.'"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-consumerStatements">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>6. Consumer Statements</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>Consumer Statements are explanations of up to 100 words you can attach to your credit file to provide more information on an item you may disagree with or would like to provide details on. Consumer statements are voluntary and have no impact on your credit score.</xsl:text>
		</fo:block>

		<xsl:choose>
			<xsl:when test="not(/printableCreditReport/creditReport/providerViews/consumerStatements)">
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:call-template name="func-no-item">
						<xsl:with-param name="item">Consumer Statements</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<fo:table xsl:use-attribute-sets="class-table">
					<fo:table-column column-width="1.25in" />
					<fo:table-column column-width="5in" />
					<fo:table-column column-width="1.25in" />
					<fo:table-body>
						<fo:table-row xsl:use-attribute-sets="class-row-header">
							<fo:table-cell>
								<fo:block>
									<xsl:text>Date</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:text>Statement</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:text>Removal Date</xsl:text>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:for-each select="/printableCreditReport/creditReport/providerViews/consumerStatements">
							<fo:table-row font-size="8pt">
								<xsl:attribute name="background-color">
									<xsl:choose>
										<xsl:when test="(position() mod 2) != 1">
											<xsl:value-of select="$colorEvenRowBG" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$colorOddRowBG" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:call-template name="func-formatDate">
											<xsl:with-param name="date" select="reportedDate" />
											<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:value-of select="statement" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:choose>
											<xsl:when test="not(purgeDate) or string(purgeDate) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="purgeDate" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-personalInfo">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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
'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>7. Personal Information</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>Creditors use your personal information primarily to identify you. This information has no impact on your credit score.</xsl:text>
		</fo:block>

		<!-- IDENTIFICATION -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Identification</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Identification is the information in your credit file that indicates your current identification as reported to Equifax. It does not affect your credit score or rating.</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<fo:table xsl:use-attribute-sets="class-table">
					<fo:table-column column-width="40%" />
					<fo:table-column column-width="60%" />
					<fo:table-body>
						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Name</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/firstName" />
									<xsl:text>&#160;</xsl:text>
									<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/middleName" />
									<xsl:text>&#160;</xsl:text>
									<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/lastName" />
									<xsl:text>&#160;</xsl:text>
									<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentName/suffix" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Formerly known as</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/aliases">
										<fo:block>
											<xsl:value-of select="firstName" />
											<xsl:text>&#160;</xsl:text>
											<xsl:value-of select="middleName" />
											<xsl:text>&#160;</xsl:text>
											<xsl:value-of select="lastName" />
											<xsl:text>&#160;</xsl:text>
											<xsl:value-of select="suffix" />
										</fo:block>
									</xsl:for-each>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Social Security Number</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/nationalIdentifier" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Age or Date of Birth</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(/printableCreditReport/creditReport/providerViews/summary/subject/dateOfBirth) or string(/printableCreditReport/creditReport/providerViews/summary/subject/dateOfBirth) = 'NaN'">
											<xsl:value-of select="concat(/printableCreditReport/creditReport/providerViews/summary/subject/age,' yrs old')" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/dateOfBirth" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:choose>
							<xsl:when test="not(/printableCreditReport/creditReport/providerViews/summary/subject/dateOfDeath) or string(/printableCreditReport/creditReport/providerViews/summary/subject/dateOfDeath) = 'NaN'">

							</xsl:when>
							<xsl:otherwise>
								<fo:table-row xsl:use-attribute-sets="class-row-odd">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Date of Death</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/dateOfDeath" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:otherwise>
						</xsl:choose>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</fo:block>

		<!--OTHER IDENTIFICATION -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Other Identification</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text/>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:choose>
					<xsl:when test="(count(/printableCreditReport/creditReport/providerViews/summary/subject/otherIdentifications) &gt; 0)">
						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="1.875in" />
							<fo:table-column column-width="1.875in" />
							<fo:table-column column-width="1.875in" />
							<fo:table-column column-width="1.875in" />
							<fo:table-body>
								<fo:table-row xsl:use-attribute-sets="class-row-header">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Date Reported</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Type Code</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Identification Number</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Reason</xsl:text>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:for-each select="/printableCreditReport/creditReport/providerViews/summary/subject/otherIdentifications">
									<fo:table-row>
										<xsl:attribute name="background-color">
											<xsl:choose>
												<xsl:when test="(position() mod 2) != 1">
													<xsl:value-of select="$colorEvenRowBG" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$colorOddRowBG" />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(dateReported) and (dateReported!='')">
													<xsl:call-template name="func-formatDate">
														<xsl:with-param name="date" select="dateReported" />
														<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
													</xsl:call-template>
												</xsl:if>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(type/description) and (type/description!='')">
													<xsl:value-of select="type/description" />
												</xsl:if>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(idNumber) and (idNumber!='')">
													<xsl:value-of select="idNumber" />
												</xsl:if>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(reason/description) and (reason/description!='')">
													<xsl:value-of select="reason/description" />
												</xsl:if>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</xsl:when>
					<xsl:otherwise>
						<fo:block xsl:use-attribute-sets="class-paragraph">
							<xsl:call-template name="func-no-item">
								<xsl:with-param name="item">Other Identifications</xsl:with-param>
							</xsl:call-template>
						</fo:block>
					</xsl:otherwise>
				</xsl:choose>
			</fo:block>
		</fo:block>


		<!-- ALERT CONTACT INFORMATION -->
		<fo:block xsl:use-attribute-sets="class-h2">
			<xsl:text>Alert Contact Information</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text/>
		</fo:block>
		<xsl:choose>
			<xsl:when test="(count(/printableCreditReport/creditReport/providerViews/summary/subject/alertContacts) &gt; 0)">
				<xsl:for-each select="/printableCreditReport/creditReport/providerViews/summary/subject/alertContacts">
					<fo:block xsl:use-attribute-sets="class-h4">
						<xsl:text>Alert Contact #</xsl:text>
						<xsl:value-of select="position()" />
					</fo:block>
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="1.75in" />
							<fo:table-column column-width="1.75in" />
							<fo:table-column column-width="0.5in" />
							<fo:table-column column-width="1.75in" />
							<fo:table-column column-width="1.75in" />
							<fo:table-body>
								<fo:table-row xsl:use-attribute-sets="class-row-odd">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Date Reported</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:if test="(dateReported) and (dateReported!='')">
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="dateReported" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:if>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>&#160;</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Phone: </xsl:text>
											<xsl:if test="(count(contactPhones) &gt; 0) and (contactPhones[1]/phoneType) and (contactPhones[1]/phoneType!='')">
												<xsl:value-of select="contactPhones[1]/phoneType" />
											</xsl:if>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:if test="(count(contactPhones) &gt; 0) and (contactPhones[1]/*)">
												<xsl:call-template name="func-formatPhone">
													<xsl:with-param name="phone" select="contactPhones[1]" />
												</xsl:call-template>
											</xsl:if>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- begin row -->
								<fo:table-row xsl:use-attribute-sets="class-row-even">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Expiration Date</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:if test="(expirationDate) and (expirationDate!='')">
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="expirationDate" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:if>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>&#160;</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Phone: </xsl:text>
											<xsl:if test="(count(contactPhones) &gt; 1) and (contactPhones[2]/phoneType) and (contactPhones[2]/phoneType!='')">
												<xsl:value-of select="contactPhones[2]/phoneType" />
											</xsl:if>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:if test="(count(contactPhones) &gt; 1) and (contactPhones[2]/*)">
												<xsl:call-template name="func-formatPhone">
													<xsl:with-param name="phone" select="contactPhones[2]" />
												</xsl:call-template>
											</xsl:if>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- begin row -->
								<fo:table-row xsl:use-attribute-sets="class-row-odd">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Address</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:if test="(address/*)">
												<xsl:call-template name="func-formatAddress">
													<xsl:with-param name="address" select="address" />
												</xsl:call-template>
											</xsl:if>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>&#160;</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Phone: </xsl:text>
											<xsl:if test="(count(contactPhones) &gt; 2) and (contactPhones[3]/phoneType) and (contactPhones[3]/phoneType!='')">
												<xsl:value-of select="contactPhones[3]/phoneType" />
											</xsl:if>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:if test="(count(contactPhones) &gt; 2) and (contactPhones[3]/*)">
												<xsl:call-template name="func-formatPhone">
													<xsl:with-param name="phone" select="contactPhones[3]" />
												</xsl:call-template>
											</xsl:if>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<!-- begin row -->
								<fo:table-row xsl:use-attribute-sets="class-row-even">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-label class-cell">
											<xsl:text>Comments</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
											<xsl:if test="(additionalInformation) and (additionalInformation!='')">
												<xsl:value-of select="additionalInformation" />
											</xsl:if>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>&#160;</xsl:text>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:call-template name="func-no-item">
						<xsl:with-param name="item">Alert Contacts</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>

		<!-- CONTACT INFORMATION -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Contact Information</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Contact information is the information in your credit file that indicates your former and current addresses as reported to Equifax. It does not affect your credit score or rating.</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:choose>
					<xsl:when test="not(/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/previousAddresses)">
						<fo:block xsl:use-attribute-sets="class-paragraph">
							<xsl:call-template name="func-no-item">
								<xsl:with-param name="item">Previous Addresses</xsl:with-param>
							</xsl:call-template>
						</fo:block>
					</xsl:when>
					<xsl:otherwise>
						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="2.5in" />
							<fo:table-column column-width="2.5in" />
							<fo:table-column column-width="2.5in" />
							<fo:table-body>
								<fo:table-row xsl:use-attribute-sets="class-row-header">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Address</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Status</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Date Reported</xsl:text>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row xsl:use-attribute-sets="class-row-odd">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:call-template name="func-formatAddress">
												<xsl:with-param name="address" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress" />
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Current</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/lastReportedDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/previousAddresses">
									<fo:table-row>
										<xsl:attribute name="background-color">
											<xsl:choose>
												<xsl:when test="(position() mod 2) != 1">
													<xsl:value-of select="$colorOddRowBG" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$colorEvenRowBG" />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-formatAddress">
													<xsl:with-param name="address" select="." />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Former</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="lastReportedDate"/>
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</xsl:otherwise>
				</xsl:choose>
			</fo:block>
		</fo:block>

		<!-- EMPLOYMENT HISTORY -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Employment History</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Employment history is the information in your credit file that indicates your current and former  employment as reported to Equifax. It does not affect your credit score or rating.</xsl:text>
			</fo:block>

			<xsl:choose>
				<xsl:when test="not(/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/employmentHistory)">
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<xsl:call-template name="func-no-item">
							<xsl:with-param name="item">Employment History</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="3.5in" />
							<fo:table-column column-width="3.5in" />
							<fo:table-body>
								<fo:table-row xsl:use-attribute-sets="class-row-header">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Company</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Occupation</xsl:text>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/employmentHistory">
									<fo:table-row>
										<xsl:attribute name="background-color">
											<xsl:choose>
												<xsl:when test="(position() mod 2) != 1">
													<xsl:value-of select="$colorEvenRowBG" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$colorOddRowBG" />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="employerName" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="employeeTitle" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>

	</xsl:template>

	<xsl:template name="section-inquiries">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>8. Inquiries</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>A request for your credit history is called an inquiry. There are two types of inquiries - those that may impact your credit rating/score and those that do not.</xsl:text>
		</fo:block>

		<!-- HARD INQUIRIES -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Hard Inquiries</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Inquiries that may impact your credit rating/score</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>These are inquiries made by companies with whom you have applied for a loan or credit. They may remain on your file up to 2 years.</xsl:text>
			</fo:block>

			<xsl:choose>
				<xsl:when test="not(/printableCreditReport/creditReport/providerViews/inquiries/type[text()='HARD'])">
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<xsl:call-template name="func-no-item">
							<xsl:with-param name="item">Hard Inquiries</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="2.5in" />
							<fo:table-column column-width="2.5in" />
							<fo:table-column column-width="2.5in" />
							<fo:table-body>
								<fo:table-row xsl:use-attribute-sets="class-row-header">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Date</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Company</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Request Originator</xsl:text>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/inquiries/type[text()='HARD']/..">
									<fo:table-row>
										<xsl:attribute name="background-color">
											<xsl:choose>
												<xsl:when test="(position() mod 2) != 1">
													<xsl:value-of select="$colorEvenRowBG" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$colorOddRowBG" />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(reportedDate) and (reportedDate!='')">
													<xsl:call-template name="func-formatDate">
														<xsl:with-param name="date" select="reportedDate" />
														<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
													</xsl:call-template>
												</xsl:if>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(contactInformation/contactName) and (contactInformation/contactName!='')">
													<xsl:value-of select="contactInformation/contactName" />
												</xsl:if>
											</fo:block>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-formatAddress">
													<xsl:with-param name="address" select="contactInformation/address" />
												</xsl:call-template>
											</fo:block>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-formatPhone">
													<xsl:with-param name="phone" select="contactInformation/phone" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(endUserText) and (endUserText!='')">
													<xsl:value-of select="endUserText" />
												</xsl:if>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>

		<!-- SOFT INQUIRIES -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Soft Inquiries</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Inquiries that do not impact your credit rating/score</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>These are inquiries, for example, from companies making promotional offers of credit, periodic account reviews by an existing creditor or your own requests to check your credit file. They may remain on your file for up to 2 years.</xsl:text>
			</fo:block>

			<xsl:choose>
				<xsl:when test="not(/printableCreditReport/creditReport/providerViews/inquiries/type[text()='SOFT'])">
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<xsl:call-template name="func-no-item">
							<xsl:with-param name="item">Soft Inquiries</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="1.0in" />
							<fo:table-column column-width="2.0in" />
							<fo:table-column column-width="2.0in" />
							<fo:table-column column-width="2.5in" />
							<fo:table-body>
								<fo:table-row xsl:use-attribute-sets="class-row-header">
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Date</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Company</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Request Originator</xsl:text>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-cell">
											<xsl:text>Description</xsl:text>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/inquiries/type[text()='SOFT']/..">
									<fo:table-row>
										<xsl:attribute name="background-color">
											<xsl:choose>
												<xsl:when test="(position() mod 2) != 1">
													<xsl:value-of select="$colorEvenRowBG" />
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="$colorOddRowBG" />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(reportedDate) and (reportedDate!='')">
													<xsl:call-template name="func-formatDate">
														<xsl:with-param name="date" select="reportedDate" />
														<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
													</xsl:call-template>
												</xsl:if>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(contactInformation/contactName) and (contactInformation/contactName!='')">
													<xsl:value-of select="contactInformation/contactName" />
												</xsl:if>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(endUserText) and (endUserText!='')">
													<xsl:value-of select="endUserText" />
												</xsl:if>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:if test="(prefix/description) and (prefix/description!='')">
													<xsl:value-of select="prefix/description" />
												</xsl:if>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>

	</xsl:template>

	<xsl:template name="section-publicRecords">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAACWAAAAAyCAYAAADYk+BBAAAgAElEQVR4nO29eZAj93Xn+a1KFIDEWbgKqANd1VV98VBzSUq216aPtjTLMe3VTIiWxis6JGttkivSljzWOCTvLh0b5sSMFIqRbTmkWWls2fKE6EuUNxS+2iNtWw56RrJFcskh1ey7qtGFOnAVCncWsmr/qEp0/vIAEkACyES9T0RHNLKAzJeZv+/v/fL3e/nexLdffu0AXeDguG6+ThBED5w6eQLBgJ/Zdv3WbRR3SyOyiCAIo5B+CcK+kH4Jwr6QfgnCvpB+CcK+kH4Jwr6QfgnCvmjp986v/R+YfOONEVlEEIRR+F/9Nwj9yA8z28j/EoQ1aYpiT7+bNNkOgiBMIJXexP4BGxuZnE9gYnJiRBYRBGEU0i9B2BfSL0HYF9IvQdgX0i9B2BfSL0HYF9IvQdgXLf1GnvnfAIdjRBYRBGGUypd+H6IgMNvI/xLEeDHRbQYsgiCGw/xsHAuzcWbb+sYW7mxsjcgigiCMQvolCPtC+iUI+0L6JQj7QvolCPtC+iUI+0L6JQj7oqXf9H/8AiZf/OqILCIIwij7//JfYu4Xn2W2kf8liPGBMmARhEXZ2NxGvdFgts0mZuB2uUZkEUEQRiH9EoR9If0ShH0h/RKEfSH9EoR9If0ShH0h/RKEfdHSb/znPwQxFhuRRQRBGGXiL/4C1Vu3mG3kfwlifKAALIKwKPsHB1hNrTPbJicmsJScH5FFBEEYhfRLEPaF9EsQ9oX0SxD2hfRLEPaF9EsQ9oX0SxD2RUu/nNMJzzPP6vyCIAirMNFsIv+Z32S2kf8liPGB+4WnP/x/jdoIgiC0aTQE8G4XPLy7tc3tcqJeb6BWr4/QMoIgOkH6JQj7QvolCPtC+iUI+0L6JQj7QvolCPtC+iUI+6KlX37xBHa+9xYm0+kRWkYQRCcms1nUIlF4z5xubSP/SxDjAWXAIgiLc/vOBkRxn9l2YmEWHEfyJQirQ/olCPtC+iUI+0L6JQj7QvolCPtC+iUI+0L6JQj7oqXf6C9/BAdUyowgLI/wpS+hWa4w28j/EoT9oQxYBGFxxP19HBwcIBjwt7ZxHIeJyQkUd8sjtIwgiE6QfgnCvpB+CcK+kH4Jwr6QfgnCvpB+CcK+kH4Jwr5o6dfh86G8t4eJ118foWUEQXRistFAaWcHgR/8wdY28r8EYX8ohJIgbMBmJotqjU05mYhFmdSyBEFYE9IvQdgX0i9B2BfSL0HYF9IvQdgX0i9B2BfSL0HYF039/uwTaM7Pj8gigiCMwv3t36J0+S1mG/lfgrA3FIBFEDbg4OAAq6l1ZtvExASWkjSAJgirQ/olCPtC+iUI+0L6JQj7QvolCPtC+iUI+0L6JQj7oqlfhwO+X/xFYGJiRFYRBGGI/X0Uf+u3gIOD1ibyvwRhb6gEIUHYBEHYg8vphNfDt7a5nE4IgqB6u4EgCGtB+iUI+0L6JQj7QvolCPtC+iUI+0L6JQj7QvolCPuipV/3/Bx2bt7E5O3bI7SMIIhOTBYKqPp88N57T2sb+V+CsC+OURtAEIRxUusbCAUDcDi41rbk/CwKxV00m+IILSMIohOkX4KwL6RfgrAvpF+CsC921q/L5YSH5+FyOZnt1WoN1WoNTdHa9hNEv4xSvw6Og0e2+NyJ3VJ5gNYQg8Tr4cFxd9tYQxDQaAhd7cPlcsLlvNtXi6KISrVmmo3t8Hp4+P2+1udGQ0C1Vuv6HMzGzv63VwKy+wDg2PpqMzQlR6s/pj53sGjpN/ZLv4jcq69islIx/XhTFy4Y+l7z9ddxkMuZfnwlSnv2Ll0ydR/cygomT5xofd6/fRvijRtdH6NXjF5vYHjXfJwwo/30Q/M//2fsXbiAqXCotc1O/lfq8+X9viiKqFZrQxtbKW2Ro/Q/4+qjzPblRG9MfPvl1w46f80+uF1OeDUmuSpHAj+OA2divJiJRnDyBJt6cjubw63b6zq/sCYOjmPexjBCcQycX69oXa9BXI9hHee4Mi76bUdQMWklp50fdismPeU0hzgBShB62E2/Si3SOFiN18PDoXggrcseSMknjg92069d8Hp4lY4knz0Iv91Js8R4Yjf9Bvw+xGdi8Pu8bb+XyxewuZ0xPBHq4DhEo2FsbmXMMLMjoekgBEGgMfgQGPa9HSaj0m/A78Op5aWufiMIArL5ArLZPI2ZbcTplZNMf5ve3OpaS4l4DHOJeOtzqVzBtRu3TLNRCwfH4eTSCU1fIYoiXnvj8kCPbwS7+d9+eeiB+5nP12+ujsUibLeYoSk5Wv3xK6+90fP+CGNo6Xfrj/8EB7/7u6YfK3LxouHv7udyqH/r71D7whdNt0PPntyjj5q6D/7pp+B5z+Otz9WvvTjQ8+lkWyeka17/6osUjGUAM9pPvzR/7AIW/s//ndlmdf9r5BlYEARsZbLIZPNDs6mT/7Gzj2r3vG62Lyd6Y2wyYAX9PszORDtOcmXzBWxsZ2milrAt29kcYpEQfF5Pa9tMNIJMroBypTpCy7rD6+FxZnmx69+JoohCcffY6Vjrev3Ta2/a9jjHlXHRbzva6Xp9cxtpncHewmwcoWBA82+lcgVv3Vg1wzzTcXAcZqJh3fMixge76Vepxas312wVPDQMbSVn48yzg7KPIp/YHVbuD+2mXysj3edELMK8UaekIewhmy9gu8uF7Mh0EHWdSaROmiXGEzvpNxYNIzk/Z+i7kXAI08EArt9c7RjklIjHEI9FUa3VBz5x6nI5cWJhHn6fF9dvrg70WMRw7+0osJN+nU4n5hJxRMMh3FpLUfAhMVD0gq+Aw/kPK2An/RIEwaKl3/i/eh/ufOObcKwONsC0HZORCDzveRzcTBzl558fmR3HCemaO9/xfdj9+McpCMsGOL71dyj+5GMIPvg/tLZZ1f86OA4nkvOY1lnTkeN0OpGcn0M0HMa1G7fohYceoed1+zA5agPMYCYaxpnlxY7BVwAQDYdw7+nlrjPvEISVWE2t4+CATV63lJzHxMTEiCwaHhzHkY4JW3Oc9evh3bp/Cxjw4VZjLh7D+XtO29J2ojeOs36HCWnLftjhnpF++ycyHcT5e05jPjHTNvgKAFzOKcwnZnDvmRVDY3a3y4lzK0tYXlxgslwRBGAP/Qb8PsPBVxIcx+HU8pIqg7uE18PjnjOnMJeId9ScGSTiMdx37oyhuTWiP4Z9b0eJHfQrx+k8XNQgiEHh4DhVPyuKIkrlCmq1Oqo16wT/2U2/BEHcRaXfiQkEf/mjwOTol4RdjzwC/umnRm3GscKRTML7zDOjNoMwwsEBSr/9WRwoApSs5n8dHIfTKycNBV/J4Xk3Tq+cpHmfHqDndXth+wxYQb8Pi/OzXf2G4zicXV7E967dPFYZdIjxoVKtYTubRzwWaW3zenjMRMPYyhyPKHZJx69fvkbR0oStOM761VuYV9altjpeD4+lhbm2AWXEeHKc9TsMSFv2w073jPTbHzPRcNfP3cBhINa9p5extr6BbZ1U83PxGOYTM/2aSIwxdtDv/GxCtS2XL6Baq7XKDHo8PKLhEJyystscxyExE8NaSl1Swu/3gR9i/yovwUUMlmHf21FiFf2mN7dU2w4DYdT3gufdSMRjY5mVjBg9Ho3AdCPZEEeBVfRLDI+dYhGl8t3M2dU+22VDEDT7X2LwaOnXf/992L3w4+C++Y2BHbf6tRdV25zv+D44kklmG/8Tj9myLF7z6jXmHJtXr43QGu3rDQDcTBzOhx/GBH/X57geeQS1lRWIN24MyzyiRxx3Utj+oz9B/Gff39pmNf97IjmvGkOLoohcvtAq4ctxHAJ+H6aDAWbth+fdmJ9LaD4DE/oYfV4325cTvWH7AKyFWXWDy+YLqNTqrUku79Ekl8s51foOx3GYnYniVio9NFsJwkxS6U2Ep4OYmror4+RcAvmdIvb2miO0rHfWN7d1/+ZyTiGkcNQcx2E2HkMqvTkM844FDUFoex8IcxhH/RqB4zh4PbxqYjHo943Iot4I+n22CDYgBsNx1e8wIG3ZD7vdM9Jvb3g9PBY0AqQawh4Kxd3W5Jr0XeWzNwAsJGZQqdY0Fxcp+IowgpX163I5VZPPt9ZSKOwUmW27pTI2tzK458wp5vuRcIgmn4mxxgr6bRdMFfD7cHIxycw3+X0+CsAihoYVg68krKBfYnhkdF6Y6JVGQ6C+dIRo6Tf+7Iex/Y//iMnS7kCOWfvCFzW3uZ94P7wf+GBr2wTPw3H+PPYuXRqIHYNi79IlS9msdb0lJiIRhH7v95ggrKkf+H4KwLIJ4h//ERr/0z+DaybW2mYV/xuaDqoyX+XyBaynN1XJMgo7RWxuZ7C8eEL1DLy5nWnFcRDmYbYvJ3rD1gFYbpdTNeF/c+0OcopJrmKpjPRWBvedWWG+Hw2HKACLsC2iKOL2ehorSyda2ziOw4n5OdxYvT1Cy3on3eGBLJXewtmVJUbHVi51Y0fqDaHjfSD6Zxz1q0dD2GMWYbUCsJS+XPkbgrASx0m/BDFukH57IzmrLpG1vrmtOWaUnr2VWa04jkNyNo63bqwO2lxiTLGyfl1OdQlBZfCVnM3tDE4uslkAAn5fK5jR5XLC5XSq9us4eoMYOLweegv2Ab9PlWGl0RCYbFzK72sh30e1WtPNPK08XrVaa/t9B8ep7JPO3cFxCIWCrT6nVCqrztPBcfD7fa3SjY2G0PZ6m2EzoM7a2xCE1vV0uZwI+H2tv1erNSY4VaKfe+v18PAobBBFEVWd4FYrYWX9AoftbyuTZd4q71Tao5c2pNf25e1eFEXNRROz77/S/kZDQKlU7phh3gwdaKH8rUQ3+xgkZupfKwOWvB9ud75a10mrnzQTq+t3mAyq/Wv5NUmP7XymEbuUx+l3X932Y0aOqaSX/lV5Dnb1l2ajpV9HIICpn/s5iL/z2aHaUv/KC5h623k4H3zwri1nTjPBTFMXLjC/0Qp0MvIdLRwPP4Spt78dACBubEL4+tcN2y6HW1nB5Im713P/9u22AU1TFy7AceZ063Pz6rWhBXAd5HKo//3fg3/00da2CZ/+S9Dcygqc73pn63O3tvZ7rr38Xu9+ON/9bnCzCd17Lf0dAPa++100X37FsJ169h6Uy2i+9VZP+9Jisl5H5rOfxcK/fb61zSr+NyELCgOAUrnS9oWiRkPA7TvrOHt6hdkei4Rxp0NyjVGMfdrRr48CDv2UXzb26+Sjun1eNzoukNPrde7k5+XXSxRF7JbKhoLuxsGX2zoAS2uSSxl8JWdzO4vlxQVmW9DvQ1FjoOlQNE6tUoWOo0wecuT7avd3B8chHAq2jlPUmVQKKgbf7c6vnd1eD9/KMNIUReQLRVWHIP8OAOR3ioZLNLqPxKms21qp1lTXV3mOWtdIfn2aR6KU3+9mm8lGQJ1NpdJlB2gXsvkdxCJhpgOOhqeRyeUtMUFhNk1RVOnYSNaFoN/HtDPp7XutNuF2Obtqa718X6kVLf13g5k2d+rXjHxHfr0l/RrtS9r1Q0b7ZrtwXPRbKpfhCodan70amvXwbHtS/sYoSq03GgKKBieRtdqWvD3mj/zv4YIJGxzGHflroL3+zGzfynOVzrdSq41Eb8q+TboOdhkQd8u46LfdfVbe005jOgnJRyjbpxHf26u2zNBDLwx7rK9FN2McCTPue7/3bJSMi36HRWQ6qFqE1gu+kiP9XR6E5fd5medvvQyYyjZt5DlO6dO6HV/3oiWjz7J6pReJ7rGTftuVLyvsFJm+X5pIlAhNBzXLC/C8G6eWlwAcTnJfu3FLdcx4LNq2tLfWm8nSPpXIbbh+c1V1jWPRMOKxKFNSUUIURWxlsshm8yodeTy86pivvPaGtv2JOHaKu7idWkdTFBGLhjGXUAeFzs/GcWst1VH3vdoMAHOzCaY/TG9uIZvNY34ugYjGs4sgCCqberm3oekg5mfjmjbLj7W+sdV1INowsbp+jZbm6KcNabX919+4jNMrJ5mMANFwGJevXgdg7v13cBwS8Rgi4ZBuP5HLF9pmIzBDB3K8Hl61T619jLp9D1L/ANsPv/LaG6q/B/w+zM8mtEuXJuIQBAFbmezAMh5YXb/Dwuz2D+j7blEUcftOGqIoavrMTnZpjUH0/G83++q2HzNyTIl++ldgfPyl2WjpN/bun8KdixfhuHplqLY0b91kArCUBD7xCeZzTiP4xsh35ExEIvD96q+qjrv/Mz+D8n/6T10HQznf9U543vN463P1ay+iphGA5Xz3u+H9mZ/BZCSi+tv+k0/2dOxeOKh07qMnIhF4n3kGrkceUf1t/8knUfnjP24bsNbvubqfeD/4n/wp3d+3O77W/Zj4F/+CCTprPPAAys8fBjFNXbgA35NPssd6z+MQXn0V5U9/WtdGOfzTT4H/iceYzGJy9q5cQfXLf2BKIJbjO99B4b/+N4R+8H9sbRu1/9XK/pze6FyhqFKtIZcvwMPzaAiHLweV2pzDqMc+Svr1UcDhOZ1YmNP1U4Ig4PadtOredvu8bnRcINnUz3XW8/PtfPJ2JqsbeDdOvtzWAVhazMVjupPBOcUkl96iQHI2zjROvQlmr4fHmeVFZts/vfZmx7/PxWNIxCLMwHo+MYNCcRerqTSaooiZaBgLiRnNSaUbOgN3LbuLpbJqO3BYAmLtzgZyO0U4OA6nlpKq78wnZrCZybUt7+b18Jr7l9MQ9rC+saW5oKR1jV594y1VliMloijilTfe0rVJvs923x0HVlPreNs9ZzAxMdHatpScx3+/fBUHBwcjtGwwdBNINxMNIxGLambSEUURm5kcthVOMeD3YXF+tvW5Iezh9ctXdY8xOxNFVPaQnc0XcEtDn0G/Dwuzcc12PZ+YQUPYw2Ym29MCjZk2d+rX2n0ncuQcta63kb5kaWFOdX3k/ZDRvtlOHAf9NoQ95rNf8abN4SL+3TYjiqLqN+1wHJUijYWndSeRs/kCNrazuoEYWm2rKYqMruYTM1jf3NYsk+Th3S1NlMoVVXYPM9u31hhC63xT6S3d/tJMe9wup6pPkVMqV7CxnTUUuGM3xkG/Wvd5O5tHci6ueU8bwp7uONTBcbq/k6PVPsPTwZ60ZYYe+mHYY305vYxxJMy4773eM6swDvodFgE/+5zXEPYMj7/SWxlVOcLwdKDlE5T6kZC3ras319r6EL3n0fnEDErlClIbW2311I+WjD7LxsIhvHmVyjyYhRX1u1sqQxRFpk+fS8Th9/mwUyyioPECnNnleBaT85qLv0oi4RA8PI9rN2715Rs7HY/jOMwl4ggFg4aO1W5/UnkLQRAwE4tqfsfpdOLU8hLeunZDN3DEbJsdHKdacO7Wpk7EomEk5+c6fs/pdOLkYhIOB2fpkhNW1K+ENF/cDrPbEACcSM6r2lBDOGwvZt5/79HiSLtxM3DYR0wHA7h9J21oUaMfHRi1yYrtexj6lzDSvzudTiTn5+D3+VoBq2ZjZf2Oin7bQbt7y3EcTi4msZ3JmmrzIGjXjxml3/513Pyl2aj0OzGB0K/8a+w++ywmhpi0gJvRDkIdJIFPfQqOZFK1fTISQeATn0Bxt2haxiIJZblFvWPvwngGr16Zuu9+5vNBmX22nohEdK8RcGir/9lnUfH7UP/KC6q/93uuvuee0wz8Uh5fHkTVjqn77sfU2bPMNnF7C8BhFjRlAJ+E88EHEfjUpzrun3/6KSbgS9OGs2cReO7XUfzYx/ov93hwgOrnPofpd7wdE1N35yxG6X9D00HmsyAIhl9+a5clS45Vxj5G7THyDGDET0njhtR6eig+alDXudO5Ss/0yiCscfPlk6M2oB+KR5NccuYTMzi3soSZaFiVjQk4nAROb2WQ2ykayophNieTc5jXWGwBgFAwgKXkHJJzCSzOz2p+x+WcwtnlRbgNTAx4eDfOLi9qBkdxHIflxQVEpoM4f89p3QCqRCyC5FxC829eD6+7f6XNy4sLmImGO9oMAEtJ9aJwobjLLMhzHIeIoqOXCCu2F4qDqWdtFWr1BjYUk7e824XZeEznF/ZGmW5RL1DjZHIOi/OzumXMOI7DfGIGZ1eWmL5iO5tn+hWXc0q3rTk4TrVQuZ0raNpyZnmxbVChyzmFxflZnFpKavZd7RiEzd0yEw1jeXFB93ob6Uv0rk8iFsG5laW+bbQix0G/lWpN1T7lPkyp6d1yxfC+vR4e5+853TEAIxoO4d7Ty7q6UOLh3UzwVT+Y2b7bjSHkRMMhVd82CHu8Hh73nl5uG3Dj93lxZnnR8BjAToyjfjmOw9mVJd17qjcOdXT4nZx27bMbzNDDIBjGWL/XMY4evd53OzOO+h0UoaPAB4lsvrtxo/L7yv31Q7vnXeDQB51dXtTVgdlaArSfZbtdgCLaY1X9bmkskPp9XiTn53D+/ntwz5lTWJhLIDQdNN0nhaaDqolTQRBQKldQ0hhb87wb0T7GZlIGHTmiKKJUrkBQtHeed+OkrOyNHtL+arW6ps3TwUBrolY6lnI+kOM4VTmMQdo8E4u2Fpz1rnU7mzrhcjlV2XIEQUB6cwvpzS1sZ7Kqa5CcnzMUSDQqrKpfB8chrgjuU97PQbQh4G6AoZxqrWbq/XdwnGagk9RP1Gp1ZrsU+KHM8qhFPzo4sTCvsknah/KaAtDNHjUKBq1/Ca12Jz+msg1MBwM4kZzv65h6WFW/o6SfdqB3b5V+UC/w2Ero9WNG6bd/HUd/aTZa+vWeWsHBTzw2NBscDz8E58MPM9tEA1lz+j7uUWBRM5VCM5VS/d3/sX9j6vGmLlxQBSTt53LYu3IFBwpd+J580tRjy3E8/BB8zz2nCkba+/Z3WBt+9VdVwVd7V65gP5djtnk/8EE4Hn6I2dbvufJPP6UKvjqo1TSP73rkEbifeL9qH0qU5wsclhgEtO+1vF3oBaFJcCsrquAr4dVXD7OgXbzInPMEz8P70Y92tNcI3NYWNv/gy8y2Ufpf5bNsVTGO7BcrjX307On2GSA0HdQMLNIahwOHY95B+6hBXmfpXKVnDa1x/UwsypzjOPpy22fA2szkVG9f+31e+H1eLM7PolqrY7dcQfWofMaoy9BJCxvVWh2iKKomi+UT0qIoolqrw8O7mQdSjuMwOxPFrVS67bGkfUn7cWqUCZGXcpM6SuWEcSIWQSaXV2UOWVqY03xQBqB5rIXEjKHsPlqT8tVaHQ1hD4nY3dSQAb9XM6uW8ve7JeOL+XZlfXMb0XAITtk1n0/MIJsvQOgik4yVkcqCyNsAoB1gNxePqRYR9XTg4d04tZRkMjRk8juG2lo4xAZzVGt1VbS3li3AXa0o9S213+ur6geCdphpcy9IwSoNYQ+CIGj2AVp9iYPjcHZ5UTPVtvx+dQr0tDPHQb+75QrTNwf8PtQbh/5AWZLQ6KBdr+1IbZDjOMafSYHHdQNvZWj5IeUArx8be2nfkemgqi+RzhWAah8e3o2ZaJjJUmKmPXr70hvfLM7PtkpCjhPjpl+5H5H8lPJeao1DZ+Mx1fgxmy+0gqQDR2NzCQ/vRnIu3nEsq4cZehgUgx7r9zvG0aLX+253xk2/g8DBcap+vttxo/L7HMe1SvP1i1xP7dqulv4HoSWlTRJmT0gS1tTv5lYGfp9PdxzF824mO8ROcRdZndIRm1sZbG5lkIjHmElIrbKDABCNsMFUyhIDDo7DuTMrTBp/eUl6qRTQQw+wb8hrlR3UmhjN5QvM28yh6SBOyOaL/D4vYtFw27dTRVHErbVU63gBv0+z1IK8hKJW5hGt6z8om4HDhfKba7dbmU20MvrIy613c29D00FmP7VavVWWTr4/5b1NzMQMv10+CkalX+WLP8Bh23A5nZol+UqyDBGDbEN3j1eBg+PA824Udoqm3v/5uYTq/JT9hFZJlJOLSbzRJru63LZudCAdT65dQRBw7eYqkyVIqROO4+ByOfvOKGUWvepfq3/TKsmm1e6Ux5TKSsqDdKaDga7aXjdY0f+Oml7av1bQpyiKuH5ztTV2dnAcTiTnNYObrIqyHzOCGf3ruPpLs9HSb/zpJ7H5Dy+BK/T/crbE1IULzOcJvx+OU6fg/pEfYUq2HdRq2PuHfzDtuO3Y/eQnW9mXpi5cYLIgTUYicD/xfs3sTr3glpW+A4DGSy+1MjdNRCKY/p3faZW/M+PYkYsXDX+38dJLTEYmx8MPMaUZD2o17D7/G62MYJ5f+RWmlB//3vehJMsW1s+5TkQi4BUBgPLfA+rsWJ73vg+Nv7mIA0VwlhbNVAqTHs/h/19+Be4n3q8qcVj5wy+37FG2Cy2c73on87l28SKqn/lM67Pwrb9D8N/9+9bnqbNnwa2s9J8FCwC+9ueoP/YY3LIgnlH5X17h07oJuO2E1cY+Zj0DzM+qz0meKUs5duA4DrFIuJUhqpvn9V7Py+zrrHzW0Mq25eH51vHG0ZfbPgArvZVRLerI8fBuZkGoUNxFJlcY2QKgKIq4sXandfyg36dZekFeLkXKKuBhJpXUEwdaKMuunFtZUl0rpU0z0bAq84d8sVyyW25PQ9jD1ZurTGDFXDzGBMdxHAe3y6lbAkpJqVxpLaDnd4qHb4zIFohCwYBqEcjr4VWlrLSCUMaN/f19rKbWcUaWtWRychJLyXlctWjpFy3e8cB9XX1fFEVkcmxn73Y5VUGZ2XyBaSuR6SAWF2YZpzgTDbcCBDO5PNPWouGQZvmimMJhZBRv+GvZUq3VcWMt1dKBVD5N2bbl9hjBLJv7QVmi7GRyTrWw5eV5pg+YiYZVE4HK/Wj1SePEuOi3HdVanVmQlC/4KCeiKtWaoTdtk3Pxjm0n6PdhcWGO8Qsri8m2JTrlSAEdHt6NQnG3lUVT6d/0ymyZ2b5jEVZLyv04OA73nllhzlUZBGmmPcrrL4oirtxcYyYLl5JzzH1fXJgzfO3twjjqV+mnpKxp7SaQY+Fp5vPNtTvM+EtLN9FwqFUatFttmaGHQTHIsb4ZYxw9ujWS3WgAACAASURBVL3v3d4zKzKO+jUbLX/c7XO01ve9Hh7FUrlV5lr5DNCp7KAcZdt1u5w4s7zEaD7g8zJ9xCC1JKF8liXMxar6vbV6WzVJqcd0MIDpYAA7xd2+SyZsbWdQKpfh4Dg4nU5VecOmKCKbLzCTrPJJy25QlpwolSuqCc/CTlE1qev3+dpO1G5lsszk8W6p3HqxR0IUxVbwlXRehWKRCeLQOq9B2SyKoqrERKVaQy5fYNqAXmmqbnE6pxDw+5jr1BRF3L6TbgWliKJoygtWg2RU+tUK6NNDEARkZfd+UG0IUAddBPw+zQCjXu+/y+VULXYoF0SAQ83dWkvh7OkV2TGdhoIne9FBQxCQWk8f+UoehZ2i6rw3tzKqxSGX0xoBWMPQvzJrkiAIqmM2RRF30ptwOp1MoE48Fh1IAJZV/e+o6LUdhEJB1dzMLUXJ96Yo4nZqHR7e3bPPHhZG+zEtBtG/jou/NBst/XI8D/dTT2HPQOk1o3QKYpGo/fVfGQqk6ZfaxYtM6bu9S5dQe/BBJrBo6m3nUUf/AVgTkYgqoEkeUHSQy6H+rb9rZVE6qNUwYXCdt1+aqRQqn/88s835oz/GfK7+2Z8y5Rirn/kMXG9/eytwSX5u/Z6r+6cfZwLy9q5cUZUYLD//PCY/+9lWVqsJnof7px9H7QtfbHuu1a+92PqOlLXLsbzCfKd28SIT+KbVLjoxde+9mIhEWu24+fIrqPzhl7FfKuOgVELz9ddNa+MTewKyn/lNLPyHT7e2jaP/tdrYxwwfFZoOqvy41thhK5M15XndCIO+zlrPGuvpTdUzSbvsVePgy20fgAUcZopRBjDoEQoGEAoGUCjuYjWVHnpGrM1MjplMLpbKaAh7qqAheeDE4aTSLrMoY2QRSbkfAMgXd1UBWEqbtrN5LChKpyjTCjYEAWvrG3AcTSoXdnZVgVXprYxqYtvl7ByApVzEDfp9rd9IWQKAw4CuoN/H2B5UvNE27uUH5RSKu9gp7jKdYUg2qTtuSO1E2Z6UJShL5YoqUC935BTl7TPg87YWVOqNw9SIcq2EQ0FmwcXtcqqyfeQL7OLK7Aw78d4Q9nDlxqrKkaXSm3A5p5hAhUQs2lUAllk294py8RsAUuktVQCW0qkqswRIQS5ytrN5OI5KwIwr465f5UAocNROJR8ip1gqdwzAcrucqral1QaLpTJurKVw7+nl1jaXc8rQAqp8IdZx9KZtt5jZvje2s9g9Wsx1OadU+5EW1uT7cTkHpzflvm6s3VFNFq6m0gj4vK3xhMs5Ba+Ht/TAuBfGSb+iKKr8VKVaU2VZVOpWOXkc8HtVmWeltibd/0q11vM43Aw9DIpBjvXNGONo0et9HwfGSb/HFWXbrTcElf6Vz7+D0hLQ/lmWMBcr6leapMzk8ohFwpgOBjpOnE4HA+A4TjOzlVF2S+W2b756PbwqeLpXlAHC8ixBcgo7RWYCuVMGj5KG/Q1hj7l+1VpdNXaoGhhXDspmLXuAw/thRskorRKLp5aXIAgCdoq7qFRrqNZqh/e+1PfhhooV9SshZWOT39tBtSHg8C16+fORpGWz7r9y4UgQBNWCiIQUOCJfHOkURNarDhoNAZmG/n4dHAe/RtYyqzBo/QPq9rOVyeo+P61vbDLfdzqdA3v2trJ+h02v7UD5bFqr1TX9eFMUsVPctXwZQr1+zAhm9K/j7C/NRku/kX/2Ltz567+G4/XXh2ZHM5XqGERjFnuvvqq5TR5oMxk1R2OO8+fZ47z1luo79a++iL3vfpcJdBokB7Uaan/9V6h/9UVVMJBjaYn5rCxPCACN736XDVa7cAF7ly71fa5T97GZfOrf+Iam/fVvfIMpKzh13/1o59kOajWmbUnH5hbZFyONtAvVvhX9kyOZRPiFFyC8+iqat25C+MY3TcukpoXjtf8P+W/+vwi/88db28bN/1pt7GOGj1KuKZXKFc1zymbzKJXKQ1k3GfR11npGbx6VbdRLpjSOvnwsArCkAAZpkisUDHQMUAoFA3Bw3NDf0NZ6k1cQBMZercF7L6Lb1RCy1tsHWvuu1uptSxDVGwKTEUuJ4yg4qhcy+R3GJvk1Uy5OBRQBWMoF4e2cedl97MDt9Q1V53lifnZsHDBw2BEXirutrBlKAop2u1vWLkGZ3ykyCyrKtqMMVoyFQ8yCS0xR5iGbL6j0ptznZhtHdmdjS5EhqPtABTNs7hUtOzs5VUC9mJvR0ex2Nj/WAVjAeOtX6fs8vFvTT5R09KpEuXDaEPZ0S4tVqjVk8wUmYMvIAmoqvdX6f1MU0ezBD5vZvoulcttsIIcLa+2DI8yyJ+j3qbJfadkmBZXIr33Q7xu7ACxgfPTbbgK53YsOygCjaDiEaDiEQnG3Veq2WCqbVgLQDD0MikGO9c0a4yjp9b6PC+Oi3+OI3sRVJz0NSktA+2dZwnysqt9GQ8Cd9CbupDfhcjkR8Pvg4Xn4fV7NgKxuS5W1w8Fx8Hj4w39Hx1QGSveD0r+6nE4k4jGdb7O0Kx1mxA/qTXh3YlA292qPUQqFw4l85f1zOp3MYnytVkepXEYml7dEZiCjWFG/8hKXcgbVhgD9QAWz7r8y+LLTM/duqawIwGpfnt4sHXiP+i2X0wm/z2da5rhBMWj9ez286t63C2ppNATUanW2JOsAn72tqN9R0Gs7UJZvarcfM4P6BkUv5Y8kzOhfx91fmo2WfkMf/jBKH/7wwI8tBQMNK/gKAJP9itkmy9TlSCZNOZbjzGnmc/PWTdV3DnI5NE3M/LV35QoAgItGVSX29nM57PzSL+lmYZIHNgFHJfYUZfaUQVqOM6cPA7D6PFfHiRPseeiUo9z7h38Ann1W93dKmrdvax9PcY+NtAsljb+5CM9738dk7gIOM4M5H3wQnvc8jv2jzF9aAW9mUP3S7zMBWMDo/a8yeUuvWHHsY4aPMhrE1ev6U7cM4zr3Mi4YR18+FgFYEvWGgFR6E6n0JtxHk1xe3g2/z6cZkNVtGQEzMCJ+vQngbqnW6oa+Z8aksNfDH5X/cyLg8/a16NVOnFqT4KmjOqjK7D4NYW8sF3nboUzhBxxOINkF+USQ1iRPQ9jD967eaBs0pHaKU5gz6BTlJTKVmeA8vJv5uypga4cd5HTryOoNgcnwBnQfqNCvzf3QSz+iFaSpt5+mKKquz7hhd/12QhmMF/T74FFkujLq/5TtoNOk126pogrA6mRrv8GJg2zfDo5r+V0P72ayTA3DHmWGsqa4r9vPKt/sHFYZuGEzLvrtdQyqzDYjIWWeBQ4D9XbLFeyWK6aOvXvRwyAZ5FjfrDGOWfaMC+Oi32Hh4LiufKRZk3FaWE1LQH8LUET32EG/yiwvLpcToemgqqzWdDDYVwBWwO9D9Cjr1iBR+lite6DHqEqH2dFm4HBMfv3mKk4tL7Ud2/C8Gzzvxkwsiu1MFneO5siszrD1m97c0twuiiIaDaFt/z3INtQQtP9m1v1X/lbveBJab58PCgfHIRoNIxoOWb7E2rDRuu6d+qJhVvmwg/+1E8Ou0GI2nfqVdpjRv467vzQbrWtc/Ju/waRJ+69+7UXN7c2r10wtyUYcsvuRj7T+P3XhAvwf/WgrQGgyEkHo934Pu8//hqGMW1K5wGGgDGLSaxfK7crfKWmurvZlVzsOcjlU/+xP4f3AB3W/MxmJwPOex8H/xGOo/tmfmp4Ra/KHf1i1bdj+t1QuM2s8yqDidrhczlbpaSVWHPvY9TmyHVa8ztIxxs2Xj1UAlhxlhia3y4nwdFC1OBQOBoYagDVOODgOM0cPymYuqLYbtCvLrMmzBCkzohyn8oMA4Ha5MKtYOKg3GtgwKdvEMJBnpJPaF1s+aArn7znNlPVQouyclWXK2qEskaksvROLhJFKbyIyHWTafEPYUwUyaC02GSm/2S/92Gx1zLg+VmUc9NuJiiKzosfDqwKhjA5K1WVx99p+XzlI7DSJ3M/kUa8Yad9Bvw+xSMhQBo5h2CPhck4ZzlA3rDJww+Q46LcT6a0MXM6ptj6X47hWQFYiFsWNtVRfgfLD1INVMHOMQxxC+m2P1ljR6+G7GkNqlRUe9Rh0kFoaxRjiuGIl/QZkLxZ4eB7ZXF43mKPRuFv+Sx6E1SnLTDti0TCS83O6f5dedOrnGMRoqFRreOvaDcMlLaW3g608EQ2MRr96ZfdGTbtn4HG9/8DhM/3plZO6ma4E4XD+t5uFLmI4WMn/EtbACgvM49xfmomWfqs3b2LiL//StGMMM7sVwbJ36RJ2d4sIPPfrrUClCZ6H98PPoPgLvzBi64bDQWWwcw31r7wAMb0B96OPwvngg7rfm+B5eD/wQTTfesu0cpPizAwS/+vPsfaMwP8q+3y/z2v4Rb1YJIyZWBQnF5PYKe4eZjKi+AziiHHz5bYOwAr6fa0JXQ/vRiZX0J3MrTeEVtkT+SIhTUD1hoPjcHZlSTc7RkPYQ6lc7moyW6LT4pCyzFp4OohKtaaR3UcdRTvOLCXnMTkxwWxbTa1j/+BgRBb1R1MUkd7KoCmKWJyfbW3nOA4ri8mOmbDMIL9TZIKZpIxrAT/bb2Qt9JaXHW0mxk+/WihrP3t5t8qHjHpBVqJTQNcomImGmb5QCS2sjY7joF8j3EqlUanVEfB5OwZFuZxTOLu8iO9du9lTUBDpgTAL0m9nlCVGw9OBrvx1QJGB0Yo+1kwo0HF4WEm/JxbmmMlBURQ7ZkNTjo17xcFxqmxatVod2Xwe1WqtFeyciMdM8YuiKDJBjNdvrlo+85sdbZYjL2np9fDw+33w+3y693MmFsXm0VyKVbGSfo0wyjbU7/0XBAGA7EWoDlkKlFmqhQEFFkejYVXw1XYmi91SGdVqrWX/cQ3A0groll5A1kM5vzKolxjtpl8rotRlu4yxSk32wygzRethZv86jv7SbLT0m//N34Kj2RyRRYOHW1mBeOMGs21CUarvoDaYKjoTXnU1gkHTfPkV1P76r5hsVo5kEvzTT6mC4w5qNSajVO7RR3s+brfnup/LMSUTte6TtF35u15QnutEJKLOrqVoF3rsXbqEvUuXMBGJwPXPH8XU285j6tw5zexczh/9MdMCsDwffgacIiBlFP63pNFHR6Phji87ODiOGddNBwNwOZ2tACwrjn3M8FFKm0b9croVr7OccfLltg7AWlyYYyaDRVHsOBlsZkm6QZZTsDoz0bBKdJuZHHZLZVRkD8q9BGB1Il8oMotugaMI2+NcfjASmkYwwA5ycoUdFHftM6mox3Y2Dy/vZtqSyzmFpeQcrq+mVN9XOsWrN9d6DuqoVGtMGS4p45qRYD8zHFkvTqMfm4eN1vm1u0bjWn5wnPUrR6lD5aCpWqsbbvMNQYCfmURu3zaU2TeGsfhrZvt2cBwWFBmmqrU6MvkCKrKFtbk2C2uD1FupXGEyGB4njot+jbKdzWM7m4eD4xAOBduWAuc4rpWlsRvM0INdMXOMQ5B+jVIo7moE928Z8tkOjkMsPK3a36ghLdkfq+m3WqszAVjTwQA2tzNtM0IoF1R7ncQMhYJMexYEAZevXu9pX0aoamS11ZqEdnAcXC6nJeZl7GizEq+HR6MhtMY60gKH18MjPhNTlZ7UO0crYDX9GmHUbaif+6+cm+qUpcDvY+9NaUClqpXzxan1NGVAkNFoCKrxit/v021bAb9PFVwziD7Ajvq1Impd6gcudAqa1EJvzcrlsl5GcrP713Hyl2ajpd/MX/4VHJcvj8ii7nE8/FDXv5n6ge9XBfZM/dAPMZ+bt2/3ZVdrP1evsce5917VdyYiEYRfeAF7V64AAPbefMP0rGG1L3wRU/fdj6mzZ1vbPO95HMI3vslci+bt28x3HA8/pAoWcjz8EMTVNVWwUr/n2rx9G05ZwJPWfZK2M8ft8V4pz3Xqh34Iwte/zh5L0S7aMXXhAvYuXUL9Ky+gjsMyg46HH4Lngz/HXtOlpZ7sVdJ8x/ch8cOsfaPyv01RRC5fYIKp4rEoSkexAXrMzyVUY5Vs/u7Yz4pjHzN8VLVWY3yPnl93uZy479yZ1ti7Vqshk8ubnmXSitdZybj4crNK+46EqiIyORQMwN1hIKlchDUyyaX3doAVB63DQvmgvLa+gVR6E8VSeeCRhk1RZCbuPbwbM9Ew853jlN2H4zicWGCzQIiiiNt3NkZkkfncSqVRrdWZbaFgABFF2UkAqu9plT0BDp2i3t/kZBRtaWlhjukTCsVdzTfd60eOTE7Qr/9AHTTRkfVq87CpVGuGr5HW9RkHjoN+JZqi2DbwSenT26HcjxSIq4ey1GGpPPgBmZntO6xYWGsIe3jz6g1sZ/OGJ/fNtEd5zHZBLl4PP7YB68dJv0aRfGtTFLGdzeNWKo3XL1/Fq2+8hbX1DVUb9PYQWGuGHuyK2WOc4wzp1zjKoH3uKBNyp77dwXE4tZRU+ZNMbvSLq6Qle2NF/RY0dLK8eEJ3zigWDauyVvUa5KDUmCjuq77j4DjTXo5TjqPjsahmf5CIx3D29AoeeuB+PPTA/VhMzpty/F6wo80AsLx0omXL2dMriCrmvYDDcfnNVXMWDYeBFfVrhFG0IbPuv1b/ND+X0PxuaDqoerZT/t4slCVFmk31XHJCUSbruLGjCFqPx6K645L5WfaelsoV0xfs7KpfK6LMHsLzblXWWOBw0VO5yGgErYAuM8cCZmJG/zqO/tJstPTbLJUgfOlLI7LIGM53v5v5PPX2t3e/j+//AdU21w/+IPO5ubra9X612Lt0icmm5UgmVRmcXP/8MMvU1Nmzh//uu9+UYyup/PZvq7Z5nnyS+bz35hvMZ/djP8l8nohEEHju1xF+4QVELl5E8Hd/t3U+/Z7r3n9/nfku/5M/pcpANRGJgP/Jn2JtVvzOKMp77H7Xu1Tf0domx//JTyJy8SIiFy8i8IlPYOrCBfYYL7+C2p//eU/2tWPf7Ub0o7/EbBu1/93czjBzvBzH4dTyEhLxmKoPd7mcWF46ocpqKgiCKvjeamMfM3yUUZ8fOlrr9vu88Pu8iIRDAyvxa7XrDIynL7d1AFZhh20kUmkyvSCsmWiYKT8IALsGJrmUC7eAdQetw0KZyUDUeFCeG+CDsvK+yd/KBqyR3WdYLMzG4Zxi78edjS0Ie+NV3uPGWkq1cDs/G1c5PK22oeUUZ+Mx3Ht6Ge944D6844H7cDI5p3ncfKHIHFeZFUbZDzF/UziyRCyi68gWZtUT8L0GSfVj87DRukbK++XgONX1GReOi34l2gU+VRSLoe3QWgxOzmm3kYjGJHJ+SBowq30rf6MVPG5kXGKWPcVSWWWDls93cBzuPb2MB+8/h3c8cB/O33OmbSCq3Thu+tUjMh3E+XvO4B0P3IcH7z+Hs8uLqnYlBWRtZnpLFS7HLD3YEbPHOMcZ0q9xKtWayn94eDfOrizp9ululxNnV5ZU/jebL1jiJQDSkr2xon4LO0XUFGNZnnfjvnNncHrlJBLxGBLxGBbmErjnzCkk59VtKWsgONHDu+HgODg4TnPSVjruwlyi1aZD00GcXjmpCnYwgpSly+vhW8Fk2WxeNdl+euVka8LYwXFIxGOYiUWZfWlliB4WdrBZ694qX1CZS8RbNstRBqkYKYE5KqyoXyOMog2Zdf8bDQHbmSzznUg4hOWlu0Gikv0nF5PM90rlysDaktb8ntT2XS4nEvGYKlD1uKG3uBmTLUgF/D7cc+aUqpzj1nb7MkC9YFf9WpFKtaYKvD65mGTubSwaVmlSD+VcG8+7sZicb40FAn5fz2OBQWNG/zqO/tJstPS79X9/AVzRWmtoUqYkCf7d724F9fBPP8WU1TPK1Nmz8D33HCYikcOAnqefgvPBB5nvCN/6u55tViK8/DLz2fdrv9bK3DV14QI8730f+/3vfNu0Y8sRb9xA9WsvMtucDz7IBA0J3/gm83fXI4+Af/qp1rXyPvMMU1bvoFplslT1c66Nv7nIBHBNRiIIfOpTrd9zKysIfOpTTJnCZiqF+ldeMHYBFCjvsbJd+J57jslcpcVBhe23PU88oQoacz3yCPNZGeTWC5M//V64E2wQzKj9b6MhIL25xWzjOA5ziTjO338PTq+cxOmVk7jnzCncd+6MZjDx7Ttp1TarjX3M8FFGfH4iHkNcsQ9lkJQWWs/rRrDadQbG05fbugRhbqeIxEyUCS7w8G687dzpw4fEo0bNcRwCPq9mOZ1MTp0pabdcYdPK8W6cTM61Si0E/T4szMY1y6kcF5Qp6uZn42gelYB0u5wITwdVwW5msp3NYyEx07JBbku1VrfExP4w8PBuxBXBZ9VaHVsmLHBajXpDwGYmx7Qrl3MKM9Ew0rL6wtvZPBKxCNM2zq4sYXM7i9xOEQ6Ow0w0rAra08vMI2Vc01rIbQh7yLUJ9tvYziIUDLC2LC/izuY2to+iu6X+RNk/bWxnVfszSj82D5v8Dmsnx3G498wKNjNZNBrC4cRbLDqW/e1x0q9EpVZHVOdv3QyUpP5AruNoOASO43BnYwv1htDSutIXlcoV08sMSQsmwOGAV9r/oNq3h3cjOZfAxlF968h0EImZzvsx0x5lfyz9P79TRL0hwOvhsbTALi46uMmxyVB0HPWrR7FUxqLsTUruKOvN9dUUkxXV7XKq/FKnFyH0tKX8Ti96sCNmj3EGgZF7NmpIv92zmkoj4PMyz1we3o0zy4uo1urYLVdakzehYEDzubsh7CGV3lJt10JqO14PD1EUTX+2s4OWCG2srN/bd9ZxanlJlZFKeoO1HduZrOZYuKoYN3Ech/P33wPgbmBEYaeoClKYiUVVk8BKtHRaUsyFzSXirX1fv7mKRkNAUxSR3txigsh43o2Ti0ndheJard4qGzAKrGizkXubzeYRDYeYBfOTi0nMz8Zb/ZGHd6va3Fam97mEQWJl/XZiFG3IzPu/uZWB3+djFlCmg4G2mXVqtTpuDfAN853iLpMJwel04tTyUsffWbXEyCCQFjfl7Y7jOCTn5zQDeSVS62nTr5Gd9WtV0hubOHv6brYYI/dWj1KpDCjGApFwSJVtRLmeYwXM6F/HzV+ajZZ+S9+7DO6//JcRWaTP3ptvsOXbkklMf/7zrc8HtRoTEGSEg1oNrkceUQXGSAivvqoqu9cPlc9/Hs6HH27Z6UgmEfx3/17zu/0EFBmh/tUX4f7RH2OCmDxPPIHipUsADoO0ahcvgn/00bt/f8/juoFuyuxO/ZzrQS6H8pe+BP+zz7a2tfv9Qa2Gyn/8vObfjNB8+RUIr77KBN8p20Wn9qV1vvISi44TJ9iAtVoN9a++qLkvw3bPz2P+Z9/PbLOK/5WyV2n5rU7Pv3pjFSuNfQDzngHSG5vMXEGncxJFEevpTdV2I8/rRrDadQbG05fbOgALAFbvpHF2ebGnSa7NTE5zUaBYKqsWbKPhkGrRyIqD1mGhDO5wOadwZnmx4+/MXIjRCzBRvqE9ziydWMDExASzbfX2HRwcHIzIosGS3sqoFnXmEzMoyuoLN0URdza3sTh/dzHYw7uxvLiA5cUFzf1Wa3UmiEvJdq7QU1urNwSVLRzHYXF+ltmmZG19o2+d9GrzsCmWyqpAGpdzSnV9xKPydVoLBXbluOkXUJeuk+hlcXVjK6MKrg4FAwi1mUSu1uq4vprq6jhaKM+D4zg8eP85AGyAl1ntO79TVI1LErGIamFYiXJ/ZuptO5vX7I/bBV+v3dkYeJniYXEc9atHUxRVAXl+nxcP3n+u9YYPx3Gq9tQQ9lrByBJGtGWWHuzIIMY4/WK0P7QSpN/uaYoirtxc03zu9vDujvoSRRE31lK6PkA5iST3J1dvrpkegGVFLRHGsLJ+K9Uart9cxcnFZFcZJrYzWdzRmFwFDoN09OadpGDXRkNAaj3dccE2tZ7GXCLOTPq6XE5mkrZULuvOo8ltyGTzrTecO1Gr1XHtxq2O3xs0VrPZyL1tiiJuraVwYmGeCZxxOp26bWw7kx1psFs7rKxfIwy7DZl5/5uiiGs3buHk0omOc+XAXfsH+ey2nt6Eh+dVb9Ur7SgU2SBTlwUz+AwSaXFT3n+3I7WeVpXzMQO769eKVKq1jv5bFEVsZbId+51KtYbtTLZt8HWtVsfmdsZwVq1h0m//Om7+0mxU+j04QPG3fguOfXXZ6lFT/+qL4H/iMd0gmOqf/Sm8H/hgV/ts95tmKoXypz/dtZ3tOMjlsPv8byDw3K+3DebpN6DIqC21v/wL5vwdySTcT7y/FQxV/cxn4Fha6pj9qfKHX8beUeCWfP/9nKvw9a+j4vd1vKcHtRp2n/+NvgPlyp/+9GGWraR2P9ipfemdr9a1k2w+yPURKDUxAd9HPoIJBxvGYSX/m8nmUa3WMDebMDTGFAQB6xtbbUtcW2XsI7en32cAaa5A64UtJaIo4vrNVc1xuNHndSNY7TqPoy+3dQlC4LDhXrm51vXbqJuZHFI6k1yVaq1jiZRqrY61Y1zjPJXeQrVDuahqrY71zW1mm5nZCHZL2lkTjkv5wVgkDL/Xw2zL5PIoVaojsmg4rGqkplRmWdnO5lVtT49qrY4rN1bbfqdSrWm294yBMhHb2TzW1jc0SyRpsba+oVqQ7oV+bB42qfQmsnl1NkKJhrCHKzfXDF9DO3Bc9Vs5WmhQYqQcsJKmKOLKjVVVClc9JK2bMYmsdx6AerBrRvuuNwSsrXcecyj7Go7jVGWZzdJb82gxvdNYQG6blbLv9cNx1W870lsZTb8rvRChFXylFYxhRFtm6sGOmD3G6Zdu+kMrQPrtnUq1htcvXzPsdyVK5Qpev3ytbQbEduMArdKAZmA1LRGdsYN+K9Ua3rp6A+nNLVVJQjmiKCKXL+D6zVXd4CvgcLx1/eaq5r447u50Xiabx621FASNcmc7xV1cuXYDmWxeVcZAmdJ/cyuD7UxWu7yvg1N99/rNVd3SCIJw+FbtoIM4usFKztscnQAACvpJREFUNhu9t5VqDZevXu/YpnaKux3b0yixg36NMOw2ZOb9l4Kw2tlfq9WRWk/j8tXrQ9HAtRu3kNN4NpWu4+Wr11ULdNPBwMDGBlYlk83jzctXkd7c0uznJZ/y5ltXB7IwNi76tSKZbB7Xb2rPa+0Ud/HWtRuqjIl63ElvIr25pfLh4lH2jms3bll6XrXf/nVc/KXZaOl3+8WvwXHz5ogsao8U4KIsRbify2H3k5/sKVtU/SsvoPS5z2FfEQjTeOkl7H784/0FyOjQfPkVFD/2MTReeknz742XXkLh53/e1MxbetS/8oLqenre+z6mdN7uRz6C6tdeVF0j4DBIrd217/dc6195ATvPPIPGSy8xJQnlvy9+7GOmXKuDXA67H/+4ytb9XA6lz33OUPuSn6+WvWba3PyhRzB9VJJRwor+t1KttcaYuXxB1QcLgoCd4i5S62m8cflq2+AriVGPfZSY8QxQqdbw5uWryOULmv64dU6Xr+rOn3XzvG4Eq13ncfPlE99++TVrhEr2iVQmQK/kAXDYWArFXeR3dg29jT0XjzGlCaR9bGZy2M7m4fXwqqxP//Tam63/B/2+tn+XOLeyxEQtrm9uq96uNbIvs/ZjdF8OjkNyLq7KstMQ9pDNF5DeysDtcuJt5063/iaKIl6/fK3VCRm1R4+H7j/H3J9SuYK3jsHkuMPB4YF7z8Ihi35uNkW89r0raDabI7TMOP3c++RcQpXpQq+9xyIhzYw4UjvdzuYNTSzNRMPMW/LdtjWpj4qGQ6pARKlv2tjO6r7h38v16sVmI8fpxhYjfYnc3nAw0Pq+8h51sy8rMw76bcc7HriP+Xz15hrjc08tJVWaVN7LuXiMyXDTqe2203q1VkfmqB3p0UvbkkrsaQWWvH75qur7ZrTvyHQQ8xolkKX+o1Kt4WRyjvHLeudilt7a9W2SbZlcwZJZcHrBTvrtpEXAeNs32u97PTxmjrSoFXxjxPca1ZYZeuh0/p3Oe9hjfeX3ex3jDOK+d9Mfjgo76dfqBP0+hKcDulrv9rkbOBzfx8LTqv3JX04wu+1K3+1VS/0+yxLGsbN+A34f87larfUU2OByOVuZX9rtw+j3OiHZLYqioRLSXg/f0m9DEAyXPxglVrG523smb1NG788osbN+OzGKNmTm/Zfvq5/+wgy67XOOM/I+Y9DXa5z1azUcHAeP5zCjilyPAb9PVZ7zldfeaLsvqW+ys57M6F/t5i/NRku/e/kCMh/6ECYr3b8IO2y4lRVMnjiBg92iaYFKjocfwkQgiObrrw8k8EqPqQsXWv9XZpGyGtJ1B4D927ch3rjR1e/7PddhXauJSASO8+f7bl9SmwJgalvd93oR/f0vwRkOt7YdZ/87zLGPEczwUf3uYxBjZ6tdZ8DevnxsArCUBBWTXJU+HiS9Hh4OjkPTZjd3mEjXe9jX6Pw9Z5iFN7OyB1mdkycWMBMNM9tu3b5zLM69VyQdA4cOzexSJt3gljky6leMMy4BWKTfwSL3//34fqPI9dzP8bpp32Yd0yx7JBwcB6/nbgrmcQm6kkP6NY68nQLdt1Wj7XwYerA6VhnjWP1ekH4Hg1Lr/bbBUT1XAtbREqGG9EsQ9oX0SxD2hfQ7enoJwCIIQFu/d57/t3B861sjsoggCKNMPPkU4v/qvcw28r8EYS8cnb9iT8xc9KPgiM6MYpE16Pepsh7kC+NR3qgdPq9HNXguV6rkfDtgJR3XG7SgI3FuZQlOp7OV4nK3XEF+p6h5fZSZNax0T41C+h08w/ZH7fQ8qPbdax8yaL01RXEsg64kSL/d0a+vM/p78qnW8YdWvhek38Fh9n0fpR+xipYIFtIvQdgX0i9B2BfSL0HYFy39Fl95FY6///sRWUQQhFGaJ09i4X0/zWwj/0sQ9mNsA7CI8cbBcViYjTPbCsVdy71pbzYTExM4eWKe2XZwcIBbt9dHZBFB9EdTFOF3TrWCKf0+Lzy8G9dXU8z3knMJVUkauy2SkX6PH1Zr31azx06QfgnCvpB+CcK+kH4Jwr6QfgnCvpB+CcK+aOpXFFH67GfhOBjLYkgEMT5MTiL4yx8FJiZam8j/EoQ9oQAswjbMxWMIHJVDkpdFksjkCsM2aejEYxF4eJ7ZtpXJoVo73gvjhH0p7OwiFAww20LBAM7fc6aVpcfDu1XBINl8wXYBl6Tf44fV2rfV7LETpF+CsC+kX4KwL6RfgrAvpF+CsC+kX4KwL5r6/cofwXHnzogsIgjCKOI73wn/ffcx28j/EoQ9oQAswlZoBV4Bh9mvxrnsEQBMTU2psn7t7e3hzsbWiCwiiP7J7RQR8HsRDYeY7S5Zlh4l1VodqbS92j3p93hitfZtNXvsAumXIOwL6Zcg7AvplyDsC+mXIOwL6Zcg7IuWfhtbW9j/0z/B5IhsIgjCGGIggPgzH2a2kf8lCPtCAViEbdArf5TNF47F4vDiwqwqK8nanQ2IxzwrCWF/bqXSaAh7iIZDukEgEpLe7ZaNh/R7fLFa+7aaPXaA9EsQ9oX0SxD2hfRLEPaF9EsQ9oX0ay2q1Rqu31wdtRmETdDSb+a3fweOen1EFhEEYRTnhz4Eh9/PbCP/SxD2hQKwCNtQqdawtr4Bx9EgsimK2C2VUW8II7Zs8AT8PkRC08y23VIZucLOiCwiCHNJb2WQ3srA6+Hh9fAtnUtUqjVUqjVbBoKQfgmrtW+r2WNlSL8EYV9IvwRhX0i/BGFfSL8EYV9Iv9ZDWv8giE5o6bfwX/8bHP/4nRFZRBCEUZpnzyHxP/8Us438L0HYGwrAImxDUxSxnc2P2oyhMzkxgaXkPLNt/+AAq6n1EVlEEINDCvwYF0i/hByrtW+r2WM1SL8EYV9IvwRhX0i/BGFfSL8EYV9IvwRhX7T0KwoCqp/7HDid3xAEYQ0OHA6E/vUvM9vI/xKE/aHSvwRhcRLxGHi3i9m2uZVBrd4YkUUEQRiF9EsQ9oX0SxD2hfRLEPaF9EsQ9oX0SxD2hfRLEPZFS7/bf/BlcFtbI7KIIAijHDz2GLynVpht5H8Jwv5QABZBWBiX04n5xAyzrSEIWN/cHpFFBEEYhfRLEPaF9EsQ9oX0SxD2hfRLEPaF9EsQ9oX0SxD2RUu/tVQK+PP/Z0QWEQRhFDEcRvzJX2C2kf8liPGAArAIwsIsJucwOcnKdC2Vxv7+/ogsIgjCKKRfgrAvpF+CsC+kX4KwL6RfgrAvpF+CsC+kX4KwL1r6zf3mb2NiTxiRRQRBGMX99NPgeJ7ZRv6XIMYDCsAiCIsSCgYQCgaYbYXiLgrF3RFZRBCEUUi/BGFfSL8EYV9IvwRhX0i/BGFfSL8EYV9IvwRhX7T0m/vGN+F4/bURWUQQhFGaDzyAyDt/nNlG/pcgxgcKwCIICzI5OYnF5ByzbX9/H2up9IgsIgjCKKRfgrAvpF+CsC+kX4KwL6RfgrAvpF+CsC+kX4KwL1r6FWs11L/4xRFZRBCEUQ6mnIj88keZbeR/CWK8cHT9A44bhB0EQciYn43D5XQy2za2MhBFkTRIEBaH9EsQ9oX0SxD2hfRLEPaF9EsQ9oX0SxD2hfRLEPZFS79bf/CHmKjVsc97RmQVQRBGmHz8cfDJJLON/C9BWJOmKPb0O8qARRAWw+12IR6LMNvqjQa2srkRWUQQhFFIvwRhX0i/BGFfSL8EYV9IvwRhX0i/BGFfSL8EYV+09Fu9dQv424sjsoggCKPsx2cw88T/wmwj/0sQ48f/D59wXeBvSQviAAAAAElFTkSuQmCC'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>9. Public Records</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>This section includes public record items Equifax obtained from local, state and federal courts through a third party vendor, LexisNexis. They can be contacted at: https://equifaxconsumers.lexisnexis.com</xsl:text>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<fo:block>
					<xsl:text>LexisNexis Consumer Center</xsl:text>
				</fo:block>
				<fo:block>
					<xsl:text>P.O. Box 105615</xsl:text>
				</fo:block>
				<fo:block>
					<xsl:text>Atlanta, GA 30348-5108</xsl:text>
				</fo:block>
			</fo:block>
		</fo:block>

		<!-- BANKRUPTCIES -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Bankruptcies</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Bankruptcies are a legal status granted by a federal court that indicates you are unable to pay off outstanding debt. Bankruptcies stay on your credit report for up to 10 years, depending on the chapter of bankruptcy you file for. They generally have a negative impact on your credit score.</xsl:text>
			</fo:block>

			<xsl:choose>
				<xsl:when test="not(/printableCreditReport/creditReport/providerViews/publicRecords/bankruptcies)">
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<xsl:call-template name="func-no-item">
							<xsl:with-param name="item">Bankruptcies</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="class-paragraph">

						<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/publicRecords/bankruptcies">

							<fo:block xsl:use-attribute-sets="class-h4-state">
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text>Reference Number: </xsl:text>
									<xsl:choose>
										<xsl:when test="not(referenceNumber) or string(referenceNumber) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="referenceNumber" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-comments-label">
								<xsl:text>Status</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell-pub">
								<xsl:choose>
									<xsl:when test="not(dispositionStatus) or not(dispositionStatus/description) or string(dispositionStatus/description) = 'NaN'">
										<xsl:text/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="dispositionStatus/description" />
									</xsl:otherwise>
								</xsl:choose>
							</fo:block>

							<!-- DATA TABLE -->

							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-body>

									<fo:table-row xsl:use-attribute-sets="class-row-odd">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Date Filed</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(filedDate) or string(filedDate) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatDate">
															<xsl:with-param name="date" select="filedDate" />
															<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Type</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(type) or not(type/description) or string(type/description) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="type/description" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Verified Date</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(verifiedDate) or string(verifiedDate) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatDate">
															<xsl:with-param name="date" select="verifiedDate" />
															<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Filer</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(filer) or not(filer/description) or string(filer/description) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="filer/description" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-odd">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Liability</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(liability) or string(liability) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatMoney">
															<xsl:with-param name="money" select="liability" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Court</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(courtName) or string(courtName) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="courtName" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Exempt Amount</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(exemptAmount) or string(exemptAmount) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatMoney">
															<xsl:with-param name="money" select="exemptAmount" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Asset Amount</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(assetAmount) or string(assetAmount) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatMoney">
															<xsl:with-param name="money" select="assetAmount" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
							<fo:table xsl:use-attribute-sets="class-table-comments">

								<fo:table-column column-width="7.5in" />

								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-comments-label">
												<xsl:text>Prior Disposition</xsl:text>
											</fo:block>
											<fo:block xsl:use-attribute-sets="class-comments">
												<xsl:choose>
													<xsl:when test="not(priorDispositionCode) or not(priorDispositionCode/description) or string(priorDispositionCode/description) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatPriorDisposition">
															<xsl:with-param name="item" select="priorDispositionCode/description" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>

							</fo:table>
							<fo:table xsl:use-attribute-sets="class-table-comments">

								<fo:table-column column-width="7.5in" />

								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-comments-label">
												<xsl:text>Comments</xsl:text>
											</fo:block>
											<fo:block xsl:use-attribute-sets="class-comments">
												<xsl:choose>
													<xsl:when test="(count(comments) &gt; 0) and string(comments) != 'NaN'">
														<xsl:for-each select="comments">
															<xsl:choose>
																<xsl:when test="(description) and (description!='') and string(description) != 'NaN'">
																	<fo:block>
																		<xsl:value-of select="description" />
																	</fo:block>
																</xsl:when>
																<xsl:otherwise>
																	<fo:block>
																		<xsl:text/>
																	</fo:block>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<fo:block xsl:use-attribute-sets="class-cell class-cell">
															<xsl:text/>
														</fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>

							</fo:table>

						</xsl:for-each>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>

		<!-- JUDGMENTS -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Judgments</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Judgments are a legal status granted by a court that indicates you must pay back an outstanding debt. Judgments stay on your credit report up to 7 years from the date filed and generally have a negative impact on your credit score.</xsl:text>
			</fo:block>

			<xsl:choose>
				<xsl:when test="not(/printableCreditReport/creditReport/providerViews/publicRecords/judgments)">
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<xsl:call-template name="func-no-item">
							<xsl:with-param name="item">Judgments</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="class-paragraph">

						<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/publicRecords/judgments">


							<fo:block xsl:use-attribute-sets="class-h4-state">
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text>Case/Docket # </xsl:text>
									<xsl:choose>
										<xsl:when test="not(caseDocumentNumber) or string(caseDocumentNumber) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="caseDocumentNumber" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:block>

							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="1.75in" />

								<fo:table-body>

									<fo:table-row xsl:use-attribute-sets="class-row-odd">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Date Filed</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(filedDate) or string(filedDate) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatDate">
															<xsl:with-param name="date" select="filedDate" />
															<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Plaintiff</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(plaintiff) or string(plaintiff) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="plaintiff" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Court</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(courtName) or string(courtName) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="courtName" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Date Verified</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(verifiedDate) or string(verifiedDate) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatDate">
															<xsl:with-param name="date" select="verifiedDate" />
															<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-odd">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Defendant</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(defendant) or string(defendant) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="defendant" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Status</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(status/description) or string(status/description) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="status/description" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Amount</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(amount) or string(amount) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatMoney">
															<xsl:with-param name="money" select="amount" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Date Satisfied</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(satisfiedDate) or string(satisfiedDate) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatDate">
															<xsl:with-param name="date" select="satisfiedDate" />
															<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>

							<fo:table xsl:use-attribute-sets="class-table-comments">
								<fo:table-column column-width="7.5in" />

								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-comments-label">
												<xsl:text>Comments</xsl:text>
											</fo:block>
											<fo:block xsl:use-attribute-sets="class-comments">
												<xsl:choose>
													<xsl:when test="(count(comments) &gt; 0)">
														<xsl:for-each select="comments">
															<xsl:choose>
																<xsl:when test="(description) and (description!='')">
																	<fo:block>
																		<xsl:value-of select="description" />
																	</fo:block>
																</xsl:when>
																<xsl:otherwise>
																	<fo:block>
																		<xsl:text/>
																	</fo:block>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>
															<xsl:text/>
														</fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>

						</xsl:for-each>

					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>

		<!-- LIENS -->
		<fo:block>
			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:text>Liens</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>A lien is a legal claim on an asset, and Equifax only collects tax related liens. Liens stay on your credit report up to 10 years and generally have a negative impact on your credit score.</xsl:text>
			</fo:block>

			<xsl:choose>
				<xsl:when test="not(/printableCreditReport/creditReport/providerViews/publicRecords/liens)">
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<xsl:call-template name="func-no-item">
							<xsl:with-param name="item">Liens</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="class-paragraph">



						<xsl:for-each select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/publicRecords/liens">

							<fo:block xsl:use-attribute-sets="class-h4-state">
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text>Case/Docket # </xsl:text>
									<xsl:choose>
										<xsl:when test="not(caseDocumentNumber) or string(caseDocumentNumber) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="caseDocumentNumber" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:block>



							<!-- DATA TABLE -->

							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-column column-width="1.75in" />
								<fo:table-body>

									<fo:table-row xsl:use-attribute-sets="class-row-odd">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Date Filed</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(filedDate) or string(filedDate) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatDate">
															<xsl:with-param name="date" select="filedDate" />
															<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Date Reported</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(verifiedDate) or string(verifiedDate) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatDate">
															<xsl:with-param name="date" select="verifiedDate" />
															<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Court</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(courtName) or string(courtName) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="courtName" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Status</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(status) or string(status) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="status" />
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row xsl:use-attribute-sets="class-row-odd">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Lien Amount</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="not(lienAmount) or string(lienAmount) = 'NaN'">
														<xsl:text/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="func-formatMoney">
															<xsl:with-param name="money" select="lienAmount" />
														</xsl:call-template>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-label class-cell">
												<xsl:text>Lien Class</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
												<xsl:choose>
													<xsl:when test="(lienClass/description) and (lienClass/description!='')">
														<xsl:value-of select="lienClass/description" />
													</xsl:when>
													<xsl:otherwise>
														<xsl:text/>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>

							<fo:table xsl:use-attribute-sets="class-table-comments">
								<fo:table-column column-width="7.5in" />

								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-even">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-comments-label">
												<xsl:text>Comments</xsl:text>
											</fo:block>
											<fo:block xsl:use-attribute-sets="class-comments">
												<xsl:choose>
													<xsl:when test="(count(comments) &gt; 0)">
														<xsl:for-each select="comments">
															<xsl:choose>
																<xsl:when test="(description) and (description!='')">
																	<fo:block>
																		<xsl:value-of select="description" />
																	</fo:block>
																</xsl:when>
																<xsl:otherwise>
																	<fo:block>
																		<xsl:text/>
																	</fo:block>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:for-each>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>
															<xsl:text/>
														</fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</xsl:for-each>

					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>

	</xsl:template>

	<xsl:template name="section-collections">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'" />
					<xsl:with-param name="height" select="'0.16in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</fo:marker>
			<xsl:text>10. Collections</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>Collections are accounts with outstanding debt that have been placed by a creditor with a collection agency. Collections stay on your credit report for up to 7 years from the date the account first became past due. They generally have a negative impact on your credit score.</xsl:text>
		</fo:block>

		<xsl:choose>
			<xsl:when test="not(/printableCreditReport/creditReport/providerViews/collections)">
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:call-template name="func-no-item">
						<xsl:with-param name="item">Collections</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>

				<xsl:for-each select="/printableCreditReport/creditReport/providerViews/collections">


					<fo:block xsl:use-attribute-sets="class-h4-state">
						<fo:block xsl:use-attribute-sets="class-cell">
							<xsl:text>Date Reported:  </xsl:text>
							<xsl:choose>
								<xsl:when test="not(reportedDate) or string(reportedDate) = 'NaN'">
									<xsl:text/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="func-formatDate">
										<xsl:with-param name="date" select="reportedDate" />
										<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</fo:block>
					</fo:block>

					<!-- DATA TABLE -->

					<fo:table xsl:use-attribute-sets="class-table">
						<fo:table-column column-width="1.75in" />
						<fo:table-column column-width="1.75in" />
						<fo:table-column column-width="0.5in" />
						<fo:table-column column-width="1.75in" />
						<fo:table-column column-width="1.75in" />
						<fo:table-body>

							<fo:table-row xsl:use-attribute-sets="class-row-odd">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Collection Agency</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(agencyClient) or string(agencyClient) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="agencyClient" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Balance Date</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(balanceDate) or string(balanceDate) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="balanceDate" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>

							<fo:table-row xsl:use-attribute-sets="class-row-even">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Original Creditor Name</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(originalCreditorName) or string(originalCreditorName) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="originalCreditorName" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Account Designator Code</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(accountDesignatorCode) or string(accountDesignatorCode) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="accountDesignatorCode" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>

							<fo:table-row xsl:use-attribute-sets="class-row-odd">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Date Assigned</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(assignedDate) or string(assignedDate) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="assignedDate" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Account Number</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(accountNumber) or string(accountNumber) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="accountNumber" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>

							<fo:table-row xsl:use-attribute-sets="class-row-even">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Original Amount Owed</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(orginalAmountOwed) or string(orginalAmountOwed) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatMoney">
													<xsl:with-param name="money" select="orginalAmountOwed" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Creditor Classification</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(creditorClassification) or not(creditorClassification/description) or string(creditorClassification/description) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="creditorClassification/description" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>

							<fo:table-row xsl:use-attribute-sets="class-row-odd">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Amount</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(amount) or string(amount) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatMoney">
													<xsl:with-param name="money" select="amount" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Last Payment Date</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(lastPaymentDate) or string(lastPaymentDate) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="lastPaymentDate" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>

							<fo:table-row xsl:use-attribute-sets="class-row-even">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Status Date</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(statusDate) or string(statusDate) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="statusDate" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Date of First Delinquency</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(dateOfFirstDelinquency) or string(dateOfFirstDelinquency) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="func-formatDate">
													<xsl:with-param name="date" select="dateOfFirstDelinquency" />
													<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>

							<fo:table-row xsl:use-attribute-sets="class-row-odd">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text>Status</xsl:text>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:choose>
											<xsl:when test="not(status) or string(status) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="status" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-label class-cell">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
										<xsl:text/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>

						</fo:table-body>
					</fo:table>

					<!-- COMMENTS AND CONTACTS -->
					<fo:block xsl:use-attribute-sets="class-paragraph" page-break-inside="avoid">

						<fo:table xsl:use-attribute-sets="class-table">
							<fo:table-column column-width="60%" />
							<fo:table-column column-width="40%" />
							<fo:table-body>
								<fo:table-row>

									<!-- COMMENTS -->
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-h3">
											Comments
										</fo:block>
										<xsl:for-each select="comments">
											<fo:block xsl:use-attribute-sets="class-paragraph">
												<xsl:choose>
													<xsl:when test="(description) and (description!='') and string(description) != 'NaN'">
														<xsl:value-of select="description" />
													</xsl:when>
													<xsl:otherwise>
														<xsl:text/>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</xsl:for-each>
									</fo:table-cell>

									<!-- CONTACTS -->
									<fo:table-cell>
										<fo:block xsl:use-attribute-sets="class-h3">
											Contact
										</fo:block>
										<fo:block xsl:use-attribute-sets="class-paragraph">
											<xsl:choose>
												<xsl:when test="not(agencyContactInformation/contactName) or string(agencyContactInformation/contactName) = 'NaN'">
													<xsl:text/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="agencyContactInformation/contactName" />
												</xsl:otherwise>
											</xsl:choose>
											<xsl:choose>
												<xsl:when test="not(agencyContactInformation/address) or string(agencyContactInformation/address) = 'NaN'">
													<xsl:text/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:call-template name="func-formatAddress">
														<xsl:with-param name="address" select="agencyContactInformation/address" />
													</xsl:call-template>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:choose>
												<xsl:when test="not(agencyContactInformation/phone) or string(agencyContactInformation/phone) = 'NaN'">
													<xsl:text/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:call-template name="func-formatPhone">
														<xsl:with-param name="phone" select="agencyContactInformation/phone" />
													</xsl:call-template>
												</xsl:otherwise>
											</xsl:choose>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>

					</fo:block>

					<fo:block page-break-before="always" />

				</xsl:for-each>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-disputeInfo">
		<fo:block xsl:use-attribute-sets="class-h1">
			<fo:marker marker-class-name="footer">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'7.5in'"/>
					<xsl:with-param name="height" select="'0.16in'"/>
					<xsl:with-param name="imagePath"
									select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAtAAAAAPAQMAAAD3bmoMAAAAA1BMVEX///+nxBvIAAAAE0lEQVQYGWMYBaNgFIyCUUA9AAAFVQABwxbEAwAAAABJRU5ErkJggg=='"/>
				</xsl:call-template>
			</fo:marker>
			<xsl:text>11. Dispute File Information</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>If you believe that any of the information found on this report is incorrect, there are 3 ways to launch an investigation about the information in this report.</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>When you file a dispute, the credit bureau you contact is required to investigate your dispute within 30 days. They will not remove accurate data unless it is outdated or cannot be verified.</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>To initiate a dispute online please visit </xsl:text>
			<xsl:call-template name="element-a">
				<xsl:with-param name="href" select="'https://www.ai.equifax.com'" />
				<xsl:with-param name="text" select="'https://www.ai.equifax.com'" />
			</xsl:call-template>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<xsl:text>To check the status or view the results of your dispute please visit </xsl:text>
			<xsl:call-template name="element-a">
				<xsl:with-param name="href" select="'https://www.ai.equifax.com'" />
				<xsl:with-param name="text" select="'https://www.ai.equifax.com'" />
			</xsl:call-template>
		</fo:block>
	</xsl:template>

	<xsl:template name="section-summaryOfRights">
		<!--<xsl:variable name="rights" select="/printableCreditReport/properties/entry/key[text()='fo-FCRA-rights']/../value" />
        <xsl:value-of select="$rights" disable-output-escaping="yes"/>-->
		<fo:block text-align="center"><fo:inline font-style="italic" font-size="8pt">Para información en español, visite www.consumerfinance.gov/learnmore o escribe a la</fo:inline></fo:block>
		<fo:block text-align="center" space-after="5pt"><fo:inline font-style="italic" font-size="8pt">Consumer Financial Protection Bureau, 1700 G Street N.W., Washington, DC 20552.</fo:inline></fo:block>
		<fo:block xsl:use-attribute-sets="class-h1">
			<xsl:text>12. A Summary of Your Rights Under the Fair Credit Reporting Act</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">

			The federal Fair Credit Reporting Act (FCRA) promotes the accuracy, fairness, and privacy of information in the files of consumer reporting agencies. There are many types of consumer reporting agencies, including credit bureaus and specialty agencies (such as agencies that sell information about check writing histories, medical records, and rental history records). Here is a summary of your major rights under FCRA. <fo:inline font-weight="bold">For more information, including information about additional rights, go to </fo:inline>
			<xsl:call-template name="element-a">
				<xsl:with-param name="href" select="'https://www.consumerfinance.gov/learnmore'" />
				<xsl:with-param name="text" select="'www.consumerfinance.gov/learnmore'" />
			</xsl:call-template> <fo:inline font-weight="bold"> or write to: Consumer Financial Protection Bureau, 1700 G Street N.W., Washington, DC 20552.</fo:inline>

		</fo:block>
		<fo:list-block provisional-distance-between-starts="0.4cm" xsl:use-attribute-sets="list-format">
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">You must be told if information in your file has been used against you.</fo:inline> Anyone who uses a credit report or another type of consumer report to deny your application for credit, insurance, or employment – or to take another adverse action against you – must tell you, and must give you the name, address, and phone number of the agency that provided the information.</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()" padding-right ="0.2in">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">You have the right to know what is in your file. </fo:inline> You may request and obtain all the information about you in the files of a consumer reporting agency (your “file disclosure”). You will be required to provide proper identification, which may include your Social Security number. In many cases, the disclosure will be free. You are entitled to a free file disclosure if:</fo:block>
					<fo:list-block xsl:use-attribute-sets="list-format">
						<fo:list-item padding-top="5pt">
							<fo:list-item-label>
								<fo:block margin-left="30px">o	</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block margin-left="35px">a person has taken adverse action against you because of information in your credit report;</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item padding-top="5pt">
							<fo:list-item-label>
								<fo:block margin-left="30px">o	</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block margin-left="35px">you are the victim of identity theft and place a fraud alert in your file;</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item padding-top="5pt">
							<fo:list-item-label>
								<fo:block margin-left="30px">o	</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block margin-left="35px">your file contains inaccurate information as a result of fraud;</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item padding-top="5pt">
							<fo:list-item-label>
								<fo:block margin-left="30px">o	</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block margin-left="35px">you are on public assistance;</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item padding-top="5pt">
							<fo:list-item-label>
								<fo:block margin-left="30px">o	</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block margin-left="35px">you are unemployed but expect to apply for employment within 60 days.</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
					<fo:block xsl:use-attribute-sets="class-paragraph">
						In addition, all consumers are entitled to one free disclosure every 12 months upon request from each nationwide credit bureau and from nationwide specialty consumer reporting agencies. See
						<xsl:call-template name="element-a">
							<xsl:with-param name="href" select="'https://www.consumerfinance.gov/learnmore'" />
							<xsl:with-param name="text" select="'www.consumerfinance.gov/learnmore'" />
						</xsl:call-template> for additional information.
					</fo:block>
				</fo:list-item-body>
			</fo:list-item>

			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">You have the right to ask for a credit score. </fo:inline> Credit scores are numerical summaries of your credit-worthiness based on information from credit bureaus. You may request a credit score from consumer reporting agencies that create scores or distribute scores used in residential real property loans, but you will have to pay for it. In some mortgage transactions, you will receive credit score information for free from the mortgage lender.</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">You have the right to dispute incomplete or inaccurate information.</fo:inline>If you identify information in your file that is incomplete or inaccurate, and report it to the consumer reporting agency, the agency must investigate unless your dispute is frivolous. See
						<xsl:call-template name="element-a">
							<xsl:with-param name="href" select="'https://www.consumerfinance.gov/learnmore'" />
							<xsl:with-param name="text" select="'www.consumerfinance.gov/learnmore'" />
						</xsl:call-template>  for an explanation of dispute procedures.
					</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px" space-before="5px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px" space-before="50px"><fo:inline font-weight="bold">Consumer reporting agencies must correct or delete inaccurate, incomplete, or unverifiable information.</fo:inline> Inaccurate, incomplete, or unverifiable information must be removed or corrected, usually within 30 days. However, a consumer reporting agency may continue to report information it has verified as accurate.</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px" space-before="5px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px" space-before="5px"><fo:inline font-weight="bold">Consumer reporting agencies may not report outdated negative information.</fo:inline> In most cases, a consumer reporting agency may not report negative information that is more than seven years old, or bankruptcies that are more than 10 years old.</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px" space-before="5px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px" space-before="5px"><fo:inline font-weight="bold">Access to your file is limited.</fo:inline> A consumer reporting agency may provide information about you only to people with a valid need – usually to consider an application with a creditor, insurer, employer, landlord, or other business. The FCRA specifies those with a valid need for access.</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">You must give your consent for reports to be provided to employers.</fo:inline>A consumer reporting agency may not give out information about you to your employer, or a potential employer, without your written consent given to the employer. Written consent generally is not required in the trucking industry. For more information, go to
						<xsl:call-template name="element-a">
							<xsl:with-param name="href" select="'https://www.consumerfinance.gov/learnmore'" />
							<xsl:with-param name="text" select="'www.consumerfinance.gov/learnmore.'" />
						</xsl:call-template>
					</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">You may limit “prescreened” offers of credit and insurance you get based on information in your credit report.</fo:inline> Unsolicited “prescreened” offers for credit and insurance must include a toll-free phone number you can call if you choose to remove your name and address form the lists these offers are based on. You may opt out with the nationwide credit bureaus at 1-888-5-OPTOUT (1-888-567-8688).</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="15pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px">The following FCRA right applies with respect to nationwide consumer reporting agencies:</fo:block>
					<fo:block xsl:use-attribute-sets="class-h3" margin-left="25px">CONSUMERS HAVE THE RIGHT TO OBTAIN A SECURITY FREEZE</fo:block>
					<fo:block xsl:use-attribute-sets="class-paragraph" margin-left="25px">
						<fo:inline font-weight="bold">You have a right to place a “security freeze” on your credit report, which will prohibit a consumer reporting agency from releasing information in your credit report without your express authorization.</fo:inline> The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent.
						However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, or any other account involving the extension of credit.
					</fo:block>
					<fo:block xsl:use-attribute-sets="class-paragraph" margin-left="25px">
						As an alternative to a security freeze, you have the right to place an initial or extended fraud alert on your credit file at no cost. An initial fraud alert is a 1-year alert that is placed on a consumer’s credit file. Upon seeing a fraud alert display on a consumer’s credit file, a business is required to take steps to verify the consumer’s identity before extending new credit. If you are a victim of identity theft, you are entitled to an extended fraud alert, which is a fraud alert lasting 7 years.
					</fo:block>
					<fo:block xsl:use-attribute-sets="class-paragraph" margin-left="25px">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">You may seek damages from violators.</fo:inline> If a consumer reporting agency, or, in some cases, a user of consumer reports or a furnisher of information to a consumer reporting agency violates the FCRA, you may be able to sue in state or federal court.</fo:block>
				</fo:list-item-body>
			</fo:list-item>
			<fo:list-item padding-top="5pt">
				<fo:list-item-label>
					<fo:block margin-left="20px">&#x2022;</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()">
					<fo:block margin-left="25px"><fo:inline font-weight="bold">Identity theft victims and active duty military personnel have additional rights.</fo:inline> For more information,
						<xsl:call-template name="element-a">
							<xsl:with-param name="href" select="'https://www.consumerfinance.gov/learnmore'" />
							<xsl:with-param name="text" select="'www.consumerfinance.gov/learnmore'" />
						</xsl:call-template>
					</fo:block>
				</fo:list-item-body>
			</fo:list-item>


		</fo:list-block>
		<fo:block space-before="20pt"><fo:inline font-weight="bold">States may enforce the FCRA, and many states have their own consumer reporting laws. In some cases, you may have more rights under state law. For more information, contact your state or local consumer protection agency or your state Attorney General. For information about your federal rights, contact (see next page):</fo:inline></fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" space-after="20pt" page-break-before="always">
			<fo:table xsl:use-attribute-sets="class-table class-table-with-border" margin="5px">
				<fo:table-column column-width="50%" />
				<fo:table-column column-width="50%" />
				<fo:table-body>
					<fo:table-row xsl:use-attribute-sets="class-header">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell ">
								<xsl:text>TYPE OF BUSINESS:</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell ">
								<xsl:text>CONTACT:</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>1.a. Banks, savings associations, and credit unions with total assets of over $10 billion and their affiliates</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>b. Such affiliates that are not banks, savings associations, or credit unions also should list, in addition to the CFPB:</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>a.Consumer Financial Protection Bureau 1700 G Street, N.W.Washington, DC 20552</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>b.Federal Trade Commission Consumer Response Center 600 Pennsylvania Avenue, N.W. Washington, DC 20580 (877) 382-4357</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>2.To the extent not included in item 1 above: a.National banks, federal savings associations, and federal branches and federal agencies of foreign banks</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>b.State member banks, branches and agencies of foreign banks (other than federal branches, federal agencies, and Insured State Branches of Foreign Banks), commercial lending companies owned or controlled by foreign banks, and organizations operating under section 25 or 25A of the Federal Reserve Act.</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>c.Nonmember Insured Banks, Insured State Branches of Foreign Banks, and insured state savings associations</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>d.Federal Credit Unions</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>a.Office of the Comptroller of the Currency Customer Assistance Group 1301 McKinney Street, Suite 3450 Houston, TX 77010-9050 </xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell" padding-top="20pt">
								<xsl:text>b.Federal Reserve Consumer Help Center P.O. Box 1200 Minneapolis, MN 55480 </xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell" padding-top="35pt">
								<xsl:text>c.FDIC Consumer Response Center 1100 Walnut Street, Box #11 Kansas City, MO 64106</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-cell" padding-bottom="1pt">
								<xsl:text>d.National Credit Union Administration Office of Consumer Financial Protection (OCFP) Division of Consumer Compliance Policy and Outreach 1775 Duke Street Alexandria, VA 22314 </xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>3.Air carriers</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>Asst. General Counsel for Aviation Enforcement &amp; Proceedings Aviation Consumer Protection Division Department of Transportation 1200 New Jersey Avenue, S.E. Washington, DC 20590</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>4.Creditors Subject to the Surface Transportation Board</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>Office of Proceedings, Surface Transportation Board Department of Transportation 395 E Street, S.W. Washington, DC 20423 </xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>5.Creditors Subject to the Packers and Stockyards Act, 1921</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>Nearest Packers and Stockyards Administration area supervisor</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>6.Small Business Investment Companies</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>Associate Deputy Administrator for Capital Access United States Small Business Administration
409 Third Street, S.W., Suite 8200
Washington, DC 20416
</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>7.Brokers and Dealers</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>Securities and Exchange Commission 100 F Street, N.E. Washington, DC 20549 </xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>8.Federal Land Banks, Federal Land Bank Associations, Federal Intermediate Credit Banks, and Production Credit Associations</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>Farm Credit Administration 1501 Farm Credit Drive McLean, VA 22102-5090</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row text-align="left">
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>9.Retailers, Finance Companies, and All Other Creditors Not Listed Above</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell border-width="0.5mm" border-style="solid">
							<fo:block xsl:use-attribute-sets="class-cell">
								<xsl:text>Federal Trade Commission Consumer Response Center 600 Pennsylvania Avenue, N.W. Washington, DC 20580 (877) 382-4357 </xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>

				</fo:table-body>
			</fo:table>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-h3" page-break-before="always" text-align="center">
			<fo:inline font-style="italic"><xsl:text>Commonly Asked Questions About Credit Files</xsl:text></fo:inline>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<fo:inline font-weight="bold" font-style="italic"><![CDATA[Q.  How can I correct a mistake in my credit file?]]></fo:inline>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<fo:inline font-weight="bold">A. </fo:inline><xsl:text>Complete the Research Request form and give details of the information you believe is incorrect. We will then check with the credit grantor, collection agency or public record source to see if any error has been reported.  Information that cannot be verified will be removed from your file. If you and a credit grantor disagree on any information, you will need to resolve the dispute directly with the credit grantor who is the source of the information in question.</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<fo:inline font-weight="bold" font-style="italic"><![CDATA[Q.  If I do have credit problems, is there someplace where I can get advice and assistance?]]></fo:inline>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<fo:inline font-weight="bold">A. </fo:inline><xsl:text><![CDATA[Yes, there are a number of organizations that offer assistance. For example, the Consumer Credit Counseling Service (CCCS) is a non-profit organization that offers free or low-cost financial counseling to help people solve their financial problems. CCCS can help you analyze your situation and work with you to develop solutions. There are more than 600 CCCS offices throughout the country.  Call 1 (800) 388-2227 for the telephone number of the office nearest you.]]></xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-h3" space-before="10pt" text-align="center">
			<fo:inline font-style="italic"><xsl:text>Facts You Should Know</xsl:text></fo:inline>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<fo:inline font-weight="bold">o </fo:inline><xsl:text>The length of time an account or record remains in your credit file is shown below:</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" text-align="left" margin-left="35px">
			<xsl:text>Collection Agency Accounts: Remain up to 7 years from the Date of First Delinquency.</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" text-align="left" margin-left="35px">
			<xsl:text>Credit or Other reported accounts: Accounts paid as agreed remain for up to 10 years from the date last reported by the lender. Accounts not paid as agreed (i.e., delinquent, charged off, accounts placed for collection) remain for up to 7 years from the Date of First Delinquency.</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" text-align="left" margin-left="35px">
			<xsl:text>Public Records: Bankruptcy-</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" text-align="left" margin-left="87px">
			<xsl:text>Chapter 7 or 11 bankruptcies filed and discharged remain for 10 years from the date filed. </xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" text-align="left" margin-left="87px">
			<xsl:text>Chapter 12 and 13 bankruptcies remain for 7 years from the date filed. </xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" text-align="left" margin-left="87px">
			<xsl:text>Dismissed bankruptcies (all chapters) remain for 7 years from the date filed. </xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph" margin-left="25px">
			<fo:inline font-weight="bold">New York Residents Only </fo:inline><xsl:text>(must be a current resident): Paid collections remain on your Equifax credit report for 5 years from the date of the first missed payment. A paid Charged Off account remains on the file for 5 years from the Date of First Delinquency.</xsl:text>
		</fo:block>
		<fo:block xsl:use-attribute-sets="class-paragraph">
			<fo:inline font-weight="bold">o </fo:inline><xsl:text>Name, address, and Social Security Number information may be provided to businesses that have a legitimate need to locate or identify a consumer.</xsl:text>
		</fo:block>

		<fo:block xsl:use-attribute-sets="class-paragraph">
			<fo:table xsl:use-attribute-sets="class-table class-table-with-border">
				<fo:table-column column-width="100%" />
				<fo:table-body>
					<fo:table-row text-align="left" margin="5px">
						<fo:table-cell>
							<fo:block xsl:use-attribute-sets="class-paragraph">
								<fo:inline font-weight="bold" font-style="italic">Additional Notice to Consumer:</fo:inline>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-paragraph">
								<xsl:text>You may request a description of the procedure used to determine the accuracy and completeness of the information, including the business name and address of the furnisher of information contacted, and if reasonably available the telephone number.</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-paragraph">
								<xsl:text>If the reinvestigation does not resolve your dispute, you have the right to add a statement to your credit file disputing the accuracy or completeness of the information; the statement should be brief and may be limited to not more than one hundred words  explaining the nature of your dispute.</xsl:text>
							</fo:block>
							<fo:block xsl:use-attribute-sets="class-paragraph">
								<xsl:text>If the reinvestigation results in the deletion of disputed information, or you submit a statement in accordance with the preceding paragraph, you have the right to request that we send your revised credit file to any company specifically designated by you that received your credit report in the past six months (twelve months for California, Colorado, Maryland, New Jersey and New York residents) for any purpose or in the past two years for employment purposes.</xsl:text>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>

	</xsl:template>

	<xsl:template name="section-remedyingIdentityTheft">
		<xsl:if test="((/printableCreditReport/creditReport/providerViews/summary/fraudVictimAlert) and /printableCreditReport/creditReport/providerViews/summary/fraudVictimAlert!='')">

			<!-- DOESN'T WORK
    <xsl:variable name="theft" select="/printableCreditReport/properties/entry/key[text()='fo-identity-theft']/../value" />
    <xsl:value-of select="$theft" disable-output-escaping="yes"/>-->
			<fo:block xsl:use-attribute-sets="class-h1">
				<xsl:text>Remedying the Effects of Identity Theft</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>
                You are receiving this information because you have notified a consumer reporting agency that you believe that you are a victim of identity theft. Identity theft occurs when someone uses your name, Social Security number, date of birth, or other identifying information, without authority, to commit fraud. For example, someone may have committed identity theft by using your personal information to open a credit card account or get a loan in your name. For more information, visit
				</xsl:text>
				<xsl:call-template name="element-a">
					<xsl:with-param name="href" select="'https://www.consumerfinance.gov/learnmore'" />
					<xsl:with-param name="text" select="'www.consumerfinance.gov/learnmore'" />
				</xsl:call-template>
				<xsl:text> or write to: Consumer Financial Protection Bureau, 1700 G Street N.W., Washington, DC 20552.</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>
                The Fair Credit Reporting Act (FCRA) gives you specific rights when you are, or believe that you are, the victim of identity theft. Here is a brief summary of the rights designed to help you recover from identity theft.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphBoldStart">
				<xsl:text>
                You have the right to ask that nationwide consumer reporting agencies place "fraud alerts" in your file to let potential creditors and others know that you may be a victim of identity theft.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphEnd">
				<xsl:text>
                A fraud alert can make it more difficult for someone to get credit in your name because it tells creditors to follow certain procedures to protect you. It also may delay your ability to obtain credit. You may place a fraud alert in your file by calling just one of the three nationwide consumer reporting agencies. As soon as that agency processes your fraud alert, it will notify the other two, which then also must place fraud alerts in your file.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<fo:table xsl:use-attribute-sets="class-table">
					<fo:table-column column-width="34%" />
					<fo:table-column column-width="33%" />
					<fo:table-column column-width="33%" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block text-align="left">
									<fo:block xsl:use-attribute-sets="class-h4">
										<xsl:text>Equifax: 1-800-525-6285; </xsl:text>
										<xsl:call-template name="element-a">
											<xsl:with-param name="href" select="'https://www.equifax.com'" />
											<xsl:with-param name="text" select="'www.equifax.com'" />
										</xsl:call-template>
									</fo:block>
								</fo:block>
								<fo:block text-align="left">
									<fo:block xsl:use-attribute-sets="class-h4">
										<xsl:text>Experian: 1-888-397-3742; </xsl:text>
										<xsl:call-template name="element-a">
											<xsl:with-param name="href" select="'https://www.experian.com'" />
											<xsl:with-param name="text" select="'www.experian.com'" />
										</xsl:call-template>
									</fo:block>
								</fo:block>
								<fo:block text-align="left">
									<fo:block xsl:use-attribute-sets="class-h4">
										<xsl:text>TransUnion: 1-800-680-7289; </xsl:text>
										<xsl:call-template name="element-a">
											<xsl:with-param name="href" select="'https://www.transunion.com'" />
											<xsl:with-param name="text" select="'www.transunion.com'" />
										</xsl:call-template>
									</fo:block>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>An initial fraud alert stays in your file for at least 90 days. An extended alert stays in your file for seven years. To place either of these alerts, a consumer reporting agency will require you to provide appropriate proof of your identity, which may include your Social Security number. If you ask for an extended alert, you will have to provide an identity theft report. An identity theft report includes a copy of a report you have filed with a federal, state, or local law enforcement agency, and additional information a consumer reporting agency may require you to submit. For more detailed information about the identity theft report, visit </xsl:text>
				<xsl:call-template name="element-a">
					<xsl:with-param name="href" select="'https://www.consumerfinance.gov/learnmore'" />
					<xsl:with-param name="text" select="'www.consumerfinance.gov/learnmore'" />
				</xsl:call-template>
				<xsl:text>.</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphBoldStart">
				<xsl:text>You have the right to free copies of the information in your file (your "file disclosure").</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphEnd">
				<xsl:text>
                An initial fraud alert entitles you to a copy of all the information in your file at each of the three nationwide agencies, and an extended alert entitles you to two free file disclosures in a 12-month period following the placing of the alert. These additional disclosures may help you detect signs of fraud, for example, whether fraudulent accounts have been opened in your name or whether someone has reported a change in your address. Once a year, you also have the right to a free copy of the information in your file at any consumer reporting agency, if you believe it has inaccurate information due to fraud, such as identity theft. You also have the ability to obtain additional free file disclosures under other provisions of the FCRA. See
				</xsl:text>
				<xsl:call-template name="element-a">
					<xsl:with-param name="href" select="'https://www.ftc.gov/credit'" />
					<xsl:with-param name="text" select="'www.ftc.gov/credit'" />
				</xsl:call-template>
				<xsl:text>.</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphBoldStart">
				<xsl:text>You have the right to obtain documents relating to fraudulent transactions made or accounts opened using your personal information.</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphEnd">
				<xsl:text>
                A creditor or other business must give you copies of applications and other business records relating to transactions and accounts that resulted from the theft of your identity, if you ask for them in writing. A business may ask you for proof of your identity, a police report, and an affidavit before giving you the documents. It also may specify an address for you to send your request. Under certain circumstances, a business can refuse to provide you with these documents. See
				</xsl:text>
				<xsl:call-template name="element-a">
					<xsl:with-param name="href" select="'https://www.consumer.gov/idtheft'" />
					<xsl:with-param name="text" select="'www.consumer.gov/idtheft'" />
				</xsl:call-template>
				<xsl:text>.</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphBoldStart">
				<xsl:text>You have the right to obtain information from a debt collector.</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphEnd">
				<xsl:text>
                If you ask, a debt collector must provide you with certain information about the debt you believe was incurred in your name by an identity thief - like the name of the creditor and the amount of the debt.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphBoldStart">
				<xsl:text>
                If you believe information in file results from identity theft, you have the right to ask that a consumer reporting agency block that information from your file.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphEnd">
				<xsl:text>
                An identity thief may run up bills in your name and not pay them. Information about the unpaid bills may appear on your consumer report. Should you decide to ask a consumer reporting agency to block the reporting of this information, you must identify the information to block, and provide the consumer reporting agency with proof of your identity and a copy of your identity theft report. The consumer reporting agency can refuse or cancel your request for a block if, for example, you don't provide the necessary documentation, or where the block results from an error or a material misrepresentation of fact made by you. If the agency declines or rescinds the block, it must notify you. Once a debt resulting from identity theft has been blocked, a person or business with notice of the block may not sell, transfer, or place the debt for collection.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphBoldStart">
				<xsl:text>
                You also may prevent businesses from reporting information about you to consumer reporting agencies if you believe the information is a result of identity theft.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraphEnd">
				<xsl:text>
                To do so, you must send your request to the address specified by the business that reports the information to the consumer reporting agency. The business will expect you to identify what information you do not want reported and to provide an identity theft report.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>To learn more about identity theft and how to deal with its consequences, visit </xsl:text>
				<xsl:call-template name="element-a">
					<xsl:with-param name="href" select="'https://www.consumer.gov/idtheft'" />
					<xsl:with-param name="text" select="'www.consumer.gov/idtheft'" />
				</xsl:call-template>
				<xsl:text>
                , or write to the FTC. You may have additional rights under state law. For more information, contact your local consumer protection agency or your state attorney general.
				</xsl:text>
			</fo:block>
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>
                In addition to the new rights and procedures to help consumers deal with the effects of identity theft, the FCRA has many other important consumer protections. They are described in more detail at
				</xsl:text>
				<xsl:call-template name="element-a">
					<xsl:with-param name="href" select="'https://www.ftc.gov/credit'" />
					<xsl:with-param name="text" select="'www.ftc.gov/credit'" />
				</xsl:call-template>
				<xsl:text>.</xsl:text>
			</fo:block>
		</xsl:if>
	</xsl:template>

	<xsl:template name="section-statesRights">
		<xsl:variable name="stateSelector">
			<xsl:value-of select="/printableCreditReport/creditReport/providerViews[provider/text()='EFX']/summary/subject/currentAddress/line4" />
		</xsl:variable>

		<!-- output our stateSelector value for debugging
    <fo:block xsl:use-attribute-sets="class-paragraph">
      <xsl:text>==============stateSelector:</xsl:text><xsl:value-of select="$stateSelector" />
    </fo:block>
 -->

		<xsl:choose>

		<!--	<xsl:when test="$stateSelector='AK'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF ALASKA - NOTICE TO CONSUMERS</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report and credit score for $5 to protect your privacy and ensure that credit is not granted in your name without your knowledge. You may not have to pay the $5 charge if you are a victim of identity theft. You have a right to place a security freeze on your credit report and credit score under state law (AS 45.48.100 - 45.48.290).</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze will prohibit a consumer credit reporting agency from releasing your credit score and any information in your credit report without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and other services from being approved in your name without your consent. However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report and credit score may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, a mortgage, a governmental service, a governmental payment, a cellular telephone, a utility, an Internet credit card application, an extension of credit at point of sale, and other items and services.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">When you place a security freeze on your credit report and credit score, within 10 business days, you will be provided a personal identification number, password, or similar device to use if you choose to remove the freeze on your credit report and credit score or to temporarily authorize the release of your credit report and credit score to a specific third party or specific third parties or for a specific period of time after the freeze is in place. To provide that authorization, you must contact the consumer credit reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>proper identification to verify your identity;</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the personal identification number, password, or similar device provided by the consumer credit reporting agency;</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>proper information necessary to identify the third party or third parties who are authorized to receive the credit report and credit score or the specific period of time for which the credit report and credit score are to be available to third parties.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer credit reporting agency that receives your request to temporarily lift a freeze on a credit report and credit score is required to comply with the request within 15 minutes, except after normal business hours and under certain other conditions, after receiving your request if you make the request by telephone, or an electronic method if the agency provides an electronic method, or within three business days after receiving your request if you make the request by mail. The consumer credit reporting agency may charge you $2 to temporarily lift the freeze.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances where you have an existing account relationship and a copy of your credit report and credit score are requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control, or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around, or specifically for a certain creditor, days before applying for new credit.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under these laws on security freezes. The action can be brought against a consumer credit reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $5.00. If you are the victim of identity theft and you submit a copy of a valid complaint filed with a law enforcement agency, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or specific period of time.</fo:block>
			</xsl:when>
-->
<!--
			<xsl:when test="$stateSelector='AL'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF ALABAMA - NOTICE TO CONSUMERS</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Although your state does not currently have a security freeze law in effect, under the Equifax voluntary security freeze program you may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by certified mail or by electronic means as described below. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific party who is to receive the credit report or the specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the release of your credit report no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or no later than three business days when a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will permanently remove the security freeze from your credit file not later than 3 business days after receiving your request to do so.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes or employment purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect. </fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are the victim of identity theft and you submit a copy of a valid police report, investigative report or complaint you have filed with a law enforcement agency regarding the unlawful use of your personal information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>
			</xsl:when>
-->
<!--
			<xsl:when test="$stateSelector='AR'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">Arkansas - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Arkansas Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to place a security freeze on your credit report, which will prohibit a consumer reporting agency from releasing information in your credit report without your express authorization.  The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, Internet credit card transaction, or other services, including an extension of credit at point of sale.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze on your credit report or authorize the release of your credit report for a period of time after the security freeze is in place. To provide that authorization you must contact the consumer reporting agency by one (1) of the methods that it requires and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Your personal identification number or password;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the period of time for which the credit report shall be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must authorize the release of your credit report for a period of time within fifteen (15) minutes or as soon as practical if good cause exists for the delay, and must remove a security freeze no later than three (3) business days after receiving all of the above items by any method that the consumer reporting agency allows.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or an entity, or its affiliates, or collection agencies acting on behalf of the person or entity with which you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against anyone, including a consumer reporting agency that willfully or negligently fails to comply with any requirement of the Arkansas Consumer Report Security Freeze Act.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency has the right to charge you up to five dollars ($5.00) to place a security freeze on your credit report, to temporarily lift a security freeze on your credit report, or to remove a security freeze from your credit report. However, you shall not be charged any fee if you are at least sixty-five (65) years of age or if you are a victim of identity theft and have submitted, in conjunction with the security freeze request, a copy of a valid investigative report or incident report or complaint with a law enforcement agency alleging the unlawful use of your identifying information by another person.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00. If you are a victim of identity theft and you submit a copy of a valid investigative report, incident report or complaint with a law enforcement agency alleging the unlawful use of your identifying information by another person or you are age 65 or older, no fee will be charged to place a security freeze on your Equifax credit file. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a period of time.</fo:block>
			</xsl:when>
-->
			<xsl:when test="$stateSelector='AZ'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF ARIZONA - Revised Statutes</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer may provide a statement to the consumer reporting agency and, unless there are reasonable grounds to believe that it is frivolous or irrelevant, the consumer reporting agency shall include the statement in the consumer’s credit report if either of the following applies:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The statement is a written explanation regarding an item of information that the consumer reporting agency denies is inaccurate.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The statement is regarding the contents of the consumer’s credit report. The consumer may provide such a statement at any time, and the consumer reporting agency shall not charge the consumer for the statement.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency may limit a consumer’s statement as described above to not more than one hundred words if the consumer reporting agency provides the consumer with assistance in writing the statement.</fo:block>
<!--
				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF ARIZONA - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by mail. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, governfment services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">.
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific period of time for which the credit report is to be available.
								Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $5.00. If you are a victim of identity theft and you submit a copy of a valid police report that alleges a violation of Section 13-2008, 13-2009 or 13-2010, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
-->
			</xsl:when>

			<xsl:when test="$stateSelector='CA'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF CALIFORNIA - Consumer Credit Reporting Agencies Act</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You have a right to obtain a copy of your credit file from a consumer credit reporting agency. You may be charged a reasonable fee not exceeding eight dollars ($8.00). There is no fee, however, if you have been turned down for credit, employment, insurance, or a rental dwelling because of information in your credit report within the preceding 60 days. The consumer credit reporting agency must provide someone to help you interpret the information in your credit file.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You have a right to dispute inaccurate information by contacting the consumer credit reporting agency directly. However, neither you nor any credit repair company or credit service organization has the right to have accurate, current, and verifiable information removed from your credit report. Under the Federal Fair Credit Reporting Act, the consumer credit reporting agency must remove accurate, negative information from your report only if it is over seven (7) years old. Bankruptcy information can be reported for ten (10) years.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">If you have notified a consumer credit reporting agency in writing that you dispute the accuracy of information in your file, the consumer credit reporting agency must then, within 30 business days, reinvestigate and modify or remove inaccurate information. The consumer credit reporting agency may not charge a fee for this service. Any pertinent information and copies of all documents you have concerning an error should be given to the consumer credit reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">If reinvestigation does not resolve the dispute to your satisfaction, you may send a brief statement to the consumer credit reporting agency to keep in your file, explaining why you think the record is inaccurate. The consumer credit reporting agency must include your statement about disputed information in a report it issues about you.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You have a right to receive a record of all inquiries relating to a credit transaction initiated in 12 months preceding your request. This record shall include the recipients of any consumer credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You may request in writing that the information contained in your file not be provided to a third party for marketing purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You have a right to place a "security alert" in your credit report, which will warn anyone who receives information in your credit report that your identity may have been used without your consent. Recipients of your credit report are required to take reasonable steps, including contacting you at the telephone number you may provide with your security alert, to verify your identity prior to lending money, extending credit, or completing the purchase, lease, or rental of goods or services. The security alert may prevent credit, loans, and services from being approved in your name without your consent. However, you should be aware that taking advantage of this right may delay or interfere with the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, or cellular phone or other new account, including an extension of credit at point of sale. If you place a security alert on your credit report, you have a right to obtain a free copy of your credit report at the time the initial one year security alert period expires. A security alert may be requested by calling the following toll-free telephone number: 1-800-525-6285.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You have a right to bring civil action against anyone, including a consumer credit reporting agency, who improperly obtains access to a file, knowingly or willfully misuses file data, or fails to correct inaccurate file data.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph-ca">If you are a victim of identity theft and provide to a consumer credit reporting agency a copy of a valid police report or a valid investigative report made by a Department of Motor Vehicles investigator with peace officer status describing your circumstances, the following shall apply:</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You have a right to have any information you list on the report as allegedly fraudulent promptly blocked so that the information cannot be reported. The information will be unblocked only if (A) the information you provide is a material misrepresentation of the facts, (B) you agree that the information is blocked in error, or (C) you knowingly obtained possession of goods, services, or moneys as result of the blocked transactions. If blocked information is unblocked, you will be promptly notified.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You have a right to receive, free of charge and upon request, one copy of your credit report each month for up to 12 consecutive months.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph-ca">If you have requested the credit file and not the credit score, you may request and obtain a credit score. The charge for the credit score is $7.95. To obtain a credit score from Equifax call 800-685-1111.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph-ca">You may also mail your request to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105379</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30348-5379</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph-ca">Using any other address may delay the processing of your request.  Please enclose a check for $7.95 payable to Equifax Information Services LLC with your request. Also include your complete name, complete address, social security number and date of birth.</fo:block>
<!--
				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The proper information regarding the third party who is to receive the credit report or the period of time for which the report shall be available to users of the credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer credit reporting agency must authorize the release of your credit report no later than three business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply when you have an existing account and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control, or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, you should understand that the procedures involved in lifting a security freeze may slow your application for credit. You should plan ahead and lift a freeze, either completely if you are shopping around, or specifically for a certain creditor, before applying for new credit.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer credit reporting agency may not charge a fee to a consumer for placing or removing a security freeze if the consumer is a victim of identity theft and submits a copy of a valid police report or valid Department of Motor Vehicles investigative report. A person 65 years of age or older with proper identification shall not be charged a fee for placing an initial security freeze, but may be charged a fee of no more than five dollars ($5) for lifting, removing, or replacing a security freeze. All other consumers may be charged a fee of no more than $10.00 for each of these steps.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring civil action against anyone, including a consumer credit reporting agency, who improperly obtains access to a file, knowingly or willfully misuses file data, or fails to correct inaccurate file data.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are a victim of identity theft and provide to a consumer credit reporting agency a copy of a valid police report or a valid investigative report made by a Department of Motor Vehicles investigator with peace officer status describing your circumstances, the following shall apply:</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to have any information you list on the report as allegedly fraudulent promptly blocked so that the information cannot be reported. The information will be unblocked only if (A) the information you provide is a material misrepresentation of the facts, (B) you agree that the information is blocked in error, or (C) you knowingly obtained possession of goods, services, or moneys as result of the blocked transactions. If blocked information is unblocked, you will be promptly notified.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to receive, free of charge and upon request, one copy of your credit report each month for up to 12 consecutive months.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may also mail your request to:</fo:block>SW

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report or valid Department of Motor Vehicles investigative report that alleges a violation of Section 530.5 of the Penal Code or you are age 65 or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Please call 800-685-1111 to learn more about placing a security freeze on your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have requested the credit file and not the credit score, you may request and obtain a credit score.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The charge for the credit score is $7.95. To obtain a credit score from Equifax call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may also mail your request to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105379</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30348-5379</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Using any other address may delay the processing of your request. The credit score is $7.95. Please enclose a check for $7.95 payable to Equifax Information Services LLC with your request. Also include your complete name, complete address, social security number and date of birth.</fo:block>
-->
			</xsl:when>

			<xsl:when test="$stateSelector='CO'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Colorado - Notice to Colorado Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have requested the credit file and not the credit score, you may request and obtain a credit score.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The charge for the credit score is $7.95. To obtain a credit score from Equifax, call 1 (800) 685-1111. For your convenience, our automated ordering system will facilitate the handling and charging of your request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may also mail your request to: Equifax, PO Box 105379, Atlanta, Ga., 30348-5379. Using any other address may delay the processing of your request. The charge for the credit score is $7.95. Please enclose a check for $7.95 payable to Equifax Information Services LLC with your request. Also include your name, address and social security number.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">
					<fo:table xsl:use-attribute-sets="class-table class-table-with-border">
						<fo:table-column column-width="100%" />
						<fo:table-body>
							<fo:table-row text-align="left">
								<fo:table-cell>
									<fo:block xsl:use-attribute-sets="class-paragraph">
										<fo:inline font-weight="bold">Additional Notice to Consumer:</fo:inline>
									</fo:block>
									<fo:block xsl:use-attribute-sets="class-paragraph">
										<xsl:text>You may request a description of the procedure used to determine the accuracy and completeness of the information, including the business name and address of the furnisher of information contacted, and if reasonably available the telephone number.</xsl:text>
									</fo:block>
									<fo:block xsl:use-attribute-sets="class-paragraph">
										<xsl:text>If you still disagree with an item after it has been verified, you may send to us a brief statement, not to exceed one hundred words, explaining the nature of your dispute. Your statement will become part of your credit file and will be disclosed each time that your credit file is accessed.</xsl:text>
									</fo:block>
									<fo:block xsl:use-attribute-sets="class-paragraph">
										<xsl:text>If the reinvestigation results in a change to or deletion of the information you are concerned about, or you submit a statement in accordance with the preceding paragraph, you have the right to request that we send your revised credit file to any company that received your credit file in the past twelve months for any purpose or in the past two years for employment purposes.</xsl:text>
									</fo:block>
									<fo:block xsl:use-attribute-sets="class-paragraph">
										<xsl:text>You may bring an action to enforce any obligation of Equifax Information Services LLC (Equifax) to you under Colorado law in any court of competent jurisdiction as provided by the federal "Fair Credit Reporting Act" or you may submit a claim to binding arbitration after you have followed all dispute procedures in Colorado law and have received this notice or have followed all of the block procedures in Colorado law, or have followed all of the freeze procedures in Colorado law, in the manner set forth in the rules of the American Arbitration Association to determine whether Equifax met its obligations under applicable law. No decision by an arbitrator pursuant to this section shall affect the validity of any obligations or debts owed to any party. If you are successful in such an arbitration proceeding, you shall be compensated for the costs and attorney fees of the proceeding as determined by the court or arbitration. You may not submit more than one action to arbitration against any consumer-reporting agency during any one-hundred-twenty-day period. The results of an arbitration action brought against a consumer reporting agency doing business in this state shall be communicated in a timely manner with all other consumer reporting agencies doing business in this state. If, as a result of an arbitration a determination is made in your favor, any adverse information in your file or record shall be blocked, removed or stricken in a timely manner, or the consumer report shall be frozen within five days of receipt of such determination by the consumer reporting agency. If such adverse information is not so blocked, removed or stricken, or the file is not frozen, you may bring an action against the non-complying agency pursuant to this section notwithstanding the one-hundred-twenty-day waiting period.</xsl:text>
									</fo:block>

								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>

		<!--		<fo:block xsl:use-attribute-sets="class-paragraph">Or, as an alternative, please visit www.equifax.com and explore our Score Power product. The Score Power report enables you to quickly and easily view your credit status, where you stand in the eyes of lenders, and how you compare to the national averages. Access your Score Power 24 hours a day, 7 days a week, in an easy-to-read printable format. It includes:</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Your FICO credit score- the score lenders use- and your Equifax Credit Report</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">An explanation of your credit score that helps you better understand how lenders view your credit risk along with tips on how you can improve your credit score over time</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Access to a dynamic score simulator that analyzes your personal credit information and answers questions such as , What happens to my score if I pay off a credit card or open a new account?</fo:block>


				<fo:block xsl:use-attribute-sets="class-h4-state">STATE CONSUMERS HAVE THE RIGHT TO OBTAIN A SECURITY FREEZE</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your consumer report to protect your privacy and ensure that credit is not granted in your name without your knowledge, except as provided by law. You have a right to place a security freeze on your consumer report to prohibit a consumer reporting agency from releasing any information in your consumer report without your express authorization or approval, except as the law allows.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You will not be initially charged to place a security freeze on your consumer report. However, you will be charged a fee of no more than $10.00 dollars to temporarily lift the freeze for a period of time, to permanently remove the freeze from your consumer report, or when you make a subsequent request for a freeze to be placed on your consumer report. As well, you may be charged a fee of no more than twelve dollars to temporarily lift the freeze for a specific party.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. When you place a security freeze on your consumer report, within ten business days you will be provided procedures for the temporary release of your consumer report to a specific party or parties or for a period of time after the security freeze is in place. To provide that authorization, you must contact the consumer reporting agency and provide the proper information regarding the third party or parties who are to receive the consumer report or the period of time for which the report shall be available to users of the consumer report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from a consumer to temporarily lift a security freeze on a consumer report shall comply with the request no later than three business days after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances where you have an existing account relationship, and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You should be aware that using a security freeze to take control over who gains access to the personal and financial information in your consumer report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding new loans, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, internet credit card transaction, or other services, including an extension of credit at the point of sale. You should plan ahead and lift a security freeze either completely if you are shopping around, or specifically for a certain creditor a few days before actually applying for new credit.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to bring a civil action or submit to binding arbitration against a consumer reporting agency to enforce an obligation under the security freeze law after following specified dispute procedures and having received the necessary notice.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">There is no initial fee to place a security freeze. Include your complete name, complete address, social security number and date of birth.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or period of time.</fo:block>
		-->
			</xsl:when>

			<xsl:when test="$stateSelector='CT'">

				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF CONNECTICUT - Fair Credit Reporting Act</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to obtain a copy of your credit file from a credit reporting agency*. You may be charged a reasonable fee not exceeding $5.00 for your first request in 12 months or $7.50 for any subsequent request in that same 12 month period. There is no fee, however, if you have been turned down for credit, employment, insurance, or a rental dwelling because of information in your credit report within the preceding 60 days. The credit reporting agency* must provide someone to help you interpret the information in your credit file.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to dispute inaccurate information by contacting the credit reporting agency* directly. However, neither you nor any credit repair company or credit service organization has the right to have accurate, current, and verifiable information removed from your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Under the Federal Fair Credit Reporting Act, the credit reporting agency* must remove accurate, negative information from your report only if it is over seven years old. Bankruptcy information can be reported for 10 years.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have notified a credit reporting agency* in writing that you dispute the accuracy of information in your file, the credit reporting agency* must then, within 30 business days, reinvestigate and modify or remove inaccurate information. If you provide additional information to the credit reporting agency*, the agency may extend this time period by 15 business days. The credit reporting agency* shall provide you with a toll-free telephone number to use in resolving the dispute.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The credit reporting agency* may not charge a fee for this service. Any pertinent information and copies of all documents you have concerning an error should be given to the credit reporting agency*.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If the reinvestigation does not resolve the dispute to your satisfaction, you may send a brief statement to the credit reporting agency* to keep in your file, explaining why you think the record is inaccurate. The credit reporting agency* must include your statement about disputed information in a report it issues about you.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to receive a record of all inquiries relating to a credit transaction initiated in 12 months preceding your request which resulted in the provision of a credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request in writing that the information contained in your file not be provided to a third party for marketing purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have reviewed your credit report with the credit reporting agency* and are dissatisfied, you may contact the Connecticut Department of Banking. You have a right to bring civil action against anyone who knowingly or willfully misuses file data or improperly obtains access to your file.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Note: The term "Credit Reporting Agency" is terminology utilized in various Fair Credit Reporting Acts. However with similar meaning, Connecticut's Fair Credit Reporting law uses the term "Credit Rating Agency."</fo:block>

				<!--
				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a security freeze on your credit file which will prohibit a credit reporting agency from releasing any information in your credit file without your express authorization. A security freeze must be requested in writing by certified mail or by electronic means as described below. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit file may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit file, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit file or to authorize the temporary release of your credit report for a specific party or period of time after the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific party who is to receive the credit report or the specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the release of your credit report no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or no later than three business days when a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will permanently remove the security freeze from your credit file not later than 3 business days after receiving your request to do so.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report to a specific party or for a specific period of time.</fo:block>
-->
			</xsl:when>
<!--
			<xsl:when test="$stateSelector='DC'">
				<fo:block xsl:use-attribute-sets="class-h4-state">District of Columbia - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">District of Columbia Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">District of Columbia law gives you the right to place a "security freeze" on your credit report. A security freeze restricts when a credit reporting agency may release information in your credit report without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze is designed to help prevent credit, loans, and services from being approved in your name without your consent.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To obtain a security freeze, you should contact each credit reporting agency. When you place a security freeze on your credit report, the credit reporting agency will send you a personal identification number or password to use if you later choose to lift the freeze from your credit report, or to authorize the release of your credit report to a specific party or parties, or for a specific period of time after the freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Verification of your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Information regarding who may receive the credit report or the period of time for which the report shall be made available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Upon receiving your proper request to lift temporarily a freeze from your credit report, the credit reporting agency shall comply within 3 business days. Beginning September 1, 2008, the credit reporting agency is required to provide methods, including web-based and telephonic methods, for you to request that the freeze be temporarily lifted within 15 minutes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply when you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and consider lifting a freeze - either completely if you are shopping around, or for a specific creditor before actually applying for new credit. Beginning September 1, 2008, you will be able to have a credit reporting agency temporarily lift a freeze on your credit report within 15 minutes of your request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to take legal action against someone who violates your rights under the credit reporting laws. The action can be brought against a credit reporting agency or anyone who fraudulently caused the release of your credit information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft, no fees will be charged. It is requested that you submit a copy of a valid police report that you have filed with a law enforcement agency about the unlawful use of your personal information by another person.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or period of time.</fo:block>
			</xsl:when>
-->
<!--
			<xsl:when test="$stateSelector='DE'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Delaware - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Delaware Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report for no more than $10.00 to protect your privacy and ensure that credit is not granted in your name without your knowledge. You have a right to place a 'security freeze' on your credit report pursuant to Delaware law. The security freeze will prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization or approval. You must separately request, by certified mail, that it be frozen by the three consumer reporting agencies and pay each a $10.00 fee to do so. After January 31, 2009, you will be able to request this freeze from the agencies by e-mail.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. When you place a security freeze on your credit report, you will be sent a personal identification number or password to use if you choose to remove the freeze on your credit report or to temporarily authorize the release of your credit report for a specific period of time after the freeze is in place. To provide that authorization, you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the period of time for which the report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>A consumer reporting agency that receives a request from a consumer to lift temporarily a freeze on a credit report shall comply with the request no later than three business days after receiving the request. By January 31, 2009, the consumer reporting agency must temporarily lift the freeze within 15 minutes of receiving the request.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances where you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, telephone, or insurance account, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze with enough advance notice before you apply for new credit for the lifting to take effect. Until January 31, 2009, you should lift the freeze at least 3 business days before applying, and after that date you should lift the freeze at least 15 minutes before applying for a new account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws. The action can be brought against a consumer reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Note: In accordance with Delaware law, temporary lifting of a security freeze on a protected consumer's credit report is not permitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, a security freeze request may be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your Equifax credit report is $10.00. If you are age 65 or older, the fee to place a security freeze on your Equifax credit report is $5.00. If you are a victim of identity theft and you submit a copy of a valid investigative or incident report or complaint with a law enforcement agency about the unlawful use of your identifying information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>

			</xsl:when>
-->
<!--
			<xsl:when test="$stateSelector='FL'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">Florida Consumers Have the Right to Place a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your consumer report, which will, except as provided by law, prohibit a consumer reporting agency from releasing any information in your consumer report without your express authorization. A security freeze must be requested in writing by certified mail to a consumer reporting agency. The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">YOU SHOULD BE AWARE THAT USING A SECURITY FREEZE TO CONTROL ACCESS TO THE PERSONAL AND FINANCIAL INFORMATION IN YOUR CONSUMER REPORT MAY DELAY, INTERFERE WITH, OR PROHIBIT THE TIMELY APPROVAL OF ANY SUBSEQUENT REQUEST OR APPLICATION YOU MAKE REGARDING A NEW LOAN, CREDIT, MORTGAGE, INSURANCE, GOVERNMENT SERVICES OR PAYMENTS, RENTAL HOUSING, EMPLOYMENT, INVESTMENT, LICENSE, CELLULAR PHONE, UTILITIES, DIGITAL SIGNATURE, INTERNET CREDIT CARD TRANSACTION, OR OTHER SERVICES, INCLUDING AN EXTENSION OF CREDIT AT POINT OF SALE.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">When you place a security freeze on your consumer report, you will be provided a personal identification number or password to use if you choose to remove the freeze on your consumer report or authorize the release of your consumer report for a designated period of time after the security freeze is in place. To provide that authorization, you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Information specifying the period of time for which the report shall be made available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Payment of a fee authorized by this section.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must authorize the release of your consumer report no later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account, that requests information in your consumer report for the purposes of reviewing or collecting the account. Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to bring a civil action against anyone, including a consumer reporting agency, who fails to comply with the provisions of s. 501.005, Florida Statutes, which governs the placing of a consumer report security freeze on your consumer report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax Security Freeze
					P.O. Box 105788
					Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid investigative or incident report or complaint with a law enforcement agency about the unlawful use of your identifying information by another person, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='GA'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF GEORGIA - NOTICE TO CONSUMERS</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">Georgia Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report, which will prohibit a consumer reporting agency from releasing information in your credit report without your express authorization. A security freeze must be requested in writing by certified mail or by electronic means as provided by a consumer reporting agency. The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. If you are actively seeking a new credit, loan, utility, telephone, or insurance account, you should understand that the procedures involved in lifting a security freeze may slow your applications for credit. You should plan ahead and lift a freeze in advance of actually applying for new credit. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or authorize the release of your credit report for a period of time after the freeze is in place.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To provide that authorization you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the period of time for which the report shall be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must authorize the release of your credit report no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or by telephone, or no later than three business days when a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account, that requests information in your credit report for the purposes of reviewing or collecting the account. Reviewing the account includes activities related to account maintenance. You have a right to bring civil action against anyone, including a consumer reporting agency, who improperly obtains access to a file, knowingly or willfully misuses file data, or fails to correct inaccurate file data. Unless you are a victim of identity theft with a police report or other official document acceptable to a consumer reporting agency to verify the crimes, or you are 65 or older, a consumer reporting agency has the right to charge you a fee of no more than $3.00 to place a freeze on your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $3.00. If you are a victim of identity theft and you submit a copy of a valid investigative or incident report or complaint with a law enforcement agency about the unlawful use of your identifying information by another person or you are age 65 or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='HI'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Hawaii - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your credit report by sending a request in writing by certified mail to a consumer reporting agency. The security freeze on your credit report will, except as provided by law, prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party, parties or period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party or parties who are to receive your credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including by way of example but not limited to, a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, your request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $5.00. If you are a victim of identity theft and you submit a copy of a valid police report, investigative report, or complaint you filed with a law enforcement agency about unlawful use of your personal information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='ID'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF IDAHO - NOTICE TO CONSUMERS</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by regular or certified mail. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific party or specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via regular or certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $6.00. If you are a victim of identity theft and you submit a copy of a valid police report, an investigative report or complaint filed with a law enforcement agency, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='IL'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Illinois - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your credit report by sending a request in writing by certified mail to a consumer reporting agency. The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage,  government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party who is to receive your credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Note: In accordance with Illinois law, temporary lifting of a security freeze on a minor's credit report is not permitted</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report, investigative report, or complaint that you have filed with a law enforcement agency about unlawful use of your personal information by another person, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time</fo:block>

			</xsl:when>
-->

			<xsl:when test="$stateSelector='MA'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State Of Massachusetts - Notice to Consumer</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to obtain a copy of your credit file from a consumer credit reporting agency. You may be charged a reasonable fee not exceeding eight dollars. There is no fee, however, if you have been turned down for credit, employment, insurance, or rental dwelling because of information in your credit report within the preceding sixty days. The consumer credit reporting agency must provide someone to help you interpret the information in your credit file. Each calendar year you are entitled to receive, upon request, one free consumer credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to dispute inaccurate information by contacting the consumer credit reporting agency directly. However, neither you nor any credit repair company or credit service organization has the right to have accurate, current, and verifiable information removed from your credit report. In most cases, under state and federal law, the consumer credit reporting agency must remove accurate, negative information from your report only if it is over seven years old, and must remove bankruptcy information only if it is over ten years old.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to dispute inaccurate information by contacting the consumer reporting agency directly, either in writing or by telephone. The consumer reporting agency shall provide, upon request and without unreasonable delay, a live representative of the consumer reporting agency to assist in dispute resolution whenever possible and practicable, or to the extent consistent with federal law. The consumer credit reporting agency may not charge a fee for this service. Any pertinent information and copies of all documents you have concerning a dispute should be given to the consumer credit reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If reinvestigation does not resolve the dispute to your satisfaction, you may send a statement to the consumer credit reporting agency to keep in your file, explaining why you think the record is inaccurate. The consumer credit reporting agency must include your statement about the disputed information in a report it issues about you.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to receive a record of all inquiries relating to a credit transaction initiated in the six months preceding your request, or two years in the case of a credit report used for employment purposes. This record shall include the recipients of any consumer credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to opt out of any prescreening lists compiled by or with the assistance of a consumer credit reporting agency by calling the agency's toll-free telephone number or contacting the agency in writing*. You may be entitled to collect compensation, in certain circumstances, if you are damaged by a person's negligent or intentional failure to comply with the credit reporting act.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">* If you prefer not to receive pre-approved offers, please notify: </fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Opt-Out</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 740123 Atlanta, GA 30374-0123</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">Include your full name, complete address, Social Security number, daytime telephone number, and signature.</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Or you may call toll free: 1 (888) 567-8688.</fo:block>

		<!--		<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to request a "security freeze" on your consumer report. The security freeze will prohibit a consumer reporting agency from releasing any information in your consumer report without your express authorization. A security freeze shall be requested by sending a request either by certified mail, overnight mail or regular stamped mail to a consumer reporting agency, or as authorized by regulation. The security freeze is designed to prevent credit, loans or services from being approved in your name without your consent. You should be aware that using a security freeze may delay, interfere with, or prevent the timely approval of any subsequent request or application you make regarding new loans, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, internet credit card transactions, or other services, including an extension of credit at point of sale.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">When you place a security freeze on your consumer report, within 5 business days of receiving your request for a security freeze, the consumer reporting agency shall provide you with a personal identification number or password to use if you choose to remove the freeze on your consumer report or to authorize the release of your consumer report to a specific party or for a specified period of time after the freeze is in place. To provide that authorization, you must contact the consumer reporting agency and provide the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the personal identification number or password provided by the consumer reporting agency;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>proper identification to verify your identity; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the third party or parties who are to receive the consumer report or the specified period of time for which the report shall be available to authorized users of the consumer report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from a consumer to lift a freeze on a consumer report shall comply with the request not later than 3 business days after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze shall not apply to a person or entity, or to its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account, that requests information relative to your consumer report for the purposes of reviewing or collecting the account, if you have previously given consent to the use of your consumer report. "Reviewing the account" includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified, overnight or regular mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00. If you or your spouse is a victim of identity theft and you submit a copy of a valid police report relating to the identity theft, no fees will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail.  It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">* If you prefer not to receive pre-approved offers, please notify:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Options</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 740123</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30374-0123</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Include your full name, complete address, Social Security number, daytime telephone number, and signature. Or you may call toll free: 1 (888) 567-8688.</fo:block>
-->
			</xsl:when>
<!--
			<xsl:when test="$stateSelector='MI'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF MICHIGAN - NOTICE TO CONSUMERS</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a security freeze on your credit report which will prohibit a consumer reporting agency from releasing information in your credit report without your express authorization. You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by mail or by electronic means as described below. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific party who is to receive the credit report or the specific period of time for which the credit report is to be available.
								Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the release of your credit report no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or no later than three business days when a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will permanently remove the security freeze from your credit file no later than 3 business days after receiving your request to do so.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Note: In accordance with Michigan law, temporary lifting of a security freeze on a protected consumer's credit report is not permitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are the victim of identity theft and you submit a copy of a valid police report of alleged identity theft you have filed with a law enforcement agency, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>
			</xsl:when>

			<xsl:when test="$stateSelector='MN'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Minnesota - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may elect to place a security freeze on your credit report by making a request in writing by certified mail or by calling and providing certain personal information to a consumer reporting agency. The security freeze on your credit report will, except as provided by law, prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a consumer reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or specific period of time while the security freeze is in place. To provide that authorization, you must contact the consumer reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Clear and proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party who is to receive the credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including for example a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00. If you are a victim of identity theft and you submit a copy of a valid police report or a police case number documenting the identity theft, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='MO'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF MISSOURI - NOTICE TO CONSUMERS</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Missouri Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report, which will prohibit a consumer credit reporting agency from releasing information in your credit report without your express authorization. A security freeze must be requested in writing by mail or via other approved methods. The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, Internet credit card transaction, or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or authorize the release of your credit report for a specific requestor orperiod of time after the freeze is in place. To provide that authorization you must contact the consumer credit reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password;</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity;</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>he proper information regarding the specific requestor or period of time for which the report shall be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer credit reporting agency must authorize the release of your credit report no later than fifteen minutes after receiving the above information, under certain circumstances.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account, that requests information in your credit report for the purposes of reviewing or collecting the account. Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring civil action against anyone, including a consumer credit reporting agency, who improperly obtains access to a file, knowingly misuses file data, or fails to correct inaccurate file data.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $5.00 for the first request and $10.00 forany subsequent request. If you are a victim of identity theft and you submit an incident report as defined under section 570.222, RSMo, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='MS'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Mississippi - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have been a victim of identity theft and you submit proper identification and a copy of a valid police report, investigative report or complaint you have filed with a law enforcement agency regarding the unlawful use of your personal information by another person, you have the right to place a security freeze on your credit report pursuant to the Mississippi security freeze law.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have not been a victim of identity theft you do not have the right to place a security freeze on your credit report under the Mississippi security freeze law. However, under Equifax policy, Mississippi consumers who are not victims of identity theft may place a security freeze on their Equifax credit file. The Equifax security freeze policy closely follows the provisions of the Mississippi security freeze law.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze on your credit report will prohibit a credit reporting agency from releasing your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, , government services or payments, rental housing, , investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or specific period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party who is to receive the credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, your request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The charge to place a security freeze on your Equifax credit file is $10.00. Include your complete name, complete address, social security number, date of birth and, if you are a victim of identity theft, also include a copy of a valid police report, investigative report or complaint you have filed with a law enforcement agency regarding the unlawful use of your personal information by another person.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='MT'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">Montana - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Montana Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report to protect your privacy and ensure that credit is not granted in your name without your knowledge. You have a right to place a security freeze on your credit report pursuant to Montana law.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze will prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. When you place a security freeze on your credit report, within 5 business days you will be provided a personal identification number, password, or other device to use if you choose to remove the security freeze on your credit report or to temporarily authorize the release of your credit report for a specific party, parties, or period of time after the security freeze is in place. To provide that authorization, you shall contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the unique personal identification number, password, or other device provided by the consumer reporting agency;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the proper identification to verify your identity;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the proper information regarding the third party or parties who are to receive the credit report or the period of time for which the credit report is to be available to users of the credit report; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>a fee, if applicable.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from a consumer to temporarily lift a security freeze on a credit report shall comply no later than 3 business days after receiving the request or, after January 31, 2009, within 15 minutes of receiving a request by telephone or telefax or through a secure electronic connection.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances in which you have an existing account relationship and a copy of your credit report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control, or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws. The action may be brought against a consumer reporting agency or a user of your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via regular or certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $3.00. If you are a victim of identity theft and submit a copy of a valid police report, an investigative report, or complaint filed with a law enforcement agency, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='NM'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">New Mexico - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">New Mexico Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report to protect your privacy and ensure that credit is not granted in your name without your knowledge. You have a right to place a security freeze on your credit report pursuant to the Credit Report Security Act.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze will prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans and services from being approved in your name without your consent. When you place a security freeze on your credit report, you will be provided with a personal identification number, password or similar device to use if you choose to remove the freeze on your credit report or to temporarily authorize the release of your credit report to a specific party or parties or for a specific period of time after the freeze is in place. To remove the freeze or to provide authorization for the temporary release of your credit report, you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">The unique personal identification number, password or similar device provided by the consumer reporting agency;</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">Proper identification to verify your identity;</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">Information regarding the third party or parties who are to receive the credit report or the period of time for which the credit report may be released to users of the credit report; and</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Payment of a fee, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from a consumer to lift temporarily a freeze on a credit report shall comply with the request no later than three business days after receiving the request. As of September 1, 2008, a consumer reporting agency shall comply with the request within fifteen minutes of receiving the request by a secure electronic method or by telephone.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply in all circumstances, such as where you have an existing account relationship and a copy of your credit report is requested by your existing creditor or its agents for certain types of account review, collection, fraud control or similar activities; for use in setting or adjusting an insurance rate or claim or insurance underwriting; for certain governmental purposes; and for purposes of prescreening as defined in the federal Fair Credit Reporting Act.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, telephone or insurance account, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit for the lifting to take effect. You should contact a consumer reporting agency and request it to lift the freeze at least three business days before applying. As of September 1, 2008, if you contact a consumer reporting agency by a secure electronic method or by telephone, the consumer reporting agency should lift the freeze within fifteen minutes. You have a right to bring a civil action against a consumer reporting agency that violates your rights under the Credit Report Security Act.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified or regular mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police or investigative report filed with a law enforcement agency alleging the crime of identity theft, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='NE'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Nebraska - Notice to Consumers</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">You, for yourself, or as parent, custodial parent, or guardian on behalf of a minor less than 19 years old, may request that a security freeze be placed on your credit report or that of the minor by sending a request in writing by certified mail to a consumer reporting agency. The security freeze will prohibit a credit reporting agency from releasing any information in the credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file or within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $3.00. If you are a victim of identity theft and submit a copy of an official police report evidencing that you have alleged to be a victim of identity theft, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable. Also, when acting on behalf of a minor less than 19 years old, no fee will be charged.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>

			</xsl:when>
-->
			<xsl:when test="$stateSelector='NH'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of New Hampshire - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to bring a civil action against anyone who violates your rights under the credit reporting laws.</fo:block>
<!--
				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to place a "security freeze" on your credit report pursuant to RSA 359-B:24.  Under New Hampshire law, what is commonly known as a credit report is referred to as a "consumer report."  A security freeze will prohibit a consumer reporting agency from releasing any information in your consumer report without your express authorization.  The security freeze must be requested in writing, by certified mail.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your consumer report at no charge if you are a victim of identity theft and you submit a copy of the police report, investigative report, or complaint that you filed with a law enforcement agency about unlawful use of your personal information by another person.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The consumer reporting agency may charge you a fee for the security freeze if you are not a victim of identity theft.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent.  However, you should be aware that using a security freeze to take control over who gains access to the personal and financial information in your consumer report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding new loans, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, internet credit card transaction, or other services, including an extension of credit at point of sale.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">When you place a security freeze on your consumer report, within 10 business days you will be provided a personal identification number or password to use if you choose to remove the freeze on your consumer report or authorize the release of your consumer report for a specific party or period of time after the freeze is in place.  To provide that authorization, you must contact the consumer reporting agency and provide all of the following:</fo:block>
test
				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party who will receive the credit report or the period of time for which the report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Payment of the applicable fee, if any.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from a consumer to lift temporarily a freeze on a consumer report must comply with the request no later than 3 business days after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity with which you have an existing account that requests information in your consumer report for the purposes of reviewing or collecting the accounts, provided the use of your credit report is for a permissible purpose as provided by the federal Fair Credit Reporting Act.  Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to bring a civil action against anyone who violates your rights under the credit reporting laws.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, mail your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report, investigative report, or complaint that you filed with a law enforcement agency about unlawful use of your personal information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>
-->
			</xsl:when>
<!--
			<xsl:when test="$stateSelector='NJ'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of New Jersey - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">New Jersey Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report to protect your privacy and ensure that credit is not granted in your name without your knowledge. You have a right to place a "security freeze" on your credit report pursuant to New Jersey law.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze will prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. When you place a security freeze on your credit report, within five business days you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or to temporarily authorize the release of your credit report for a specific party, parties or period of time after the freeze is in place. To provide that authorization, you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party or parties who are to receive the credit report or the period of time for which the report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from a consumer to lift temporarily a freeze on a credit report shall comply with the request no later than three business days or less, as provided by regulation, after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances in which you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around, or specifically for a certain creditor, a few days before actually applying for new credit.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws. The action can be brought against a consumer reporting agency or a user of your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, mail your request via certified or overnight mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us the web at equifax.com or call 800-685-1111.</fo:block>

			</xsl:when>
-->
			<xsl:when test="$stateSelector='NV'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF NEVADA - Fair Credit Reporting Act</fo:block>


				<fo:block xsl:use-attribute-sets="class-paragraph">The Nevada law regulating credit reporting (NRS 598C.010 et seq.) was amended effective 10-1-93. It requires that credit reporting agencies, such as Equifax, inform you of your rights under this law. You have the right to:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>receive "clear and adequate" disclosure of the "nature and substance" of your credit file at the time of your request.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>obtain the names of the sources of information in your credit file.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>receive, upon request, a readable copy of your credit file.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>obtain the names of recipients of information from your credit file (a) within the preceding two years for purposes of employment, promotion, reassignment or retention as an employee, or (b) within the preceding six months if for any other purpose.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>have any disputed information reverified by us within 30 days of notice of the dispute.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>receive notification if you dispute information in your credit file and the credit reporting agency determines that your dispute is frivolous or irrelevant.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>receive notification if you dispute information in your credit file that the credit reporting agency cannot reverify or learns is incorrect. If the information is incorrect, you have the right to have your file updated accordingly (Equifax does this automatically).</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>receive notification, within five days of reinsertion, if credit file information which had previously been deleted is reinserted into your credit file.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>receive, from a user of credit reports (such as a creditor) which has taken adverse action regarding you,
								(a)	notice of the action taken, (b) the name and address of the credit reporting agency that supplied the user with your credit information, and (c) notice that you have a right to obtain a copy of such information from that credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>*	</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>receive, if the credit reporting agency or user willfully fails to comply with the terms of this law, an amount equal to the sum of actual damages sustained by you as a result of the violation, as well as costs of the action plus reasonable attorney's fees.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
<!--
				<fo:block xsl:use-attribute-sets="class-paragraph" font-weight="bold">State of Nevada - Rights of the Consumer Related to Security Freezes</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a security freeze in your file which will prohibit a reporting agency from releasing any information in your file without your express authorization. A security freeze must be requested in writing by certified mail. The security freeze is designed to prevent a reporting agency from releasing your consumer report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your file may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze in your file, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your file or to authorize the temporary release of your consumer report for a specific person or period after the security freeze is in place. To provide that authorization, you must contact the reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Sufficient identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Your personal identification number or password provided by the reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>A statement that you choose to remove the security freeze from your file or that you authorize the reporting agency to temporarily release your consumer report. If you authorize the temporary release of your consumer report, you must name the person who is to receive your consumer report or the period for which your consumer report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A reporting agency must remove the security freeze from your file or authorize the temporary release of your consumer report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your consumer report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police, investigative report or complaint filed with a law enforcement agency regarding the unlawful use of your personal information, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>
-->
			</xsl:when>
<!--
			<xsl:when test="$stateSelector='OH'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF OHIO - NOTICE TO CONSUMERS</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">Ohio Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report to protect your privacy and ensure that credit is not granted in your name without your knowledge. You have a right to place a "security freeze" on your credit report pursuant to Ohio law. The security freeze will prohibit a consumer credit reporting agency from releasing any information in your credit report without your express authorization or approval. The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. When you place a security freeze on your credit report, within five business days you will be provided a personal identification number or password to use if you choose to remove the security freeze on your credit report or to temporarily authorize the release of your credit report for a specific party or parties or for a specific period of time after the security freeze is in place. To provide that authorization, you must contact the consumer credit reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Information generally considered sufficient to identify the consumer;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer credit reporting agency;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party who is to receive the consumer credit report or the time period for which the credit report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer credit reporting agency that receives a request from a consumer to temporarily lift a security freeze on a credit report shall comply with the request not later than fifteen minutes after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances in which you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control, or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around, or specifically for a certain creditor, a few days before actually applying for new credit.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail or other comparable service where a receipt of delivery is provided to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00. If you are a victim of identity theft and you submit a copy of a valid police report related to the violation of section 2913.49 of the Revised Code, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='OK'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Oklahoma - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Oklahoma Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report, which will prohibit a consumer reporting agency from releasing information in your credit report without your express authorization.  A security freeze must be requested in writing by certified mail.  The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent.  However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, Internet credit card transaction, or other services, including an extension of credit at point of sale.  When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or authorize the release of your credit report for a period of time after the freeze is in place.  To provide that authorization you must contact the consumer reporting agency by one of the methods that it requires, and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the period of time for which the report shall be available; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The payment of the appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must authorize the release of your credit report no later than three (3) business days after receiving all of the above items by any method that the consumer reporting agency allows.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.  Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring civil action against anyone, including a consumer reporting agency who willfully or negligently fails to comply with any requirement of the Oklahoma Consumer Report Security Freeze Act.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency has the right to charge you up to Ten Dollars ($10.00) to place a freeze on your credit report, up to Ten Dollars ($10.00) to temporarily lift a freeze on your credit report, and up to Ten Dollars ($10.00) to remove a freeze from your credit report.  However, you shall not be charged any fee if you are a victim of identity theft who has submitted, at the time the security freeze is requested, a copy of a valid investigative or incident report or complaint with a law enforcement agency about the unlawful use of your identifying information by another person, or if you are sixty-five (65) years of age or older for the initial placement and removal of a security freeze.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid investigative or incident report or complaint with a law enforcement agency about the unlawful use of your identifying information by another person, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='OR'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Oregon - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your credit report by sending a request in writing by mail to a consumer reporting agency. The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, your request must be mailed to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report, incident report or identity theft declaration that you have filed with a law enforcement agency, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>

			<xsl:when test="$stateSelector='PA'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Pennsylvania - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your credit report by sending a request in writing by certified mail to a consumer reporting agency. The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party who is to receive your credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, your request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report that you have filed with a law enforcement agency about unlawful use of your personal information by another person, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>
			</xsl:when>
-->
			<xsl:when test="$stateSelector='PR'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">Puerto Rico - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">According to Puerto Rico Code, Title 7, Banking, Part VI, Control and Supervision, Chapter 132, Credit Reporting Agencies, § 2040, Obtaining free of charge once per year a credit report, a consumer is entitled to one free credit file disclosure from each credit reporting agency that maintains business in Puerto Rico. Pursuant to this article, Equifax Information Services LLC will, upon request, provide you with one free credit file disclosure each calendar year.</fo:block>

			<!--	<fo:block xsl:use-attribute-sets="class-paragraph">Although Puerto Rico does not currently have a security freeze law in effect, under the Equifax voluntary security freeze program you may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by certified mail or by electronic means as described below. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific party who is to receive the credit report or the specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the release of your credit report no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or no later than three business days when a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will permanently remove the security freeze from your credit file not later than 3 business days after receiving your request to do so.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes or employment purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect. </fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are the victim of identity theft and you submit a copy of a valid police report, investigative report or complaint you have filed with a law enforcement agency regarding the unlawful use of your personal information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>
			</xsl:when>

			<xsl:when test="$stateSelector='PW'">
			-->
				<!-- stub for future content -->

			</xsl:when>
<!--
			<xsl:when test="$stateSelector='SC'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of South Carolina - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by certified mail or by contacting us on the Internet. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific party or specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">There is no fee to place a security freeze on your credit report. Include your complete name, complete address, social security number and date of birth.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='SD'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of South Dakota - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have been a victim of identity theft you may place a security freeze on your credit report under the South Dakota security freeze law by making a request in writing by certified mail to a consumer credit reporting agency with a copy of a valid police report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have not been a victim of identity theft you do not have the right to place a security freeze on your credit report under the South Dakota security freeze law. However, under Equifax policy, South Dakota consumers who are not victims of identity theft may place a security freeze on their credit file. This Equifax security freeze policy closely follows the provisions of the South Dakota security freeze law.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party who is to receive your credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00.  This charge applies to security freezes under the voluntary Equifax security freeze policy for South Dakota consumers that are not victims of identity theft or did not provide a copy of a valid police report. Include your complete name, complete address, social security number, date of birth and payment.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are a victim of identity theft and submit a copy of a valid police report, your security freeze is pursuant to the South Dakota security freeze law and no fees will be charged. Include your complete name, complete address, and social security number.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='TN'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Tennessee - Notice to Consumer</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Tennessee Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report, which will prohibit a consumer reporting agency from releasing information in your credit report without your express authorization. A security freeze must be requested in writing by certified mail or by electronic means as provided by a consumer reporting agency. The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting a security freeze may slow your applications for credit. You should plan ahead and lift a freeze in advance of actually applying for new credit. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or authorize the release of your credit report for a period of time after the freeze is in place. To provide that authorization you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the period of time for which the report shall be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must authorize the release of your credit report no later than fifteen (15) minutes after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account, that requests information in your credit report for the purposes of fraud control, or, reviewing or collecting the account. Reviewing the account includes activities related to account maintenance.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You should consider filing a complaint regarding your identity theft situation with the Federal Trade Commission and the Tennessee department of commerce and insurance, division of consumer affairs, either in writing or via their websites.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring civil action against anyone, including a consumer reporting agency, who improperly obtains access to a file, misuses file data, or fails to correct inaccurate file data.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Unless you are a victim of identity theft with a police report, or other official document acceptable to a consumer reporting agency to verify the crimes, a consumer reporting agency has the right to charge you up to seven dollars and fifty cents ($7.50) to place a freeze on your credit report, but may not charge you to temporarily lift a freeze on your credit report. A consumer reporting agency may charge a consumer a reasonable fee not to exceed five dollars ($5.00) to permanently remove a security freeze, or to replace a personal identification number or password. A consumer reporting agency may increase these fees annually based on changes to a common measure of consumer prices. A consumer reporting agency may not charge a Tennessee consumer to place or permanently remove a security freeze if that Tennessee consumer is a victim of identity theft as defined in Tennessee law or federal law regarding identity theft and presents to the consumer reporting agency, at the time the request is made, a police report or other official document acceptable to the consumer reporting agency detailing the theft.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $7.50. If you are a victim of identity theft and you submit a copy of a valid police report or other official document detailing the identity theft that you have filed with a law enforcement agency, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='UT'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Utah - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by certified mail. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report or police case number documenting the identity fraud, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='VA'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF VIRGINIA - NOTICE TO CONSUMERS</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Virginia Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report, which will prohibit a consumer reporting agency from releasing information in your credit report without your express authorization. A security freeze must be requested in writing by certified mail. The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, Internet credit card transaction, or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or authorize the release of your credit report for a period of time or for a specific party after the freeze is in place. To provide that authorization you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the period of time or the specific party for which the report shall be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must authorize the release of your credit report no later than three business days after receiving the above information. After September 1, 2008, a consumer credit reporting agency must authorize the release of your credit report no later than 15 minutes after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity, with which you have an existing account, that requests information in your credit report for the purposes of reviewing or collecting the account. Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring civil action against anyone, including a consumer reporting agency, who improperly obtains access to a file, knowingly or willfully misuses file data, or fails to correct inaccurate file data.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Unless you are a victim of identity theft with a police report to verify the crimes, a consumer reporting agency has the right to charge you up to $10 to place a freeze on your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, your request must be mailed to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us the web at Equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>

			</xsl:when>

			<xsl:when test="$stateSelector='VI'">
				stub for future content
			</xsl:when>
-->
			<xsl:when test="$stateSelector='VT'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF VERMONT - NOTICE TO VERMONT CONSUMERS</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Under Vermont law, you are allowed to receive one free copy of your credit report every 12 months from each credit reporting agency. If you would like to obtain your free credit report from Equifax, you should contact us by writing to:</fo:block>
							<fo:block text-align="center">
								<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Information Services LLC</fo:block>
								<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 740241 Atlanta,</fo:block>
								<fo:block xsl:use-attribute-sets="class-list-item-end">GA 30374-0241</fo:block>
								<fo:block xsl:use-attribute-sets="class-paragraph">or</fo:block>
								<fo:block xsl:use-attribute-sets="class-paragraph" space-after="3px">you may call 1 (800) 685-1111</fo:block>
							</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Under Vermont law, no one may access your credit report without your permission except under the following limited circumstances:</fo:block>
							<fo:block xsl:use-attribute-sets="class-paragraph">
								<fo:list-block xsl:use-attribute-sets="list-format">
									<fo:list-item>
										<fo:list-item-label>
											<fo:block>(A)</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block>in response to a court order;</fo:block>
										</fo:list-item-body>
									</fo:list-item>
									<fo:list-item>
										<fo:list-item-label>
											<fo:block>(B)</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block>for direct mail offers of credit;</fo:block>
										</fo:list-item-body>
									</fo:list-item>
									<fo:list-item>
										<fo:list-item-label>
											<fo:block>(C)</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block>if you have given ongoing permission and you have an existing relationship with the person requesting a copy of your credit report;</fo:block>
										</fo:list-item-body>
									</fo:list-item>
									<fo:list-item>
										<fo:list-item-label>
											<fo:block>(D)</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block>where the request for a credit report is related to an education loan made, guaranteed, or serviced by the Vermont Student Assistance Corporation;</fo:block>
										</fo:list-item-body>
									</fo:list-item>
									<fo:list-item>
										<fo:list-item-label>
											<fo:block>(E)</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block>where the request for a credit report is by the Office of Child Support Services when investigating a child support case;</fo:block>
										</fo:list-item-body>
									</fo:list-item>
									<fo:list-item>
										<fo:list-item-label>
											<fo:block>(F)</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block>where the request for a credit report is related to a credit transaction entered into prior to January 1, 1993; and</fo:block>
										</fo:list-item-body>
									</fo:list-item>
									<fo:list-item>
										<fo:list-item-label>
											<fo:block>(G)</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block>where the request for a credit report is by the Vermont State Tax Department and is used for the purpose of collecting or investigating delinquent taxes.</fo:block>
										</fo:list-item-body>
									</fo:list-item>
								</fo:list-block>
							</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>If you believe a law regulating consumer credit reporting has been violated, you may file a complaint with the Vermont Attorney Generals Consumer Assistance Program, 104 Morrill Hall, University of Vermont, Burlington, Vermont 05405.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws. The action can be brought against a credit reporting agency or a user of your credit report.</fo:block>
<!--
				<fo:block xsl:use-attribute-sets="class-h4-state">
					<fo:block text-decoration="underline" text-align="center">Vermont Consumers Have the Right to Obtain a Security Freeze</fo:block>
				</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report pursuant to 9 V.S.A. § 2480h at no charge if you are a victim of identity theft. All other Vermont consumers will pay a fee to the credit reporting agency of up to $10.00 to place the freeze on their credit report. The security freeze will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. A security freeze must be requested in writing by certified mail.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to help prevent credit, loans, and services from being approved in your name without your consent. <fo:block  font-weight="bold">However, you should be aware that using a security freeze to take control over who gains access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding new loans, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular phone, utilities, digital signature, internet credit card transaction, or other services, including an extension of credit at point of sale.</fo:block>
				</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">When you place a security freeze on your credit report, within ten business days you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or authorize the release of your credit report for a specific party, parties or period of time after the freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party or parties who are to receive the credit report or the period of time for which the report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency may charge a fee of up to $5.00 to a consumer who is not a victim of identity theft to remove the freeze on your credit report or authorize the release of your credit report for a specific party, parties, or period of time after the freeze is in place. For a victim of identity theft, there is no charge when the victim submits a copy of a police report, investigative report, or complaint filed with a law enforcement agency about unlawful use of the victim's personal information by another person.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency that receives a request from a consumer to lift temporarily a freeze on a credit report shall comply with the request no later than three business days after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze will not apply to "preauthorized approvals of credit." If you want to stop receiving preauthorized approvals of credit, you should call 1-888-567-8688 or forward your request, including full name, address, Social Security number and date of birth, to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Options</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 740123</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30374-0123</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or entity, or its affiliates, or collection agencies acting on behalf of the person or entity with which you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account, provided you have previously given your consent to this use of your credit reports. Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws. The action can be brought against a credit reporting agency or a user of your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, your request must be mailed via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and submit a copy of a valid police report, investigative report or complaint filed with a law enforcement agency about the unlawful use of your personal information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and if applicable, your payment.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or period of time.</fo:block>
-->
			</xsl:when>
<!--
			<xsl:when test="$stateSelector='WI'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Wisconsin - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Wisconsin Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to include a "security freeze" with your credit report, which will prohibit a consumer reporting agency from releasing information in your credit report in connection with a credit transaction without your express authorization.  A security freeze must be requested in writing by certified mail or by any other means provided by a consumer reporting agency.  The security freeze is designed to prevent an extension of credit, such as a loan, from being approved in your name without your consent.  However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a loan, credit, mortgage, or Internet credit card transaction, including an extension of credit at point of sale.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">When you request a security freeze for your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or authorize the release of your credit report for a period of time after the security freeze is in place.  To provide that authorization you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number or password.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The period of time for which the report shall be made available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Payment of the appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to a person or its affiliates, or collection agencies acting on behalf of a person, with which you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.  Reviewing the account includes activities related to account maintenance, monitoring, credit line increases, and account upgrades and enhancements.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Unless you are a victim of identity theft with a police report to verify the crime, a consumer reporting agency has the right to charge you no more than $10.00 to include a security freeze with your credit report, no more than $10.00 to authorize release of a report that includes a security freeze, and no more than $10.00 to remove a security freeze from your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Note: In accordance with Wisconsin law, temporary lifting of a security freeze on a protected consumer's credit report is not permitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and submit a copy of a valid police report to verify the crime, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>


			</xsl:when>

			<xsl:when test="$stateSelector='WY'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Wyoming - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your credit report by sending a request in writing by certified mail to a consumer reporting agency. The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and, effective August 1, 2008, within 15 minutes when your request is received via telephone or internet during normal business hours.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report that you have filed with a law enforcement agency about unlawful use of your personal information by another person or a police case number documenting the identity theft, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>

			<xsl:when test="$stateSelector = 'IA'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">STATE OF IOWA - NOTICE TO CONSUMERS</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by certified mail. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report concerning the unlawful use of identification information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>

			<xsl:when test="$stateSelector='IN'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Indiana - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your credit report by sending a request in writing by mail to a consumer reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">UNDER IC 24-5-24, YOU MAY OBTAIN A SECURITY FREEZE ON YOUR CONSUMER REPORT TO PROTECT YOUR PRIVACY AND ENSURE THAT CREDIT IS NOT GRANTED IN YOUR NAME WITHOUT YOUR KNOWLEDGE. THE SECURITY FREEZE WILL PROHIBIT A CONSUMER REPORTING AGENCY FROM RELEASING ANY INFORMATION IN YOUR CONSUMER REPORT WITHOUT YOUR EXPRESS AUTHORIZATION OR APPROVAL. THE SECURITY FREEZE IS DESIGNED TO PREVENT CREDIT LOANS AND SERVICES FROM BEING APPROVED IN YOUR NAME WITHOUT YOUR CONSENT. WHEN YOU PLACE A SECURITY FREEZE ON YOUR CONSUMER REPORT, WITHIN TEN (10) BUSINESS DAYS YOU WILL BE PROVIDED A PERSONAL IDENTIFICATION NUMBER TO USE IF YOU CHOOSE TO REMOVE THE SECURITY FREEZE OR TO TEMPORARILY AUTHORIZE THE RELEASE OF YOUR CONSUMER REPORT FOR A PERIOD OF TIME OR TO A SPECIFIC PERSON AFTER THE SECURITY FREEZE IS IN PLACE. A SECURITY FREEZE DOES NOT APPLY TO PERSONS OR ENTITIES LISTED IN IC 24-5-24-11. IF YOU ARE ACTIVELY SEEKING CREDIT, YOU SHOULD UNDERSTAND THAT THE PROCEDURES INVOLVED IN LIFTING A SECURITY FREEZE MAY SLOW YOUR OWN APPLICATIONS FOR CREDIT. YOU HAVE A RIGHT TO BRING A CIVIL ACTION AGAINST SOMEONE WHO VIOLATES YOUR RIGHTS UNDER IC 24-5-24.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To authorize the temporary release of your credit report you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party or parties who are to receive your credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, mail your request to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">There is no fee to place a security freeze on your credit report. Include your complete name, complete address, social security number and date of birth.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze, authorizing the release of your credit report for a specific party, parties or period of time and requesting issuance of a new personal identification number to you if you fail to retain the original personal identification number.</fo:block>
			</xsl:when>
			<xsl:when test="$stateSelector='KS'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Kansas - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by mail. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified or regular mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00.  If you are a victim of identity theft and submit a copy of a valid police report, investigative report or complaint you filed with a law enforcement agency about the unlawful use of your personal information by another person, no fee will be charged.  Include your complete name, complete address, and social security number.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>

			<xsl:when test="$stateSelector='KY'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Kentucky - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may place a security freeze on your credit report by making a request in writing by certified mail that includes clear and proper identification to a consumer credit reporting agency. The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization, except as the law allows. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding credit in connection with  a new loan, mortgage, government services or payments, rental housing, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other credit services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons who may request your credit file, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account; a person that requests information in your credit report for the purpose of fraud control or insurance underwriting; or in connection with prescreening</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report you have filed with a law enforcement agency about the unlawful use of your identifying information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>

			<xsl:when test="$stateSelector='LA'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Louisiana - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may place a security freeze on your credit report by making a request in writing by standard or certified mail, telephone call or secure website to a credit reporting agency. The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other credit services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Clear and proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must authorize the temporary release of your credit report no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or by telephone, or no later than three business days when a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or no later than three business days when the request is by telephone or a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via standard or certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report as described in R.S. 9:3568 or if you are sixty-two (62) years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>
-->
			<xsl:when test="$stateSelector='MD'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">Statement of Rights of the Consumer - Annotated Code of Maryland Commercial Law Article (141201, et seq.)</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">As a resident of the State of Maryland, you have the following rights as a consumer under the laws of the State of Maryland relating to consumer credit information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to request, in writing, that a consumer reporting agency restrict the sale or other transfer of information in your credit file to:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>A mail-service organization;</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>A marketing firm; or</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Any other similar organization that obtains information about a consumer for marketing purposes.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right, upon request and proper identification, to receive from a consumer reporting agency an exact copy of any credit file on you, including a written explanation of codes or trade language used in the report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to receive disclosure of information in your credit file during normal business hours:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>&#x2022;</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>In person, upon furnishing proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>&#x2022;</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>By telephone, if you make written request with proper identification, and toll charges, if any, are charged to you.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>&#x2022;</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>In writing, if you make written request and furnish proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may be accompanied by one other person of your choosing, who must furnish reasonable identification, and the consumer reporting agency may require a written statement from you granting permission to discuss your credit information in this person's presence.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to dispute the completeness or accuracy of any item of information contained in your credit file, and if you convey the dispute in writing, the consumer reporting agency will, within 30 days, reinvestigate and record the current status of that information, unless it has reasonable grounds to believe that the dispute is frivolous or irrelevant.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If, after reinvestigation, the information you disputed is found to be inaccurate or cannot be verified, the consumer reporting agency will delete the information and mail to you a written notice of the correction and will also mail to each person to whom the erroneous information was furnished written notice of the correction. You will also be sent a written notice if the information you disputed is found to be accurate or is verified.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You will not be charged for our handling of the information you dispute, nor for the corrected reports resulting from our handling.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have 60 days after receiving notice of correction or other findings to request in writing that the consumer reporting agency furnish you with the name, address, telephone number of each creditor contacted during its reinvestigation, and it will provide this information to you within 30 days after receiving your request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If the reinvestigation does not resolve your dispute, you may file with the consumer reporting agency a brief statement of not more than 100 words, setting forth the nature of your dispute. This statement will be placed on your credit file, and in any subsequent report containing the information you dispute, it will be clearly noted that the information has been disputed by you, and your statement or a clear and accurate summary of it will be provided with that report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Following deletion of any information you disputed that is found to be inaccurate or could not be verified, at your request, the consumer reporting agency will furnish notification of the information deleted or your statement, or statement summary, to any person you designate who has received your report within the past two years for employment purposes, or within the past one year for any other purpose.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Your Commissioner of Financial Regulation is Antonio P. Salazar. In the event you wish to file a complaint, please write or call the Office of the Commissioner of Financial Regulation, Complaint Unit, 500 N. Calvert Street, Suite 402, Baltimore, MD 21202; telephone number is (410) 230-6077. In addition to the rights above, you are entitled to request a copy of your file free of charge, one time within a twelve month period, and thereafter for a $5.00 charge each time.</fo:block>

<!--
				<fo:block xsl:use-attribute-sets="class-h4-state">State Of Maryland - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right, under Section 14-1212.1 of the Commercial Law Article of the Annotated Code of Maryland, to place a security freeze on your credit report. The security freeze will prohibit a consumer reporting agency from releasing your credit report or any information derived from your credit report without your express authorization. The purpose of a security freeze is to prevent credit, loans, and services from being approved in your name without your consent.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may elect to have a consumer reporting agency place a security freeze on your credit report by written request sent by certified mail or by electronic mail or the internet if the consumer reporting agency provides a secure electronic connection. The consumer reporting agency must place a security freeze on your credit report within 3 business days after your request is received. Within 5 business days after a security freeze is placed on your credit report, you will be provided with a unique personal identification number or password to use if you want to remove the security freeze or temporarily lift the security freeze to release your credit report to a specific person or for a specific period of time. You also will receive information on the procedures for removing or temporarily lifting a security freeze.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you want to temporarily lift the security freeze on your credit report, you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<ul>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper identifying information to verify your identity; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the person who is to receive the credit report or the period of time for which the credit report is to be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</ul>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must comply with a request to temporarily lift a security freeze on a credit report within 3 business days after the request is received or within 15 minutes for certain requests. A consumer reporting agency must comply with a request to remove a security freeze on a credit report within 3 business days after the request is received.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, you should be aware that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a security freeze, either completely if you are seeking credit from a number of sources, or just for a specific creditor if you are applying only to that creditor, a few days before actually applying for new credit.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency may charge a reasonable fee not exceeding $5 for each placement, temporary lift, or removal of a security freeze. However, a consumer reporting agency may not charge any fee to a consumer who, at the time of a request to place, temporary lift, or remove a security freeze, presents to the consumer reporting agency a police report of alleged identity fraud against the consumer or an identity theft passport.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply if you have an existing account relationship and a copy of your credit report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control, or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Note: In accordance with Maryland law, temporary lifting of a security freeze on a minor's or protected person's credit report is not permitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, GA 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00. If you are a victim of identity theft and you submit a copy of a valid police report of alleged identity fraud or an identity theft passport, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or period of time.</fo:block>
-->
			</xsl:when>
<!--
			<xsl:when test="$stateSelector='ME'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Maine - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have been a victim of identity theft you may place a security freeze on your credit report by making a request in writing by certified mail to a consumer credit reporting agency with a valid copy of a police report, investigative report, or complaint you have filed with a law enforcement agency about unlawful use of your personal information by another person.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you have not been a victim of identity theft you may place a security freeze on your credit report by making a request in writing by certified mail to a consumer credit reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze on your credit report will prohibit a credit reporting agency from releasing any information in your credit report without your express authorization. The security freeze is designed to prevent a credit reporting agency from releasing your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other credit services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific party or period of time while the security freeze is in place. To provide that authorization, you must contact the credit reporting agency and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific party who is to receive your credit report or the time period for which your credit report must be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A credit reporting agency must remove the security freeze from your credit file or authorize the temporary release of your credit report not later than 3 business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report, investigative report, or complaint you have filed with a law enforcement agency about unlawful use of your personal information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>
			<xsl:when test="$stateSelector='NC'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of North Carolina - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">North Carolina Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report pursuant to North Carolina law. The security freeze will prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization. A security freeze can be requested in writing by first-class mail, by telephone, or electronically. You also may request a freeze by visiting the following Web site: https://www.freeze.equifax.com or calling the following telephone number: 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. However, you should be aware that using a security freeze to take control over who gains access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding new loans, credit, mortgage, insurance, rental housing, employment, investment, license, cellular phone, utilities, digital signature, Internet credit card transactions, or other services, including an extension of credit at point of sale.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The freeze will be placed within three business days if you request it by mail, or within 24 hours if you request it by telephone or electronically. When you place a security freeze on your credit report, within three business days, you will be sent a personal identification number or a password to use when you want to remove the security freeze, temporarily lift it, or lift it with respect to a particular third party.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A freeze does not apply when you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control, or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You should plan ahead and lift a freeze if you are actively seeking credit or services as a security freeze may slow your applications, as mentioned above.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You can remove a freeze, temporarily lift a freeze, or lift a freeze with respect to a particular third party by contacting the consumer reporting agency and providing all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>our personal identification number or password,</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity, and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper information regarding the period of time you want your report available to users of the credit report, or the third party with respect to which you want to lift the freeze.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from you to temporarily lift a freeze or to lift a freeze with respect to a particular third party on a credit report shall comply with the request no later than three business days after receiving the request by mail and no later than 15 minutes after receiving a request by telephone or electronically. A consumer reporting agency may charge you up to three dollars ($3.00) to institute a freeze if your request is made by telephone or by mail. A consumer reporting agency may not charge you any amount to freeze, remove a freeze, temporarily lift a freeze, or lift a freeze with respect to a particular third party, if any of the following are true:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Your request is made electronically.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>You are over the age of 62.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>You are the victim of identity theft and have submitted a copy of a valid investigative or incident report or complaint with a law enforcement agency about the unlawful use of your identifying information by another person, or you are the spouse of such a person.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws. The action can be brought against a consumer reporting agency or a user of your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via first-class mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at https://www.freeze.equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $3.00. If you request to place a security freeze by visiting us on the web, no fee will be charged. If you or your spouse is a victim of identity theft and you submit a copy of a valid investigative or incident report or complaint with a law enforcement agency about the unlawful use of your identifying information by another person, no fee will be charged. If you are age 62 or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 3 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>
			</xsl:when>
			<xsl:when test="$stateSelector='ND'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">North Dakota - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">North Dakota Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your consumer credit file at no charge to protect your privacy and ensure that credit is not granted in your name without your knowledge. You have a right to place a "security freeze" on your consumer credit file pursuant to North Dakota law.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze will prohibit a consumer reporting agency from releasing any information in your consumer credit file without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. When you place a security freeze on your credit file, within five business days you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit file or to temporarily authorize the release of your credit report or credit score for a specific party, parties, or period of time after the freeze is in place. To provide that authorization, you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the third party or parties who are to receive the credit report or the period of time for which the report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency must authorize the release of your credit report no later than fifteen (15) minutes after receiving the above information if the request is by electronic means or by telephone, or no later than two business days when a written request is submitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency may charge you up to five dollars each time you freeze or temporarily lift the freeze, except a consumer reporting agency may not charge any amount to a victim of identity theft who has submitted a copy of a valid investigative report or complaint to a law enforcement agency about the unlawful use of the victim's information by another person.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances where you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control, or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze - either completely if you are shopping around, or specifically for a certain creditor - with enough advance notice before you apply for new credit for the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws. The action can be brought against a consumer reporting agency or a user of your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00. If you are a victim of identity theft and you submit a copy of a valid investigative report or complaint to a law enforcement agency about the unlawful use of your information by another person, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party, parties or period of time.</fo:block>
			</xsl:when>
			<xsl:when test="$stateSelector='NY'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of New York - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">New York Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security freeze" on your credit report, which will prohibit a consumer credit reporting agency from releasing information in your credit report without your express authorization. A security freeze must be requested in writing, delivery confirmation requested, or via telephone, secure electronic means, or other methods developed by the consumer credit reporting agency. The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent. However, you should be aware that using a security freeze to take control over who gets access to the personal and financial information in your credit report may delay, interfere with, or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, government services or payments, insurance, rental housing, employment, investment, license, cellular phone, utilities, digital signature, internet credit card transaction, or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or authorize the release of your credit report to a specific party or for a period of time after the freeze is in place. To provide that authorization you must contact the consumer credit reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the personal identification number or password;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>proper identification to verify your identity;</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>the proper information regarding the party or parties who are to receive the credit report or the period of time for which the report shall be available to users of the credit report; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>payment of any applicable fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer credit reporting agency must authorize the release of your credit report no later than three business days after receiving the above information. Effective September first, two thousand nine, a consumer credit reporting agency that receives a request via telephone or secure electronic method shall release a consumer’s credit report within fifteen minutes when the request is received.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances in which you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, you should understand that the procedures involved in lifting a security freeze may slow your application for credit. You should plan ahead and lift a freeze, either completely if you are shopping around, or specifically for a certain creditor, before applying for new credit. When seeking credit or pursuing another transaction requiring access to your credit report, it is not necessary to relinquish your pin or password to the creditor or business; you can contact the consumer credit reporting agency directly. If you choose to give out your pin or password to the creditor or business, it is recommended that you obtain a new pin or password from the consumer credit reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send a request in writing to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">There is no initial fee to place a security freeze. If you are a victim of identity theft and you submit a copy of a signed Federal Trade Commission ID theft victim’s affidavit, or a copy of a report of ID theft from a law enforcement agency, no fees will be charged. Include your complete name, complete address, social security number and date of birth.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific party or specific period of time.</fo:block>
			</xsl:when>
			<xsl:when test="$stateSelector='RI'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Rhode Island - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report to protect your privacy and ensure that credit is not granted in your name without your knowledge.  You have a right to place a "security freeze" on your credit report pursuant to the R.I.G.L. chapter 6-48 to the Identity Theft Prevention Act of 2006.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze will prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans, and services from being approved in your name without your consent.  When you place a security freeze on your credit report, within five (5) business days you will be provided a personal identification number or password to use if you choose to remove the freeze on your credit report or to temporarily authorize the release of your credit report for a specific period of time after the freeze is in place.  To provide that authorization, you must contact the consumer reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>

					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the period of time for which the report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer reporting agency that receives a request from a consumer to temporarily lift a freeze on a credit report shall comply with the request no later than three (3) business days after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances where you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of an account review, collection, fraud control or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, telephone, or insurance account, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit.  You should plan ahead and lift a freeze - either completely if you are shopping around, or specifically for a certain creditor - with enough advance notice before you apply for new credit for the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to bring a civil action against someone who violates your rights under the credit reporting laws.  The action can be brought against a consumer reporting agency or a user of your credit report.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Unless you are sixty-five (65) years of age or older, or you are a victim of identity theft with an incident report or a complaint from a law enforcement agency, a consumer reporting agency has the right to charge you up to ten dollars ($10.00) to place a freeze on your credit report, up to ten dollars ($10.00) to temporarily lift a freeze on your credit report, depending on the circumstances, and up to ten dollars ($10.00) to remove a freeze from your credit report.  If you are sixty-five (65) years of age or older or are a victim or identity theft with a valid incident report or complaint, you may not be charged a fee by a consumer reporting agency for placing, temporarily lifting, or removing a freeze.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid incident report or a complaint from a law enforcement agency, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>
-->
			<xsl:when test="$stateSelector='TX'">
				<fo:block xsl:use-attribute-sets="class-h1" page-break-before="always">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Texas - Notice to Texas Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to obtain a copy of your credit file from a consumer credit reporting agency. You may be charged a reasonable fee not exceeding twelve dollars ($12.00). There is no fee, however, if your request for a copy of your credit file is made not later than the 60th day after the date on which adverse action is taken against you; or made before the expiration of an initial one year  security alert. To obtain a copy of your credit file from Equifax call 1-800-685-1111 or write to PO Box 740241, Atlanta, Georgia, 30374-0241.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have a right to place a "security alert" in your credit file. This notice alerts a recipient of a consumer report involving your credit file that your identity may have been used without your consent to fraudulently obtain goods or services in the your name. Placement or removal of a security alert may be requested by calling 1-800-525-6285 or, you may send a written request to Equifax Information Services, PO Box 105069, Atlanta, GA 30348. With your request, you may include a daytime and evening telephone number so a person who receives a copy of your credit report can verify your identity before approving a transaction.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to file an action to enforce an obligation of a consumer reporting agency to you under this chapter in any court as provided by the Fair Credit Reporting Act (15 U.S.C. Section 1681 et seq.), as amended, or, if agreed to by both parties, the action may be submitted to binding arbitration after the you have followed all dispute procedures in Section 20.06 of the Texas Business and Commercial Code and have received the notice specified in Section 20.06(f) in the manner provided by the rules of the American Arbitration Association.</fo:block>
<!--

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The personal identification number described above.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the designated period for which the report shall be available or proper identification of the requester who is to receive the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer credit reporting agency must authorize the release of your credit report no later than three business days after receiving the above information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">
					<fo:block text-decoration="underline">Exceptions</fo:block>. A security freeze does not apply to a person with whom you have an account or contract or to whom you issued a negotiable instrument, or the person's subsidiary, affiliate, agent, assignee, prospective assignee, or private collection agency, for purposes related to that account, contract, or instrument</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Note: In accordance with Texas law, temporary lifting of a security freeze on a protected consumer's credit report is not permitted.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze on your credit report is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report, investigative report, or complaint made under Section 32.51, Penal Code, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a certain properly designated period or for a certain properly identified requester.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The temporary lifting of a security freeze can be requested by contacting us on the web at equifax.com, calling 800-685-1111 or writing to Equifax Security Freeze, P O Box 105788, Atlanta, Georgia, 30348. The fee to temporarily lift a security freeze for a certain properly designated period is $10.00 or $12.00 for a certain properly identified requester. If you are a victim of identity theft and you submit a copy of a valid police report, investigative report, or complaint made under Section 32.51, Penal Code, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Permanent removal of a security freeze can be requested by contacting us on the web at equifax.com, calling 800-685-1111 or writing to Equifax Security Freeze, P O Box 105788, Atlanta, Georgia, 30348. The fee to permanently remove a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report, investigative report, or complaint made under Section 32.51, Penal Code, no fee will be charged.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to file an action to enforce an obligation of a consumer reporting agency to a you under this chapter in any court as provided by the Fair Credit Reporting Act (15 U.S.C. Section 1681 et seq.), as amended, or, if agreed to by both parties, the action may be submitted to binding arbitration after the you have followed all dispute procedures in Section 20.06 of the Texas Business and Commercial Code and have received the notice specified in Section 20.06(f) in the manner provided by the rules of the American Arbitration Association.</fo:block>
	-->
			</xsl:when>
	<!--
			<xsl:when test="$stateSelector='WA'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Washington - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">STATE OF WASHINGTON - Fair Credit Reporting Act</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Effective January 1, 1994, Washington’s Fair Credit Reporting Act requires agencies (such as Equifax) to provide you a summary of your rights and remedies under the law when providing you with a written copy of your credit report. You have a right:</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To have your name and address excluded from any list provided by a credit reporting agency in connection with a credit transaction or direct solicitation you do not initiate. You must notify the credit reporting agency in writing through the notification system maintained by the agency, and must include a statement that you do not consent to any use of consumer reports relating to you in connection with any transaction you did not initiate. Equifax’s notification system is: Equifax Options, P.O. Box 740123, Atlanta, GA 30374-0123.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To request a credit reporting agency to disclose all information in its file on you at the time of your request, including disclosure of the sources of the information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To the identification of each person or business which obtained your report for employment purposes during the two years prior to your request, and each person or business which obtained your report for any other purpose within six months prior to your request, including those inquiries in connection with a credit transaction you did not initiate. Identification will include the name of the person or trade name under which the person conducts business, and, if you request, that person’s or business’ address.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To receive credit file disclosures during normal business hours and on reasonable notice (1) in person, if you appear in person and furnish proper identification, (2) by telephone, if you make written request with proper identification and pay for any toll charges, or (3) by any other reasonable means available to the credit reporting agency and authorized by you. For in-person disclosure, you may be accompanied by one other person of your choosing, although you may be required to furnish written permission for your credit file to be discussed in the other person’s presence. If a credit score is disclosed as part of your credit report, you will be provided an explanation of the meaning of the credit score.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To an explanation of how you may exercise rights and remedies under this law, including the name, address, and phone number of the agency responsible for enforcing this law. You may write to: Washington State Attorney General's Office, Consumer Protection Division, 900 4th Ave, Suite 2000, Seattle, WA 98164. Call: 1 (800) 551-4636 Or on the web at: http://www.wa.gov/ago/consumer</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To notify the credit reporting agency if you dispute the completeness or accuracy of any item of information in your credit report, and to dispute the completeness or accuracy of any item of information in your credit report, and to have disputed items reinvestigated without charge, and the current status of the disputed information recorded in your credit file within 30 business days from the date the credit reporting agency receives your dispute. You will be notified if the agency receives your dispute. You will be notified if the agency stops reinvestigating disputed information upon determining the dispute is frivolous or irrelevant, including failure on your part to provide sufficient information relative to the dispute. Such notice will be in writing within five business days after the determination that the dispute is frivolous or irrelevant.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To have the credit reporting agency review all information you submit which is relevant to the disputed information.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To receive notification from the credit reporting agency when information you disputed is deleted from your credit file because it could not be verified, but is subsequently found to be complete and accurate and is reinserted into your credit file.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To file a brief statement with the credit reporting agency setting forth the nature of your dispute. If the reinvestigation does not resolve the dispute or it is found to be frivolous or irrelevant. Your statement may be limited by the credit reporting agency, provided you receive help from the agency in writing a clear summary of the dispute.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To request that the credit reporting agency, when a disputed item of information has been deleted or remains on file with a statement of dispute, to provide notification to any person you designate who, within the past two years, received a copy of your consumer report for employment purposes, or who, within the past six months, received a copy of your consumer report for any other purpose.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To receive the results of the reinvestigation of disputed information within five business days following completion of the reinvestigation.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To request the credit reporting agency to provide you with a description of the procedure used to determine the accuracy and completeness of the information disputed, including the name, business address, and telephone number of the person or business contacted during the reinvestigation.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To receive disclosure of the information in your credit file without charge, if requested within 60 days following our receipt of a notice denying you credit, employment, insurance, or other benefit, or notification from a debt collection agency stating that your credit may be or has been impaired. No charges will be imposed for any reinvestigation of disputed information, deletion of information found to be inaccurate, or for assisting you in filing your statement of dispute.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">No charge will be imposed following deletion of information, or filing your statement of dispute, for notifying persons who previously received your consumer report. If you have not been denied credit, employment, insurance, or other benefit, the credit reporting agency may charge a fee not exceeding eleven dollars  ($11.00) for disclosure and all subsequent handling as listed here.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To receive, from a user of consumer reports (such as creditor), which has taken adverse action regarding you based on your credit report, (a) notice of the action taken, and (b) the name, address and telephone number of the credit reporting agency that furnished the report. Notice of adverse action must be in writing, except verbal notice may be given if the business is regulated by the Washington Utilities and Transportation Commission, or involves an application for the rental and leasing of residential real estate.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To bring legal action against a credit reporting agency for failure to comply with its obligations under this law, if you do so within two years after the agency fails to comply (unless the credit reporting agency materially and willfully fails to comply, in which case you may file legal action anytime within two years after you learn the agency has done so).</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">State of Washington - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may request that a security freeze be placed on your Equifax Information Services LLC (Equifax) credit report by sending a request in writing by certified mail. The security freeze on your credit report will prohibit Equifax from releasing your credit report without your express authorization. The security freeze is designed to prevent the release of your credit report without your consent. However, you should be aware that using a security freeze to take control over who is allowed access to the personal and financial information in your credit report may delay, interfere with or prohibit the timely approval of any subsequent request or application you make regarding a new loan, credit, mortgage, insurance, government services or payments, rental housing, employment, investment, license, cellular telephone, utilities, digital signature, Internet credit card transaction or other services, including an extension of credit at point of sale. When you place a security freeze on your credit report, you will be provided a personal identification number or password to use if you choose to remove the security freeze from your credit report or to authorize the temporary release of your credit report for a specific period of time while the security freeze is in place. To provide that authorization, you must contact Equifax and provide all the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the credit reporting agency.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The proper information regarding the specific period of time for which the credit report is to be available.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>4.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Appropriate fee.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will remove the security freeze from your credit file within 3 business days after receiving the above information.</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">Equifax will authorize the temporary release of your credit report not later than 3 business days after receiving the above information via your written request and within 15 minutes when your request is received via telephone or internet.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to certain persons, including a person, or collection agencies acting on behalf of a person, with whom you have an existing account that requests information in your credit report for the purposes of reviewing or collecting the account. A security freeze does not apply to the use of your credit report for insurance underwriting purposes.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking a new credit, loan, utility, or telephone account, you should understand that the procedures involved in lifting security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, with enough advance notice before you apply for new credit to enable the lifting to take effect.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at equifax.com or call 800-685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $10.00. If you are a victim of identity theft and you submit a copy of a valid police report evidencing your claim to be a victim of a violation of RCW 9.35.020, no fee will be charged. If you are sixty-five years of age or older, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 10 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a specific period of time.</fo:block>
			</xsl:when>
			<xsl:when test="$stateSelector='WV'">
				<fo:block xsl:use-attribute-sets="class-h1">Your Rights Under State Law</fo:block>

				<fo:block xsl:use-attribute-sets="class-h4-state">West Virginia - Notice to Consumers</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">West Virginia Consumers Have the Right to Obtain a Security Freeze</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You may obtain a security freeze on your credit report to protect your privacy and ensure that credit is not granted in your name without your knowledge. You have a right to place a security freeze on your credit report pursuant to West Virginia law.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze will prohibit a consumer reporting agency from releasing any information in your credit report without your express authorization or approval.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The security freeze is designed to prevent credit, loans and services from being approved in your name without your consent. When you place a security freeze on your credit report, within five business days you will be provided a unique personal identification number or password to use if you choose to remove the freeze on your credit report or to temporarily authorize the distribution of your credit report for a period of time after the freeze is in place. To provide that authorization, you must contact the consumer-reporting agency and provide all of the following:</fo:block>

				<fo:list-block xsl:use-attribute-sets="list-format">
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>1.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The unique personal identification number or password provided by the consumer-reporting agency;</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>2.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>Proper identification to verify your identity; and</fo:block>
						</fo:list-item-body>
					</fo:list-item>
					<fo:list-item>
						<fo:list-item-label>
							<fo:block>3.</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block>The period of time for which the report shall be available to users of the credit report.</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A consumer-reporting agency that receives a request from a consumer to temporarily lift a freeze on a credit report shall comply with the request no later than three business days after receiving the request.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">A security freeze does not apply to circumstances in which you have an existing account relationship and a copy of your report is requested by your existing creditor or its agents or affiliates for certain types of account review, collection, fraud control or similar activities.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">If you are actively seeking credit, you should understand that the procedures involved in lifting a security freeze may slow your own applications for credit. You should plan ahead and lift a freeze, either completely if you are shopping around or specifically for a certain creditor, a few days before actually applying for new credit.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">You have the right to bring a civil action against someone who violates your rights under the credit reporting laws. The action can be brought against a consumer-reporting agency.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">To place a security freeze on your Equifax credit report, send your request via certified or overnight mail to:</fo:block>

				<fo:block xsl:use-attribute-sets="class-list-item-begin">Equifax Security Freeze</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item">P.O. Box 105788</fo:block>
				<fo:block xsl:use-attribute-sets="class-list-item-end">Atlanta, Georgia 30348</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Or, you may contact us on the web at Equifax.com or call 800685-1111.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">The fee to place a security freeze is $5.00. If you are a victim of identity theft and you submit a copy of a valid police report, an investigative report or a written complaint made to the Federal Trade Commission, to the Office of the Attorney General of West Virginia or to a law enforcement agency concerning the identity theft, no fee will be charged. Include your complete name, complete address, social security number, date of birth and payment, if applicable.</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">Written confirmation of the security freeze will be sent within 5 business days of receipt of the request via first class mail. It will include your unique personal identification number and instructions for removing the security freeze or authorizing the release of your credit report for a period of time.</fo:block>
			</xsl:when>
			<xsl:when test="$stateSelector='MP'">
				No content for Territories
			</xsl:when>
			<xsl:when test="$stateSelector='MH'">
				No content for Territories
			</xsl:when>
			<xsl:when test="$stateSelector='GU'">
				No content for Territories
			</xsl:when>
			<xsl:when test="$stateSelector='AS'">
				No content for Territories
			</xsl:when>
			<xsl:when test="$stateSelector='PW'">
				No content for Territories
			</xsl:when>
			<xsl:when test="$stateSelector='VI'">
				No content for Territories
			</xsl:when>
			<xsl:when test="$stateSelector='FM'">
				No content for Territories
			</xsl:when>
-->
			<xsl:otherwise>
				<!-- Summary of Your Rights Under State Law -->
				<fo:block xsl:use-attribute-sets="class-h1">
					<xsl:text/>
				</fo:block>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

	<xsl:template name="section-tradeLines">
		<xsl:param name="tradeLineSet" />
		<xsl:param name="prefix"/>

		<xsl:for-each select="$tradeLineSet">
			<xsl:variable name="i" select="position()" />
			<xsl:variable name="accountName" select="accountName"/>

			<fo:block xsl:use-attribute-sets="class-h2">
				<xsl:value-of select="concat($prefix,$i,' ',$accountName)"/>
				<xsl:if test="accountOpen='false'">
					<xsl:text> (CLOSED)</xsl:text>
				</xsl:if>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-h3">
				<xsl:text>Summary</xsl:text>
			</fo:block>

			<fo:block xsl:use-attribute-sets="class-paragraph">
				<xsl:text>Your debt-to-credit ratio represents the amount of credit you're using and generally makes up a percentage of your credit score. It's calculated by dividing an account's reported balance by its credit limit.</xsl:text>
			</fo:block>

			<!-- ACCOUNT SUMMARY -->
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<fo:table xsl:use-attribute-sets="class-table">
					<fo:table-column column-width="1.75in" />
					<fo:table-column column-width="1.75in" />
					<fo:table-column column-width="0.5in" />
					<fo:table-column column-width="1.75in" />
					<fo:table-column column-width="1.75in" />
					<fo:table-body>
						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Account Number</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(accountNumber) or string(accountNumber) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="accountNumber" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text>&#160;</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Reported Balance</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(balanceAmount) or string(balanceAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="balanceAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Account Status</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(accountStatus) or string(accountStatus) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatAccountStatus">
												<xsl:with-param name="status" select="accountStatus" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text>&#160;</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Debt-to-Credit Ratio</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:call-template name="func-calcPercent">
										<xsl:with-param name="balance" select="balanceAmount/amount"/>
										<xsl:with-param name="creditLimit" select="creditLimitAmount/amount"/>
										<xsl:with-param name="highCredit" select="highCreditAmount/amount"/>
										<xsl:with-param name="tradeLinePrefix" select="$prefix"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Available Credit</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(creditLimitAmount) or string(creditLimitAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="creditLimitAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text>&#160;</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>


			<!-- ACCOUNT HISTORY -->
			<fo:block xsl:use-attribute-sets="class-accountHistory-table">
				<fo:block xsl:use-attribute-sets="class-h3">
					<xsl:value-of select="trendedDataHistory/name"/>
				</fo:block>
				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:text> The tables below show up to 2 years of the monthly balance, available credit, scheduled payment, date of last payment, high credit, credit limit, amount past due, activity designator, and comments.</xsl:text>
				</fo:block>
				<xsl:for-each select="trendedDataHistory/trendedDataList">
					<!-- Balance -->
					<xsl:if test="name='Balance'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Available Credit-->
					<xsl:if test="name='Available Credit'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Scheduled Payment-->
					<xsl:if test="name='Scheduled Payment'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Actual Payment-->
					<xsl:if test="name='Actual Payment'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--High Credit-->
					<xsl:if test="name='High Credit'">
						<fo:block xsl:use-attribute-sets="class-h4-hist" keep-with-next.within-page="always">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block page-break-inside="avoid">
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Credit Limit-->
					<xsl:if test="name='Credit Limit'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Amount Past Due-->
					<xsl:if test="name='Amount Past Due'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataMoney">
															<xsl:with-param name="money" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Date of Last Payment-->
					<xsl:if test="name='Date of Last Payment'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="0.3in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-column column-width="0.6in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[1]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[2]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[3]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[4]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[5]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[6]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[7]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[8]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[9]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[10]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[11]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:call-template name="func-formatTrendedDataDate">
															<xsl:with-param name="DateTimeStr" select="monthData[12]"/>
														</xsl:call-template>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Activity Designator-->
					<xsl:if test="name='Activity Designator'">
						<fo:block xsl:use-attribute-sets="class-h4-hist">
							<xsl:value-of select="name"/>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-number="1" column-width="0.3in" />
								<fo:table-column column-number="2" />
								<fo:table-column column-number="3" />
								<fo:table-column column-number="4" />
								<fo:table-column column-number="5" />
								<fo:table-column column-number="6" />
								<fo:table-column column-number="7" />
								<fo:table-column column-number="8" />
								<fo:table-column column-number="9" />
								<fo:table-column column-number="10" />
								<fo:table-column column-number="11" />
								<fo:table-column column-number="12" />
								<fo:table-column column-number="13" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[1]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[2]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[3]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[4]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[5]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[6]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[7]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[8]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[9]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[10]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[11]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[12]"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:value-of select="labels[13]"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:for-each select="years">
										<xsl:if test="year">
											<fo:table-row text-align="center">
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:value-of select="year" />
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[1]) or string(monthData[1]) = 'NaN' or string(monthData[1]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[1]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[2]) or string(monthData[2]) = 'NaN' or string(monthData[2]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[2]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[3]) or string(monthData[3]) = 'NaN' or string(monthData[3]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[3]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[4]) or string(monthData[4]) = 'NaN' or string(monthData[4]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[4]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[5]) or string(monthData[5]) = 'NaN' or string(monthData[5]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[5]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[6]) or string(monthData[6]) = 'NaN' or string(monthData[6]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[6]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[7]) or string(monthData[7]) = 'NaN' or string(monthData[7]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[7]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[8]) or string(monthData[8]) = 'NaN' or string(monthData[8]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[8]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[9]) or string(monthData[9]) = 'NaN' or string(monthData[9]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[9]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[10]) or string(monthData[10]) = 'NaN' or string(monthData[10]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[10]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[11]) or string(monthData[11]) = 'NaN' or string(monthData[11]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[11]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
												<fo:table-cell>
													<fo:block xsl:use-attribute-sets="class-cell">
														<xsl:choose>
															<xsl:when test="not(monthData[12]) or string(monthData[12]) = 'NaN' or string(monthData[12]) = 'UNKNOWN'">
																<xsl:text/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="monthData[12]" />
															</xsl:otherwise>
														</xsl:choose>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</xsl:if>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:if>
					<!--Comments 1-->
					<xsl:if test="name='Comments 1'">
						<xsl:if test="years/monthData!=''">
							<fo:block xsl:use-attribute-sets="class-h4-hist">
								<xsl:value-of select="name"/>
							</fo:block>
							<!-- DATA TABLE -->
							<fo:block>
								<fo:table xsl:use-attribute-sets="class-table" table-omit-header-at-break="false">
									<fo:table-column column-width="1.5in" />
									<fo:table-column column-width="6.0in"  />

									<fo:table-header xsl:use-attribute-sets="class-row-header">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Date
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Comment
											</fo:block>
										</fo:table-cell>
									</fo:table-header>

									<fo:table-body>
										<xsl:call-template name="func-formatTrendedDataComments"/>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</xsl:if>
					</xsl:if>
					<!--Comments 2-->
					<xsl:if test="name='Comments 2'">
						<xsl:if test="years/monthData!=''">
							<fo:block xsl:use-attribute-sets="class-h4-hist">
								<xsl:value-of select="name"/>
							</fo:block>
							<!-- DATA TABLE -->
							<fo:block>
								<fo:table xsl:use-attribute-sets="class-table" table-omit-header-at-break="false">
									<fo:table-column column-width="1.5in" />
									<fo:table-column column-width="6.0in"  />

									<fo:table-header xsl:use-attribute-sets="class-row-header">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Date
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Comment
											</fo:block>
										</fo:table-cell>
									</fo:table-header>

									<fo:table-body>
										<xsl:call-template name="func-formatTrendedDataComments"/>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</xsl:if>
					</xsl:if>
					<!--Comments 3-->
					<xsl:if test="name='Comments 3'">
						<xsl:if test="years/monthData!=''">
							<fo:block xsl:use-attribute-sets="class-h4-hist">
								<xsl:value-of select="name"/>
							</fo:block>
							<!-- DATA TABLE -->
							<fo:block>
								<fo:table xsl:use-attribute-sets="class-table" table-omit-header-at-break="false">
									<fo:table-column column-width="1.5in" />
									<fo:table-column column-width="6.0in"  />

									<fo:table-header xsl:use-attribute-sets="class-row-header">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Date
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Comment
											</fo:block>
										</fo:table-cell>
									</fo:table-header>

									<fo:table-body>
										<xsl:call-template name="func-formatTrendedDataComments"/>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</xsl:if>
					</xsl:if>
					<!--Comments 4-->
					<xsl:if test="name='Comments 4'">
						<xsl:if test="years/monthData!=''">
							<fo:block xsl:use-attribute-sets="class-h4-hist">
								<xsl:value-of select="name"/>
							</fo:block>
							<!-- DATA TABLE -->
							<fo:block>
								<fo:table xsl:use-attribute-sets="class-table" table-omit-header-at-break="false">
									<fo:table-column column-width="1.5in" />
									<fo:table-column column-width="6.0in"  />

									<fo:table-header xsl:use-attribute-sets="class-row-header">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Date
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												Comment
											</fo:block>
										</fo:table-cell>
									</fo:table-header>

									<fo:table-body>
										<xsl:call-template name="func-formatTrendedDataComments"/>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
			</fo:block>

			<!-- PAYMENT HISTORY -->
			<fo:block xsl:use-attribute-sets="class-h3">
				<xsl:text>Payment History</xsl:text>
			</fo:block>
			<xsl:choose>
				<xsl:when test="not(paymentHistory)">
					<fo:block xsl:use-attribute-sets="class-paragraph">
						<xsl:call-template name="func-no-item">
							<xsl:with-param name="item">Payment History</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="class-paymenthistory-table">
						<fo:block xsl:use-attribute-sets="class-paragraph">
							<xsl:text>View up to 7 years of monthly payment history on this account. The numbers indicated in each month represent the number of days a payment was past due; the letters indicate other account events, such as bankruptcy or collections.</xsl:text>
						</fo:block>
						<!-- DATA TABLE -->
						<fo:block>
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width="1.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-column column-width="0.5in" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="class-row-header" text-align="center">
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Year</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Jan</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Feb</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Mar</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Apr</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>May</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Jun</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Jul</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Aug</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Sep</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Oct</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Nov</xsl:text>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:text>Dec</xsl:text>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<xsl:for-each select="paymentHistory">
										<fo:table-row text-align="center">
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:value-of select="year" />
												</fo:block>
											</fo:table-cell>

											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="january/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="february/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="march/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="april/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="may/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="june/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="july/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="august/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="september/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="october/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="november/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block xsl:use-attribute-sets="class-cell">
													<xsl:call-template name="func-calcPaymentHistoryValue">
														<xsl:with-param name="value" select="december/value" />
													</xsl:call-template>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:for-each>

								</fo:table-body>
							</fo:table>
						</fo:block>
						<!-- TABLE LEGEND -->
						<fo:block xsl:use-attribute-sets="class-paymenthistory-legend">
							<fo:table xsl:use-attribute-sets="class-table">
								<fo:table-column column-width=".25in" />
								<fo:table-column column-width="1.25in" />
								<fo:table-column column-width=".25in" />
								<fo:table-column column-width="1.25in" />
								<fo:table-column column-width=".25in" />
								<fo:table-column column-width="1.25in" />
								<fo:table-column column-width=".25in" />
								<fo:table-column column-width="1.25in" />
								<fo:table-column column-width=".25in" />
								<fo:table-column column-width="1.25in" />
								<fo:table-body>
									<fo:table-row table-layout="fixed" border-top="solid 0.1mm black">
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'PAYS_AS_AGREED'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Paid on Time</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'DAYSLATE_30'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> 30 Days Past Due</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'DAYSLATE_60'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> 60 Days Past Due</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'DAYSLATE_90'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> 90 Days Past Due</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'DAYSLATE_120'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> 120 Days Past Due</fo:block>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'DAYSLATE_150'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> 150 Days Past Due</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'DAYSLATE_180'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> 180 Days Past Due</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'VOLUNTARY_SURRENDER'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Voluntary Surrender</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'FORECLOSURE'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Foreclosure</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'COLLECTION'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Collection Account</fo:block>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'CHARGE_OFF'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Charge-Off</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'BANKRUPTCY'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Included in Bankruptcy</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'REPOSSESSION'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Repossession</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="'TOO_NEW_TO_RATE'" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> Too New to Rate</fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block xsl:use-attribute-sets="class-cell">
												<xsl:call-template name="func-calcPaymentHistoryValue">
													<xsl:with-param name="value" select="''" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block xsl:use-attribute-sets="class-cell">
												<fo:block xsl:use-attribute-sets="class-legend-text"> No Data Available</fo:block>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>

			<!-- ACCOUNT DETAILS -->
			<fo:block xsl:use-attribute-sets="class-paragraph">
				<fo:block xsl:use-attribute-sets="class-h3">
					<xsl:text>Account Details</xsl:text>
				</fo:block>

				<fo:block xsl:use-attribute-sets="class-paragraph">
					<xsl:text>View detailed information about this account. Contact the creditor or lender if you have any questions about it.</xsl:text>
				</fo:block>

				<fo:table xsl:use-attribute-sets="class-table">
					<fo:table-column column-width="1.75in" />
					<fo:table-column column-width="1.75in" />
					<fo:table-column column-width="0.5in" />
					<fo:table-column column-width="1.75in" />
					<fo:table-column column-width="1.75in" />
					<fo:table-body>

						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>High Credit</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(highCreditAmount) or string(highCreditAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="highCreditAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Owner</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(paymentResponsibility) or string(paymentResponsibility) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="paymentResponsibility" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Credit Limit</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(creditLimitAmount) or string(creditLimitAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="creditLimitAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Account Type</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(accountType) or string(accountType) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="accountType" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Terms Frequency</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(termFrequency) or string(termFrequency) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="termFrequency" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Term Duration</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(termDurationMonths) or string(termDurationMonths) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="termDurationMonths" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Balance</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(balanceAmount) or string(balanceAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="balanceAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Date Opened</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(dateOpened) or string(dateOpened) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="dateOpened" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Amount Past Due</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(pastDueAmount) or string(pastDueAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="pastDueAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Date Reported</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(reportedDate) or string(reportedDate) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="reportedDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Actual Payment Amount</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(actualPayment) or string(actualPayment) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="actualPayment" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Date of Last Payment</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(lastPaymentDate) or string(lastPaymentDate) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="lastPaymentDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Date of Last Activity</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(lastActivityDate) or string(lastActivityDate) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="lastActivityDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Scheduled Payment Amount</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(monthlyPayment) or string(monthlyPayment) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="monthlyPayment" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Months Reviewed</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(monthsReviewed) or string(monthsReviewed) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="monthsReviewed" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Delinquency First Reported</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(majorDelinquencyFirstReportedDate) or string(majorDelinquencyFirstReportedDate) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="majorDelinquencyFirstReportedDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Activity Designator</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(activityDesignator) or string(activityDesignator) = 'NaN' or string(activityDesignator) = 'UNKNOWN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="activityDesignator" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Creditor Classification</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(creditorClassification) or string(creditorClassification) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="creditorClassification" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Deferred Payment Start Date</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(deferredPaymentStartDate) or string(deferredPaymentStartDate) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="deferredPaymentStartDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Charge Off Amount</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(chargeOffAmount) or string(chargeOffAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="chargeOffAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Balloon Payment Date</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(balloonPaymentDate) or string(balloonPaymentDate) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="balloonPaymentDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Balloon Payment Amount</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(balloonPaymentAmount) or string(balloonPaymentAmount) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatMoney">
												<xsl:with-param name="money" select="balloonPaymentAmount" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-even">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Loan Type</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(loanType/description) or string(loanType/description) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="loanType/description" />
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Date Closed</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(dateClosed) or string(dateClosed) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="dateClosed" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row xsl:use-attribute-sets="class-row-odd">
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text>Date of First Delinquency</xsl:text>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:choose>
										<xsl:when test="not(firstDelinquencyDate) or string(firstDelinquencyDate) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatDate">
												<xsl:with-param name="date" select="firstDelinquencyDate" />
												<xsl:with-param name="mode" select="'mmm dd, yyyy'" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-label class-cell">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell class-cell-right">
									<xsl:text/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>

					</fo:table-body>
				</fo:table>
			</fo:block>

			<!-- COMMENTS AND CONTACTS -->
			<fo:block xsl:use-attribute-sets="class-paragraph" page-break-inside="avoid">

				<fo:table xsl:use-attribute-sets="class-table">
					<fo:table-column column-width="60%" />
					<fo:table-column column-width="40%" />
					<fo:table-body>
						<fo:table-row>

							<!-- COMMENTS -->
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-h3">
									Comments
								</fo:block>
								<xsl:for-each select="comments">
									<fo:block xsl:use-attribute-sets="class-paragraph">
										<xsl:choose>
											<xsl:when test="not(description) or string(description) = 'NaN'">
												<xsl:text/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="description" />
											</xsl:otherwise>
										</xsl:choose>
									</fo:block>
								</xsl:for-each>
							</fo:table-cell>

							<!-- CONTACTS -->
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-h3">
									Contact
								</fo:block>
								<fo:block xsl:use-attribute-sets="class-paragraph">
									<xsl:choose>
										<xsl:when test="not(contactInformation/contactName) or string(contactInformation/contactName) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="contactInformation/contactName" />
										</xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="not(contactInformation/address) or string(contactInformation/address) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatAddress">
												<xsl:with-param name="address" select="contactInformation/address" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:choose>
										<xsl:when test="not(contactInformation/phone) or string(contactInformation/phone) = 'NaN'">
											<xsl:text/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="func-formatPhone">
												<xsl:with-param name="phone" select="contactInformation/phone" />
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>

			</fo:block>

			<fo:block page-break-before="always" />
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="element-hr">
		<fo:block>
			<fo:leader leader-length="100%" leader-pattern="rule" rule-style="solid" rule-thickness="1px" />
		</fo:block>
	</xsl:template>

	<xsl:template name="element-image">
		<xsl:param name="width" />
		<xsl:param name="height" />
		<xsl:param name="imagePath" />

		<fo:external-graphic content-height="scale-to-fit" scaling="non-uniform">
			<xsl:attribute name="src">
				<xsl:text>url("</xsl:text>
				<!-- <xsl:value-of select="$cmsBasePath" /> -->
				<xsl:value-of select="$imagePath" />
				<xsl:text>")</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="height">
				<xsl:value-of select="$height" />
			</xsl:attribute>
			<xsl:attribute name="width">
				<xsl:value-of select="$width" />
			</xsl:attribute>
		</fo:external-graphic>
	</xsl:template>

	<xsl:template name="element-image-base64">
		<xsl:param name="width" />
		<xsl:param name="height" />
		<xsl:param name="imagePath" />

		<fo:external-graphic content-height="scale-to-fit" scaling="non-uniform">
			<xsl:attribute name="src">
				<xsl:text>url("</xsl:text>
				<xsl:value-of select="$imagePath" />
				<xsl:text>")</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="height">
				<xsl:value-of select="$height" />
			</xsl:attribute>
			<xsl:attribute name="width">
				<xsl:value-of select="$width" />
			</xsl:attribute>
		</fo:external-graphic>
	</xsl:template>

	<xsl:template name="element-image-logo">
		<xsl:param name="width" select="'2.00in'" />
		<xsl:param name="height" select="'0.39in'" />

		<xsl:call-template name="element-image-base64">
			<xsl:with-param name="width" select="$width" />
			<xsl:with-param name="height" select="$height" />
			<xsl:with-param name="imagePath" select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAtsAAACQCAMAAADurlccAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAMAUExURQAAAMEfK8EgLMEhLcIiLcIjLsIjL8IkMMMlMcMmMsMoM8QpNMQqNcQqNsQrN8UsN8UtOMUuOcUvOsYwO8YxPMYyPcczPsc0P8c1QMc2Qcg3Qcg4Q8g5RMk6Rck7Rsk8Rsk9R8o+SMo/ScpASspAS8tCTMtDTctETstFT8xGUMxHUcxIUs1JU81LVc1MVc5NVs5OV85OWM5PWc9RWs9SW9BUXdBVX9BWX9FXYNFYYdJbZNJcZNJdZtNeZ9NhadRkbNRkbdRlbtVnb9VpcdZqctZrc9dtdddudtdwd9hyedhyethze9l0fNl3ftp5gNt7gtt8g9x/htyAhtyBh9yBiNyCid2Dit2Ei96Hjd6JkN+Mkt+Nk+CPleCQluGRl+GUmuKWm+KWnOOYnuOZn+SdouSdo+SepOWgpeWhpuWjqAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHjQOn0AAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAAAsRAAALEQF/ZF+RAAAAGHRFWHRTb2Z0d2FyZQBwYWludC5uZXQgNC4wLjlsM35OAAAPYklEQVR42u2daYMdRRWG5y6zJZNUkCVGaSLBBSgQI4TCBShiFGwRl1ZBacWlXfj/P+D6xSSTmdvdZ3lPdd/rOZ/n9lL11Kn3LF1zsBmzf772jZcs7WcbNzcLOxj7g3+crUxtefLAZ8FtErbvLBe2tnzaZ8FtErbPrNlefdVnwW0Ktr88tWZ7fc9nwW0Ktn9+aIz24uhTnwW3Kdh+dW0tt098EtwmYftp81DyzCfBbRK2r5iHkhXvgdtH5pPnpmH782Nrub3+MQnolEauE1NKjQPvRmb7XWu5vTj+8wjWKXAvWaWm85l1G2H79spabp8O3L1LiivHxmfX2R4w88rN8kavw670V4/uv53tPjsxDyVf237jhLpB9Dl2trfZr46s5fbhR9vuWyFvEYYDTOplRgaSeJULz0KMJbLRwh94Mv5Dbhkpdqi0IGJbU641zPZb1nJ7cdIZkz1KN/EaCcO27FedbDliqEqKK/GnCof2CNv2lZurdmrkidRJf7yqdmubzWazaUzZ3kzIdqvZATL7xzUM7XqY7dPiTYCt1Z0a1TiNbpZJtMZkK6KzGJ+o1Wzb8bRQJTVxwgfZ/s+xeRPgW0/eMdrdqmfyImbIZV6JePMkW46QtS+YkaRaGhUG7bFY8kP7JsBGFbUA4AaNuKlwbozjkYG122gHmi8xWwDaYTRP8krZyk1nfLeIc7hSUbpzclt/Lba/CiC0h9kO1myvrllvtWNwtzKHe9GyiKBuPmxHTPpvy/PyPVbSoh0J+W37UPKlkmhvE5VJ59aYDCTRiqgKhNu1askODlZS/l6K9iDb9k2Ahw/sEyTDoxYwbMukJFE4l6jc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'" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="facta-positive-plus">
		<xsl:param name="width" select="'0.183in'" />
		<xsl:param name="height" select="'0.150in'" />

		<xsl:call-template name="element-image-base64">
			<xsl:with-param name="width" select="$width" />
			<xsl:with-param name="height" select="$height" />
			<xsl:with-param name="imagePath" select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAASCAMAAABo+94fAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTExIDc5LjE1ODMyNSwgMjAxNS8wOS8xMC0wMToxMDoyMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjA3Mzg3RjlDNjg3QjExRTZCMjk0REQzQ0E5RkRBQTYxIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjA3Mzg3RjlENjg3QjExRTZCMjk0REQzQ0E5RkRBQTYxIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MDczODdGOUE2ODdCMTFFNkIyOTRERDNDQTlGREFBNjEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MDczODdGOUI2ODdCMTFFNkIyOTRERDNDQTlGREFBNjEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7uEi1SAAAAeFBMVEX///8AgAAAgEcAh4cAn8cXgz8Xh3cXm78fg18/gxc/gx8/hz9HgABXt+dfgx93hxeHhwCHu9eHz/+X0/+f3/+/mxe/6//HnwDH8//Xu4fnt1fv7+/v///3+//3////z4f/05f/35//67//88f/+/f//+////f////er6ApAAAAAXRSTlMAQObYZgAAAHdJREFUGNOFkOcKgDAMhFu31r331r7/G9ogFUWD96OBj+TSC+EfIoTwT114bboX3iqfUmpF7QPPAT1l5De8hILozBavWl54z6Ax5gMUs5d4cm9YSSWuwYElfGTg40lcQOspMaD9YMQEWYl8UMZxnnGw8Nip3oc9AJsaKRA98tLAAAAAAElFTkSuQmCC'" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="facta-negative-minus">
		<xsl:param name="width" select="'0.183in'" />
		<xsl:param name="height" select="'0.150in'" />

		<xsl:call-template name="element-image-base64">
			<xsl:with-param name="width" select="$width" />
			<xsl:with-param name="height" select="$height" />
			<xsl:with-param name="imagePath" select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAASCAMAAABo+94fAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTExIDc5LjE1ODMyNSwgMjAxNS8wOS8xMC0wMToxMDoyMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjEzREU2Mjg1Njg3QjExRTZBQzgxQzRDMDI2QURFOURGIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjEzREU2Mjg2Njg3QjExRTZBQzgxQzRDMDI2QURFOURGIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MTNERTYyODM2ODdCMTFFNkFDODFDNEMwMjZBREU5REYiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MTNERTYyODQ2ODdCMTFFNkFDODFDNEMwMjZBREU5REYiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4R2MgyAAAAYFBMVEX/////AAD/ABf/AEf/AIf/NwD/Nx//N1//N4f/Pxf/Pyf/Pz//P3f/bxf/b7//hwD/h8f/r1f/r4f/r9f/r+f/35//3///77//7+//7///98f/9////8f//+////f///9ugfj2AAAAAXRSTlMAQObYZgAAAGJJREFUGNOF0FcOgCAQRVGevfdecP+7lEhADEy8nyehzDDm7nKmmS82n10EIO6/PKeQFavBWwhVsmvmJd4qzaOh8CfFLeDlT5nwQXENBPLoIbj5YeIS4knig8Q41PDUquzF3rqpHOtDJAulAAAAAElFTkSuQmCC'" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="element-a">
		<xsl:param name="href" />
		<xsl:param name="text" />
		<fo:basic-link xsl:use-attribute-sets="class-link">
			<xsl:attribute name="external-destination">
				<xsl:text>url('</xsl:text>
				<xsl:value-of select="$href" />
				<xsl:text>')</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="$text" />
		</fo:basic-link>
	</xsl:template>


	<xsl:template name="func-calcAge">
		<xsl:param name="totalMonths" />

		<xsl:variable name="years">
			<xsl:value-of select="format-number(floor($totalMonths div 12),'#')" />
		</xsl:variable>

		<xsl:variable name="months">
			<xsl:value-of select="$totalMonths - 12 * $years" />
		</xsl:variable>

		<xsl:if test="$years &gt; 0">
			<xsl:choose>
				<xsl:when test="$years = 1">
					<xsl:value-of select="$years" />
					<xsl:text> Year</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$years" />
					<xsl:text> Years</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="$months &gt; 0">

			<xsl:if test="$years &gt; 0">
				<xsl:text>, </xsl:text>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="$months = 1">
					<xsl:value-of select="$months" />
					<xsl:text> Month</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$months" />
					<xsl:text> Months</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template>

	<xsl:template name="func-formatPriorDisposition">
		<xsl:param name="item"/>
		<xsl:value-of select="concat(substring-before($item,':'),':')"/>
		<fo:block>
			<xsl:value-of select="substring-after($item,':')"/>
		</fo:block>
	</xsl:template>

	<xsl:template name="func-calcPercent">
		<xsl:param name="balance" />
		<xsl:param name="creditLimit" />
		<xsl:param name="highCredit" />
		<xsl:param name="tradeLinePrefix"/>
		<xsl:choose>
			<xsl:when test="$tradeLinePrefix = '2.' or $tradeLinePrefix = '5.'">
				<xsl:choose>
					<xsl:when test="$creditLimit = '' or not($creditLimit) or  string($creditLimit) = 'NaN'">
						<xsl:choose>
							<xsl:when test="$highCredit = '' or not($highCredit) or string($highCredit) = 'NaN'">
								<xsl:value-of select="'N/A'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable name="ratio">
									<xsl:value-of select="format-number((round(($balance div $highCredit)*100) div 100)*100,'##')"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$ratio != 'NaN' and $ratio != ''">
										<xsl:value-of select="concat($ratio, '%')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'N/A'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="ratio">
							<xsl:value-of select="format-number((round(($balance div $creditLimit)*100) div 100)*100,'##')"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$ratio != 'NaN' and $ratio != ''">
								<xsl:value-of select="concat($ratio, '%')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'N/A'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$highCredit = '' or not($highCredit) or string($highCredit) = 'NaN'">
						<xsl:value-of select="'N/A'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="ratio">
							<xsl:value-of select="format-number((round(($balance div $highCredit)*100) div 100)*100,'##')"/>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$ratio != 'NaN' and $ratio != ''">
								<xsl:value-of select="concat($ratio, '%')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'N/A'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-calcPaymentHistoryValue">
		<xsl:param name="value" />

		<xsl:choose>
			<xsl:when test="$value = 'PAYS_AS_AGREED'">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'0.13in'" />
					<xsl:with-param name="height" select="'0.10in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACYAAAAeCAMAAAB3ypxcAAABIFBMVEX///9RdDVRdTVRdTZSdDVSdDZSdTVSdTZSdjZTdDVTdTVTdTZTdTdTdjVTdjZTdjdUdDVUdTVUdTZUdjZUdjdVdDVVdDZVdTVVdTZVdTdVdjVVdjZVdzdWdDVWdTVWdTZWdjVWdjZWdzZYdzdZeTlbeTtefT5kf0Flf0FshElvhk1xh1B6jlp/kmCAlGSNnXKRoXiWpXyaqYScqIKcqIOcqYScqYWcqoadqYOdqYSdqYWdqoOdqoSdqoWdqoaeqYSeqoKeqoOeqoSeqoWeqoaeq4Weq4afqoSfq4Ofq4Sfq4Wfq4egqYKgq4amr4upspKxupy9wqq/xq3GyrPR1MLV2cnY29Dg49jk5t7o6uPt8Orz8ev1+PT4+fX5/f/8+/eoAQgjAAAAAXRSTlMAQObYZgAAAYZJREFUGBmNwYl2DFEQBuAium7PFJX5S9q9UnRL7Dth0IQYbSb2fV/f/y1wHKct09O+j3pM79N/aKS8Sr1m7uJ3qUcjyY1lixaaKsBQhEe0QCNQYLVgqR5TpwbJAJVlcNigLlN1Z/Aaxwob1KWBKFjMVfw6dWk0hDLCIqSoqUsDlzI3c2jcpC6NRMBNnROuUev2ha/Umu4BmN3ckcbUehCqsx/pl1k2GgIK2wW/TK2HMduJU+/op5tIhgEbYmU1tRobIEN+/DX9MBM3ha4ZxGtq1UHcQ574yAsiujcKDGW3MsRtat1RFIwKOMQHntKNfSLRYwKybEK/ebKkab8gGlSgYbfG3DxhWE7oD8/WEZBbWiqhZYzRTT0kTOgvzw8jrRTMlYvs5SEc7j6mf7w86okPLjOCiItZgNc0x6tjBv+uiMHNUfmY5npzwk0096gwsNfU4e1JlrBaKlylvESd3p+OIj7SkRY1LfDhzA5jJGCTFvp0jtPKQK5Qj8/nEaqGen256Ldovm9NMCzTrxZ0GgAAAABJRU5ErkJggg=='" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$value = 'DAYSLATE_30'">
				<fo:block xsl:use-attribute-sets="class-days-late-all">
					<xsl:text>30</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'DAYSLATE_60'">
				<fo:block xsl:use-attribute-sets="class-days-late-all">
					<xsl:text>60</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'DAYSLATE_90'">
				<fo:block xsl:use-attribute-sets="class-days-late-all">
					<xsl:text>90</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'DAYSLATE_120'">
				<fo:block xsl:use-attribute-sets="class-days-late-all">
					<xsl:text>120</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'DAYSLATE_150'">
				<fo:block xsl:use-attribute-sets="class-days-late-all">
					<xsl:text>150</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'DAYSLATE_180'">
				<fo:block xsl:use-attribute-sets="class-days-late-all">
					<xsl:text>180</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'BANKRUPTCY'">
				<fo:block xsl:use-attribute-sets="class-judgement">
					<xsl:text>B</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'COLLECTION'">
				<fo:block xsl:use-attribute-sets="class-judgement">
					<xsl:text>C</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'REPOSSESSION'">
				<fo:block xsl:use-attribute-sets="class-judgement">
					<xsl:text>R</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'CHARGE_OFF'">
				<fo:block xsl:use-attribute-sets="class-judgement">
					<xsl:text>CO</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'COLLECTION_CHARGEOFF'">
				<fo:block xsl:use-attribute-sets="class-judgement">
					<xsl:text>CO</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'TOO_NEW_TO_RATE'">
				<fo:block xsl:use-attribute-sets="class-too-new-to-rate">
					<xsl:text>TN</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'VOLUNTARY_SURRENDER'">
				<fo:block xsl:use-attribute-sets="class-judgement">
					<xsl:text>V</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'FORECLOSURE'">
				<fo:block xsl:use-attribute-sets="class-judgement">
					<xsl:text>F</xsl:text>
				</fo:block>
			</xsl:when>
			<xsl:when test="$value = 'ZERO_BAL_AND_CURR_ACCT'">
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'0.13in'" />
					<xsl:with-param name="height" select="'0.10in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACYAAAAeCAMAAAB3ypxcAAABIFBMVEX///9RdDVRdTVRdTZSdDVSdDZSdTVSdTZSdjZTdDVTdTVTdTZTdTdTdjVTdjZTdjdUdDVUdTVUdTZUdjZUdjdVdDVVdDZVdTVVdTZVdTdVdjVVdjZVdzdWdDVWdTVWdTZWdjVWdjZWdzZYdzdZeTlbeTtefT5kf0Flf0FshElvhk1xh1B6jlp/kmCAlGSNnXKRoXiWpXyaqYScqIKcqIOcqYScqYWcqoadqYOdqYSdqYWdqoOdqoSdqoWdqoaeqYSeqoKeqoOeqoSeqoWeqoaeq4Weq4afqoSfq4Ofq4Sfq4Wfq4egqYKgq4amr4upspKxupy9wqq/xq3GyrPR1MLV2cnY29Dg49jk5t7o6uPt8Orz8ev1+PT4+fX5/f/8+/eoAQgjAAAAAXRSTlMAQObYZgAAAYZJREFUGBmNwYl2DFEQBuAium7PFJX5S9q9UnRL7Dth0IQYbSb2fV/f/y1wHKct09O+j3pM79N/aKS8Sr1m7uJ3qUcjyY1lixaaKsBQhEe0QCNQYLVgqR5TpwbJAJVlcNigLlN1Z/Aaxwob1KWBKFjMVfw6dWk0hDLCIqSoqUsDlzI3c2jcpC6NRMBNnROuUev2ha/Umu4BmN3ckcbUehCqsx/pl1k2GgIK2wW/TK2HMduJU+/op5tIhgEbYmU1tRobIEN+/DX9MBM3ha4ZxGtq1UHcQ574yAsiujcKDGW3MsRtat1RFIwKOMQHntKNfSLRYwKybEK/ebKkab8gGlSgYbfG3DxhWE7oD8/WEZBbWiqhZYzRTT0kTOgvzw8jrRTMlYvs5SEc7j6mf7w86okPLjOCiItZgNc0x6tjBv+uiMHNUfmY5npzwk0096gwsNfU4e1JlrBaKlylvESd3p+OIj7SkRY1LfDhzA5jJGCTFvp0jtPKQK5Qj8/nEaqGen256Ldovm9NMCzTrxZ0GgAAAABJRU5ErkJggg=='" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--                <fo:block xsl:use-attribute-sets="class-no-data-container">
                  <fo:block xsl:use-attribute-sets="class-no-data">
                    <xsl:text>&#160;</xsl:text>
                  </fo:block>
               </fo:block> -->
				<xsl:call-template name="element-image-base64">
					<xsl:with-param name="width" select="'0.29in'" />
					<xsl:with-param name="height" select="'0.10in'" />
					<xsl:with-param name="imagePath" select="'data:image/png;base64,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'" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="func-formatDate">
		<xsl:param name="date" />
		<xsl:param name="mode" select="'mm/dd/yyyy'" />

		<xsl:variable name="datestr">
			<xsl:value-of select="substring-before($date,'T')" />
		</xsl:variable>

		<xsl:variable name="mm">
			<xsl:value-of select="substring($datestr,6,2)" />
		</xsl:variable>

		<xsl:variable name="mmm">
			<xsl:choose>
				<xsl:when test="$mm='01'">
					<xsl:text>Jan</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='02'">
					<xsl:text>Feb</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='03'">
					<xsl:text>Mar</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='04'">
					<xsl:text>Apr</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='05'">
					<xsl:text>May</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='06'">
					<xsl:text>Jun</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='07'">
					<xsl:text>Jul</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='08'">
					<xsl:text>Aug</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='09'">
					<xsl:text>Sep</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='10'">
					<xsl:text>Oct</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='11'">
					<xsl:text>Nov</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='12'">
					<xsl:text>Dec</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="mmmx">
			<xsl:choose>
				<xsl:when test="$mm='01'">
					<xsl:text>January</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='02'">
					<xsl:text>February</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='03'">
					<xsl:text>March</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='04'">
					<xsl:text>April</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='05'">
					<xsl:text>May</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='06'">
					<xsl:text>June</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='07'">
					<xsl:text>July</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='08'">
					<xsl:text>August</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='09'">
					<xsl:text>September</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='10'">
					<xsl:text>October</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='11'">
					<xsl:text>November</xsl:text>
				</xsl:when>
				<xsl:when test="$mm='12'">
					<xsl:text>December</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="dd">
			<xsl:value-of select="substring($datestr,9,2)" />
		</xsl:variable>

		<xsl:variable name="yyyy">
			<xsl:value-of select="substring($datestr,1,4)" />
		</xsl:variable>

		<!-- output format mm/dd/yyyy -->

		<xsl:choose>
			<xsl:when test="($mmm != '') or ($mm != '') or ($dd != '') or ($yyyy != '')">
				<xsl:choose>
					<xsl:when test="$mode='mmm dd, yyyy'">
						<xsl:value-of select="concat($mmm,' ', $dd, ', ', $yyyy)" />
					</xsl:when>
					<xsl:when test="$mode='mmmx dd, yyyy'">
						<xsl:value-of select="concat($mmmx,' ', $dd, ', ', $yyyy)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($mm,'/', $dd, '/', $yyyy)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-formatTrendedDataComments">
		<xsl:for-each select="years">
			<xsl:choose>
				<xsl:when test="year">
					<xsl:if test="monthData[1] and monthData[1] != '' and string(monthData[1]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('01/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[1]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[2]  and monthData[2] != '' and string(monthData[2]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('02/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[2]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[3]  and monthData[3] != '' and string(monthData[3]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('03/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[3]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[4]  and monthData[4] != '' and string(monthData[4]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('04/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[4]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[5]  and monthData[5] != '' and string(monthData[5]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('05/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[5]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[6]  and monthData[6] != '' and string(monthData[6]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('06/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[6]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[7]  and monthData[7] != '' and string(monthData[7]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('07/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[7]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[8]  and monthData[8] != '' and string(monthData[8]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('08/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[8]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[9]  and monthData[9] != '' and string(monthData[9]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('09/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[9]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[10]  and monthData[10] != '' and string(monthData[10]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('10/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[10]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[11]  and monthData[11] != '' and string(monthData[11]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('11/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[11]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="monthData[12]  and monthData[12] != '' and string(monthData[12]) != 'NaN'">
						<fo:table-row>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="concat('12/',year)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block xsl:use-attribute-sets="class-cell">
									<xsl:value-of select="monthData[12]"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="func-formatTrendedDataDate">
		<xsl:param name="DateTimeStr" />
		<xsl:choose>
			<xsl:when test="$DateTimeStr!=''">
				<xsl:variable name="datestr">
					<xsl:value-of select="substring-before($DateTimeStr,'T')" />
				</xsl:variable>
				<xsl:variable name="mm">
					<xsl:value-of select="substring($datestr,6,2)" />
				</xsl:variable>
				<xsl:variable name="dd">
					<xsl:value-of select="substring($datestr,9,2)" />
				</xsl:variable>
				<xsl:value-of select="concat($mm,'/', $dd)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-formatTrendedDataMoney">
		<xsl:param name="money" />
		<xsl:choose>
			<xsl:when test="$money!=''">
				<xsl:value-of select="format-number($money,'$#,##0')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-formatAccountAge">
		<xsl:param name="number"/>
		<xsl:if test="$number != ''">
			<xsl:choose>
				<xsl:when test="$number &lt; 12">
					<xsl:value-of select="concat(format-number($number, '##'),' Month(s)')"/>
				</xsl:when>
				<xsl:when test="$number mod 12 = 0">
					<xsl:variable name="years">
						<xsl:value-of select="$number div 12"/>
					</xsl:variable>
					<xsl:value-of select="concat(format-number($years,'##'),' Year(s)')"/>
				</xsl:when>
				<xsl:when test="$number mod 12 != 0">
					<xsl:variable name="years">
						<xsl:value-of select="round($number div 12)"/>
					</xsl:variable>
					<xsl:variable name="months">
						<xsl:value-of select="$number mod 12"/>
					</xsl:variable>
					<xsl:value-of select="concat(format-number($years,'##'),' Year(s), ', format-number($months,'##'),' Month(s)')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="$number = ''">
			<xsl:text/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="func-formatMoney">
		<xsl:param name="money" />
		<xsl:choose>
			<xsl:when test="$money != '' and $money/currency = 'USD'">
				<xsl:value-of select="format-number($money/amount,'$#,##0')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-formatAccountStatus">
		<xsl:param name="status" />
		<xsl:value-of select="$status" />
	</xsl:template>

	<xsl:template name="func-formatAddress">
		<xsl:param name="address" />

		<xsl:choose>
			<xsl:when test="not($address/line1) or $address/line1 = ''">
			</xsl:when>
			<xsl:otherwise>
				<fo:block>
					<xsl:value-of select="$address/line1" />
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="not($address/line2) or $address/line2 = ''">
			</xsl:when>
			<xsl:otherwise>
				<fo:block>
					<xsl:value-of select="$address/line2" />
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="$address/line3 = '' and $address/line4 = '' and $address/line5 = ''">
				<xsl:text/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block>
					<xsl:if test="$address/line3 and $address/line3 != '' and string($address/line3) != 'NaN'">
						<xsl:value-of select="concat($address/line3,', ')"/>
					</xsl:if>
					<xsl:if test="$address/line4 and $address/line4 != '' and string($address/line4) != 'NaN'">
						<xsl:value-of select="concat($address/line4,'&#160;&#160;')"/>
					</xsl:if>
					<xsl:if test="$address/line5 and $address/line5 != '' and string($address/line5) != 'NaN'">
						<xsl:choose>
							<xsl:when test="string-length($address/line5) = '9'">
								<xsl:call-template name="func-formatZipCode">
									<xsl:with-param name="uglyZipCode" select="$address/line5"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$address/line5"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-formatZipCode">
		<xsl:param name="uglyZipCode"/>
		<xsl:variable name="prefix">
			<xsl:value-of select="substring($uglyZipCode,1,5)" />
		</xsl:variable>
		<xsl:variable name="suffix">
			<xsl:value-of select="substring($uglyZipCode,6,4)" />
		</xsl:variable>
		<xsl:value-of select="concat($prefix,'-',$suffix)"/>
	</xsl:template>

	<xsl:template name="func-formatPhone">
		<xsl:param name="phone" />

		<xsl:choose>
			<xsl:when test="not($phone/areaCode) or not($phone/exchange) or not($phone/extension) or not($phone/countryCode) or $phone/areaCode = '' or $phone/exchange = '' or $phone/extension = ''">
				<xsl:text/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($phone/countryCode, '-', $phone/areaCode,'-',$phone/exchange,'-',$phone/extension)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="func-no-item">
		<xsl:param name="item"/>
		<xsl:text>You currently do not have any </xsl:text>
		<xsl:value-of select="$item" />
		<xsl:text> in your file.</xsl:text>
	</xsl:template>

	<xsl:attribute-set name="class-h1">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">18pt</xsl:attribute>
		<xsl:attribute name="space-after">20pt</xsl:attribute>
		<xsl:attribute name="color">#981E32</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="class-subhead">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">10pt</xsl:attribute>
		<xsl:attribute name="space-after">10pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="class-h2">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">15pt</xsl:attribute>
		<xsl:attribute name="space-after">15pt</xsl:attribute>
		<xsl:attribute name="color">#45555F</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-h2-highlight">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">15pt</xsl:attribute>
		<xsl:attribute name="space-after">15pt</xsl:attribute>
		<xsl:attribute name="color">#981E32</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-h3">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">11pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">15pt</xsl:attribute>
		<xsl:attribute name="space-after">15pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-h4">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<!--<xsl:attribute name="font-weight">bold</xsl:attribute> -->
		<xsl:attribute name="space-before">15pt</xsl:attribute>
		<xsl:attribute name="space-after">15pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-h4-state">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">10pt</xsl:attribute>
		<xsl:attribute name="space-after">0pt</xsl:attribute>
		<xsl:attribute name="color">#981E32</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-h4-hist">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">10pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
		<xsl:attribute name="color">#981E32</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-paragraph">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-paragraphBold">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-paragraphBoldStart">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-paragraphEnd">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="list-format">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="provisional-label-separation">3pt</xsl:attribute>
		<xsl:attribute name="provisional-distance-between-starts">14pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-table">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="table-layout">fixed</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-table-comments">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="table-layout">fixed</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-accountHistory-table">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-paymenthistory-table">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-paymenthistory-legend">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">6pt</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-label">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-link">
		<xsl:attribute name="color">blue</xsl:attribute>
		<xsl:attribute name="text-decoration">underline</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-header">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-footer">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-row-header">
		<xsl:attribute name="background-color">#888</xsl:attribute>
		<xsl:attribute name="color">#FFFFFF</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-text-danger">
		<xsl:attribute name="color">#A94442</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-row-odd">
		<xsl:attribute name="background-color">
			<xsl:value-of select="$colorOddRowBG" />
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-row-even">
		<xsl:attribute name="background-color">
			<xsl:value-of select="$colorEvenRowBG" />
		</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-cell">
		<xsl:attribute name="padding">5pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-cell-pub">
		<xsl:attribute name="padding">0pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-cell-right">
		<xsl:attribute name="text-align">right</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-comments-label">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="space-after">1pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-comments">
		<xsl:attribute name="font-weight">normal</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-list-item-begin">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
		<xsl:attribute name="space-after">1pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-list-item">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="space-before">1pt</xsl:attribute>
		<xsl:attribute name="space-after">1pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-list-item-end">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="space-before">1pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-pays-as-agreed">
		<xsl:attribute name="color">#567535</xsl:attribute>
		<xsl:attribute name="width">0.13in</xsl:attribute>
		<xsl:attribute name="height">0.10in</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-days-late-all">
		<xsl:attribute name="color">#d7121b</xsl:attribute>
		<xsl:attribute name="width">0.13in</xsl:attribute>
		<xsl:attribute name="height">0.10in</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-judgement">
		<xsl:attribute name="color">#7b137c</xsl:attribute>
		<xsl:attribute name="width">0.13in</xsl:attribute>
		<xsl:attribute name="height">0.10in</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-too-new-to-rate">
		<xsl:attribute name="color">#241f24</xsl:attribute>
		<xsl:attribute name="width">0.13in</xsl:attribute>
		<xsl:attribute name="height">0.10in</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-legend-text">
		<xsl:attribute name="color">#241f24</xsl:attribute>
		<xsl:attribute name="width">.6in</xsl:attribute>
		<xsl:attribute name="height">0.10in</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-no-data">
		<xsl:attribute name="background-image">url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAANElEQVQoU2NcsGDx/4SEWEYGKADxQUx0MbACmGJkTehiKCYhm4JsAIhNvIlEu5FohUPAMwDbP3uTAksG9gAAAABJRU5ErkJggg==')</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-no-data-container">
		<xsl:attribute name="padding-left">0.10in</xsl:attribute>
		<xsl:attribute name="padding-right">0.10in</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-efx-logo">
		<xsl:attribute name="padding-left">0.10in</xsl:attribute>
		<xsl:attribute name="padding-right">0.10in</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-table-with-border">
		<xsl:attribute name="border-width">0.5mm</xsl:attribute>
		<xsl:attribute name="border-style">solid</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="class-paragraph-ca">
		<xsl:attribute name="font-family">Calibri</xsl:attribute>
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="space-before">7pt</xsl:attribute>
		<xsl:attribute name="space-after">7pt</xsl:attribute>
	</xsl:attribute-set>


</xsl:stylesheet>