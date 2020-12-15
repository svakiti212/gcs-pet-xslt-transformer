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
  public void runInclude() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("src/main/resources/xsl-main-include.xsl", "xls-out2.xsl");
  }


}
