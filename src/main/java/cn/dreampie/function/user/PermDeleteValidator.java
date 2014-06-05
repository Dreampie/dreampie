package cn.dreampie.function.user;

import cn.dreampie.common.config.ReTurnType;
import cn.dreampie.common.thread.ThreadLocalUtil;
import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 14-4-22.
 */
public class PermDeleteValidator extends Validator {

    protected void validate(Controller c) {
        boolean idEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("permission.id"));
        if (idEmpty) addError("permission_idMsg", "权限id不能为空");
        boolean idNum = ValidateUtils.me().isPositiveNumber(c.getPara("permission.id"));
        if (!idEmpty && !idNum) addError("permission_idMsg", "权限id必须为正整数");
        if (!idEmpty && idNum) {
            Permission permission = Permission.dao.findById(c.getPara("permission.id"));
            if (ValidateUtils.me().isNullOrEmpty(permission)) addError("permission_idMsg", "权限不存在");
            long childrenCount = Permission.dao.countBy("`permission`.pid=" + c.getPara("permission.id"));
            if (childrenCount > 0) addError("permission_idMsg", "删除当前权限，必须先删除子权限");

        }

    }

    protected void handleError(Controller c) {
        c.keepModel(Permission.class);
        c.keepPara();
        c.setAttr("state", "failure");
        if (ThreadLocalUtil.returnType() == ReTurnType.JSON)
            c.renderJson();
        else
            c.forwardAction("/admin/role");
    }
}
