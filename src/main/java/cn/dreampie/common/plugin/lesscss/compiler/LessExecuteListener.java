package cn.dreampie.common.plugin.lesscss.compiler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Observable;
import java.util.Observer;

/**
 * Created by wangrenhui on 2014/7/22.
 */
public class LessExecuteListener implements Observer {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public void update(Observable o, Object arg) {
        LessExecuteThread run = new LessExecuteThread();
        run.addObserver(this);
        new Thread(run).start();
        logger.error("LessExecuteThread is start");
    }
}
