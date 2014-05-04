package cn.dreampie.function.user;

import cn.dreampie.common.controller.Controller;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class AdminController extends Controller {
    public void index() {
        dynaRender("/page/admin/index.ftl");
    }
}
