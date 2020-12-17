package com.efx.pet.batch.service;

import com.efx.pet.batch.utils.FileUtils;
import com.efx.pet.batch.utils.ResourceUtils;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.BooleanUtils;
import org.apache.xml.serializer.OutputPropertiesFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.PrintWriter;

/**
 * Class responsible for work with xls files.
 */
@Slf4j
public class XslService {
    public static final String CUSTOM_IMPORT_TAG = "full-import";
    public static final String IGNORE_ATTRIBUTE = "ignore-namespaces";
    public static final String PATH_ATTRIBUTE = "href";
    public static final String INDENT_AMOUNT = "4";

    /**
     * Processes full-import tags in xls-templates.
     *
     * @param xslFilename path to input xls file in resource folder.
     * @return byte array of result xls document with completed imports.
     * If there are no full-import tags - then original file will be returned as byte array.
     */
    @SneakyThrows
    public byte[] resolveImportTags(String xslFilename) {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

        Document document = factory
                .newDocumentBuilder()
                .parse(ResourceUtils.loadFileFromResources(xslFilename));

        XPath xpath = XPathFactory.newInstance().newXPath();
        NodeList nodes = (NodeList) xpath.evaluate(CUSTOM_IMPORT_TAG, document.getDocumentElement(), XPathConstants.NODESET);

        log.info("Found {} nodes with tag: {}", nodes.getLength(), CUSTOM_IMPORT_TAG);

        for (int i = 0; i < nodes.getLength(); i++) {
            Node node = nodes.item(i);
            Element value = (Element) node;

            String xlsPath = value.getAttribute(PATH_ATTRIBUTE);
            boolean ignoreNamespace = BooleanUtils.toBoolean(value.getAttribute(IGNORE_ATTRIBUTE));
            Element fragmentNode = ResourceUtils.loadXlsFromResources(xlsPath, ignoreNamespace);
            Node newNode = document.importNode(fragmentNode, true);
            node.getParentNode().replaceChild(newNode, node);
            log.info("Node {} replaced with xls fragment located in file: {}", value.getTagName(), xlsPath);
        }

        return FileUtils.toBytes(document);
    }

    /**
     * Applies xls-stylesheet to input xml file. And stores result into file.
     *
     * @param sourceFileName path to input file with data located in resource folder.
     * @param outputFilename full path to output file.
     * @param xslInputStream InputStream with stylesheet.
     */
    @SneakyThrows
    public void produceResultFile(String sourceFileName, String outputFilename, InputStream xslInputStream) {
        Source xsltSrc = new StreamSource(xslInputStream);
        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer transformer = factory.newTransformer(xsltSrc);

        Source source = new StreamSource(ResourceUtils.loadFileFromResources(sourceFileName));

        BufferedWriter out = new BufferedWriter(new FileWriter(outputFilename));
        Result xsltDest = new StreamResult(new PrintWriter(out));
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty(OutputPropertiesFactory.S_KEY_INDENT_AMOUNT, INDENT_AMOUNT);
        transformer.transform(source, xsltDest);
    }
}
