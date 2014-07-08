package cn.dreampie.common.web.filter;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.utils.SubjectUtils;
import cn.dreampie.common.web.thread.ThreadLocalUtil;
import cn.dreampie.function.user.User;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by wangrenhui on 13-12-31.
 */
public class CommonFilter extends HttpFilter {
    /**
     * 过滤字符和数据本地化存储
     *
     * @param request
     * @param response
     * @param chain
     */
    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

//        request.setCharacterEncoding(AppConstants.DEFAULT_ENCODING);
//        response.setCharacterEncoding(AppConstants.DEFAULT_ENCODING);

//    response.setHeader("Access-Control-Allow-Origin", "http://" + request.getServerName());
//    response.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS");
//    response.setHeader("Access-Control-Max-Age", "360");
//    String reqHead = request.getHeader("Access-Control-Request-Headers");
//    if (null != reqHead && !reqHead.equals(null)) {
//      response.setHeader("Access-Control-Allow-Headers", reqHead);
//    }
////    response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
//    response.setHeader("Access-Control-Allow-Credentials", "true");
        //请求数据本地化
        ThreadLocalUtil.init(request, response);

        chain.doFilter(request, response);
    }
}
