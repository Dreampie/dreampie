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
import cn.dreampie.function.user.Token;
import cn.dreampie.function.user.User;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.joda.time.DateTime;

import java.util.Date;
import java.util.UUID;

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
        String uuid = getPara("code");
        if (uuid != null && ValidateUtils.me().isUUID(uuid)) {

            Token token = Token.dao.findFirstBy("uuid='" + uuid + "'  AND expiration_at>'" + new Date() + "' AND is_sign_up = true");

            if (token != null) {
                User regUser = new User();
                regUser.set("email", token.get("email"));
                regUser.set("email", "wangrenhui1990@hotmail.com");
                setAttr("user", regUser);
                token.delete();
                SubjectUtils.me().getSession().setAttribute(AppConstants.TEMP_USER, regUser);
                dynaRender("/view/register.ftl");
                return;
            }
        }

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

        Token token = new Token();
        token.set("uuid", UUID.randomUUID().toString());
        token.set("username", regUser.get("email"));
        DateTime now = DateTime.now();
        token.set("created_at", now.toDate());
        token.set("expiration_at", now.plusDays(1).toDate());
        token.set("is_sign_up", true);

        if (token.save()) {
            Mailer.me().sendHtml("Dreampie.cn-梦想派",
                    MailerTemplate.me().set("full_name", "先生/女士").set("safe_url", getAttr("webRootPath") + "/toregister?code=" + token.get("uuid"))
                            .getText("mails/register_complete.ftl"), regUser.getStr("email"));

            setAttr("user", regUser);
            dynaRender("/view/send_email_notice.ftl");
        }
    }

    @Before({RootValidator.RegisterValidator.class, Tx.class})
    public void register() {
        User regUser = getModel(User.class);
        Object u = SubjectUtils.me().getSession().getAttribute(AppConstants.TEMP_USER);

        regUser.set("email", ((User) u).get("email"));

        regUser.set("created_at", new Date());
        regUser.set("providername", "dreampie");


        regUser.set("full_name", regUser.get("first_name") + "·" + regUser.get("last_name"));

        boolean autoLogin = getParaToBoolean("autoLogin") == null ? false : getParaToBoolean("autoLogin");

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
                    return;
                }
            }
        } else {
            setAttr("state", "failure");
            dynaRender("/view/register.ftl");
            return;
        }

        dynaRender("/view/login.ftl");
    }

}
