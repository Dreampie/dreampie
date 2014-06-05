package cn.dreampie.function.user;

import cn.dreampie.common.config.ReTurnType;
import cn.dreampie.common.thread.ThreadLocalUtil;
import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 14-4-22.
 */
public class RolePermsValidator extends Validator {

    protected void validate(Controller c) {
        boolean idEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("role.id"));
        if (idEmpty) addError("role_idMsg", "角色id不能为空");
        boolean idNum = ValidateUtils.me().isPositiveNumber(c.getPara("role.id"));
        if (!idEmpty && !idNum) addError("role_idMsg", "角色id必须为正整数");
        if (!idEmpty && idNum) {
            Role role = Role.dao.findById(c.getPara("role.id"));
            if (ValidateUtils.me().isNullOrEmpty(role)) addError("role_idMsg", "角色不存在");
        }

    }

    protected void handleError(Controller c) {
        c.keepModel(Role.class);
        c.keepPara();
        c.setAttr("state", "failure");
        if (ThreadLocalUtil.returnType() == ReTurnType.JSON)
            c.renderJson();
        else
            c.forwardAction("/admin/role");
    }
}
