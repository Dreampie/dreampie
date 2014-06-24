package cn.dreampie.common.web.handler;

import cn.dreampie.common.web.thread.ThreadLocalUtil;
import com.jfinal.handler.Handler;
import com.jfinal.i18n.I18N;
import com.jfinal.kit.PathKit;
import com.jfinal.kit.StrKit;
import com.jfinal.render.RenderFactory;
import org.apache.shiro.util.AntPathMatcher;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

/**
 * Created by wangrenhui on 14-1-5.
 */
public class FakeStaticHandler extends Handler {

    public static AntPathMatcher antPathMatcher = new AntPathMatcher();

    @Override
    public void handle(String target, HttpServletRequest request, HttpServletResponse response, boolean[] isHandled) {
        target = target.replace(";JESSIONID", "?JESSIONID");

        //i18n不支持json
        if (!ThreadLocalUtil.isJson())
            request.setAttribute("i18n", I18N.me());

        nextHandler.handle(target, request, response, isHandled);
    }
}
