/*
 * Copyright 2010 David Yeung
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package cn.dreampie.common.plugin.coffeescript.compiler;

import org.apache.commons.io.FileUtils;
import org.mozilla.javascript.Context;
import org.mozilla.javascript.JavaScriptException;
import org.mozilla.javascript.Scriptable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.URL;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class CoffeeCompiler {
    private static Logger logger = LoggerFactory.getLogger(CoffeeCompiler.class);

    private URL coffeeJs = CoffeeCompiler.class.getClassLoader().getResource("META-INF/coffee-script.min.js");
    private List<Option> optionArgs = Collections.emptyList();
    private String encoding = null;

    private Scriptable globalScope;
    private Options options;

    private static final int BUFFER_SIZE = 262144;
    private static final int BUFFER_OFFSET = 0;

    public CoffeeCompiler() {
        this(Collections.<Option>emptyList());
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
     * Must be set before {@link #compile(java.io.File)}  } is called.
     *
     * @param coffeeJs COFFEE JavaScript file used by the compiler.
     */
    public synchronized void setCoffeeJs(URL coffeeJs) {
        this.coffeeJs = coffeeJs;
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
     * Must be set before {@link #compile(java.io.File)} ()} is called.
     *
     * @param encoding character encoding used by the compiler when writing the output <code>File</code>.
     */
    public synchronized void setEncoding(String encoding) {
        this.encoding = encoding;
    }

    public CoffeeCompiler(List<Option> options) {
        this.optionArgs = options;
    }

    private void init() throws IOException {
        InputStream inputStream = coffeeJs.openConnection().getInputStream();
        try {
            try {
                Reader reader = new InputStreamReader(inputStream, "UTF-8");
                try {
                    Context context = Context.enter();
                    context.setOptimizationLevel(-1); // Without this, Rhino hits a 64K bytecode limit and fails
                    try {
                        globalScope = context.initStandardObjects();
                        context.evaluateReader(globalScope, reader, "coffee-script.js", 0, null);
                    } finally {
                        Context.exit();
                    }
                } finally {
                    reader.close();
                }
            } catch (UnsupportedEncodingException e) {
                throw new Error(e); // This should never happen
            } finally {
                inputStream.close();
            }
        } catch (IOException e) {
            throw new Error(e); // This should never happen
        }

    }

    public String compile(String coffeeScriptSource) throws CoffeeException, IOException {
        return compile(coffeeScriptSource, "<inline>");
    }

    public String compile(String coffeeScriptSource, String name) throws CoffeeException, IOException {
        if (globalScope == null) {
            init();
        }

        options = new Options(optionArgs);

        Context context = Context.enter();
        try {
            Scriptable compileScope = context.newObject(globalScope);
            compileScope.setParentScope(globalScope);
            compileScope.put("coffeeScriptSource", compileScope, coffeeScriptSource);
            try {
                return (String) context.evaluateString(compileScope, String.format("CoffeeScript.compile(coffeeScriptSource, %s);", options.toJavaScript()),
                        name, 0, null);
            } catch (JavaScriptException e) {
                throw new CoffeeException(e);
            }
        } finally {
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
    public String compile(File input) throws IOException, CoffeeException {
        return compile(input, input.getName());
    }

    /**
     * Compiles the COFFEE input <code>File</code> to CSS and writes it to the specified output <code>File</code>.
     *
     * @param input  The COFFEE input <code>File</code> to compile.
     * @param output The output <code>File</code> to write the CSS to.
     * @throws IOException If the COFFEE file cannot be read or the output file cannot be written.
     */
    public void compile(File input, File output) throws IOException, CoffeeException {
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
    public void compile(File input, File output, boolean force) throws IOException, CoffeeException {
        if (force || !output.exists() || output.lastModified() < input.lastModified()) {
            String data = compile(input);
            FileUtils.writeStringToFile(output, data, encoding);
        }
    }

    public String compile(CoffeeSource input) throws CoffeeException, IOException {
        return compile(input.getNormalizedContent(), input.getName());
    }

    /**
     * Compiles the input <code>CoffeeSource</code> to CSS and writes it to the specified output <code>File</code>.
     *
     * @param input  The input <code>CoffeeSource</code> to compile.
     * @param output The output <code>File</code> to write the CSS to.
     * @throws IOException If the COFFEE file cannot be read or the output file cannot be written.
     */
    public void compile(CoffeeSource input, File output) throws IOException, CoffeeException {
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
    public void compile(CoffeeSource input, File output, boolean force) throws IOException, CoffeeException {
        if (force || (!output.exists() && output.createNewFile()) || output.lastModified() < input.getLastModifiedIncludingImports()) {
            String data = compile(input);
            FileUtils.writeStringToFile(output, data, encoding);
        }
    }

    public String compile(File input, String name) throws IOException, CoffeeException {
        String data = new CoffeeCompiler(optionArgs).compile(readSourceFrom(new FileInputStream(input)), name);
        return data;
    }


    public void compile(File input, File output, String name) throws IOException, CoffeeException {

        String data = new CoffeeCompiler(optionArgs).compile(readSourceFrom(new FileInputStream(input)), name);

        FileUtils.writeStringToFile(output, data, encoding);

    }

    private String readSourceFrom(InputStream inputStream) {
        final InputStreamReader streamReader = new InputStreamReader(inputStream);
        try {
            try {
                StringBuilder builder = new StringBuilder(BUFFER_SIZE);
                char[] buffer = new char[BUFFER_SIZE];
                int numCharsRead = streamReader.read(buffer, BUFFER_OFFSET, BUFFER_SIZE);
                while (numCharsRead >= 0) {
                    builder.append(buffer, BUFFER_OFFSET, numCharsRead);
                    numCharsRead = streamReader.read(buffer, BUFFER_OFFSET, BUFFER_SIZE);
                }
                return builder.toString();
            } finally {
                streamReader.close();
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private List<Option> readOptionsFrom(String... args) {
        optionArgs = new LinkedList<Option>();

        if (args.length == 1 && args[0].equals("--bare")) {
            optionArgs.add(Option.BARE);
        }
        return optionArgs;
    }

    public List<Option> getOptionArgs() {
        return optionArgs;
    }

    public void setOptionArgs(String... args) {
        this.optionArgs = readOptionsFrom(args);
    }
}
