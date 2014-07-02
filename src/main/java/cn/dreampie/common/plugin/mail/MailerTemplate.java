package cn.dreampie.common.plugin.mail;

import cn.dreampie.common.web.thread.ThreadLocalUtil;
import com.jfinal.kit.PathKit;
import freemarker.cache.*;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * Created by wangrenhui on 2014/7/2.
 */
public class MailerTemplate {
    private static Logger logger = LoggerFactory.getLogger(MailerTemplate.class);

    private static MailerTemplate mailerTemplate = new MailerTemplate();
    /**
     * 邮件模板的存放位置
     */
    private static final String TEMPLATE_PATH = "/template/";
    /**
     * 模板引擎配置
     */
    private static Configuration configuration;
    /**
     * 参数
     */
    private static Map<Object, Object> parameters;

    public static MailerTemplate me() {
        //初始化参数
        parameters = new HashMap<Object, Object>();

        if (configuration == null) {
            configuration = new Configuration();
//        ClassTemplateLoader ctl= new ClassTemplateLoader(MailerTemplate.class, TEMPLATE_PATH);
            try {
                logger.info("template dir:" + PathKit.getWebRootPath() + TEMPLATE_PATH);
                TemplateLoader[] templateLoaders = new TemplateLoader[]{new WebappTemplateLoader(ThreadLocalUtil.getServletContex(), TEMPLATE_PATH), new ClassTemplateLoader(MailerTemplate.class, TEMPLATE_PATH), new FileTemplateLoader(new File(PathKit.getWebRootPath() + TEMPLATE_PATH))};
                configuration.setTemplateLoader(new MultiTemplateLoader(templateLoaders));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            configuration.setEncoding(Locale.getDefault(), "UTF-8");
            configuration.setDateFormat("yyyy-MM-dd HH:mm:ss");
        }
        return mailerTemplate;
    }

    public MailerTemplate set(String attr, Object value) {
        parameters.put(attr, value);
        return this;
    }

    public String getText(String templateFile) {
        try {
            Template template = configuration.getTemplate(templateFile);
            StringWriter stringWriter = new StringWriter();
            template.process(parameters, stringWriter);
            return stringWriter.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
