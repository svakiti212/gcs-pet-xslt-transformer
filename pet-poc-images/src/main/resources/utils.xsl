<xsl:stylesheet
        version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        xmlns:date="http://exslt.org/dates-and-times">

    <xsl:template name="addCharacterEntities">
<xsl:text disable-output-escaping="yes">
    &lt;!DOCTYPE fo:root [
    &lt;!ENTITY tilde "&amp;#126;"&gt;
    &lt;!ENTITY florin "&amp;#131;"&gt;
    &lt;!ENTITY elip "&amp;#133;"&gt;
    &lt;!ENTITY dag "&amp;#134;"&gt;
    &lt;!ENTITY ddag "&amp;#135;"&gt;
    &lt;!ENTITY cflex "&amp;#136;"&gt;
    &lt;!ENTITY permil "&amp;#137;"&gt;
    &lt;!ENTITY uscore "&amp;#138;"&gt;
    &lt;!ENTITY OElig "&amp;#140;"&gt;
    &lt;!ENTITY lsquo "&amp;#145;"&gt;
    &lt;!ENTITY rsquo "&amp;#146;"&gt;
    &lt;!ENTITY ldquo "&amp;#147;"&gt;
    &lt;!ENTITY rdquo "&amp;#148;"&gt;
    &lt;!ENTITY bullet "&amp;#149;"&gt;
    &lt;!ENTITY endash "&amp;#150;"&gt;
    &lt;!ENTITY emdash "&amp;#151;"&gt;
    &lt;!ENTITY trade "&amp;#153;"&gt;
    &lt;!ENTITY oelig "&amp;#156;"&gt;
    &lt;!ENTITY Yuml "&amp;#159;"&gt;
    &lt;!ENTITY nbsp "&amp;#160;"&gt;
    &lt;!ENTITY iexcl "&amp;#161;"&gt;
    &lt;!ENTITY cent "&amp;#162;"&gt;
    &lt;!ENTITY pound "&amp;#163;"&gt;
    &lt;!ENTITY curren "&amp;#164;"&gt;
    &lt;!ENTITY yen "&amp;#165;"&gt;
    &lt;!ENTITY brvbar "&amp;#166;"&gt;
    &lt;!ENTITY sect "&amp;#167;"&gt;
    &lt;!ENTITY uml "&amp;#168;"&gt;
    &lt;!ENTITY copy "&amp;#169;"&gt;
    &lt;!ENTITY ordf "&amp;#170;"&gt;
    &lt;!ENTITY laquo "&amp;#171;"&gt;
    &lt;!ENTITY not "&amp;#172;"&gt;
    &lt;!ENTITY shy "&amp;#173;"&gt;
    &lt;!ENTITY reg "&amp;#174;"&gt;
    &lt;!ENTITY macr "&amp;#175;"&gt;
    &lt;!ENTITY deg "&amp;#176;"&gt;
    &lt;!ENTITY plusmn "&amp;#177;"&gt;
    &lt;!ENTITY sup2 "&amp;#178;"&gt;
    &lt;!ENTITY sup3 "&amp;#179;"&gt;
    &lt;!ENTITY acute "&amp;#180;"&gt;
    &lt;!ENTITY micro "&amp;#181;"&gt;
    &lt;!ENTITY para "&amp;#182;"&gt;
    &lt;!ENTITY middot "&amp;#183;"&gt;
    &lt;!ENTITY cedil "&amp;#184;"&gt;
    &lt;!ENTITY sup1 "&amp;#185;"&gt;
    &lt;!ENTITY ordm "&amp;#186;"&gt;
    &lt;!ENTITY raquo "&amp;#187;"&gt;
    &lt;!ENTITY frac14 "&amp;#188;"&gt;
    &lt;!ENTITY frac12 "&amp;#189;"&gt;
    &lt;!ENTITY frac34 "&amp;#190;"&gt;
    &lt;!ENTITY iquest "&amp;#191;"&gt;
    &lt;!ENTITY Agrave "&amp;#192;"&gt;
    &lt;!ENTITY Aacute "&amp;#193;"&gt;
    &lt;!ENTITY Acirc "&amp;#194;"&gt;
    &lt;!ENTITY Atilde "&amp;#195;"&gt;
    &lt;!ENTITY Auml "&amp;#196;"&gt;
    &lt;!ENTITY Aring "&amp;#197;"&gt;
    &lt;!ENTITY AElig "&amp;#198;"&gt;
    &lt;!ENTITY Ccedil "&amp;#199;"&gt;
    &lt;!ENTITY Egrave "&amp;#200;"&gt;
    &lt;!ENTITY Eacute "&amp;#201;"&gt;
    &lt;!ENTITY Ecirc "&amp;#202;"&gt;
    &lt;!ENTITY Euml "&amp;#203;"&gt;
    &lt;!ENTITY Igrave "&amp;#204;"&gt;
    &lt;!ENTITY Iacute "&amp;#205;"&gt;
    &lt;!ENTITY Icirc "&amp;#206;"&gt;
    &lt;!ENTITY Iuml "&amp;#207;"&gt;
    &lt;!ENTITY ETH "&amp;#208;"&gt;
    &lt;!ENTITY Ntilde "&amp;#209;"&gt;
    &lt;!ENTITY Ograve "&amp;#210;"&gt;
    &lt;!ENTITY Oacute "&amp;#211;"&gt;
    &lt;!ENTITY Ocirc "&amp;#212;"&gt;
    &lt;!ENTITY Otilde "&amp;#213;"&gt;
    &lt;!ENTITY Ouml "&amp;#214;"&gt;
    &lt;!ENTITY times "&amp;#215;"&gt;
    &lt;!ENTITY Oslash "&amp;#216;"&gt;
    &lt;!ENTITY Ugrave "&amp;#217;"&gt;
    &lt;!ENTITY Uacute "&amp;#218;"&gt;
    &lt;!ENTITY Ucirc "&amp;#219;"&gt;
    &lt;!ENTITY Uuml "&amp;#220;"&gt;
    &lt;!ENTITY Yacute "&amp;#221;"&gt;
    &lt;!ENTITY THORN "&amp;#222;"&gt;
    &lt;!ENTITY szlig "&amp;#223;"&gt;
    &lt;!ENTITY agrave "&amp;#224;"&gt;
    &lt;!ENTITY aacute "&amp;#225;"&gt;
    &lt;!ENTITY acirc "&amp;#226;"&gt;
    &lt;!ENTITY atilde "&amp;#227;"&gt;
    &lt;!ENTITY auml "&amp;#228;"&gt;
    &lt;!ENTITY aring "&amp;#229;"&gt;
    &lt;!ENTITY aelig "&amp;#230;"&gt;
    &lt;!ENTITY ccedil "&amp;#231;"&gt;
    &lt;!ENTITY egrave "&amp;#232;"&gt;
    &lt;!ENTITY eacute "&amp;#233;"&gt;
    &lt;!ENTITY ecirc "&amp;#234;"&gt;
    &lt;!ENTITY euml "&amp;#235;"&gt;
    &lt;!ENTITY igrave "&amp;#236;"&gt;
    &lt;!ENTITY iacute "&amp;#237;"&gt;
    &lt;!ENTITY icirc "&amp;#238;"&gt;
    &lt;!ENTITY iuml "&amp;#239;"&gt;
    &lt;!ENTITY eth "&amp;#240;"&gt;
    &lt;!ENTITY ntilde "&amp;#241;"&gt;
    &lt;!ENTITY ograve "&amp;#242;"&gt;
    &lt;!ENTITY oacute "&amp;#243;"&gt;
    &lt;!ENTITY ocirc "&amp;#244;"&gt;
    &lt;!ENTITY otilde "&amp;#245;"&gt;
    &lt;!ENTITY ouml "&amp;#246;"&gt;
    &lt;!ENTITY oslash "&amp;#248;"&gt;
    &lt;!ENTITY ugrave "&amp;#249;"&gt;
    &lt;!ENTITY uacute "&amp;#250;"&gt;
    &lt;!ENTITY ucirc "&amp;#251;"&gt;
    &lt;!ENTITY uuml "&amp;#252;"&gt;
    &lt;!ENTITY yacute "&amp;#253;"&gt;
    &lt;!ENTITY thorn "&amp;#254;"&gt;
    &lt;!ENTITY yuml "&amp;#255;"&gt;
    &lt;!ENTITY euro "&amp;#x20AC;"&gt;
    ]&gt;
