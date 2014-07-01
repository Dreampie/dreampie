/**
 * @create_time 2012-4-27 上午11:17:38
 * @create_user wangrenhui
 * @whattodo
 * @modify_time like:date1/date2
 * @modify_user like:user1/user2
 * @modify_content like:content1/content2
 */
package cn.dreampie.common.web.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author wangrenhui
 * @description Http请求过滤
 * @create_time 2012-4-28 上午9:16:23
 */
public abstract class HttpFilter implements Filter {
    private FilterConfig config;

    /*
     * (non-Javadoc)
     *
     * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
     */
    public void init(FilterConfig config) throws ServletException {
        this.config = config;
        init();
    }

    /**
     * @throws javax.servlet.ServletException
     * @create_time 2012-4-28 上午9:16:50
     * @create_user wangrenhui
     * @whattodo 初始化过滤器
     * @modify_time like:date1/date2
     * @modify_user like:user1/user2
     * @modify_content like:content1/content2
     */
    public void init() throws ServletException {
    }

    /*
     * (non-Javadoc)
     *
     * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
     * javax.servlet.ServletResponse, javax.servlet.FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) {
        try {
            doFilter((HttpServletRequest) request,
                    (HttpServletResponse) response, chain);
        } catch (Exception e) {
            return;
        }
        return;
    }

    /**
     * @param request
     * @param response
     * @param chain
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @create_time 2012-4-28 上午9:17:02
     * @create_user wangrenhui
     * @whattodo 过滤
     * @modify_time like:date1/date2
     * @modify_user like:user1/user2
     * @modify_content like:content1/content2
     */
    public abstract void doFilter(HttpServletRequest request,
                                  HttpServletResponse response, FilterChain chain) throws IOException, ServletException;

    /*
     * (non-Javadoc)
     *
     * @see javax.servlet.Filter#destroy()
     */
    public void destroy() {
    }

    /**
     * @param name
     * @return
     * @create_time 2012-4-28 上午9:17:14
     * @create_user wangrenhui
     * @whattodo 获取初始化参数
     * @modify_time like:date1/date2
     * @modify_user like:user1/user2
     * @modify_content like:content1/content2
     */
    public String getInitParameter(String name) {
        return config.getInitParameter(name);
    }

    public FilterConfig getFilterConfig() {
        return config;
    }

    public ServletContext getServletContext() {
        return config.getServletContext();
    }
}
