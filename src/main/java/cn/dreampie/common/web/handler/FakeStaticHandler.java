package cn.dreampie.common.web.handler;

import cn.dreampie.common.web.thread.ThreadLocalUtil;
import com.jfinal.handler.Handler;
import com.jfinal.i18n.I18N;
import com.jfinal.kit.PathKit;
import com.jfinal.kit.StrKit;
import com.jfinal.render.RenderFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

/**
 * Created by wangrenhui on 14-1-5.
 */
public class FakeStaticHandler extends Handler {

    private static final Logger log = LoggerFactory.getLogger(FakeStaticHandler.class);
    /**
     * 基础文件目录
     */
    private String baseUrl;
    /**
     * 禁止直接访问的动态文件后缀
     */
    private String viewPostfix;

    /**
     * 拒绝访问的目录
     */
    private String accessDeniedFix;
    /**
     * 资源文件目录
     */
    private String[] resourceDir;

    /**
     * 跳过的url
     */
    private String[] skipUrls;

    public FakeStaticHandler() {
    }

    public FakeStaticHandler(String viewPostfix) {
        if (StrKit.isBlank(viewPostfix))
            throw new IllegalArgumentException("viewPostfix can not be blank.");
        this.viewPostfix = viewPostfix;
    }

    public FakeStaticHandler(String baseUrl, String viewPostfix) {
        this(viewPostfix);
        if (StrKit.isBlank(baseUrl))
            throw new IllegalArgumentException("baseUrl can not be blank.");
        if (baseUrl.endsWith("/"))
            this.baseUrl = baseUrl.substring(0, baseUrl.length() - 1);
        else
            this.baseUrl = baseUrl;

    }

    public FakeStaticHandler(String baseUrl, String viewPostfix, String accessDeniedFix, String[] resourceDir) {
        this(baseUrl, viewPostfix);

        if (StrKit.isBlank(accessDeniedFix))
            throw new IllegalArgumentException("viewPostfix can not be blank.");
        else {
            if (!accessDeniedFix.endsWith("/"))
                this.accessDeniedFix += "/";
            if (!accessDeniedFix.startsWith("/")) {
                this.accessDeniedFix = "/" + this.accessDeniedFix;
            }
        }
        this.resourceDir = resourceDir;
    }

    public FakeStaticHandler(String baseUrl, String viewPostfix, String accessDeniedFix, String[] resourceDir, String[] skipUrls) {
        this(baseUrl, viewPostfix, accessDeniedFix, resourceDir);
        this.skipUrls = skipUrls;
    }

    public void handle(String target, HttpServletRequest request, HttpServletResponse response, boolean[] isHandled) {
        target = target.replace(";JESSIONID", "?JESSIONID");

        //i18n不支持json
        if (!ThreadLocalUtil.isJson())
            request.setAttribute("i18n", I18N.me());

        //判断是否是资源文件
        if (!checkResource(target)) {

            if (checkSkip(target)) {
                return;
            }

            if ((!StrKit.isBlank(viewPostfix) && target.endsWith(viewPostfix)) || (!StrKit.isBlank(accessDeniedFix) && target.contains(accessDeniedFix))) {
                isHandled[0] = true;
                RenderFactory.me().getErrorRender(403).setContext(request, response).render();
                return;
            }

            if ((!StrKit.isBlank(baseUrl) && target.contains(baseUrl))) {
                isHandled[0] = true;
                RenderFactory.me().getErrorRender(404).setContext(request, response).render();
                return;
            }
            if (target.contains(".")) {
                String fullFile = PathKit.getWebRootPath() + baseUrl + target;
                File file = new File(fullFile);
                if (!file.exists()) {
                    isHandled[0] = true;
                    RenderFactory.me().getErrorRender(404).setContext(request, response).render();
                    return;
                } else {
                    target = baseUrl + target;
                }
            }
        }
        nextHandler.handle(target, request, response, isHandled);
    }

    /**
     * 判断是否是静态的资源文件
     *
     * @param resouceUrl
     * @return
     */
    public boolean checkResource(String resouceUrl) {
        if (resourceDir != null && resourceDir.length > 0) {
            for (String dir : resourceDir) {
                if (resouceUrl.contains(dir)) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean checkSkip(String skipUrl) {
        if (skipUrls != null && skipUrls.length > 0) {
            for (String url : skipUrls) {
                if (skipUrl.startsWith(url)) {
                    return true;
                }
            }
        }
        return false;
    }
}
