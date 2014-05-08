package cn.dreampie.common.utils;


import cn.dreampie.common.config.CommonAttrs;
import cn.dreampie.common.shiro.CaptchaUsernamePasswordToken;
import cn.dreampie.common.utils.security.EncriptionUtils;
import cn.dreampie.function.user.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.subject.Subject;

/**
 * Created by wangrenhui on 14-4-24.
 */
public class SubjectUtils {

    private static SubjectUtils subjectUtils = new SubjectUtils();

    private SubjectUtils() {
    }

    public static SubjectUtils me() {
        return subjectUtils;
    }

    public Subject getSubject() {
        return SecurityUtils.getSubject();
    }

    public Session getSession() {
        Subject subject = SecurityUtils.getSubject();
        Session session = subject.getSession();
        if (session == null) {
            throw new UnknownSessionException("Unable found required Session");
        } else {
            return session;
        }
    }

    public User getUser() {
        Session session = getSession();
        Object user = session.getAttribute(CommonAttrs.CURRENT_USER);
        if (ValidateUtils.me().isNullOrEmpty(user))
            return null;
        else
            return (User) user;
    }

    public boolean login(String username, String password) {
        AuthenticationToken token = new UsernamePasswordToken(username, password);
        Subject currentUser = SecurityUtils.getSubject();
        try {
            currentUser.login(token);
            Session session = getSession();
            session.setAttribute(CommonAttrs.CURRENT_USER, User.dao.findBy("username=", username));
            return true;
        } catch (AuthenticationException e) {
            return false;
        }
    }

    public boolean doCaptcha(String captchaToken) {
        Session session = getSession();
        if (session.getAttribute(CommonAttrs.CAPTCHA_NAME) != null) {
            String captcha = session.getAttribute(CommonAttrs.CAPTCHA_NAME).toString();
            if (captchaToken != null &&
                    captcha.equalsIgnoreCase(EncriptionUtils.encrypt(captchaToken))) {
                return true;
            }
        }
        return false;
    }

    public boolean wasLogin() {
        Subject subject = getSubject();
        if (subject != null && subject.getPrincipal() != null && subject.isAuthenticated()) {
            return true;
        }
        return false;
    }
}
