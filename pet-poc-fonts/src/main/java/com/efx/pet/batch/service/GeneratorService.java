package com.efx.pet.batch.service;

import com.efx.pet.batch.utils.ReportUtils;
import com.efx.pet.domain.substrate.SubstrateContext;
import com.efx.pet.service.saas.creditreport.v1.domain.CreditReport;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;

@Slf4j
public class GeneratorService {
    public static final String FOP_CONFIG_FILENAME = "fop.xconf.xml";
    private final String xlsTemplateFile;
    private final String xmlReportFile;
    private final String pdfFile;
    private final PdfGeneratorService pdfGeneratorService;
    private final boolean absolutePath;

    public GeneratorService(String xlsTemplateFile, String xmlReportFile, String pdfFile, boolean absolutePath) {
        this.xlsTemplateFile = xlsTemplateFile;
        this.xmlReportFile = xmlReportFile;
        this.pdfFile = pdfFile;
        this.absolutePath = absolutePath;
        this.pdfGeneratorService = new PdfGeneratorService(FOP_CONFIG_FILENAME,  new XslService());
    }

    private static SubstrateContext createContext() {
        return new SubstrateContext("tenantCode", "patentCode", "configCode", Locale.US);
    }

    private void producePdf(InputStream pdfCreditReport) throws IOException {
        if (null != pdfCreditReport) {
            byte[] bytes = IOUtils.toByteArray(pdfCreditReport);
            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

            if (bytes.length > 0) {
                FileUtils.copyInputStreamToFile(byteArrayInputStream, new File(pdfFile));
                log.info("Generated document was stored under name: {}", pdfFile);
            }
        } else {
            log.error("Pdf file wasn't generated");
        }
        closeStream(pdfCreditReport, pdfFile);
    }

    private void closeStream(InputStream pdfCreditReport, String filename) {
        try {
            if (pdfCreditReport != null)
                pdfCreditReport.close();
        } catch (IOException exp) {
            System.err.println("Could not close pdfCreditReport " + filename);
        }
    }

    @SneakyThrows
    public void generateReport() {
        CreditReport report = ReportUtils.getReportById(xmlReportFile, absolutePath);
        InputStream pdfCreditReport = pdfGeneratorService.getPdfCreditReport(createContext(), report, xlsTemplateFile, absolutePath);
        producePdf(pdfCreditReport);
    }
}
