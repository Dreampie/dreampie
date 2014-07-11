package cn.dreampie.common.plugin.lesscss;

import com.jfinal.plugin.IPlugin;
import org.lesscss.LessCompiler;
import org.lesscss.LessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public class LessCssPlugin implements IPlugin {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public boolean start() {

        // Instantiate the LESS compiler
// LessCompiler lessCompiler = new LessCompiler();

// Instantiate the LESS compiler with some compiler options
        LessCompiler lessCompiler = new LessCompiler(Arrays.asList("--relative-urls", "--strict-math=on"));
// Compile LESS input string to CSS output string
//String css = lessCompiler.compile("@color: #4D926F; #header { color: @color; }");

// Or compile LESS input file to CSS output file
        try {
            lessCompiler.compile(new File("main.less"), new File("main.css"));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (LessException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean stop() {
        return false;
    }

    public static void main(String[] args) throws LessException {
        LessCompiler lessCompiler = new LessCompiler(Arrays.asList("--relative-urls", "--strict-math=on"));
        String css = lessCompiler.compile("@color: #4D926F; #header { color: @color; }");
        System.out.println(css);
    }
}
