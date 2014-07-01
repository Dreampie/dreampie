package cn.dreampie.common.plugin.akka;

import akka.actor.ActorSystem;
import cn.dreampie.common.utils.ValidateUtils;

/**
 * Created by wangrenhui on 14-5-6.
 */
public class Akka {

    /**
     * Retrieve the application Akka Actor system.
     * <p/>
     * Example:
     * {{{
     * val newActor = Akka.system.actorOf[Props[MyActor]]
     * }}}
     */
    public static ActorSystem system() {
        ActorSystem applicationSystem = AkkaPlugin.applicationSystem;
        if (ValidateUtils.me().isNullOrEmpty(applicationSystem)) {
            throw new RuntimeException("Akka plugin is not registered.");
        }
        return applicationSystem;
    }
}
