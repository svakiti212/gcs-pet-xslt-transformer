package com.efx.pet.batch.utils;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StreamUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.io.StringReader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
public class ResourceUtils {
    private final static String NAMESPACE_ATTRIBUTE_PREFIX = "xmlns";

    /**
     * Loads xml fragment from resource folder.
     *
     * @param xlsPath         path to xls file in resource folder.
     * @param ignoreNamespace if true - removes all attributes from root node of fragment that starts from <b>xmlns:<b/>
     * @return parsed xml fragment to org.w3c.dom.Element.
     */
    @SneakyThrows
    public static Element loadXlsFromResources(String xlsPath, boolean ignoreNamespace) {
        URL url = ResourceUtils.class.getClassLoader().getResource(xlsPath);
        if (Objects.isNull(url)) {
            throw new IllegalArgumentException(String.format("%s xls file does not exist in resources", xlsPath));
        }
        String data = StreamUtils.copyToString(url.openStream(), Charset.defaultCharset());

        Document document = DocumentBuilderFactory.newInstance()
                .newDocumentBuilder()
                .parse(new InputSource(new StringReader(data)));

        Element documentElement = document.getDocumentElement();
        if (ignoreNamespace) {
            removeNamespaceAttributes(documentElement);
        }
        return documentElement;
    }

    private static void removeNamespaceAttributes(Element documentElement) {
        NamedNodeMap attributes = documentElement.getAttributes();
        List<String> forRemoval = new ArrayList<>();
        for (int i = 0; i < attributes.getLength(); i++) {
            String attributeName = attributes.item(i).getNodeName();
            if (attributeName.contains(NAMESPACE_ATTRIBUTE_PREFIX)) {
                forRemoval.add(attributeName);
            }
        }

        forRemoval.forEach(attribute -> {
            documentElement.removeAttribute(attribute);
            log.info("Removed {} attribute from fragment", attribute);
        });
    }

    /**
     * Loads any file from resources.
     *
     * @param filePath path to file in resource folder.
     * @return instance of File class.
     */
    @SneakyThrows
    public static File loadFileFromResources(String filePath) {
        URL url = ResourceUtils.class.getClassLoader().getResource(filePath);
        if (Objects.isNull(url)) {
            throw new IllegalArgumentException(String.format("%s file does not exist in resources", filePath));
        }

        return new File(url.toURI());
    }
}
