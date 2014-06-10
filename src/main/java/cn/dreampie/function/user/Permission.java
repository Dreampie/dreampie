package cn.dreampie.function.user;

import cn.dreampie.common.plugin.sqlinxml.SqlKit;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.utils.tree.TreeNode;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "sec_permission")
public class Permission extends Model<Permission> implements TreeNode<Permission> {
    public static Permission dao = new Permission();


    @Override
    public long getId() {
//        return this.id;
        return this.getLong("id");
    }

    @Override
    public long getParentId() {
//        return this.parentId;
        return this.getLong("pid");
    }

    @Override
    public List<Permission> getChildren() {
        return this.get("children");
    }

    @Override
    public void setChildren(List<Permission> children) {
        this.put("children", children);
    }

    public Permission findByFirst(String where, Object... paras) {
        Permission result = dao.findFirst(SqlKit.sql("permission.findBy") + " " + where, paras);
        return result;
    }

    public List<Permission> findBy(String where, Object... paras) {
        List<Permission> result = dao.find(SqlKit.sql("permission.findBy") + " " + where, paras);
        return result;
    }

    public List<Permission> findByRole(String where, Object... paras) {
        if (!ValidateUtils.me().isNullOrEmpty(where)) {
            where = " AND " + where;
        }
        List<Permission> result = dao.find(SqlKit.sql("permission.findBySelect") + " " + SqlKit.sql("permission.findByRoleExceptSelect") + where, paras);
        return result;
    }

    public List<Permission> findAll() {
        List<Permission> result = dao.find(SqlKit.sql("permission.findAll"));
        return result;
    }

    public boolean updateBy(String set, String where, Object... paras) {
        if (!ValidateUtils.me().isNullOrEmpty(where)) {
            where = " WHERE " + where;
        }
        return Db.update(SqlKit.sql("permission.updateBy") + " " + set + where, paras) > 0;
    }

    public long countBy(String where, Object... paras) {
        long result = Db.queryFirst(SqlKit.sql("permission.countBy") + " " + where, paras);
        return result;
    }
}
