package cn.dreampie.function.blog;

import cn.dreampie.common.web.controller.Controller;

/**
 * Created by wangrenhui on 2014/7/14.
 */
public class BlogController extends Controller {

    public void index(){
        dynaRender("/view/blog/index.ftl");
    }
}
