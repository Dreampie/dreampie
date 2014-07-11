package cn.dreampie.common.plugin.coffeescript;

import cn.dreampie.common.plugin.coffeescript.compiler.CoffeeCompiler;
import cn.dreampie.common.plugin.coffeescript.compiler.CoffeeScriptException;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.IPlugin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Arrays;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public class CoffeeScriptPlugin implements IPlugin {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public boolean start() {

        // Instantiate the COFFEE compiler
// CoffeeCompiler coffeeCompiler = new CoffeeCompiler();

// Instantiate the COFFEE compiler with some compiler options
        CoffeeCompiler coffeeCompiler = new CoffeeCompiler(Arrays.asList("--relative-urls", "--strict-math=on"));
// Compile COFFEE input string to CSS output string
//String css = coffeeCompiler.compile("@color: #4D926F; #header { color: @color; }");

// Or compile COFFEE input file to CSS output file
        try {
            coffeeCompiler.compile(new File("main.less"), new File("main.css"));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (CoffeeScriptException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean stop() {
        return false;
    }

    public static void main(String[] args) {
        CoffeeCompiler coffeeCompiler = new CoffeeCompiler();
        String js = coffeeCompiler.compile("alert '测试'");
        System.out.println(js);

//        CoffeeScriptCompiler compiler = new CoffeeScriptCompiler(null, false);
//        String jss = compiler.compile("/javascript/app/main.coffee");
//        System.out.println(compiler.version.equals("1.7.1"));
    }
}
