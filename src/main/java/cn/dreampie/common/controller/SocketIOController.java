package cn.dreampie.common.controller;

import akka.actor.ActorRef;
import akka.actor.Props;
import akka.util.Timeout;
import cn.dreampie.common.plugin.akka.Akka;
import cn.dreampie.common.plugin.akka.actors.WSActor;
import cn.dreampie.common.utils.ValidateUtils;
import scala.concurrent.duration.Duration;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Created by wangrenhui on 2014/5/30.
 */
public class SocketIOController extends Controller {

    public void index() {


    }

    public void handler() {
        String transport = getPara(0);
        String sessionId = getPara(1);
        String query = getPara(2);

        if (ValidateUtils.me().isNullOrEmpty(transport)) {
            init();
        } else if ("websocket".equals(transport)) {

        } else if ("xhr-polling".equals(transport)) {

        } else {
            throw new RuntimeException("Unable to match transport");
        }

    }


    Timeout clientTimeout = new Timeout(Duration.create(10, TimeUnit.SECONDS));
    Map<String, ActorRef> wsMap = new HashMap<String, ActorRef>();
    Map<ActorRef, String> wsRevMap = new HashMap<ActorRef, String>();

    public void init() {
        String sessionId = java.util.UUID.randomUUID().toString();
        long t = clientTimeout.duration().toSeconds();
        renderJson(sessionId + ":" + t + ":" + t + ":websocket,xhr-polling");
    }

    public void wsHandler(String sessionId) {

        if (wsMap.containsKey(sessionId)) {

        } else {
            ActorRef wsActor = Akka.system().actorOf(Props.create(WSActor.class, wsMap, wsRevMap));
            wsMap.put(sessionId, wsActor);
            wsRevMap.put(wsActor,sessionId);
        }
    }

    public void connectionFailure(String error) {
        // Connection error

    }
}
