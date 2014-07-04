package cn.dreampie.function.user;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.ehcache.CacheNameRemove;
import cn.dreampie.common.plugin.shiro.hasher.Hasher;
import cn.dreampie.common.plugin.shiro.hasher.HasherInfo;
import cn.dreampie.common.plugin.shiro.hasher.HasherUtils;
import cn.dreampie.common.utils.SortUtils;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.function.common.State;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;

import java.util.List;
import java.util.Map;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class UserController extends Controller {

    public void index() {
        dynaRender("/view/user/index.ftl");
    }

    public void contacts() {
        User user = SubjectUtils.me().getUser();
        keepPara("user_search");

        //只能查询当前用户以下的角色
        String where = " `contacts`.user_id = " + user.get("id");
        String user_search = getPara("user_search");
        if (!ValidateUtils.me().isNullOrEmpty(user_search)) {
            where += " AND (INSTR(`contacts`.intro,'" + user_search + "')>0 "
                    + "OR INSTR(`contacts`.created_at,'" + user_search + "')>0 OR INSTR(`user`.full_name,'" + user_search + "')>0 "
                    + "OR  INSTR(`user`.mobile,'" + user_search + "')>0 OR  INSTR(`province`.name,'" + user_search + "')>0 "
                    + "OR  INSTR(`city`.name,'" + user_search + "')>0 OR  INSTR(`county`.name,'" + user_search + "')>0 "
                    + "OR INSTR(`userInfo`.street,'" + user_search + "')>0 OR INSTR(`userInfo`.zip_code,'" + user_search + "')>0) ";
        }
//        String start_at = getPara("start_at");
//        if (ValidateUtils.me().isDateTime(start_at)) {
//            where += " AND `user`.created_at >= '" + start_at + "'";
//        }
//
//        String end_at = getPara("end_time");
//        if (ValidateUtils.me().isDateTime(end_at)) {
//            where += " AND `user`.created_at <= '" + end_at + "'";
//        }
//
//        Boolean deleted = getParaToBoolean("deleted");
//        if (!ValidateUtils.me().isNullOrEmpty(deleted) && deleted) {
//            where += " AND `user`.deleted_at is not null";
//        } else {
//            where += " AND `user`.deleted_at is null";
//        }


        Page<Contacts> contacts = Contacts.dao.paginateInfoBy(getParaToInt(0, 1), getParaToInt(1, 15), where);
        Map userGroup = SortUtils.me().sort(contacts.getList(), "last_name");

        setAttr("users", contacts);
        setAttr("userGroup", userGroup);
        setAttr("userStates", State.dao.findBy("`state`.type='user.state'"));
        dynaRender("/view/user/contacts.ftl");
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
        dynaRender("/view/user/center.ftl");
    }

    public void center() {
        User user = SubjectUtils.me().getUser();
        if (!ValidateUtils.me().isNullOrEmpty(user)) {
            setAttr("user", user);
        }
        dynaRender("/view/user/center.ftl");
    }
}
