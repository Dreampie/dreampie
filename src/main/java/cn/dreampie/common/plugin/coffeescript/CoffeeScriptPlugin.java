package cn.dreampie.common.plugin.coffeescript;

import cn.dreampie.common.plugin.coffeescript.compiler.*;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.IPlugin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sonatype.plexus.build.incremental.ThreadBuildContext;

import java.io.File;
import java.io.IOException;

/**
 * Created by wangrenhui on 2014/7/11.
 */
public class CoffeeScriptPlugin implements IPlugin {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public boolean start() {
//        CoffeeScriptCompiler coffeeScriptCompiler = new CoffeeScriptCompiler();
//        coffeeScriptCompiler.setBuildContext(ThreadBuildContext.getContext());
//        coffeeScriptCompiler.setSourceDirectory(new File(PathKit.getWebRootPath() + "/javascript/"));
//        coffeeScriptCompiler.setOutputDirectory(new File(PathKit.getWebRootPath() + "/javascript/"));
////        coffeeScriptCompiler.setForce(true);
////        coffeeScriptCompiler.setCompress(true);
//        coffeeScriptCompiler.setCoffeeJs(new File(PathKit.getRootClassPath() + "/libs/coffee-script-1.7.1.min.js"));
//        coffeeScriptCompiler.setArgs("--bare");
//        coffeeScriptCompiler.setWatch(true);
//        try {
//            coffeeScriptCompiler.execute();
//        } catch (CoffeeException e) {
//            e.printStackTrace();
//        }
        CoffeeExecuteThread run = new CoffeeExecuteThread();
        CoffeeExecuteListener listen = new CoffeeExecuteListener();
        run.addObserver(listen);
        new Thread(run).start();
        return true;
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
        js = coffeeCompiler.compile(new File(PathKit.getWebRootPath() + "/src/main/webapp/javascript/app/main.coffee"));
//        System.out.println(js);

        CoffeeScriptCompiler coffeeScriptCompiler = new CoffeeScriptCompiler();
        coffeeScriptCompiler.setBuildContext(ThreadBuildContext.getContext());
        coffeeScriptCompiler.setSourceDirectory(new File(PathKit.getWebRootPath() + "/src/main/webapp/javascript/"));
//        coffeeScriptCompiler.setOutputDirectory(new File(PathKit.getRootClassPath() + "/javascript/"));
        coffeeScriptCompiler.setForce(true);
        coffeeScriptCompiler.setArgs("--bare");
        coffeeScriptCompiler.setWatch(true);
        coffeeScriptCompiler.execute();
    }
}
