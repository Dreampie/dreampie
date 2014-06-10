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
@TableBind(tableName = "sec_role")
public class Role extends Model<Role> implements TreeNode<Role> {
    public static Role dao = new Role();

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
    public List<Role> getChildren() {
        return this.get("children");
    }

    @Override
    public void setChildren(List<Role> children) {
        this.put("children", children);
    }


    public void initPermissiones() {
        this.put("permissiones", Permission.dao.findByRole("", this.getInt("id")));
    }

    public List<Permission> getPermissiones() {
        return this.get("permissiones");
    }

    public Role addPermission(Permission permission) {
        if (ValidateUtils.me().isNullOrEmpty(permission)) {
            throw new NullPointerException("操作权限不存在");
        }
        RolePermission rolePermission = new RolePermission();
        rolePermission.set("role_id", this.get("id"));
        rolePermission.set("permission_id", permission.get("id"));
        rolePermission.save();

        return this;
    }

    public Role findByFirst(String where, Object... paras) {
        Role result = dao.findFirst(SqlKit.sql("role.findBy") + " " + where, paras);
        return result;
    }

    public List<Role> findBy(String where, Object... paras) {
        List<Role> result = dao.find(SqlKit.sql("role.findBy") + " " + where, paras);
        return result;
    }


    public List<Role> findByUser(String where, Object... paras) {
        if (!ValidateUtils.me().isNullOrEmpty(where)) {
            where = " AND " + where;
        }
        List<Role> result = dao.find(SqlKit.sql("role.findBySelect") + " " + SqlKit.sql("role.findByUserExceptSelect") + where, paras);
        return result;
    }

    public List<Role> findAll() {
        List<Role> result = dao.find(SqlKit.sql("role.findAll"));
        return result;
    }

    public boolean updateBy(String set, String where, Object... paras) {
        if (!ValidateUtils.me().isNullOrEmpty(where)) {
            where = " WHERE " + where;
        }
        return Db.update(SqlKit.sql("role.updateBy") + " " + set + where, paras) > 0;
    }

    public long countBy(String where, Object... paras) {
        long result = Db.queryFirst(SqlKit.sql("role.countBy") + " " + where, paras);
        return result;
    }
}
