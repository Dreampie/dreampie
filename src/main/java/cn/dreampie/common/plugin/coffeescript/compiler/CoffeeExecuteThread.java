package cn.dreampie.common.plugin.coffeescript.compiler;

import com.jfinal.kit.PathKit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sonatype.plexus.build.incremental.ThreadBuildContext;

import java.io.File;
import java.util.Observable;

/**
 * Created by wangrenhui on 2014/7/22.
 */
public class CoffeeExecuteThread extends Observable implements Runnable {
    private Logger logger = LoggerFactory.getLogger(getClass());
    private int restartInterval = 10000;

    // 此方法一经调用，等待restartInterval时间之后可以通知观察者，在本例中是监听线程
    public void doBusiness() {
        logger.error("CoffeeExecuteThread is dead");
        try {
            Thread.sleep(restartInterval);
        } catch (InterruptedException e) {
            logger.error(e.getMessage());
        }

        if (true) {
            super.setChanged();
        }
        notifyObservers();
    }

    @Override
    public void run() {
        CoffeeScriptCompiler coffeeScriptCompiler = new CoffeeScriptCompiler();
        coffeeScriptCompiler.setBuildContext(ThreadBuildContext.getContext());
        coffeeScriptCompiler.setSourceDirectory(new File(PathKit.getWebRootPath() + "/javascript/"));
        coffeeScriptCompiler.setOutputDirectory(new File(PathKit.getWebRootPath() + "/javascript/"));
//        coffeeScriptCompiler.setForce(true);
//        coffeeScriptCompiler.setCompress(true);
        coffeeScriptCompiler.setCoffeeJs(new File(PathKit.getRootClassPath() + "/libs/coffee-script-1.7.1.min.js"));
        coffeeScriptCompiler.setArgs("--bare");
        coffeeScriptCompiler.setWatch(true);
        try {
            coffeeScriptCompiler.execute();
        } catch (CoffeeException e) {
            logger.error(e.getMessage());
            doBusiness();
        }
    }
}
