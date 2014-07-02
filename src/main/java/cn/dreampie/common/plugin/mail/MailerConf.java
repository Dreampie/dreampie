package cn.dreampie.common.plugin.mail;

/**
 * Created by wangrenhui on 14-5-6.
 */
public class MailerConf {
    private String charset;
    private String host;
    private String sslport;
    private int timeout;
    private String port;
    private boolean ssl;
    private boolean tls;
    private boolean debug;
    private String user;
    private String password;
    private String name;
    private String from;
    private String encode;

    public MailerConf(String host, String sslport, int timeout, String port, boolean ssl, boolean tls, boolean debug, String user, String password, String name, String from, String encode) {
        this.charset = "UTF-8";
        this.host = host;
        this.sslport = sslport;
        this.timeout = timeout;
        this.port = port;
        this.ssl = ssl;
        this.tls = tls;
        this.debug = debug;
        this.user = user;
        this.password = password;
        this.name = name;
        this.from = from;
        this.encode = encode;
    }

    public String getCharset() {
        return charset;
    }

    public void setCharset(String charset) {
        this.charset = charset;
    }

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getSslport() {
        return sslport;
    }

    public void setSslport(String sslport) {
        this.sslport = sslport;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public boolean isSsl() {
        return ssl;
    }

    public void setSsl(boolean ssl) {

        this.ssl = ssl;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getEncode() {
        return encode;
    }

    public void setEncode(String encode) {
        this.encode = encode;
    }

    public boolean isTls() {
        return tls;
    }

    public void setTls(boolean tls) {
        this.tls = tls;
    }

    public boolean isDebug() {
        return debug;
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }
}
