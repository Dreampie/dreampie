package cn.dreampie.common.controller;

import akka.util.Timeout;
import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.config.ReTurnType;
import cn.dreampie.common.plugin.db.tx.AXTxConfig;
import cn.dreampie.common.patchca.PatchcaRender;
import cn.dreampie.common.plugin.shiro.hasher.Hasher;
import cn.dreampie.common.plugin.shiro.hasher.HasherInfo;
import cn.dreampie.common.plugin.shiro.hasher.HasherUtils;
import cn.dreampie.common.plugin.web.WebSocket;
import cn.dreampie.common.thread.ThreadLocalUtil;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.function.user.User;
import com.jfinal.aop.Before;
import com.jfinal.render.JsonRender;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import scala.concurrent.duration.Duration;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * Controller
 */
public class Controller extends com.jfinal.core.Controller {

    public void dynaRender(String view) {
        if (ThreadLocalUtil.returnType() == ReTurnType.JSON)
            super.renderJson();
        else
            super.render(view);
    }

    /**
     * 根目录
     */
//  @Before(EvictInterceptor.class)
//  @CacheName("index")
    public void index() {
        String para = getPara(0);
        if (getPara() != null) {
            render("/page/index.ftl");
        }

    }

    /**
     * 登录页
     */
    @AXTxConfig({AppConstants.DEFAULT_DATESOURCE, AppConstants.SHOP_DATESOURCE})
    public void tologin() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null && subject.getPrincipal() != null) {
            subject.logout();
        }
        render("/page/login.ftl");
    }

    public void toregister() {
        render("/page/register.ftl");
    }

    /**
     * 验证码
     */
    public void patchca() {
        int width = 0, height = 0, minnum = 0, maxnum = 0;
        if (isParaExists("width")) {
            width = getParaToInt("width");
        }
        if (isParaExists("height")) {
            height = getParaToInt("height");
        }
        if (isParaExists("minnum")) {
            minnum = getParaToInt("minnum");
        }
        if (isParaExists("maxnum")) {
            maxnum = getParaToInt("maxnum");
        }
        render(new PatchcaRender(minnum, maxnum, width, height));
    }

    @Before(RegisterValidator.class)
    public void register() {
        User regUser = getModel(User.class);
        regUser.set("created_at", new Date());
        regUser.set("providername", "dreampie");

        HasherInfo passwordInfo = HasherUtils.me().hash(regUser.getStr("password"), Hasher.DEFAULT);
        regUser.set("password", passwordInfo.getHashResult());
        regUser.set("hasher", passwordInfo.getHasher());
        regUser.set("salt", passwordInfo.getSalt());

        if (regUser.save()) {
            regUser.addUserInfo(null).addRole(null);
            setAttr("state", "success");
            if (SubjectUtils.me().login(regUser.getStr("username"), regUser.getStr("password"))) {
                dynaRender("/page/user/index.ftl");
            }
        } else
            setAttr("state", "failure");
        dynaRender("/page/register.ftl");
    }

}
