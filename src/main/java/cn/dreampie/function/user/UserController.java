package cn.dreampie.function.user;

import cn.dreampie.common.controller.Controller;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class UserController extends Controller {

    public void index() {
        dynaRender("/page/index.ftl");
    }
}
