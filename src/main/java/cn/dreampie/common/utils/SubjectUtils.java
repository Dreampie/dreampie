package cn.dreampie.common.utils;


import cn.dreampie.common.config.CommonAttrs;
import cn.dreampie.function.user.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
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
    return subject.getSession();
  }

  public User getUser() {
    Session session = getSession();
    Object user = session.getAttribute(CommonAttrs.CURRENT_USER);
    if (ValidateUtils.me().isNullOrEmpty(user))
      return null;
    else
      return (User) user;
  }
}
