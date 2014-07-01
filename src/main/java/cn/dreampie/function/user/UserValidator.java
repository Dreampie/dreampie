package cn.dreampie.function.user;

import cn.dreampie.common.plugin.shiro.hasher.Hasher;
import cn.dreampie.common.plugin.shiro.hasher.HasherUtils;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.thread.ThreadLocalUtil;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 2014/6/10.
 */
public class UserValidator {

    public static class UserUpdatePwdValidator extends Validator {

        @Override
        protected void validate(Controller c) {

            boolean idEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("user.id"));
            if (idEmpty) addError("user_idMsg", "账户编号丢失");
            if (!idEmpty && !ValidateUtils.me().isPositiveNumber(c.getPara("user.id")))
                addError("user_idMsg", "账户编号必须为数字");

            if (ValidateUtils.me().isNullOrEmpty(User.dao.findBy("`user`.id=" + c.getPara("user.id"))))
                addError("user_idMsg", "账户不存在");

            boolean userEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("user.username"));
            if (userEmpty) addError("user_usernameMsg", "账户丢失");
            if (!userEmpty && !ValidateUtils.me().isUsername(c.getPara("user.username")))
                addError("user_usernameMsg", "账户为英文字母 、数字和下划线长度为5-18");

            boolean passwordEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("user.password"));
            if (passwordEmpty) addError("user_passwordMsg", "密码不能为空");
            if (!passwordEmpty && !ValidateUtils.me().isPassword(c.getPara("user.password")))
                addError("user_passwordMsg", "密码为英文字母 、数字和下划线长度为5-18");

            if (!passwordEmpty && !c.getPara("user.password").equals(c.getPara("repassword")))
                addError("repasswordMsg", "重复密码不匹配");


            boolean oldpasswordEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("oldpassword"));
            if (oldpasswordEmpty) addError("user_oldpasswordMsg", "原始密码不能为空");

            if (!oldpasswordEmpty && !ValidateUtils.me().isPassword(c.getPara("oldpassword")))
                addError("user_oldpasswordMsg", "密码为英文字母 、数字和下划线长度为5-18");

            if (!oldpasswordEmpty) {
                User user = SubjectUtils.me().getUser();

                if (user.getStr("hasher").equals(Hasher.DEFAULT.value())) {
                    boolean match = HasherUtils.me().match(c.getPara("oldpassword"), user.getStr("password"), Hasher.DEFAULT);

                    if (!match) {
                        addError("user_oldpasswordMsg", "原始密码不匹配");
                    }
                } else {
                    addError("user_oldpasswordMsg", "不支持的加密方式");
                }
            }
        }

        @Override
        protected void handleError(Controller c) {
            c.keepModel(User.class);
            c.keepPara();
            c.setAttr("state", "failure");
            if (ThreadLocalUtil.isJson())
                c.renderJson();
            else
                c.forwardAction("/user/center");
        }
    }
}
