package cn.dreampie.function.user;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.ehcache.CacheNameRemove;
import cn.dreampie.common.plugin.shiro.hasher.Hasher;
import cn.dreampie.common.plugin.shiro.hasher.HasherInfo;
import cn.dreampie.common.plugin.shiro.hasher.HasherUtils;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.controller.Controller;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class UserController extends Controller {

    public void index() {
        dynaRender("/page/user/index.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({UserValidator.UserUpdatePwdValidator.class, Tx.class})
    public void updatePwd() {
        keepModel(User.class);
        User upUser = getModel(User.class);

        HasherInfo passwordInfo = HasherUtils.me().hash(upUser.getStr("password"), Hasher.DEFAULT);
        upUser.set("password", passwordInfo.getHashResult());
        upUser.set("hasher", passwordInfo.getHasher().value());
        upUser.set("salt", passwordInfo.getSalt());

        if (upUser.update()) {
            SubjectUtils.me().getSubject().logout();
            setAttr("username", upUser.get("username"));
            setAttr("state", "success");
        } else
            setAttr("state", "failure");
        dynaRender("/page/user/center.ftl");
    }

    public void center() {
        User user = SubjectUtils.me().getUser();
        if (!ValidateUtils.me().isNullOrEmpty(user)) {
            setAttr("user", user);
        }
        dynaRender("/page/user/center.ftl");
    }
}
