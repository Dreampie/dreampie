package cn.dreampie.common.plugin.coffeescript.compiler;

import org.codehaus.plexus.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sonatype.plexus.build.incremental.BuildContext;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Arrays;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public class CoffeeScriptCompiler extends AbstractCoffeeScript {

    private Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * The directory for compiled CSS stylesheets.
     *
     * @parameter expression="${lesscss.outputDirectory}" default-value="${project.build.directory}"
     * @required
     */
    protected File outputDirectory;

    /**
     * When <code>true</code> the COFFEE compiler will compress the CSS stylesheets.
     *
     * @parameter expression="${lesscss.compress}" default-value="false"
     */
    private boolean compress;

    /**
     * When <code>true</code> the plugin will watch for changes in COFFEE files and compile if it detects one.
     *
     * @parameter expression="${lesscss.watch}" default-value="false"
     */
    protected boolean watch = false;

    /**
     * When <code>true</code> the plugin will watch for changes in COFFEE files and compile if it detects one.
     *
     * @parameter expression="${lesscss.watchInterval}" default-value="1000"
     */
    private int watchInterval = 1000;

    /**
     * The character encoding the COFFEE compiler will use for writing the CSS stylesheets.
     *
     * @parameter expression="${lesscss.encoding}" default-value="${project.build.sourceEncoding}"
     */
    private String encoding;

    /**
     * When <code>true</code> forces the COFFEE compiler to always compile the COFFEE sources. By default COFFEE sources are only compiled when modified (including imports) or the CSS stylesheet does not exists.
     *
     * @parameter expression="${lesscss.force}" default-value="false"
     */
    private boolean force;

    /**
     * The location of the COFFEE JavasSript file.
     *
     * @parameter
     */
    private File coffeeJs;

    /**
     * The location of the NodeJS executable.
     *
     * @parameter
     */
    private String nodeExecutable;

    /**
     * The format of the output file names.
     *
     * @parameter
     */
    private String outputFileFormat;

    private static final String FILE_NAME_FORMAT_PARAMETER_REGEX = "\\{fileName\\}";

    /**
     * Execute the MOJO.
     *
     * @throws cn.dreampie.common.plugin.coffeescript.compiler.CoffeeException if something unexpected occurs.
     */
    public void execute() throws CoffeeException {
        if (logger.isDebugEnabled()) {
            logger.debug("sourceDirectory = " + sourceDirectory);
            logger.debug("outputDirectory = " + outputDirectory);
            logger.debug("includes = " + Arrays.toString(includes));
            logger.debug("excludes = " + Arrays.toString(excludes));
            logger.debug("force = " + force);
            logger.debug("coffeeJs = " + coffeeJs);
            logger.debug("skip = " + skip);
        }

        if (!skip) {
            executeInternal();
        } else {
            logger.info("Skipping plugin execution per configuration");
        }
    }

    private void executeInternal() throws CoffeeException {
        long start = System.currentTimeMillis();

        String[] files = getIncludedFiles();

        if (files == null || files.length < 1) {
            logger.info("Nothing to compile - no COFFEE sources found");
        } else {
            if (logger.isDebugEnabled()) {
                logger.debug("included files = " + Arrays.toString(files));
            }

            Object coffeeCompiler = initCoffeeCompiler();
            if (watch) {
                logger.info("Watching " + sourceDirectory);
                if (force) {
                    force = false;
                    logger.info("Disabled the 'force' flag in watch mode.");
                }
                Thread.currentThread().setPriority(Thread.MIN_PRIORITY);
                while (watch && !Thread.currentThread().isInterrupted()) {
                    compileIfChanged(files, coffeeCompiler);
                    try {
                        Thread.sleep(watchInterval);
                    } catch (InterruptedException e) {
                        System.out.println("interrupted");
                    }
                }
            } else {
                compileIfChanged(files, coffeeCompiler);
            }

            logger.info("Complete Less compile job finished in " + (System.currentTimeMillis() - start) + " ms");
        }
    }

    private void compileIfChanged(String[] files, Object coffeeCompiler) throws CoffeeException {

        for (String file : files) {
            File input = new File(sourceDirectory, file);

            buildContext.removeMessages(input);

            if (outputFileFormat != null) {
                file = outputFileFormat.replaceAll(FILE_NAME_FORMAT_PARAMETER_REGEX, file.replace(".less", ""));
            }

            File output = new File(outputDirectory, file.replace(".less", ".css"));

            if (!output.getParentFile().exists() && !output.getParentFile().mkdirs()) {
                throw new CoffeeException("Cannot create output directory " + output.getParentFile());
            }

            try {
                CoffeeSource coffeeSource = new CoffeeSource(input);
                if (force || !output.exists() || output.lastModified() < coffeeSource.getLastModifiedIncludingImports()) {
                    long compilationStarted = System.currentTimeMillis();
                    logger.info("Compiling COFFEE source: " + file + "...");
                    if (coffeeCompiler instanceof CoffeeCompiler) {
                        ((CoffeeCompiler) coffeeCompiler).compile(coffeeSource, output, force);
                    }
                    buildContext.refresh(output);
                    logger.info("Finished compilation to " + outputDirectory + " in " + (System.currentTimeMillis() - compilationStarted) + " ms");
                } else if (!watch) {
                    logger.info("Bypassing COFFEE source: " + file + " (not modified)");
                }
            } catch (IOException e) {
                buildContext.addMessage(input, 0, 0, "Error compiling COFFEE source", BuildContext.SEVERITY_ERROR, e);
                throw new CoffeeException("Error while compiling COFFEE source: " + file, e);
            } catch (CoffeeException e) {
                String message = e.getMessage();
                if (StringUtils.isEmpty(message)) {
                    message = "Error compiling COFFEE source";
                }
                buildContext.addMessage(input, 0, 0, "Error compiling COFFEE source", BuildContext.SEVERITY_ERROR, e);
                throw new CoffeeException("Error while compiling COFFEE source: " + file, e);
            }
        }

    }

    private Object initCoffeeCompiler() throws CoffeeException {

        CoffeeCompiler coffeeCompiler = new CoffeeCompiler();
        coffeeCompiler.setEncoding(encoding);
        if (coffeeJs != null) {
            try {
                coffeeCompiler.setCoffeeJs(coffeeJs.toURI().toURL());
            } catch (MalformedURLException e) {
                throw new CoffeeException("Error while loading COFFEE JavaScript: " + coffeeJs.getAbsolutePath(), e);
            }
        }
        return coffeeCompiler;

    }
}