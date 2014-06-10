package cn.dreampie.function.user;

import cn.dreampie.common.plugin.sqlinxml.SqlKit;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by wangrenhui on 14-4-22.
 */
@TableBind(tableName = "sec_user_role")
public class UserRole extends Model<UserRole> {
  public static UserRole dao = new UserRole();

    public List<String> findUserIds(String where, Object... paras) {
        List<String> result = Db.query("SELECT DISTINCT `userRole`.user_id " + SqlKit.sql("userRole.findByExceptSelect") + " " + where, paras);
        return result;
    }

    public boolean deleteBy(String where, Object... paras) {
        return Db.update(SqlKit.sql("userRole.deleteBy") + " " + where, paras) > 0;
    }
}
