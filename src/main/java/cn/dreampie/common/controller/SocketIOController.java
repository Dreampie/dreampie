package cn.dreampie.common.controller;

import akka.actor.ActorRef;
import akka.actor.Props;
import akka.util.Timeout;
import cn.dreampie.common.plugin.akka.Akka;
import cn.dreampie.common.plugin.akka.actors.Parser;
import cn.dreampie.common.plugin.akka.actors.WSActor;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.function.user.User;
import com.jfinal.kit.JsonKit;
import scala.concurrent.duration.Duration;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Created by wangrenhui on 2014/5/30.
 */
public class SocketIOController extends Controller {

    public void index() {
        handler();
    }

    public void handler() {
        String transport = getPara("transport");
        String sessionId = getPara("sid");
        User user = (User) SubjectUtils.me().getUser();

        if (ValidateUtils.me().isNullOrEmpty(transport) || transport.equals("polling")) {
            init();
        } else if ("websocket".equals(transport)) {
            wsHandler(sessionId, user.getStr("username"));
        } else if ("xhr-polling".equals(transport)) {

        } else {
            throw new RuntimeException("Unable to match transport");
        }

    }


    Timeout clientTimeout = new Timeout(Duration.create(10, TimeUnit.SECONDS));
    Map<String, String> usernameMap = new HashMap<String, String>();
    Map<String, ActorRef> wsMap = new HashMap<String, ActorRef>();
    Map<ActorRef, String> wsRevMap = new HashMap<ActorRef, String>();

    public void init() {
        String sessionId = java.util.UUID.randomUUID().toString();
        long t = clientTimeout.duration().toSeconds();
        Parser.SSession sSession = new Parser.SSession(sessionId, new String[]{"websocket", "xhr-polling"},t,t);
        renderJson(sSession);
    }

    public void wsHandler(String sessionId, String username) {

        if (wsMap.containsKey(sessionId)) {

        } else {
            ActorRef wsActor = Akka.system().actorOf(Props.create(WSActor.class, wsMap, wsRevMap));
            usernameMap.put(username, sessionId);
            wsMap.put(sessionId, wsActor);
            wsRevMap.put(wsActor, sessionId);
        }
    }

    public void connectionFailure(String error) {
        // Connection error

    }
}
