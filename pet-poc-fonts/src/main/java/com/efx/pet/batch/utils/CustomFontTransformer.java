//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.efx.pet.batch.utils;

import com.efx.pet.channelweb.domain.SubstrateContextable;
import com.efx.pet.transformer.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.fop.apps.MimeConstants;
import org.apache.fop.configuration.Configuration;
import org.apache.fop.configuration.DefaultConfigurationBuilder;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URI;

@Slf4j
@RequiredArgsConstructor
public class CustomFontTransformer extends TransformerBase {
    private final String configFileName;

    @Override
    public TransformerStream onTransform(SubstrateContextable context, Object inputObject, TransformerStyle style) throws TransformerException {
        validateStylesheet(style);

        TransformerStream output = null;
        try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            FopFactory fopFactory = getFopFactoryConfiguredFromClasspath();
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, fopFactory.newFOUserAgent(), out);
            fopFactory.getFontManager().disableFontCache();

            TransformerFactory factory = TransformerFactory.newInstance();
            Source xslSource = new StreamSource((InputStream) style.getValue());
            Transformer transformer = factory.newTransformer(xslSource);
            Source source = new StreamSource(new ObjectXmlTransformerStream(inputObject));
            Result result = new SAXResult(fop.getDefaultHandler());

            transformer.transform(source, result);
            output = new ByteArrayTransformerStream(out.toByteArray());

            return output;

        } catch (Exception exception) {
            throw new TransformerException(exception);
        }
    }

    private void validateStylesheet(TransformerStyle style) {
        if (!(style.getValue() instanceof InputStream)) {
            throw new TransformerException("Transformer Style value must be InputStream");
        }
    }

    private FopFactory getFopFactoryConfiguredFromClasspath() throws Exception {
        URI baseUri = URI.create(".");
        FopFactoryBuilder builder = new FopFactoryBuilder(baseUri, new ClasspathResolverURIAdapter());
        DefaultConfigurationBuilder cfgBuilder = new DefaultConfigurationBuilder();
        Configuration cfg = cfgBuilder.build(CustomFontTransformer.class.getResourceAsStream("/" + this.configFileName));

        builder.setConfiguration(cfg);

        return builder.build();
    }

}
