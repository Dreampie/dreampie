package cn.dreampie.function.blog;

import cn.dreampie.common.web.model.Model;
import com.jfinal.ext.plugin.tablebind.TableBind;

/**
 * Created by wangrenhui on 2014/7/14.
 */
@TableBind(tableName = "blog")
public class Blog extends Model<Blog> {
    public static Blog dao = new Blog();
}
