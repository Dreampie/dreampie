package cn.dreampie.common.plugin.coffeescript.compiler;

import cn.dreampie.common.web.resource.FileResource;
import cn.dreampie.common.web.resource.HttpResource;
import cn.dreampie.common.web.resource.Resource;
import org.apache.commons.io.IOUtils;
import org.lesscss.deps.org.apache.commons.io.input.BOMInputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.util.regex.Pattern.MULTILINE;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public class CoffeeSource {

    private static Logger logger = LoggerFactory.getLogger(CoffeeSource.class);

    /**
     * The <code>Pattern</code> used to match imported files.
     */
    private static final Pattern IMPORT_PATTERN = Pattern.compile("^(?!\\s*//\\s*).*(@import\\s+(url\\(|\\((less|css)\\))?\\s*(\"|')(.+)\\s*(\"|')(\\))?(.*);).*$", MULTILINE);

    private Resource resource;
    private String content;
    private String normalizedContent;
    private Map<String, CoffeeSource> imports = new LinkedHashMap<String, CoffeeSource>();

    /**
     * Constructs a new <code>CoffeeSource</code>.
     * <p>
     * This will read the metadata and content of the LESS source, and will automatically resolve the imports.
     * </p>
     * <p>
     * The resource is read using the default Charset of the platform
     * </p>
     *
     * @param resource The <code>File</code> reference to the LESS source to read.
     * @throws java.io.FileNotFoundException If the LESS source (or one of its imports) could not be found.
     * @throws java.io.IOException           If the LESS source cannot be read.
     */
    public CoffeeSource(Resource resource) throws IOException {
        this(resource, Charset.defaultCharset());
    }

    /**
     * Constructs a new <code>CoffeeSource</code>.
     * <p>
     * This will read the metadata and content of the LESS resource, and will automatically resolve the imports.
     * </p>
     *
     * @param resource The <code>File</code> reference to the LESS resource to read.
     * @param charset  charset used to read the less resource.
     * @throws java.io.FileNotFoundException If the LESS resource (or one of its imports) could not be found.
     * @throws IOException                   If the LESS resource cannot be read.
     */
    public CoffeeSource(Resource resource, Charset charset) throws IOException {
        if (resource == null) {
            throw new IllegalArgumentException("Resource must not be null.");
        }
        if (!resource.exists()) {
            throw new IOException("Resource " + resource + " not found.");
        }
        this.resource = resource;
        this.content = this.normalizedContent = loadResource(resource, charset);
        resolveImports();
    }

    /**
     * Simple helper method to handle simple files.  This delegates
     * to @see #CoffeeSource(Resource) .
     *
     * @param input a File to use as input.
     * @throws IOException
     */
    public CoffeeSource(File input) throws IOException {
        this(new FileResource(input));
    }

    private String loadResource(Resource resource, Charset charset) throws IOException {
        BOMInputStream inputStream = new BOMInputStream(resource.getInputStream());
        try {
            if (inputStream.hasBOM()) {
                logger.debug("BOM found %s", inputStream.getBOMCharsetName());
                return IOUtils.toString(inputStream, inputStream.getBOMCharsetName());
            } else {
                logger.debug("Using charset " + charset.name());
                return IOUtils.toString(inputStream, charset.name());
            }
        } finally {
            inputStream.close();
        }
    }

    /**
     * Returns the absolute pathname of the LESS source.
     *
     * @return The absolute pathname of the LESS source.
     */
    public String getAbsolutePath() {
        return resource.toString();
    }

    /**
     * Returns the content of the LESS source.
     *
     * @return The content of the LESS source.
     */
    public String getContent() {
        return content;
    }

    /**
     * Returns the normalized content of the LESS source.
     * <p>
     * The normalized content represents the LESS source as a flattened source
     * where import statements have been resolved and replaced by the actual
     * content.
     * </p>
     *
     * @return The normalized content of the LESS source.
     */
    public String getNormalizedContent() {
        return normalizedContent;
    }

    /**
     * Returns the time that the LESS source was last modified.
     *
     * @return A <code>long</code> value representing the time the resource was last modified, measured in milliseconds since the epoch (00:00:00 GMT, January 1, 1970).
     */
    public long getLastModified() {
        return resource.lastModified();
    }

    /**
     * Returns the time that the LESS source, or one of its imports, was last modified.
     *
     * @return A <code>long</code> value representing the time the resource was last modified, measured in milliseconds since the epoch (00:00:00 GMT, January 1, 1970).
     */
    public long getLastModifiedIncludingImports() {
        long lastModified = getLastModified();
        for (Map.Entry<String, CoffeeSource> entry : imports.entrySet()) {
            CoffeeSource importedCoffeeSource = entry.getValue();
            long importedCoffeeSourceLastModified = importedCoffeeSource.getLastModifiedIncludingImports();
            if (importedCoffeeSourceLastModified > lastModified) {
                lastModified = importedCoffeeSourceLastModified;
            }
        }
        return lastModified;
    }

    /**
     * Returns the LESS sources imported by this LESS source.
     * <p>
     * The returned imports are represented by a
     * <code>Map&lt;String, CoffeeSource&gt;</code> which contains the filename and the
     * <code>CoffeeSource</code>.
     * </p>
     *
     * @return The LESS sources imported by this LESS source.
     */
    public Map<String, CoffeeSource> getImports() {
        return imports;
    }

    private void resolveImports() throws IOException {
        Matcher importMatcher = IMPORT_PATTERN.matcher(normalizedContent);
        while (importMatcher.find()) {
            String importedResource = importMatcher.group(5);
            importedResource = importedResource.matches(".*\\.(le?|c)ss$") ? importedResource : importedResource + ".less";
            String importType = importMatcher.group(3) == null ? importedResource.substring(importedResource.lastIndexOf(".") + 1) : importMatcher.group(3);
            if (importType.equals("less")) {
                logger.debug("Importing %s", importedResource);

                if (!imports.containsKey(importedResource)) {
                    CoffeeSource importedCoffeeSource = new CoffeeSource(getImportedResource(importedResource));
                    imports.put(importedResource, importedCoffeeSource);

                    normalizedContent = includeImportedContent(importedCoffeeSource, importMatcher);
                    importMatcher = IMPORT_PATTERN.matcher(normalizedContent);
                } else {
                    normalizedContent = normalizedContent.substring(0, importMatcher.start(1)) + normalizedContent.substring(importMatcher.end(1));
                    importMatcher = IMPORT_PATTERN.matcher(normalizedContent);
                }
            }
        }
    }

    private Resource getImportedResource(String importedResource) throws IOException {
        try {
            if (importedResource.startsWith("http:") || importedResource.startsWith("https:")) {
                return new HttpResource(importedResource);
            } else {
                return resource.createRelative(importedResource);
            }
        } catch (URISyntaxException e) {
            throw (IOException) new IOException(importedResource).initCause(e);
        }
    }

    private String includeImportedContent(CoffeeSource importedCoffeeSource, Matcher importMatcher) {
        StringBuilder builder = new StringBuilder();
        builder.append(normalizedContent.substring(0, importMatcher.start(1)));

        String mediaQuery = importMatcher.group(8);
        if (mediaQuery != null && mediaQuery.length() > 0) {
            builder.append("@media");
            builder.append(mediaQuery);
            builder.append("{\n");
        }
        builder.append(importedCoffeeSource.getNormalizedContent());
        if (mediaQuery != null && mediaQuery.length() > 0) {
            builder.append("}\n");
        }
        builder.append(normalizedContent.substring(importMatcher.end(1)));
        return builder.toString();
    }

    public String getName() {
        return resource.getName();
    }
}
