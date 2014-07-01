package cn.dreampie.common.plugin.akka;

import akka.actor.ActorSystem;
import com.jfinal.plugin.IPlugin;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by wangrenhui on 14-5-6.
 */
public class AkkaPlugin implements IPlugin {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private boolean applicationSystemEnabled = false;
    static ActorSystem applicationSystem;

    /**
     * no /
     */
    private String config = "akka.conf";

    public AkkaPlugin() {

    }

    public AkkaPlugin(String config) {
        this.config = config;
    }

    private ActorSystem applicationSystem() {
        applicationSystemEnabled = true;
        Config akkaConf = ConfigFactory.load(config);
        ActorSystem system = ActorSystem.create("application", akkaConf);
        logger.info("Starting application default Akka system.");
        return system;
    }

    @Override
    public boolean start() {
        applicationSystem = applicationSystem();
        return true;
    }

    @Override
    public boolean stop() {
        if (applicationSystemEnabled) {
            logger.info("Shutdown application default Akka system.");
            applicationSystem.shutdown();
            applicationSystem.awaitTermination();
        }
        return true;
    }
}
