package com.efx.pet.batch.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.fop.apps.io.ResourceResolverFactory;
import org.apache.xmlgraphics.io.Resource;
import org.apache.xmlgraphics.io.ResourceResolver;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;

@Slf4j
public class ClasspathResolverURIAdapter implements ResourceResolver {

    private final ResourceResolver wrapped;

    public ClasspathResolverURIAdapter() {
        this.wrapped = ResourceResolverFactory.createDefaultResourceResolver();
    }

    @Override
    public Resource getResource(URI uri) throws IOException {
        log.info("getResource called, uri is: " + uri + ", path is: " + uri.getSchemeSpecificPart());
        if (uri.getScheme().equals("classpath")) {
            InputStream is = ClasspathResolverURIAdapter.class.getResourceAsStream(uri.getSchemeSpecificPart());
            System.out.println("is: " + is);
            return new Resource(is);
        } else {
            return wrapped.getResource(uri);
        }
    }

    @Override
    public OutputStream getOutputStream(URI uri) throws IOException {
        if (uri.getScheme().equals("classpath")) {
            throw new RuntimeException("This is a read only ResourceResolver. You can not use it's outputstream");
        } else {
            return wrapped.getOutputStream(uri);
        }
    }
}
