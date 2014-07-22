package cn.dreampie.common.plugin.coffeescript.compiler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Observable;
import java.util.Observer;

/**
 * Created by wangrenhui on 2014/7/22.
 */
public class CoffeeExecuteListener implements Observer {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public void update(Observable o, Object arg) {
        CoffeeExecuteThread run = new CoffeeExecuteThread();
        run.addObserver(this);
        new Thread(run).start();
        logger.info("CoffeeExecuteThread is start");
    }
}
