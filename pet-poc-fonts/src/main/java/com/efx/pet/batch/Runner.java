package com.efx.pet.batch;

import com.efx.pet.batch.service.PdfGeneratorService;
import com.efx.pet.batch.utils.ReportUtils;
import com.efx.pet.domain.substrate.SubstrateContext;
import com.efx.pet.service.saas.creditreport.v1.domain.CreditReport;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import java.awt.*;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;

@Slf4j
public class Runner {
    public static final String FOP_CONFIG_FILENAME = "fop.xconf.xml";
    public static final String TEMP_FILENAME = "temp.pdf";
    public static final String CREDIT_REPORT_DOCUMENT_FILENAME = "credit-report-bahdguy-3B-001.xml";
    public static final String ONE_B_REPORT_TEMPLATE = "credit-report-1b-pdf-001.xsl";

    public static void main(String[] args) throws Exception {

        CreditReport report = ReportUtils.getReportById(CREDIT_REPORT_DOCUMENT_FILENAME);
        PdfGeneratorService service = new PdfGeneratorService(FOP_CONFIG_FILENAME);
        InputStream pdfCreditReport = service.getPdfCreditReport(createContext(), report, ONE_B_REPORT_TEMPLATE);

        generateReport(pdfCreditReport);
        openGeneratedFile();
    }

    private static void openGeneratedFile() {
        if (Desktop.isDesktopSupported()) {
            try {
                File myFile = new File(TEMP_FILENAME);
                Desktop.getDesktop().open(myFile);
            } catch (IOException ex) {
                log.error(ex.getMessage());
            }
        }
    }

    private static SubstrateContext createContext() {
        return new SubstrateContext("tenantCode", "patentCode", "configCode", Locale.US);
    }

    private static void generateReport(InputStream pdfCreditReport) throws IOException {
        if (null != pdfCreditReport) {
            byte[] bytes = IOUtils.toByteArray(pdfCreditReport);
            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

            if (bytes.length > 0) {
                FileUtils.copyInputStreamToFile(byteArrayInputStream, new File(TEMP_FILENAME));
                log.info("Generated document was stored under name: {}", TEMP_FILENAME);
            }
        } else {
            log.error("Pdf file wasn't generated");
        }
        closeStream(pdfCreditReport);
    }

    private static void closeStream(InputStream pdfCreditReport) {
        try {
            if (pdfCreditReport != null)
                pdfCreditReport.close();
        } catch (IOException exp) {
            System.err.println("Could not close pdfCreditReport " + TEMP_FILENAME);
        }
    }

}
