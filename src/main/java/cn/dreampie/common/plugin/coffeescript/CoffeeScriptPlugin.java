package cn.dreampie.common.plugin.coffeescript;

import cn.dreampie.common.plugin.coffeescript.compiler.CoffeeCompiler;
import cn.dreampie.common.plugin.coffeescript.compiler.CoffeeException;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.IPlugin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;

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
        CoffeeCompiler coffeeCompiler = new CoffeeCompiler();
// Compile COFFEE input string to CSS output string
//String css = coffeeCompiler.compile("@color: #4D926F; #header { color: @color; }");

// Or compile COFFEE input file to CSS output file
        try {
            coffeeCompiler.compile(new File("main.less"), new File("main.css"));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (CoffeeException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean stop() {
        return false;
    }

    public static void main(String[] args) throws IOException, CoffeeException {
        CoffeeCompiler coffeeCompiler = new CoffeeCompiler();
        String js = coffeeCompiler.compile("alert '测试'");
//        System.out.println(js);

        coffeeCompiler = new CoffeeCompiler();
        js = coffeeCompiler.compile(new File(PathKit.getWebRootPath()+"/src/main/webapp/javascript/app/main.coffee"));
        System.out.println(js);
    }
}
