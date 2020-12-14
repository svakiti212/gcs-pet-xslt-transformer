package com.efx.pet.batch.utils;

import com.efx.pet.channelweb.utility.BeanUtility;
import com.efx.pet.service.saas.creditreport.v1.domain.CreditReport;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StreamUtils;

import java.awt.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.Charset;

@Slf4j
public class ReportUtils {

    public static CreditReport getReportById(String documentId, boolean absolutePath) throws Exception {
        if (!absolutePath) {
            return getReportByIdFromResources(documentId);
        } else {
            String data = StreamUtils.copyToString(new FileInputStream(documentId), Charset.defaultCharset());
            return BeanUtility.xmlDeserialize(data, CreditReport.class);
        }
    }

    public static CreditReport getReportByIdFromResources(String documentId) throws Exception {
        String data = StreamUtils.copyToString(ReportUtils.class.getClassLoader().getResource("xml/" + documentId).openStream(), Charset.defaultCharset());
        return BeanUtility.xmlDeserialize(data, CreditReport.class);
    }

    public static void openGeneratedFile(String filename) {
        if (Desktop.isDesktopSupported()) {
            try {
                File myFile = new File(filename);
                Desktop.getDesktop().open(myFile);
            } catch (IOException ex) {
                log.error(ex.getMessage());
            }
        }
    }
}
