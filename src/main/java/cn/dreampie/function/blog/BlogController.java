package cn.dreampie.function.blog;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.ehcache.CacheNameRemove;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.function.user.AdminValidator;
import cn.dreampie.function.user.User;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.jfinal.plugin.ehcache.CacheName;

import java.util.Date;
import java.util.List;

/**
 * Created by wangrenhui on 2014/7/14.
 */
public class BlogController extends Controller {
    private static String NORMAL = "`blog`.completed=0 AND `blog`.opened=0 AND `blog`.deleted_at is null";

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void index() {
        //非草稿 完全公开的  未删除博客
        Page<Blog> blogs = Blog.dao.paginateInfoBy(getParaToInt(0, 1), getParaToInt("pageSize", 15), NORMAL + " ORDER BY `blog`.created_at DESC,`blog`.topped DESC");
        setAttr("blogs", blogs);
        List<Blog> hots = Blog.dao.findTopBy(8, NORMAL + " ORDER BY `blog`.hit_count DESC");
        setAttr("hots", hots);
        List<Blog> tops = Blog.dao.findTopBy(8, NORMAL + " ORDER BY `blog`.created_at DESC");
        setAttr("tops", tops);
        dynaRender("/view/blog/index.ftl");
    }

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void search() {
        keepPara("blog_search");
        String blog_search = getPara("blog_search");
        String where = "";
        if (!ValidateUtils.me().isNullOrEmpty(blog_search)) {
            where += " AND (INSTR(`blog`.title,'" + blog_search + "')>0 OR  INSTR(`blog`.body,'" + blog_search + "')>0 "
                    + "OR  INSTR(`blog`.tags,'" + blog_search + "')>0 OR  INSTR(`user`.full_name,'" + blog_search + "')>0) ";
        } else {
            String tags = getPara("tags");

            if (!ValidateUtils.me().isNullOrEmpty(tags)) {
                where += " AND INSTR(`blog`.tags,'" + tags + "')>0";
            }
        }

        //非草稿 完全公开的  未删除博客
        Page<Blog> blogs = Blog.dao.paginateInfoBy(getParaToInt(0, 1), getParaToInt("pageSize", 15), NORMAL + where + " ORDER BY `blog`.created_at DESC,`blog`.topped DESC");
        setAttr("blogs", blogs);
        dynaRender("/view/blog/search.ftl");
    }

    public void edit() {
        dynaRender("/view/blog/edit.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({BlogValidator.SaveValidator.class, Tx.class})
    public void save() {
        Blog blog = getModel(Blog.class);
        User user = SubjectUtils.me().getUser();
        blog.set("user_id", user.get("id"));
        blog.set("created_at", new Date());
        if (blog.save()) {
            setAttr("blog", blog);
        }
        dynaRender("/view/blog/detail.ftl");
    }

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void detail() {
        Integer id = getParaToInt(0);

        Integer near = getParaToInt("near");
        if (id > 0) {
            Blog blog = null;
            if (near != null) {
                if (near > 0) {
                    blog = Blog.dao.findNextInfoBy(NORMAL.replace("`blog`", "`_blog`") + " AND `_blog`.id>" + id);
                } else if (near < 0) {
                    blog = Blog.dao.findPreviousInfoBy(NORMAL.replace("`blog`", "`_blog`") + " AND `_blog`.id<" + id);
                }
            } else {
                blog = Blog.dao.findFirstInfoBy("`blog`.id=" + id);
            }
            if (blog != null) {
                blog.set("hit_count", blog.getInt("hit_count") + 1);
                blog.update();
                setAttr("blog", blog);
            }
        }
        List<Blog> hots = Blog.dao.findTopBy(8, NORMAL + " ORDER BY `blog`.hit_count DESC");
        setAttr("hots", hots);
        List<Blog> tops = Blog.dao.findTopBy(8, NORMAL + " ORDER BY `blog`.created_at DESC");
        setAttr("tops", tops);
        dynaRender("/view/blog/detail.ftl");
    }

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void user() {
        Integer userid = getParaToInt(0);

        if (userid > 0) {
            Page<Blog> blogs = Blog.dao.paginateInfoBy(getParaToInt(0, 1), getParaToInt("pageSize", 15), "`blog`.user_id=" + userid + " AND `blog`.completed=0 AND `blog`.opened=0 AND `blog`.deleted_at is null ORDER BY `blog`.created_at DESC,`blog`.topped DESC");
            if (!ValidateUtils.me().isNullOrEmpty(blogs)) {
                setAttr("blogs", blogs);
            }
        }
        dynaRender("/view/blog/user.ftl");
    }
}
