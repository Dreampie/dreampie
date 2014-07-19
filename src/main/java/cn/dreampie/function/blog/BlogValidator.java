package cn.dreampie.function.blog;

import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.web.thread.ThreadLocalUtil;
import cn.dreampie.function.user.User;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by wangrenhui on 14-7-17.
 */
public class BlogValidator {

    public static class SaveValidator extends Validator {

        @Override
        protected void validate(Controller c) {

            boolean tagEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("blog.tag"));
            if (tagEmpty) addError("blog_tagMsg", "标签不能为空");

            boolean titleEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("blog.title"));
            if (titleEmpty) addError("blog_titleMsg", "标题不能为空");

            boolean bodyEmpty = ValidateUtils.me().isNullOrEmpty(c.getPara("blog.body"));
            if (bodyEmpty) addError("blog_bodyMsg", "内容不能为空");

        }

        @Override
        protected void handleError(Controller c) {
            c.keepModel(Blog.class);
            c.keepPara();
            c.setAttr("state", "failure");
            if (ThreadLocalUtil.isJson())
                c.renderJson();
            else
                c.forwardAction("/blog/search?" + c.getRequest().getQueryString());
        }
    }
}
