package cn.dreampie.common.controller;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 14-1-2.
 */
public class RegisterValidator extends Validator {
  protected void validate(Controller c) {
    validateRequiredString("user.user", "userMsg", "请输入用户名");
    validateRequiredString("user.password", "passMsg", "请输入密码");
    validateEqualField("user.password", "repassword", "repassMsg", "重复密码不一致");
    validateEmail("user.email", "emailMsg", "邮箱格式验证失败");
  }

  protected void handleError(Controller c) {
    c.keepPara("user.user", "user.email");
    c.render("/page/register.html");
  }
}