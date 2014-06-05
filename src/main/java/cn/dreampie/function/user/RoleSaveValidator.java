package cn.dreampie.function.user;

import cn.dreampie.common.config.ReTurnType;
import cn.dreampie.common.thread.ThreadLocalUtil;
import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 2014/5/8.
 */
public class RoleSaveValidator extends Validator {
    protected void validate(Controller c) {
        boolean pidEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("role.pid"));
        if (pidEmpty) addError("role_pidMsg", "父级id不能为空");
        if (!pidEmpty && !ValidateUtils.me().isPositiveNumber(c.getPara("role.pid")))
            addError("role_pidMsg", "父级id必须为整数");
        
        boolean nameEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("role.name"));
        if (nameEmpty) addError("role_nameMsg", "角色名称不能为空");
        if (!nameEmpty && !ValidateUtils.me().isLength(c.getPara("role.name"), 2, 10))
            addError("role_nameMsg", "角色名称长度2-10");

        boolean valueEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("role.value"));
        if (valueEmpty) addError("role_valueMsg", "角色名称不能为空");
        if (!valueEmpty && !ValidateUtils.me().isLength(c.getPara("role.value"), 2, 20))
            addError("role_valueMsg", "角色名称长度2-20");


        boolean introEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("role.intro"));
        if (introEmpty) addError("role_introMsg", "角色描述不能为空");
        if (!introEmpty && !ValidateUtils.me().isLength(c.getPara("role.intro"), 3, 240))
            addError("role_introMsg", "角色描述长度3-240");
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