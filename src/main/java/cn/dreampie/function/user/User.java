package cn.dreampie.function.user;

import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.model.Model;
import com.jfinal.ext.plugin.tablebind.TableBind;

import java.util.Date;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "sec_user")
public class User extends Model<User> {
    public static User dao = new User();

    public User addUserInfo(UserInfo userInfo) {
        if (ValidateUtils.me().isNullOrEmpty(userInfo)) {
            userInfo = new UserInfo();
            userInfo.set("user_id", this.get("id"));
        }
        userInfo.set("created_at", new Date());
        userInfo.save();
        return this;
    }

    public User addRole(Role role) {
        if (ValidateUtils.me().isNullOrEmpty(role)) {
            role = Role.dao.findFirstBy("`role`.value='R_USER'");
            if (ValidateUtils.me().isNullOrEmpty(role)) {
                throw new NullPointerException("角色不存在");
            }
        }
        UserRole userRole = new UserRole();
        userRole.set("user_id", this.get("id"));
        userRole.set("role_id", role.get("id"));
        userRole.save();
        return this;
    }
}
