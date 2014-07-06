package cn.dreampie.common.utils;


import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.utils.security.EncriptionUtils;
import cn.dreampie.function.user.User;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.subject.Subject;

/**
 * Created by wangrenhui on 14-4-24.
 */
public class SubjectUtils {

    private static SubjectUtils subjectUtils = new SubjectUtils();

    private static String[] baseRole = new String[]{"R_ADMIN", "R_MANAGER", "R_MEMBER", "R_USER"};

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
        Object user = session.getAttribute(AppConstants.CURRENT_USER);
        if (ValidateUtils.me().isNullOrEmpty(user))
            return null;
        else
            return (User) user;
    }

    public boolean login(String username, String password) {
        return login(username, password, false);
    }

    public boolean login(String username, String password, boolean rememberMe) {
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        try {
            token.setRememberMe(rememberMe);
            SecurityUtils.getSubject().login(token);
            Session session = getSession();
            session.setAttribute(AppConstants.CURRENT_USER, User.dao.findBy("username=?", username));
            return true;
        } catch (AuthenticationException e) {
            return false;
        }
    }

    public boolean doCaptcha(String captchaToken) {
        Session session = getSession();
        if (session.getAttribute(AppConstants.CAPTCHA_NAME) != null) {
            String captcha = session.getAttribute(AppConstants.CAPTCHA_NAME).toString();
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

    public boolean wasBaseRole(String roleValue) {

        if (ArrayUtils.contains(baseRole, roleValue)) {
            return true;
        }
        return false;
    }
}
