package cn.dreampie.function.user;

import cn.dreampie.common.kit.sqlinxml.SqlKit;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "sec_user")
public class User extends Model<User> {
    public static User dao = new User();


    public List<User> findBy(String where, Object... paras) {
        List<User> result = (List<User>) dao.find(SqlKit.sql("user.findBy") + " " + where, paras);
        return result;
    }

    /**
     * 根据账号名查询账号
     *
     * @param userName
     * @return
     */
    public User findByUserName(String userName) {
        List<User> result = (List<User>) dao.find(SqlKit.sql("user.findBy") + " `user`.username =?", userName);
        if (result != null && result.size() > 0) {
            return result.get(0);
        } else {
            return null;
        }
    }
}
