package cn.dreampie.function.blog;

import cn.dreampie.common.web.model.Model;
import com.jfinal.ext.plugin.tablebind.TableBind;

/**
 * Created by wangrenhui on 2014/7/14.
 */
@TableBind(tableName = "blog_reply")
public class BlogReply extends Model<BlogReply> {
    public static BlogReply dao = new BlogReply();
}
