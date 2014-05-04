package cn.dreampie.common.shiro;

import junit.framework.TestCase;
import org.apache.shiro.authc.credential.DefaultPasswordService;
import org.apache.shiro.authc.credential.PasswordService;
import org.junit.Test;

/**
 * Created by wangrenhui on 14-1-5.
 */
public class MyPasswordMatcherTest extends TestCase {
    @Test
    public void testEncryptPassword() {
        PasswordService passwordService = new DefaultPasswordService();
        System.out.println("admin:" + passwordService.encryptPassword("user"));
    }
}
