package cn.dreampie.function.user;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

/**
 * Created by wangrenhui on 14-4-22.
 */
@TableBind(tableName = "sec_role_permission")
public class RolePermission extends Model<RolePermission> {
  public static RolePermission dao = new RolePermission();
}
