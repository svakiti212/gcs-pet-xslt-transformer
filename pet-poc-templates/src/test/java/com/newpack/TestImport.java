package com.newpack;

import javax.xml.transform.*;
import java.io.*;

import org.junit.Test;

public class TestImport {

  @Test
  public void runFirstImport() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("xsl-main-import.xsl", "xls-out-import.xsl");
  }

  @Test
  public void runInclude() throws TransformerException, IOException {
    ImportIncludeMain.runXSLTTransformation("xsl-main-include.xsl", "xls-out-include.xsl");
  }


}
