package cn.dreampie.function.blog;

import cn.dreampie.common.web.controller.Controller;

import java.util.List;

/**
 * Created by wangrenhui on 2014/7/14.
 */
public class BlogController extends Controller {

    public void index() {
        List<Blog> blogs = Blog.dao.findAll();
        setAttr("blogs", blogs);
        dynaRender("/view/blog/index.ftl");
    }
}
