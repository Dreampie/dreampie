package cn.dreampie.common.plugin.coffeescript.compiler;

import org.apache.commons.io.FileUtils;
import org.mozilla.javascript.*;
import org.mozilla.javascript.tools.shell.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public class CoffeeCompiler {
    private static final Logger logger = LoggerFactory.getLogger(CoffeeCompiler.class);

    private URL coffeeJs = CoffeeCompiler.class.getClassLoader().getResource("coffee-script-1.7.1.min.js");
    private List<URL> customJs = Collections.emptyList();
    private List<String> options = Collections.emptyList();
    private Boolean compress = null;
    private String encoding = null;

    private Scriptable scope;
    private ByteArrayOutputStream out;
    private Function compiler;

    /**
     * Constructs a new <code>CoffeeCompiler</code>.
     */
    public CoffeeCompiler() {
    }

    /**
     * Constructs a new <code>CoffeeCompiler</code>.
     */
    public CoffeeCompiler(List<String> options) {
        this.options = new ArrayList<String>(options);
    }

    public List<String> getOptions() {
        return Collections.unmodifiableList(options);
    }

    public void setOptions(List<String> options) {
        if (scope != null) {
            throw new IllegalStateException("This method can only be called before init()");
        }

        this.options = new ArrayList<String>(options);
    }

    /**
     * Returns the Envjs JavaScript file used by the compiler.
     *
     * @return The Envjs JavaScript file used by the compiler.
     */
    public URL getEnvJs() {
        throw new IllegalArgumentException("EnvJs is no longer supported.  You don't need this if you use a coffee-rhino-<version>.js build like the default.");
    }

    /**
     * Sets the Envjs JavaScript file used by the compiler.
     * Must be set before {@link #init()} is called.
     *
     * @param envJs The Envjs JavaScript file used by the compiler.
     */
    public synchronized void setEnvJs(URL envJs) {
        throw new IllegalArgumentException("EnvJs is no longer supported.  You don't need this if you use a coffee-script-<version>.js build like the default.");
    }

    /**
     * Returns the COFFEE JavaScript file used by the compiler.
     * COMPILE_STRING
     *
     * @return The COFFEE JavaScript file used by the compiler.
     */
    public URL getCoffeeJs() {
        return coffeeJs;
    }

    /**
     * Sets the COFFEE JavaScript file used by the compiler.
     * Must be set before {@link #init()} is called.
     *
     * @param coffeeJs COFFEE JavaScript file used by the compiler.
     */
    public synchronized void setCoffeeJs(URL coffeeJs) {
        if (scope != null) {
            throw new IllegalStateException("This method can only be called before init()");
        }
        this.coffeeJs = coffeeJs;
    }

    /**
     * Returns the custom JavaScript files used by the compiler.
     *
     * @return The custom JavaScript files used by the compiler.
     */
    public List<URL> getCustomJs() {
        return Collections.unmodifiableList(customJs);
    }

    /**
     * Sets a single custom JavaScript file used by the compiler.
     * Must be set before {@link #init()} is called.
     *
     * @param customJs A single custom JavaScript file used by the compiler.
     */
    public synchronized void setCustomJs(URL customJs) {
        if (scope != null) {
            throw new IllegalStateException("This method can only be called before init()");
        }
        this.customJs = Collections.singletonList(customJs);
    }

    /**
     * Sets the custom JavaScript files used by the compiler.
     * Must be set before {@link #init()} is called.
     *
     * @param customJs The custom JavaScript files used by the compiler.
     */
    public synchronized void setCustomJs(List<URL> customJs) {
        if (scope != null) {
            throw new IllegalStateException("This method can only be called before init()");
        }
        // copy the list so there's no way for anyone else who holds a reference to the list to modify it
        this.customJs = new ArrayList<URL>(customJs);
    }

    /**
     * Returns whether the compiler will compress the CSS.
     *
     * @return Whether the compiler will compress the CSS.
     */
    public boolean isCompress() {
        return (compress != null && compress.booleanValue()) ||
                options.contains("compress") ||
                options.contains("x");
    }

    /**
     * Sets the compiler to compress the CSS.
     * Must be set before {@link #init()} is called.
     *
     * @param compress If <code>true</code>, sets the compiler to compress the CSS.
     */
    public synchronized void setCompress(boolean compress) {
        if (scope != null) {
            throw new IllegalStateException("This method can only be called before init()");
        }
        this.compress = compress;
    }

    /**
     * Returns the character encoding used by the compiler when writing the output <code>File</code>.
     *
     * @return The character encoding used by the compiler when writing the output <code>File</code>.
     */
    public String getEncoding() {
        return encoding;
    }

    /**
     * Sets the character encoding used by the compiler when writing the output <code>File</code>.
     * If not set the platform default will be used.
     * Must be set before {@link #init()} is called.
     *
     * @param encoding character encoding used by the compiler when writing the output <code>File</code>.
     */
    public synchronized void setEncoding(String encoding) {
        if (scope != null) {
            throw new IllegalStateException("This method can only be called before init()");
        }
        this.encoding = encoding;
    }

    /**
     * Initializes this <code>CoffeeCompiler</code>.
     * <p>
     * It is not needed to call this method manually, as it is called implicitly by the compile methods if needed.
     * </p>
     */
    public synchronized void init() {
        long start = System.currentTimeMillis();

        try {
            Context cx = Context.enter();
            //cx.setOptimizationLevel(-1);
            cx.setLanguageVersion(Context.VERSION_1_7);

            Global global = new Global();
            global.init(cx);
            scope = cx.initStandardObjects(global);
            scope.put("logger", scope, Context.toObject(logger, scope));

            out = new ByteArrayOutputStream();
            global.setOut(new PrintStream(out));

            // Combine all of the streams (coffee, custom, coffeec) into one big stream
            List<InputStream> streams = new ArrayList<InputStream>();

            // coffee should be first
            streams.add(coffeeJs.openConnection().getInputStream());

            // then the custom js so it has a chance to add any hooks
            for (URL url : customJs) {
                streams.add(url.openConnection().getInputStream());
            }

            InputStreamReader reader = new InputStreamReader(new SequenceInputStream(Collections.enumeration(streams)));

            // Load the streams into a function we can run 
            compiler = (Function) cx.compileReader(reader, coffeeJs.toString(), 1, null);

        } catch (Exception e) {
            String message = "Failed to initialize COFFEE compiler.";
            logger.error(message, e);
            throw new IllegalStateException(message, e);
        } finally {
            Context.exit();
        }

        if (logger.isDebugEnabled()) {
            logger.debug("Finished initialization of COFFEE compiler in %,d ms.%n", System.currentTimeMillis() - start);
        }
    }

    /**
     * Compiles the COFFEE input <code>String</code> to CSS.
     *
     * @param input The COFFEE input <code>String</code> to compile.
     * @return The CSS.
     */
    public String compile(String input) throws CoffeeScriptException {
        return compile(input, "<inline>");
    }

    /**
     * Compiles the COFFEE input <code>String</code> to CSS, but specifies the source name <code>String</code>.
     *
     * @param input The COFFEE input <code>String</code> to compile
     * @param name  The source's name <code>String</code> to provide better error messages.
     * @return the CSS.
     * @throws CoffeeScriptException any error encountered by the compiler
     */
    public String compile(String input, String name) throws CoffeeScriptException {
        File tempFile = null;
        try {
            tempFile = File.createTempFile("tmp", "coffee.tmp");
            FileUtils.writeStringToFile(tempFile, input, this.encoding);

            return compile(tempFile, name);
        } catch (IOException e) {
            throw new CoffeeScriptException(e);

        } finally {
            tempFile.delete();
        }
    }

    /**
     * Compiles the COFFEE input <code>String</code> to CSS, but specifies the source name <code>String</code>. The entire
     * method is synchronized so that two threads don't read the output at the same time.
     *
     * @param input The COFFEE input <code>String</code> to compile
     * @param name  The source's name <code>String</code> to provide better error messages.
     * @return the CSS.
     * @throws CoffeeScriptException any error encountered by the compiler
     */
    public synchronized String compile(File input, String name) throws CoffeeScriptException {
        if (scope == null) {
            init();
        }

        long start = System.currentTimeMillis();

        try {

            Context cx = Context.enter();

            // The scope for compiling <input>
            ScriptableObject compileScope = (ScriptableObject) cx.newObject(scope);

            // give it a reference to the parent scope
            compileScope.setPrototype(scope);
            compileScope.setParentScope(null);

            // Copy the default options
            List<String> options = new ArrayList<String>(this.options);
            // Set up the arguments for <input>
            options.add(input.getAbsolutePath());

            // Add compress if the value is set for backward compatibility
            if (this.compress != null && this.compress.booleanValue()) {
                options.add("-x");
            }

            Scriptable argsObj = cx.newArray(compileScope, options.toArray(new Object[options.size()]));
            //Scriptable argsObj = cx.newArray(compileScope, new Object[] {"-ru", "c.coffee"});
            compileScope.defineProperty("arguments", argsObj, ScriptableObject.DONTENUM);

            // invoke the compiler - we don't pass arguments here because its a script not a real function
            // and we don't care about the result because its written to the output stream (out)
            compiler.call(cx, compileScope, null, new Object[]{});

            if (logger.isDebugEnabled()) {
                logger.debug("Finished compilation of COFFEE source in %,d ms.", System.currentTimeMillis() - start);
            }

            return this.encoding != null && !this.encoding.equals("") ? out.toString(encoding) : out.toString();
        } catch (Exception e) {
            if (e instanceof JavaScriptException) {
                Scriptable value = (Scriptable) ((JavaScriptException) e).getValue();
                if (value != null) {
                    StringBuilder message = new StringBuilder();
                    if (ScriptableObject.hasProperty(value, "filename")) {
                        message.append(ScriptableObject.getProperty(value, "filename").toString());
                    }

                    if (ScriptableObject.hasProperty(value, "line")) {
                        message.append("@(");
                        message.append(ScriptableObject.getProperty(value, "line").toString());
                        message.append(",");
                        message.append(ScriptableObject.getProperty(value, "column").toString());
                        message.append(")");
                    }

                    if (ScriptableObject.hasProperty(value, "message")) {
                        if (message.length() > 0) message.append(": ");
                        message.append(ScriptableObject.getProperty(value, "message").toString());
                    }

                    if (ScriptableObject.hasProperty(value, "extract")) {
                        List<String> lines = (List<String>) ScriptableObject.getProperty(value, "extract");
                        for (String line : lines) {
                            if (line != null) {
                                message.append("\n");
                                message.append(line);
                            }
                        }
                    }

                    throw new CoffeeScriptException(message.toString(), e);
                }
            }
            throw new CoffeeScriptException(e);
        } finally {
            // reset our ouput stream so we don't copy data on the next invocation
            out.reset();

            // we're done with this invocation
            Context.exit();
        }
    }

    /**
     * Compiles the COFFEE input <code>File</code> to CSS.
     *
     * @param input The COFFEE input <code>File</code> to compile.
     * @return The CSS.
     * @throws IOException If the COFFEE file cannot be read.
     */
    public String compile(File input) throws IOException, CoffeeScriptException {
        return compile(input, input.getName());
    }

    /**
     * Compiles the COFFEE input <code>File</code> to CSS and writes it to the specified output <code>File</code>.
     *
     * @param input  The COFFEE input <code>File</code> to compile.
     * @param output The output <code>File</code> to write the CSS to.
     * @throws IOException If the COFFEE file cannot be read or the output file cannot be written.
     */
    public void compile(File input, File output) throws IOException, CoffeeScriptException {
        this.compile(input, output, true);
    }

    /**
     * Compiles the COFFEE input <code>File</code> to CSS and writes it to the specified output <code>File</code>.
     *
     * @param input  The COFFEE input <code>File</code> to compile.
     * @param output The output <code>File</code> to write the CSS to.
     * @param force  'false' to only compile the COFFEE input file in case the COFFEE source has been modified (including imports) or the output file does not exists.
     * @throws IOException If the COFFEE file cannot be read or the output file cannot be written.
     */
    public void compile(File input, File output, boolean force) throws IOException, CoffeeScriptException {
        if (force || !output.exists() || output.lastModified() < input.lastModified()) {
            String data = compile(input);
            FileUtils.writeStringToFile(output, data, encoding);
        }
    }

    public String compile(CoffeeSource input) throws CoffeeScriptException {
        return compile(input.getNormalizedContent(), input.getName());
    }

    /**
     * Compiles the input <code>CoffeeSource</code> to CSS and writes it to the specified output <code>File</code>.
     *
     * @param input  The input <code>CoffeeSource</code> to compile.
     * @param output The output <code>File</code> to write the CSS to.
     * @throws IOException If the COFFEE file cannot be read or the output file cannot be written.
     */
    public void compile(CoffeeSource input, File output) throws IOException, CoffeeScriptException {
        compile(input, output, true);
    }

    /**
     * Compiles the input <code>CoffeeSource</code> to CSS and writes it to the specified output <code>File</code>.
     *
     * @param input  The input <code>CoffeeSource</code> to compile.
     * @param output The output <code>File</code> to write the CSS to.
     * @param force  'false' to only compile the input <code>CoffeeSource</code> in case the COFFEE source has been modified (including imports) or the output file does not exists.
     * @throws IOException If the COFFEE file cannot be read or the output file cannot be written.
     */
    public void compile(CoffeeSource input, File output, boolean force) throws IOException, CoffeeScriptException {
        if (force || !output.exists() || output.lastModified() < input.getLastModifiedIncludingImports()) {
            String data = compile(input);
            FileUtils.writeStringToFile(output, data, encoding);
        }
    }
}
