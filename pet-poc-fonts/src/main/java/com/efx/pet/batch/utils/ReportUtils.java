package com.efx.pet.batch.utils;

import com.efx.pet.channelweb.utility.BeanUtility;
import com.efx.pet.service.saas.creditreport.v1.domain.CreditReport;
import org.springframework.util.StreamUtils;

import java.nio.charset.Charset;

public class ReportUtils {

    public static CreditReport getReportById(String documentId) throws Exception {
        String data = StreamUtils.copyToString(ReportUtils.class.getClassLoader().getResource("xml/" + documentId).openStream(), Charset.defaultCharset());
        return BeanUtility.xmlDeserialize(data, CreditReport.class);
    }
}
