package cn.dreampie.common.plugin.mail;

import cn.dreampie.common.exception.ValidateException;
import cn.dreampie.common.utils.PropertiesUtils;
import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.plugin.IPlugin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;

/**
 * Created by wangrenhui on 14-5-6.
 */
public class MailerPlugin implements IPlugin {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private String config = "/application.properties";
    private Properties properties;

    private String host;
    private String sslport;
    private String timeout;
    private String port;
    private String ssl;
    private String tls;
    private String debug;
    private String user;
    private String password;
    private String name;
    private String from;
    private String encode;

    static MailerConf mailerConf;

    public MailerPlugin() {

    }

    public MailerPlugin(String config) {
        this.config = config;
    }

    @Override
    public boolean start() {
        properties = PropertiesUtils.me().loadPropertyFile(config);
        host = properties.getProperty("smtp.host", "");
        if (ValidateUtils.me().isNullOrEmpty(host)) {
            throw new ValidateException("email host has not found!");
        }
        port = properties.getProperty("smtp.port", "");

        ssl = properties.getProperty("smtp.ssl", "false");
        sslport = properties.getProperty("smtp.sslport", "");
//    if (Boolean.parseBoolean(ssl)) {
//      if (ValidateUtils.me().isNullOrEmpty(sslport)) {
//        throw new ValidateException("email ssl is true but sslport has not found!");
//      }
//    }
        timeout = properties.getProperty("smtp.timeout", "60000");
        tls = properties.getProperty("smtp.tls", "false");
        debug = properties.getProperty("smtp.debug", "false");
        user = properties.getProperty("smtp.user", "");

        if (ValidateUtils.me().isNullOrEmpty(user)) {
            throw new ValidateException("email user has not found!");
        }
        password = properties.getProperty("smtp.password", "");
        if (ValidateUtils.me().isNullOrEmpty(password)) {
            throw new ValidateException("email password has not found!");
        }

        name = properties.getProperty("smtp.name", "");

        from = properties.getProperty("smtp.from", "");
        if (ValidateUtils.me().isNullOrEmpty(from)) {
            throw new ValidateException("email from has not found!");
        }

        encode = properties.getProperty("smtp.encode", "UTF-8");
        mailerConf = new MailerConf(host, sslport, Integer.parseInt(timeout), port, Boolean.parseBoolean(ssl), Boolean.parseBoolean(tls), Boolean.parseBoolean(debug), user, password, name, from, encode);

        return true;
    }

    @Override
    public boolean stop() {
        host = null;
        port = null;
        ssl = null;
        user = null;
        password = null;
        name = null;
        from = null;
        return true;
    }
}
