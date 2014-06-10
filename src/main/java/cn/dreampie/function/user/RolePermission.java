package cn.dreampie.function.user;

import cn.dreampie.common.plugin.sqlinxml.SqlKit;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by wangrenhui on 14-4-22.
 */
@TableBind(tableName = "sec_role_permission")
public class RolePermission extends Model<RolePermission> {
  public static RolePermission dao = new RolePermission();


    public List<String> findPermissionIds(String where, Object... paras) {
        List<String> result = Db.query("SELECT DISTINCT `rolePermission`.permission_id " + SqlKit.sql("rolePermission.findByExceptSelect") + " " + where, paras);
        return result;
    }

    public boolean deleteBy(String where, Object... paras) {
        return Db.update(SqlKit.sql("rolePermission.deleteBy") + " " + where, paras) > 0;
    }
}
