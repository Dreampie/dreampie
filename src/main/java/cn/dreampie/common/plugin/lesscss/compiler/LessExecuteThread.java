package cn.dreampie.common.plugin.lesscss.compiler;

import cn.dreampie.common.plugin.coffeescript.compiler.CoffeeException;
import cn.dreampie.common.plugin.coffeescript.compiler.CoffeeScriptCompiler;
import com.jfinal.kit.PathKit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sonatype.plexus.build.incremental.ThreadBuildContext;

import java.io.File;
import java.util.Observable;

/**
 * Created by wangrenhui on 2014/7/22.
 */
public class LessExecuteThread extends Observable implements Runnable {
    private Logger logger = LoggerFactory.getLogger(getClass());
    private int restartInterval = 10000;

    // 此方法一经调用，等待restartInterval时间之后可以通知观察者，在本例中是监听线程
    public void doBusiness() {
        logger.error("LessExecuteThread is dead");
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
        LessCssCompiler lessCssCompiler = new LessCssCompiler();
        lessCssCompiler.setBuildContext(ThreadBuildContext.getContext());
        lessCssCompiler.setSourceDirectory(new File(PathKit.getWebRootPath() + "/css/"));
        lessCssCompiler.setOutputDirectory(new File(PathKit.getWebRootPath() + "/css/"));
//        lessCssCompiler.setForce(true);
//        lessCssCompiler.setCompress(true);
        lessCssCompiler.setWatch(true);

        try {
            lessCssCompiler.execute();
        } catch (LessCssException e) {
            logger.error(e.getMessage());
            doBusiness();
        }
    }
}
