package cn.dreampie.common.web.controller;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.config.ReTurnType;
import cn.dreampie.common.plugin.mail.Mailer;
import cn.dreampie.common.plugin.mail.MailerTemplate;
import cn.dreampie.common.plugin.patchca.PatchcaRender;
import cn.dreampie.common.plugin.shiro.hasher.Hasher;
import cn.dreampie.common.plugin.shiro.hasher.HasherInfo;
import cn.dreampie.common.plugin.shiro.hasher.HasherUtils;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.thread.ThreadLocalUtil;
import cn.dreampie.function.user.User;
import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.tx.Tx;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import java.io.File;
import java.util.Date;

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
        dynaRender("/view/index.ftl");
    }


    /**
     * 登录页
     */
    public void tologin() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null && subject.getPrincipal() != null) {
            subject.logout();
        }
        dynaRender("/view/login.ftl");
    }

    public void toregister() {
        String code = getPara(0);
        if (code != null) {
            String u = getCookie(code);
            if (u != null) {
                User regUser = JSON.parseObject(u, User.class);
                setAttr("user", regUser);
                removeCookie(code);
                dynaRender("/view/register.ftl");
            }
        } else
            dynaRender("/view/register_email.ftl");
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

    @Before({RootValidator.RegisterEmailValidator.class, Tx.class})
    public void registerEmail() {
        User regUser = getModel(User.class);

        regUser.set("full_name", regUser.get("first_name") + "·" + regUser.get("last_name"));

        String emailHash = HasherUtils.me().hash(regUser.getStr("email"), Hasher.DEFAULT).getHashText();

        setCookie(emailHash, JSON.toJSONString(regUser), 20 * 60 * 1000);

        Mailer.me().sendHtml("Dreampie.cn-梦想派",
                MailerTemplate.me().set("full_name", regUser.get("full_name")).set("safe_url", getAttr("webRootPath") + "/toregister/" + emailHash)
                        .getText("mails/register_complete.ftl"), regUser.getStr("email"));

        setAttr("user", regUser);

        dynaRender("/view/send_email_notice.ftl");
    }

    @Before({RootValidator.RegisterValidator.class, Tx.class})
    public void register() {
        User regUser = getModel(User.class);
        regUser.set("created_at", new Date());
        regUser.set("providername", "dreampie");

        boolean autoLogin = getParaToBoolean("autoLogin");

        HasherInfo passwordInfo = HasherUtils.me().hash(regUser.getStr("password"), Hasher.DEFAULT);
        regUser.set("password", passwordInfo.getHashResult());
        regUser.set("hasher", passwordInfo.getHasher().value());
        regUser.set("salt", passwordInfo.getSalt());

        if (regUser.save()) {
            regUser.addUserInfo(null).addRole(null);
            setAttr("state", "success");
            if (autoLogin) {
                if (SubjectUtils.me().login(regUser.getStr("username"), passwordInfo.getHashText())) {
                    //添加到session
                    SubjectUtils.me().getSession().setAttribute(AppConstants.CURRENT_USER, regUser);
                    dynaRender("/view/index.ftl");
                } else
                    dynaRender("/view/login.ftl");
            }
        } else {
            setAttr("state", "failure");
            dynaRender("/view/register.ftl");
        }
    }

}