</xsl:text>
    </xsl:template>

    <xsl:template name="func-formatDate">
        <xsl:param name="date"/>
        <xsl:param name="mode" select="'mm/dd/yyyy'"/>

        <xsl:variable name="datestr">
            <xsl:value-of select="substring-before($date,'T')"/>
        </xsl:variable>

        <xsl:variable name="mm">
            <xsl:value-of select="substring($datestr,6,2)"/>
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

        <xsl:variable name="dd">
            <xsl:value-of select="substring($datestr,9,2)"/>
        </xsl:variable>

        <xsl:variable name="yyyy">
            <xsl:value-of select="substring($datestr,1,4)"/>
        </xsl:variable>

        <!-- output format mm/dd/yyyy -->

        <xsl:choose>
            <xsl:when test="$mode='mmm dd, yyyy'">
                <xsl:value-of select="concat($mmm,' ', $dd, ', ', $yyyy)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($mm,'/', $dd, '/', $yyyy)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



    <xsl:template name="func-gold-header">
        <xsl:param name="header-title"/>
        <xsl:param name="container-right-margin" select="'0pt'"/>
        <fo:block-container>
            <xsl:attribute name="margin-right">
                <xsl:value-of select="$container-right-margin"/>
            </xsl:attribute>
            <fo:block xsl:use-attribute-sets="class-header">
                <fo:table xsl:use-attribute-sets="class-table">
                    <fo:table-column column-width="90%"/>
                    <fo:table-column column-width="10%"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block xsl:use-attribute-sets="class-h4" text-align="left">
                                    <xsl:value-of select="$header-title"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block xsl:use-attribute-sets="class-h4" text-align="right">
                                    <xsl:value-of select="date:year()"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block-container>
    </xsl:template>

    <xsl:template name="element-image">
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

    <xsl:attribute-set name="class-h2">
        <xsl:attribute name="font-family">Calibri</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">15pt</xsl:attribute>
        <xsl:attribute name="space-after">15pt</xsl:attribute>
        <xsl:attribute name="color">#45555F</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="class-h4">
        <xsl:attribute name="font-family">Calibri</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">15pt</xsl:attribute>
        <xsl:attribute name="space-after">15pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="class-paragraph">
        <xsl:attribute name="font-family">Calibri</xsl:attribute>
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
        <xsl:attribute name="space-after">5pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="class-table">
        <xsl:attribute name="font-family">Calibri</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="table-layout">fixed</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="class-header">
        <xsl:attribute name="font-family">Calibri</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
