package cn.dreampie.function.user;

import cn.dreampie.common.config.ReTurnType;
import cn.dreampie.common.thread.ThreadLocalUtil;
import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 2014/5/8.
 */
public class PermSaveValidator extends Validator {
    protected void validate(Controller c) {
        boolean pidEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("permission.pid"));
        if (pidEmpty) addError("permission_pidMsg", "父级id不能为空");
        if (!pidEmpty && !ValidateUtils.me().isPositiveNumber(c.getPara("permission.pid")))
            addError("permission_pidMsg", "父级id必须为整数");
        boolean nameEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("permission.name"));
        if (nameEmpty) addError("permission_nameMsg", "权限名称不能为空");
        if (!nameEmpty && !ValidateUtils.me().isLength(c.getPara("permission.name"), 2, 10))
            addError("permission_nameMsg", "权限名称长度2-10");

        boolean authKeyEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("permission.value"));
        if (authKeyEmpty) addError("permission_valueMsg", "权限名称不能为空");
        if (!authKeyEmpty && !ValidateUtils.me().isLength(c.getPara("permission.value"), 2, 20))
            addError("permission_valueMsg", "权限名称长度2-20");

        boolean urlEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("permission.url"));
        if (urlEmpty) addError("permission_urlMsg", "权限url不能为空");
        if (!urlEmpty && !ValidateUtils.me().match("^[\\w/\\*]+$",c.getPara("permission.url")))
            addError("permission_urlMsg", "权限url必须英文字母 、数字、*、下划线和右斜线");

        boolean introEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("permission.intro"));
        if (introEmpty) addError("permission_introMsg", "权限描述不能为空");
        if (!introEmpty && !ValidateUtils.me().isLength(c.getPara("permission.intro"), 3, 240))
            addError("permission_introMsg", "权限描述长度3-240");
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