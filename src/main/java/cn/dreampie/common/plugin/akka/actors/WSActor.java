package cn.dreampie.common.plugin.akka.actors;

import akka.actor.*;

import static akka.pattern.Patterns.ask;

import cn.dreampie.common.plugin.akka.Akka;
import cn.dreampie.common.plugin.web.WebSocket;
import com.jfinal.kit.JsonKit;
import scala.concurrent.Await;
import scala.concurrent.duration.Duration;

import java.util.*;

import static java.util.concurrent.TimeUnit.SECONDS;

import cn.dreampie.common.plugin.web.F.*;
import akka.actor.Actor.*;

/**
 * Created by wangrenhui on 2014/5/29.
 */
public class WSActor extends UntypedActor {

    // Default room.
    static ActorRef wsActor = Akka.system().actorOf(Props.create(WSActor.class));

    /**
     * Join the default room.
     */
    public static void join(final String username, WebSocket.In<String> in, WebSocket.Out<String> out) throws Exception {
        Cancellable cancellable = null;

        // Send the Join message to the room
        String result = (String) Await.result(ask(wsActor, new Join(username, out), 1000), Duration.create(1, SECONDS));

        if ("OK".equals(result)) {

            // For each event received on the socket,
            in.onMessage(new Callback<String>() {
                public void invoke(String event) {

                    // Send a Talk message to the room.
                    wsActor.tell(new Talk(username, event), null);

                }
            });

            // When the socket is closed.
            in.onClose(new Callback0() {
                public void invoke() {

                    // Send a Quit message to the room.
                    wsActor.tell(new Quit(username), null);

                }
            });

        } else {

            // Cannot connect, create a Json error.
            Map error = new HashMap();
            error.put("error", result);

            // Send the error to the socket.
            out.write(JsonKit.toJson(error));

        }

    }

    // Members of this room.
    Map<String, WebSocket.Out<String>> members = new HashMap<String, WebSocket.Out<String>>();

    public void onReceive(Object message) throws Exception {

        if (message instanceof Join) {

            // Received a Join message
            Join join = (Join) message;

            // Check if this username is free.
            if (members.containsKey(join.username)) {
                getSender().tell("This username is already used", getSelf());
            } else {
                members.put(join.username, join.channel);
                notifyAll("join", join.username, "has entered the room");
                getSender().tell("OK", getSelf());
            }

        } else if (message instanceof Talk) {

            // Received a Talk message
            Talk talk = (Talk) message;

            notifyAll("talk", talk.username, talk.text);

        } else if (message instanceof Quit) {

            // Received a Quit message
            Quit quit = (Quit) message;

            members.remove(quit.username);

            notifyAll("quit", quit.username, "has left the room");

        } else {
            unhandled(message);
        }

    }

    // Send a Json event to all members
    public void notifyAll(String kind, String user, String text) {
        for (WebSocket.Out<String> channel : members.values()) {

            Map event = new HashMap();
            event.put("kind", kind);
            event.put("user", user);
            event.put("message", text);

            List m = new ArrayList();
            for (String u : members.keySet()) {
                m.add(u);
            }
            event.put("members", m);
            channel.write(JsonKit.toJson(event));
        }
    }

    // -- Messages

    public static class Join {

        final String username;
        final WebSocket.Out<String> channel;

        public Join(String username, WebSocket.Out<String> channel) {
            this.username = username;
            this.channel = channel;
        }

    }

    public static class Talk {

        final String username;
        final String text;

        public Talk(String username, String text) {
            this.username = username;
            this.text = text;
        }

    }

    public static class Quit {

        final String username;

        public Quit(String username) {
            this.username = username;
        }

    }

}
