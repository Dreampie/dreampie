package cn.dreampie.common.controller;

/**
 * Created by wangrenhui on 2014/6/9.
 */
public class DemoController extends Controller {

    public void chat() {
        dynaRender("/page/demo/chat.ftl");
    }
}
