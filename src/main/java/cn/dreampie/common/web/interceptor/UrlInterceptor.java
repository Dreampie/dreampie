package cn.dreampie.common.web.interceptor;

import cn.dreampie.common.web.thread.ThreadLocalUtil;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Const;
import com.jfinal.core.Controller;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by wangrenhui on 14-4-16.
 */
public class UrlInterceptor implements Interceptor {
    @Override
    public void intercept(ActionInvocation ai) {
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
        ai.invoke();
        controller.keepPara("webRootPath", "localParas", "localUri");
        //i18n
        String tmp = controller.getCookie(Const.I18N_LOCALE);
        String i18n = controller.getRequest().getLocale().toString();
        if (!i18n.equals(tmp)) {
            ai.getController().setCookie(Const.I18N_LOCALE, i18n, Const.DEFAULT_I18N_MAX_AGE_OF_COOKIE);
        }

    }
}
