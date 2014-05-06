package cn.dreampie.function.user;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

/**
 * Created by wangrenhui on 14-4-22.
 */
@TableBind(tableName = "sec_user_role")
public class UserRole extends Model<UserRole> {
  public static UserRole dao = new UserRole();
}
