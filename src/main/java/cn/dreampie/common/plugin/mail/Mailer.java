package cn.dreampie.common.plugin.mail;

import cn.dreampie.common.plugin.akka.Akka;
import cn.dreampie.common.utils.ValidateUtils;
import org.apache.commons.mail.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import scala.concurrent.duration.Duration;

import java.util.concurrent.TimeUnit;

/**
 * Mailer.me().sendHtml("测试","173956022@qq.com","<a href='www.dreampie.cn'>Dreampie</a>");
 * Created by wangrenhui on 14-5-6.
 */
public class Mailer {
    private Logger logger = LoggerFactory.getLogger(getClass());

    private static Mailer mailer = new Mailer();

    public static Mailer me() {
        return mailer;
    }

    /**
     * @param subject    主题
     * @param body       内容
     * @param recipients 收件人
     */
    public void sendHtml(final String subject, final String body, final String... recipients) {
        sendHtml(subject, body, null, recipients);
    }

    /**
     * @param subject    主题
     * @param body       内容
     * @param attachment 附件
     * @param recipients 收件人
     */
    public void sendHtml(final String subject, final String body, final EmailAttachment attachment, final String... recipients) {

        Akka.system().scheduler().scheduleOnce(Duration.create(1000, TimeUnit.MILLISECONDS),
                new Runnable() {
                    @Override
                    public void run() {
                        MailerConf mailerConf = MailerPlugin.mailerConf;
                        HtmlEmail htmlEmail = new HtmlEmail();
                        htmlEmail.setCharset(mailerConf.getCharset());
                        htmlEmail.setSocketTimeout(mailerConf.getTimeout());
                        htmlEmail.setCharset(mailerConf.getEncode());
                        htmlEmail.setHostName(mailerConf.getHost());
                        if (!ValidateUtils.me().isNullOrEmpty(mailerConf.getSslport()))
                            htmlEmail.setSslSmtpPort(mailerConf.getSslport());
                        if (!ValidateUtils.me().isNullOrEmpty(mailerConf.getPort()))
                            htmlEmail.setSmtpPort(Integer.parseInt(mailerConf.getPort()));
                        htmlEmail.setSSLOnConnect(mailerConf.isSsl());
                        htmlEmail.setStartTLSEnabled(mailerConf.isTls());
                        htmlEmail.setDebug(mailerConf.isDebug());
                        htmlEmail.setAuthenticator(new DefaultAuthenticator(mailerConf.getUser(), mailerConf.getPassword()));
                        try {
                            htmlEmail.setFrom(mailerConf.getFrom(), mailerConf.getName());
                            htmlEmail.setSubject(subject);
                            htmlEmail.addTo(recipients);
                            htmlEmail.setHtmlMsg(body);
                            // set the alternative message
                            htmlEmail.setTextMsg("Your email client does not support HTML messages");
                            if (!ValidateUtils.me().isNullOrEmpty(attachment))
                                htmlEmail.attach(attachment);
                            htmlEmail.send();
                        } catch (EmailException e) {
                            e.printStackTrace();
                        }
                    }
                }, Akka.system().dispatcher());
    }

    /**
     * @param subject    主题
     * @param body       内容
     * @param recipients 收件人
     */
    public void sendText(final String subject, final String body, final String... recipients) {

        Akka.system().scheduler().scheduleOnce(Duration.create(1000, TimeUnit.MILLISECONDS),
                new Runnable() {
                    @Override
                    public void run() {
                        MailerConf mailerConf = MailerPlugin.mailerConf;
                        SimpleEmail simpleEmail = new SimpleEmail();
                        simpleEmail.setCharset(mailerConf.getCharset());
                        simpleEmail.setSocketTimeout(mailerConf.getTimeout());
                        simpleEmail.setCharset(mailerConf.getEncode());
                        simpleEmail.setHostName(mailerConf.getHost());
                        if (!ValidateUtils.me().isNullOrEmpty(mailerConf.getSslport()))
                            simpleEmail.setSslSmtpPort(mailerConf.getSslport());
                        if (!ValidateUtils.me().isNullOrEmpty(mailerConf.getPort()))
                            simpleEmail.setSmtpPort(Integer.parseInt(mailerConf.getPort()));
                        simpleEmail.setSSLOnConnect(mailerConf.isSsl());
                        simpleEmail.setStartTLSEnabled(mailerConf.isTls());
                        simpleEmail.setDebug(mailerConf.isDebug());
                        simpleEmail.setAuthentication(mailerConf.getUser(), mailerConf.getPassword());
                        try {
                            simpleEmail.setFrom(mailerConf.getFrom(), mailerConf.getName());
                            simpleEmail.setSubject(subject);
                            simpleEmail.addTo(recipients);
                            simpleEmail.setMsg(body);
                            simpleEmail.send();
                        } catch (EmailException e) {
                            e.printStackTrace();
                        }
                    }
                }, Akka.system().dispatcher());
    }

    /**
     * @param subject    主题
     * @param body       内容
     * @param attachment 附件
     * @param recipients 收件人
     */
    public void sendAttachment(final String subject, final String body, final EmailAttachment attachment, final String... recipients) {

        Akka.system().scheduler().scheduleOnce(Duration.create(1000, TimeUnit.MILLISECONDS),
                new Runnable() {
                    @Override
                    public void run() {
                        MailerConf mailerConf = MailerPlugin.mailerConf;
                        MultiPartEmail multiPartEmail = new MultiPartEmail();
                        multiPartEmail.setCharset(mailerConf.getCharset());
                        multiPartEmail.setSocketTimeout(mailerConf.getTimeout());
                        multiPartEmail.setCharset(mailerConf.getEncode());
                        multiPartEmail.setHostName(mailerConf.getHost());
                        if (!ValidateUtils.me().isNullOrEmpty(mailerConf.getSslport()))
                            multiPartEmail.setSslSmtpPort(mailerConf.getSslport());
                        if (!ValidateUtils.me().isNullOrEmpty(mailerConf.getPort()))
                            multiPartEmail.setSmtpPort(Integer.parseInt(mailerConf.getPort()));
                        multiPartEmail.setSSLOnConnect(mailerConf.isSsl());
                        multiPartEmail.setStartTLSEnabled(mailerConf.isTls());
                        multiPartEmail.setDebug(mailerConf.isDebug());
                        multiPartEmail.setAuthentication(mailerConf.getUser(), mailerConf.getPassword());
                        try {
                            multiPartEmail.setFrom(mailerConf.getFrom(), mailerConf.getName());
                            multiPartEmail.setSubject(subject);
                            multiPartEmail.addTo(recipients);
                            multiPartEmail.setMsg(body);
                            // add the attachment
                            if (!ValidateUtils.me().isNullOrEmpty(attachment))
                                multiPartEmail.attach(attachment);
                            multiPartEmail.send();
                        } catch (EmailException e) {
                            e.printStackTrace();
                        }
                    }
                }, Akka.system().dispatcher());
    }
}
