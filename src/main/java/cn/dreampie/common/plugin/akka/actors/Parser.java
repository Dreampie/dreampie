package cn.dreampie.common.plugin.akka.actors;

import cn.dreampie.common.utils.ValidateUtils;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by wangrenhui on 2014/6/4.
 */
public class Parser {

    static Pattern pattern = Pattern.compile("([^:]+):([0-9]+)?(\\+)?:([^:]+)?:?([\\s\\S]*)?");

    public static Packet decodePacket(String data) {
        Matcher matcher = pattern.matcher(data);
        String ptype = matcher.group(0);
        String pmsgid = matcher.group(1);
        boolean pack = !ValidateUtils.me().isNullOrEmpty(matcher.group(2));
        String pendpoint = matcher.group(3);
        String pdata = matcher.group(4);
        return new Packet(ptype, pmsgid, pack, pendpoint, pdata);
    }


    public static String encodePacket(Packet data) {
        return PacketTypes.map.get(data.packetType) + ":" + data.msgId + ":" + data.endpoint + ":" + data.data;
    }

    public static class SSession {
        String sid = "";
        String[] upgrades;
        long pingInterval = 25000;
        long pingTimeout = 60000;

        public SSession(String sid, String[] upgrades) {
            this.sid = sid;
            this.upgrades = upgrades;
        }

        public SSession(String sid, String[] upgrades, long pingInterval, long pingTimeout) {
            this.sid = sid;
            this.upgrades = upgrades;
            this.pingInterval = pingInterval;
            this.pingTimeout = pingTimeout;
        }
    }


    public static class Packet {
        String packetType = "";
        String msgId = "";
        boolean ack = false;
        String endpoint = "";
        String data = "";

        public Packet(String packetType, String msgId, boolean ack, String endpoint, String data) {
            this.packetType = packetType;
            this.msgId = msgId;
            this.ack = ack;
            this.endpoint = endpoint;
            this.data = data;
        }
    }

    public static class PacketTypes {
        static final String DISCONNECT = "disconnect";
        static final String CONNECT = "connect";
        static final String HEARTBEAT = "heartbeat";
        static final String MESSAGE = "message";
        static final String JSON = "json";
        static final String EVENT = "event";
        static final String ACK = "ack";
        static final String ERROR = "error";
        static final String NOOP = "noop";

        //Using listmap as we need to maintain the original order
        static Map<String, Integer> map = new HashMap<String, Integer>();

        static {
            map.put(DISCONNECT, 0);
            map.put(CONNECT, 1);
            map.put(HEARTBEAT, 2);
            map.put(MESSAGE, 3);
            map.put(JSON, 4);
            map.put(EVENT, 5);
            map.put(ACK, 6);
            map.put(ERROR, 7);
            map.put(NOOP, 8);
        }

        static String[] keys = (String[]) map.keySet().toArray(new String[map.keySet().size()]);
    }

    static class Reasons {
        static Map<String, Integer> map = new HashMap<String, Integer>();

        static {
            map.put("transport not supported", 0);
            map.put("client not handshaken", 1);
            map.put("unauthorized", 2);
        }

        static String[] keys = (String[]) map.keySet().toArray(new String[map.keySet().size()]);
    }

    static class Advices {
        static Map<String, Integer> map = new HashMap<String, Integer>();

        static {
            map.put("reconnect", 0);
        }

        static String[] keys = (String[]) map.keySet().toArray(new String[map.keySet().size()]);
    }
}
