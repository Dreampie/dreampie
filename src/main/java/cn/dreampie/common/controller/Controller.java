package cn.dreampie.common.controller;

import cn.dreampie.common.config.ReTurnType;
import cn.dreampie.common.patchca.PatchcaRender;
import cn.dreampie.common.thread.ThreadLocalUtil;
import com.jfinal.aop.Before;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

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
    render("/page/index.ftl");
  }

  /**
   * 登录页
   */
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

  }


}
