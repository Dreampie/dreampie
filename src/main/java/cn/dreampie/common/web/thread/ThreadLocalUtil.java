package cn.dreampie.common.web.thread;

import cn.dreampie.common.config.ReTurnType;
import com.jfinal.log.Logger;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by wangrenhui on 13-12-31.
 */
public class ThreadLocalUtil {
    protected static final Logger logger = Logger.getLogger(ThreadLocalUtil.class);
    // request线程对象
    private static ThreadLocal<HttpServletRequest> requestLocal = new ThreadLocal<HttpServletRequest>();
    // response线程对象
    private static ThreadLocal<HttpServletResponse> responseLocal = new ThreadLocal<HttpServletResponse>();

    public static void init(HttpServletRequest request, HttpServletResponse response) {
        setRequest(request);
        setResponse(response);
    }

    public static HttpServletRequest getRequest() {
        return (HttpServletRequest) requestLocal.get();
    }

    public static void setRequest(HttpServletRequest request) {
        requestLocal.set(request);
    }

    public static HttpServletResponse getResponse() {
        return (HttpServletResponse) responseLocal.get();
    }

    public static void setResponse(HttpServletResponse response) {
        responseLocal.set(response);
    }

    public static HttpSession getSession() {
        if (requestLocal.get() != null) {
            return (HttpSession) ((HttpServletRequest) requestLocal.get())
                    .getSession();
        } else {
            return null;
        }
    }

    public static ServletContext getServletContex() {
        if (requestLocal.get() != null) {
            return (ServletContext) ((HttpServletRequest) requestLocal.get())
                    .getServletContext();
        } else {
            return null;
        }
    }

    /**
     * 获取返回值类型
     *
     * @return
     */
    public static ReTurnType returnType() {
        HttpServletRequest request = getRequest();
        if (request != null) {
            String header = request.getHeader("X-Requested-With");
            if ((("XMLHttpRequest").equalsIgnoreCase(header) ||
                    ("json").equalsIgnoreCase(request.getParameter("returnType")))) {// 如果是ajax请求响应头会有，x-requested-with；
//      response.setHeader("sessionstatus", "timeout");
                return ReTurnType.JSON;
            }
        }
        return ReTurnType.PAGE;
    }

    public static boolean isAjax() {
        HttpServletRequest request = getRequest();
        
        if (request != null && ("XMLHttpRequest").equalsIgnoreCase(request.getHeader("X-Requested-With"))) {
            return true;
        }
        return false;
    }

    public static boolean isJson() {
        if (returnType() == ReTurnType.JSON) {
            return true;
        }
        return false;
    }
}