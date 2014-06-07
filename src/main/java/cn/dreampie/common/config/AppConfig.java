package cn.dreampie.common.config;

import cn.dreampie.common.handler.FakeStaticHandler;
import cn.dreampie.common.interceptor.UrlInterceptor;
import cn.dreampie.common.kit.sqlinxml.SqlInXmlPlugin;
import cn.dreampie.common.log.Slf4jLogFactory;
import cn.dreampie.common.plugin.akka.AkkaPlugin;
import cn.dreampie.common.plugin.db.FlywayPlugin;
import cn.dreampie.common.plugin.db.druid.DruidXAPlugin;
import cn.dreampie.common.plugin.mail.MailerPlugin;
import cn.dreampie.common.plugin.shiro.MyJdbcAuthzService;
import cn.dreampie.common.plugin.shiro.freemarker.ShiroTags;
import cn.dreampie.common.plugin.shiro.plugin.ShiroInterceptor;
import cn.dreampie.common.plugin.shiro.plugin.ShiroPlugin;
import cn.dreampie.common.plugin.tablebind.AutoMultiSourceTableBindPlugin;
import cn.dreampie.common.render.JsonErrorRenderFactory;
import cn.dreampie.common.resource.ResourceTags;
import com.alibaba.druid.filter.stat.StatFilter;
import com.alibaba.druid.wall.WallFilter;
import com.jfinal.config.*;
import com.jfinal.core.Const;
import com.jfinal.core.JFinal;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.ext.plugin.tablebind.SimpleNameStyles;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.FreeMarkerRender;

import java.util.Locale;

/**
 * Created with IntelliJ IDEA.
 * User: wangrenhui
 * Date: 13-12-18
 * Time: 下午6:28
 * API引导式配置
 */
public class AppConfig extends JFinalConfig {
    /**
     * 供Shiro插件使用。
     */
    Routes routes;

    /**
     * 配置常量
     */
    public void configConstant(Constants constants) {
        loadPropertyFile("application.properties");
        constants.setDevMode(getPropertyToBoolean("devMode", false));
//    constants.setEncoding("UTF-8");
//        I18N.init("messages", Locale.CHINA, Const.DEFAULT_I18N_MAX_AGE_OF_COOKIE);

        //set log to slf4j
        Logger.setLoggerFactory(new Slf4jLogFactory());
        constants.setErrorRenderFactory(new JsonErrorRenderFactory());
        constants.setI18n("messages", Locale.CHINA, Const.DEFAULT_I18N_MAX_AGE_OF_COOKIE);
        constants.setError401View("/page/login.ftl");
        constants.setError403View("/page/layout/403.ftl");
        constants.setError404View("/page/layout/404.ftl");
        constants.setError500View("/page/layout/500.ftl");
    }

    /**
     * 配置路由
     */
    public void configRoute(Routes routes) {
        this.routes = routes;
        AutoBindRoutes autoBindRoutes = new AutoBindRoutes();
        routes.add(autoBindRoutes);
    }

    /**
     * 配置插件
     */
    public void configPlugin(Plugins plugins) {

        //akka异步执行插件
        plugins.add(new AkkaPlugin());

        //emailer插件
        plugins.add(new MailerPlugin());

        //数据库版本控制插件
        plugins.add(new FlywayPlugin());
        //配置druid连接池
        DruidXAPlugin druidDefault = new DruidXAPlugin(getProperty("db.default.url"), getProperty("db.default.user"), getProperty("db.default.password"), getProperty("db.default.driver"));
        // StatFilter提供JDBC层的统计信息
        druidDefault.addFilter(new StatFilter());
        // WallFilter的功能是防御SQL注入攻击
        WallFilter wallDefault = new WallFilter();
        wallDefault.setDbType("h2");
        druidDefault.addFilter(wallDefault);

        druidDefault.setInitialSize(getPropertyToInt("db.default.poolInitialSize"));
        druidDefault.setMaxPoolPreparedStatementPerConnectionSize(getPropertyToInt("db.default.poolMaxSize"));
        druidDefault.setTimeBetweenConnectErrorMillis(getPropertyToInt("db.default.connectionTimeoutMillis"));
        plugins.add(druidDefault);

        //Model自动绑定表插件
        AutoMultiSourceTableBindPlugin tableBindDefault = new AutoMultiSourceTableBindPlugin(druidDefault, SimpleNameStyles.LOWER);
        tableBindDefault.setContainerFactory(new CaseInsensitiveContainerFactory(true)); //忽略字段大小写
//    tableBindDefault.addExcludePaths("cn.dreampie.function.shop");
        tableBindDefault.setShowSql(true);
        plugins.add(tableBindDefault);

        //第二数据源
//    DruidPlugin druidShop = new DruidPlugin(getProperty("db.shop.url"), getProperty("db.shop.user"), getProperty("db.shop.password"), getProperty("db.shop.driver"));
//    // StatFilter提供JDBC层的统计信息
//    druidShop.addFilter(new StatFilter());
//    // WallFilter的功能是防御SQL注入攻击
//    WallFilter wallShop = new WallFilter();
//    wallShop.setDbType("mysql");
//    druidShop.addFilter(wallShop);
//    plugins.add(druidShop);
//
//    AutoMultiSourceTableBindPlugin tableBindShop = new AutoMultiSourceTableBindPlugin(AppConstants.SHOP_DATESOURCE, druidShop, SimpleNameStyles.LOWER);
//    tableBindShop.setContainerFactory(new CaseInsensitiveContainerFactory(true)); //忽略字段大小写
//    tableBindShop.addIncludePaths("cn.dreampie.function.shop");
//    tableBindShop.setShowSql(true);
//    plugins.add(tableBindShop);


        //sql语句plugin
        plugins.add(new SqlInXmlPlugin());
        //ehcache缓存
        plugins.add(new EhCachePlugin());
        //shiro权限框架
        plugins.add(new ShiroPlugin(routes, new MyJdbcAuthzService()));
        //quartz
//    plugins.add(new QuartzPlugin());
    }

    /**
     * 配置全局拦截器
     */
    public void configInterceptor(Interceptors interceptors) {
        interceptors.add(new ShiroInterceptor());
//    interceptors.add(new CacheRemoveInterceptor());
//    interceptors.add(new CacheInterceptor());
        interceptors.add(new SessionInViewInterceptor());
//    interceptors.add(new TxByRegex("^(/[a-z0-9]*/)*(save|update|delete|drop)[a-z0-9/]*$",false));
        interceptors.add(new UrlInterceptor());
    }

    /**
     * 配置处理器
     */
    public void configHandler(Handlers handlers) {
        handlers.add(new FakeStaticHandler("/page", ".ftl", "/page/layout/", new String[]{"/javascript/", "/images/", "/css/", "/libs/"},new String[]{"/im/"}));
    }

    @Override
    public void afterJFinalStart() {
        super.afterJFinalStart();
        FreeMarkerRender.setProperties(loadPropertyFile("freemarker.properties"));
        FreeMarkerRender.getConfiguration().setSharedVariable("shiro", new ShiroTags());
        FreeMarkerRender.getConfiguration().setSharedVariable("resource", new ResourceTags());
    }

    /**
     * 建议使用 JFinal 手册推荐的方式启动项目
     * 运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
     */
    public static void main(String[] args) {
        JFinal.start("src/main/webapp", 80, "/", 5);
    }
}
