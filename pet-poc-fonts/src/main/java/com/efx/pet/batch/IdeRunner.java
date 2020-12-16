package com.efx.pet.batch;

import com.efx.pet.batch.service.GeneratorService;
import com.efx.pet.batch.utils.ReportUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class IdeRunner {
    public static final String TEMP_FILENAME = "temp.pdf";
    public static final String CREDIT_REPORT_DOCUMENT_FILENAME = "credit-report-bahdguy-3B-001.xml";
    public static final String ONE_B_REPORT_TEMPLATE = "credit-report-1b-pdf-001.xsl";

    public static void main(String[] args) throws Exception {
        GeneratorService generatorService = new GeneratorService(ONE_B_REPORT_TEMPLATE, CREDIT_REPORT_DOCUMENT_FILENAME, TEMP_FILENAME, false);
        generatorService.generateReport();
        ReportUtils.openGeneratedFile(TEMP_FILENAME);
    }

}
