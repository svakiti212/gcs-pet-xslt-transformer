package com.efx.pet.batch.service;

import com.efx.pet.batch.utils.CustomFontTransformer;
import com.efx.pet.domain.substrate.SubstrateContext;
import com.efx.pet.service.saas.creditreport.v1.PrintableCreditReport;
import com.efx.pet.service.saas.creditreport.v1.domain.CreditReport;
import com.efx.pet.transformer.Transformer;
import com.efx.pet.transformer.TransformerStyle;
import com.efx.pet.transformer.XslTransformerStyle;
import com.efx.pet.utility.logging.PetLogger;
import com.efx.pet.utility.logging.PetLoggerFactory;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;

@Slf4j
@RequiredArgsConstructor
public class PdfGeneratorService {
    private final String fopConfigFileName;
    private static final PetLogger LOGGER = PetLoggerFactory.getLogger(PdfGeneratorService.class);

    public InputStream getPdfCreditReport(SubstrateContext substrateContext, CreditReport creditReport, String stylesheetName, boolean absolutePath) {
        InputStream cmsXslStream = getXslStylesheet(stylesheetName, absolutePath);
        InputStream pdfInputStream = null;
        PrintableCreditReport printableCreditReport = getPrintableCreditReport(substrateContext, creditReport);
        pdfInputStream = transformCreditReportToPDF(substrateContext, printableCreditReport, cmsXslStream);
        return pdfInputStream;
    }

    private InputStream transformCreditReportToPDF(final SubstrateContext context, final PrintableCreditReport printableCreditReport,
                                                   final InputStream xslContentAsStream) {
        InputStream inputStream = null;
        try {
            Transformer transformer = null;
            TransformerStyle transformerStyle = null;
            transformer = new CustomFontTransformer(fopConfigFileName);

            if (null != xslContentAsStream) {
                transformerStyle = new XslTransformerStyle(xslContentAsStream);
                inputStream = transformer.transform(context, printableCreditReport, transformerStyle);
            } else {
                LOGGER.error("Error in cmsXslStream, stream is empty");
            }
        } catch (Exception ex) {
            LOGGER.warn("Error in credit report transformer", ex);
        }

        return inputStream;
    }

    private PrintableCreditReport getPrintableCreditReport(SubstrateContext substrateContext, final CreditReport creditReport) {
        PrintableCreditReport output = null;

        if (creditReport == null) {
            return output;
        }
        output = new PrintableCreditReport(creditReport);
        if (substrateContext == null || substrateContext.getProperties().isEmpty()) {
            LOGGER.info("substrateContext or Credit Report coverletter specific configuration is empty");
        } else {
            output.getProperties().putAll(substrateContext.getProperties());
        }

        return output;
    }

    @SneakyThrows
    public InputStream getXslStylesheet(String fileName, boolean absolutePath) {
        if (absolutePath) {
            return new FileInputStream(fileName);
        }
        URL resource = getClass().getClassLoader().getResource(fileName);
        return resource.openStream();

    }
}
