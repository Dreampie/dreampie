package cn.dreampie.common.interceptor;

import cn.dreampie.common.thread.ThreadLocalUtil;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Const;
import com.jfinal.core.Controller;
import com.jfinal.i18n.I18N;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by wangrenhui on 14-4-16.
 */
public class UrlInterceptor implements Interceptor {
    @Override
    public void intercept(ActionInvocation ai) {
        ai.invoke();
        Controller controller = ai.getController();
        HttpServletRequest request = controller.getRequest();
        //webRoot
        controller.setAttr("webRootPath", request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + request.getContextPath());
        if (!ThreadLocalUtil.isAjax()) {
            //local 数据
            controller.setAttr("localParas", request.getQueryString());
            controller.setAttr("localUri", ai.getActionKey());
        }
        //i18n
        String tmp = controller.getCookie(Const.I18N_LOCALE);
        String i18n = controller.getRequest().getLocale().toString();
        if (!i18n.equals(tmp)) {
            ai.getController().setCookie(Const.I18N_LOCALE, i18n, Const.DEFAULT_I18N_MAX_AGE_OF_COOKIE);
        }

    }
}
