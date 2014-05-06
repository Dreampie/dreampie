package cn.dreampie.common.shiro.hasher;

import org.apache.shiro.authc.credential.DefaultPasswordService;
import org.apache.shiro.authc.credential.PasswordService;

/**
 * Created by wangrenhui on 14-5-5.
 */
public class HasherUtils {

  private static HasherUtils hasherUtils = new HasherUtils();

  private HasherUtils() {
  }

  public static HasherUtils me() {
    return hasherUtils;
  }

  public HasherInfo hash(String hashText, Hasher hasher) {
    HasherInfo hasherInfo = null;
    if (hasher == Hasher.DEFAULT) {
      PasswordService passwordService = new DefaultPasswordService();
      hasherInfo = new HasherInfo(hashText, passwordService.encryptPassword(hashText), hasher, "");
    }
    return hasherInfo;
  }
}
