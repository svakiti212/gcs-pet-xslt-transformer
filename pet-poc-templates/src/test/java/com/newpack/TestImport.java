package com.newpack;

import javax.xml.transform.*;
import java.io.*;

import org.junit.Test;

public class TestImport {

  @Test
  public void runFirstImport() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("src/main/resources/xsl-main-import.xsl", "xls-out1.xsl");
  }

  @Test
  public void runImportWithUtils() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("src/main/resources/xsl-main-import-with-utils.xsl", "xls-out2.xsl");
  }

  @Test
  public void runFirstInclude() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("src/main/resources/xsl-main-include.xsl", "xls-out3.xsl");
  }

  //RuntimeException: ElemTemplateElement error: Found more than one template named: element-image
  @Test(expected = java.lang.RuntimeException.class)
  public void runIncludeWithUtilsFoundMoreThanOneTemplate() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("src/main/resources/xsl-main-include-with-utils.xsl", "xls-out4.xsl");
  }

  @Test
  public void runSecondImport() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("src/main/resources/xsl-main-import-for-pdf.xsl", "xls-out5.xsl");
  }


}
