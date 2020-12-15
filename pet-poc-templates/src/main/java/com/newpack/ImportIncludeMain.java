package com.newpack;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;


public class ImportIncludeMain {
  public static void main(String args[]) {
  }

  public static void runXSLTTransformation(String sourceFileName, String destFileName) throws TransformerException, IOException {
    InputStream inputStreamStyle = ImportIncludeMain.class.getClassLoader().getResourceAsStream(sourceFileName);
    Source xsltSrc = new StreamSource(inputStreamStyle);
    BufferedWriter out = new BufferedWriter(new FileWriter(destFileName));
    Result xsltDest = new StreamResult(new PrintWriter(out));
    Transformer transformerXSLT = TransformerFactory.newInstance().newTransformer(xsltSrc);

    InputStream inputStream = ImportIncludeMain.class.getClassLoader().getResourceAsStream(sourceFileName);
    Source source = new StreamSource(inputStream);
    transformerXSLT.transform(source, xsltDest);
  }

}
