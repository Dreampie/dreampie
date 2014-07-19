package cn.dreampie.function.blog;

import cn.dreampie.common.plugin.sqlinxml.SqlKit;
import cn.dreampie.common.web.model.Model;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Page;

/**
 * Created by wangrenhui on 2014/7/14.
 */
@TableBind(tableName = "blog")
public class Blog extends Model<Blog> {
    public static Blog dao = new Blog();

    public Page<Blog> paginateInfoBy(int pageNumber, int pageSize, String where, Object... paras) {
        Page<Blog> result = dao.paginate(pageNumber, pageSize, SqlKit.sql("blog.findInfoBySelect"), SqlKit.sql("blog.findInfoByExceptSelect") + getWhere(where), paras);
        return result;
    }

    public Blog findFirstInfoBy(String where, Object... paras) {
        Blog result = dao.findFirst(SqlKit.sql("blog.findInfoBySelect") + SqlKit.sql("blog.findInfoByExceptSelect") + getWhere(where), paras);
        return result;
    }

    public Blog findNextInfoBy(String where, Object... paras) {
        Blog result = dao.findFirst(SqlKit.sql("blog.findInfoBySelect") + SqlKit.sql("blog.findInfoByExceptSelect") + getNextSql(where), paras);
        return result;
    }

    public Blog findPreviousInfoBy(String where, Object... paras) {
        Blog result = dao.findFirst(SqlKit.sql("blog.findInfoBySelect") + SqlKit.sql("blog.findInfoByExceptSelect") + getPreviousSql(where), paras);
        return result;
    }
}
