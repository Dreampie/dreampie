package cn.dreampie.function.user;

import cn.dreampie.common.plugin.sqlinxml.SqlKit;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.model.Model;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Page;

import java.util.Date;

/**
 * Created by wangrenhui on 14-1-3.
 */
@TableBind(tableName = "contacts")
public class Contacts extends Model<Contacts> {
    public static Contacts dao = new Contacts();


    public Contacts addUser(User user, String intro) {
        if (ValidateUtils.me().isNullOrEmpty(user)) {
            throw new NullPointerException("请传入联系人");
        }
        Contacts contacts = new Contacts();
        contacts.set("user_id", this.get("id"));
        contacts.set("link_id", user.get("id"));
        contacts.set("intro", intro);
        contacts.save();
        return this;
    }

    public Page<Contacts> paginateInfoBy(int pageNumber, int pageSize, String where, Object... paras) {
        Page<Contacts> result = dao.paginate(pageNumber, pageSize, SqlKit.sql("contacts.findInfoBySelect"), SqlKit.sql("contacts.findInfoByExceptSelect") + getWhere(where), paras);
        return result;
    }

}
