package cn.dreampie.common.plugin.shiro;

import junit.framework.TestCase;
import org.apache.shiro.authc.credential.DefaultPasswordService;
import org.apache.shiro.authc.credential.PasswordService;
import org.apache.shiro.util.AntPathMatcher;
import org.junit.Test;

/**
 * Created by wangrenhui on 14-1-5.
 */
public class MyPasswordMatcherTest extends TestCase {
    @Test
    public void testEncryptPassword() {
        AntPathMatcher antPathMatcher=new AntPathMatcher();
        System.out.println(antPathMatcher.match("/**/*.ftl","/a.ftl"));
        PasswordService passwordService = new DefaultPasswordService();
        System.out.println("admin:" + passwordService.encryptPassword("dreampie"));
    }


}
