package cn.dreampie.function.user;

import cn.dreampie.common.kit.sqlinxml.SqlKit;
import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "sec_permission")
public class Permission extends Model<Permission> {
    public static Permission dao = new Permission();

    public List<Permission> findBy(String where, Object... paras) {
        List<Permission> result = (List<Permission>) dao.find(SqlKit.sql("permission.findBy") + " " + where, paras);
        return result;
    }

    public List<Permission> findByRole(String where, Object... paras) {
        if (!ValidateUtils.me().isNullOrEmpty(where)) {
            where = " AND " + where;
        }
        List<Permission> result = (List<Permission>) dao.find(SqlKit.sql("permission.findBySelect") + " " + SqlKit.sql("permission.findByRoleExceptSelect") + where, paras);
        return result;
    }
}
