<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:import
            href="C:\Users\dxd316\Projects\gcs-pet-xslt-transformer\pet-poc-templates\src\main\resources\xsl-1.xsl"/>
    <xsl:import
            href="C:\Users\dxd316\Projects\gcs-pet-xslt-transformer\pet-poc-templates\src\main\resources\xsl-2.xsl"/>

    <xsl:output method="xml" encoding="utf-8" indent="yes"/>

    <xsl:variable name="scoreEnabled"
                  select="/printableCreditReport/properties/entry/key[text()='scoreEnabled']/../value"/>
    <xsl:variable name="cmsBasePath" select="/printableCreditReport/properties/entry/key[text()='base_path']/../value"/>
    <xsl:variable name="colorOddRowBG" select="'#F9F9F9'"/> <!-- LIGHT GRAY -->
    <xsl:variable name="colorEvenRowBG" select="'#FFFFFF'"/> <!-- WHITE -->


    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="normal" page-height="11in" page-width="8in" margin-right="55pt"
                                       margin-left="70pt" margin-bottom="40pt" margin-top="22pt">
                    <fo:region-body margin-top="15pt" margin-bottom="40pt"/>
                    <fo:region-before extent="10pt"/>
                    <fo:region-after extent="10pt"/>
                </fo:simple-page-master>
            </fo:layout-master-set>


            <fo:page-sequence master-reference="normal">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block>
                        <xsl:text>Test import </xsl:text>
                        <xsl:text>Resolve-uri: </xsl:text>
                        <!--xsl:value-of select="resolve-uri('main.xsl')"/-->
                        <xsl:text>Version of XSLT: </xsl:text>
                        <xsl:value-of select="system-property('xsl:version')"/>
                    </fo:block>

                    <xsl:call-template name="xsl-1"/>
                    <fo:block page-break-before="always"/>
                    <xsl:call-template name="xsl-2"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>