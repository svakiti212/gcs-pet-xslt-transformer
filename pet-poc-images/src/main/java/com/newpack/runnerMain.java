package com.newpack;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.FopFactory;

import javax.xml.transform.*;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
//import org.apache.fop.apps.;

//import static org.apache.fop.apps.FopFactory.newInstance;

//import static org.apache.fop.apps.FopFactory.newInstance;


public class runnerMain {
  public static void main(String args[]) throws TransformerException, IOException {
    runXSLTTransformation("xsl-main-import.xsl", "xls-out1.xsl");
  }

  public static void runXSLTTransformation(String sourceFileName, String destFileName) throws TransformerException, IOException {
    Source xsltSrc = new StreamSource(new File(sourceFileName));
    BufferedWriter out = new BufferedWriter(new FileWriter(destFileName));
    Result xsltDest = new StreamResult(new PrintWriter(out));

    Transformer transformerXSLT = TransformerFactory.newInstance().newTransformer(xsltSrc);
    transformerXSLT.transform(xsltSrc, xsltDest);
  }

  public static void convertPDF() {
    FopFactory myFopFactory;
   // myFopFactory = newInstance((new File(".")).toURI());
    FOUserAgent foUserAgent;
    //foUserAgent = myFopFactory.newFOUserAgent();
    ByteArrayOutputStream out = new ByteArrayOutputStream();
  }
  /*
            LOGGER.checkBeforeDebug("Going to generate FO XML and convert it to PDF ");
  FopFactory myFopFactory = this.getFopFactory();
  FOUserAgent foUserAgent = myFopFactory.newFOUserAgent();
  ByteArrayOutputStream out = new ByteArrayOutputStream();
  Fop fop = myFopFactory.newFop("application/pdf", foUserAgent, out);
  Source xsltSrc = new StreamSource((InputStream)style.getValue());
  TransformerFactory factory = TransformerFactory.newInstance();
  javax.xml.transform.Transformer foTransformer = factory.newTransformer(xsltSrc);
  Source src = new StreamSource(inputStream);
  Result res = new SAXResult(fop.getDefaultHandler());
          foTransformer.transform(src, res);
          out.close();
  output = new ByteArrayTransformerStream(out.toByteArray());

  */


}
