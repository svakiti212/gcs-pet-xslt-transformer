package com.efx.pet.batch;

import com.efx.pet.batch.service.XslService;

import java.io.ByteArrayInputStream;

public class RelativeImportMain {

    public static final String XSL_FILENAME = "xsl-main-import-relative.xsl";
    public static final String RESULT_FILENAME = "xls-out-relative.xsl";
    public static final String INPUT_XML = "simple.xml";

    public static void main(String[] args) throws Exception {
        XslService service = new XslService();
        byte[] xlsBytes = service.resolveImportTags(XSL_FILENAME);
        service.produceResultFile(INPUT_XML, RESULT_FILENAME, new ByteArrayInputStream(xlsBytes));
    }
}
