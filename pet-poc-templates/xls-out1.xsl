<?xml version="1.0" encoding="utf-8"?><fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
<fo:layout-master-set>
<fo:simple-page-master margin-top="22pt" margin-bottom="40pt" margin-left="70pt" margin-right="55pt" page-width="8in" page-height="11in" master-name="normal">
<fo:region-body margin-bottom="40pt" margin-top="15pt"/>
<fo:region-before extent="10pt"/>
<fo:region-after extent="10pt"/>
</fo:simple-page-master>
</fo:layout-master-set>
<fo:page-sequence master-reference="normal">
<fo:flow flow-name="xsl-region-body">
<fo:block>Test import Resolve-uri: Version of XSLT: 1.0</fo:block>
<fo:block>Test of xsl-1</fo:block>
<fo:block page-break-before="always"/>
<fo:block>Test of xsl-2</fo:block>
</fo:flow>
</fo:page-sequence>
</fo:root>
