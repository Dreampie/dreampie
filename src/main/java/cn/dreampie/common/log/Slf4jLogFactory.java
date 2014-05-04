package cn.dreampie.common.log;

import com.jfinal.log.ILoggerFactory;
import com.jfinal.log.Logger;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class Slf4jLogFactory implements ILoggerFactory {
    @Override
    public Logger getLogger(Class<?> clazz) {
        return new Slf4jLogger(clazz);
    }

    @Override
    public Logger getLogger(String name) {
        return new Slf4jLogger(name);
    }
}
