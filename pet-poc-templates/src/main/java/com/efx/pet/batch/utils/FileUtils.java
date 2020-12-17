package com.efx.pet.batch.utils;

import lombok.SneakyThrows;
import org.w3c.dom.Document;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayOutputStream;
import java.io.FileWriter;
import java.io.IOException;

public class FileUtils {

    /**
     * Stores org.w3c.dom.Document to file
     * @param document instance of Document.
     * @param filename result filename.
     */
    public static void saveXlsToFile(Document document, String filename) throws IOException, TransformerException {
        DOMSource source = new DOMSource(document);
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        FileWriter writer = new FileWriter(filename);
        StreamResult result = new StreamResult(writer);
        transformer.transform(source, result);
    }

    /**
     * Converts org.w3c.dom.Document to array of bytes.
     * @param document instance of Document.
     * @return array of bytes.
     */
    @SneakyThrows
    public static byte[] toBytes(Document document) {
        DOMSource source = new DOMSource(document);
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        StreamResult result = new StreamResult(bos);
        transformer.transform(source, result);
        return bos.toByteArray();
    }
}
