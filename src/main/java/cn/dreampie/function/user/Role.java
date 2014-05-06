package cn.dreampie.function.user;

import cn.dreampie.common.kit.sqlinxml.SqlKit;
import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "sec_role")
public class Role extends Model<Role> {
  public static Role dao = new Role();


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
    List<Role> result = dao.find(SqlKit.sql("role.findBySelect") + " " + SqlKit.sql("role.findByUserExceptSelect") + " AND " + where, paras);
    return result;
  }

  public List<Role> findAll() {
    List<Role> result = dao.find(SqlKit.sql("role.findAll"));
    return result;
  }
}
