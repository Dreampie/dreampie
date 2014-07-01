package cn.dreampie.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class CookieUtils {
    private static final Logger logger = LoggerFactory
            .getLogger(CookieUtils.class);

    private static CookieUtils cookieUtils = new CookieUtils();

    private CookieUtils() {
    }

    public CookieUtils me() {
        return cookieUtils;
    }

    /**
     * 添加cookie对象
     *
     * @param request
     * @param response
     * @param name
     * @param value
     * @param expiry
     */
    public void addCookieObj(HttpServletRequest request,
                             HttpServletResponse response, String name, Object value, int expiry) {
        ByteArrayOutputStream baos = null;
        ObjectOutputStream oos = null;
        try {
            baos = new ByteArrayOutputStream();
            oos = new ObjectOutputStream(baos);
            oos.writeObject(value);
            String cookieValue = baos.toString("ISO-8859-1");
            String encodedCookieValue = java.net.URLEncoder.encode(cookieValue,
                    "UTF-8");
            addCookie(request, response, name, encodedCookieValue, expiry);
        } catch (Exception e) {
            logger.error("保 存对象到cookie出错： " + e.getMessage());
        }
    }

    /**
     * 获取cookie对象
     *
     * @param request
     * @param response
     * @param name
     * @return
     */
    public Object getCookieObj(HttpServletRequest request,
                               HttpServletResponse response, String name) {
        String cookieValue = getCookie(request, name);
        Object result = null;
        if (cookieValue != null && cookieValue.trim() != "") {
            try {
                String decoderCookieValue = java.net.URLDecoder.decode(
                        cookieValue, "UTF-8");

                ByteArrayInputStream bais = new ByteArrayInputStream(
                        decoderCookieValue.getBytes("ISO-8859-1"));
                ObjectInputStream ios = new ObjectInputStream(bais);
                result = ios.readObject();
                return result;
            } catch (Exception e) {
                logger.error(" 从 cookie中解析对象出错： " + e.getMessage());
            }
        }
        return result;
    }

    /**
     * 添加cookie
     *
     * @param request
     * @param response
     * @param name
     * @param value
     * @param expiry   有效时间
     */
    public void addCookie(HttpServletRequest request,
                          HttpServletResponse response, String name, String value, int expiry) {
        try {
            value = java.net.URLEncoder.encode(value, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        Cookie[] cookies = request.getCookies();
        boolean existuser = false;
        // cookies不为空，则修改
        if (cookies != null) {
            if (cookies.length > 0) {
                StringBuilder cname = null;
                for (int i = 0; i < cookies.length; i++) {
                    cname = new StringBuilder(cookies[i].getName());
                    // 查找用户名
                    if (cname.toString().equalsIgnoreCase(name)) {
                        existuser = true;
                        cookies[i].setValue(value);
                        cookies[i].setMaxAge(expiry);
                        response.addCookie(cookies[i]);
                        break;
                    }
                }
            }
        }

        if (!existuser) {
            // 记录cookie
            Cookie cookie = null;

            cookie = new Cookie(name, value);

            cookie.setSecure(false);
            cookie.setMaxAge(expiry);// 60 * 60 * 24 * 7);
            response.addCookie(cookie);
        }
    }

    /**
     * 删除cookie
     *
     * @param request
     * @param name
     */
    public String getCookie(HttpServletRequest request, String name) {
        String result = null;
        Cookie[] cookies = request.getCookies();
        // cookies不为空，则修改
        if (cookies != null) {
            if (cookies.length > 0) {
                StringBuilder cname = null;
                for (int i = 0; i < cookies.length; i++) {
                    cname = new StringBuilder(cookies[i].getName());
                    // 查找用户名
                    if (cname.toString().equalsIgnoreCase(name)) {
                        result = cookies[i].getValue();
                        break;
                    }
                }
            }
        }
        if (result != null) {
            try {
                result = java.net.URLDecoder.decode(result, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 删除cookie
     *
     * @param request
     * @param response
     * @param name
     */
    public void removeCookie(HttpServletRequest request,
                             HttpServletResponse response, String name) {
        Cookie[] cookies = request.getCookies();
        // cookies不为空，则修改
        if (cookies != null) {
            if (cookies.length > 0) {
                StringBuilder cname = null;
                for (int i = 0; i < cookies.length; i++) {
                    cname = new StringBuilder(cookies[i].getName());
                    // 查找用户名
                    if (cname.toString().equalsIgnoreCase(name)) {
                        cookies[i].setValue(null);
                        cookies[i].setMaxAge(-1);
                        response.addCookie(cookies[i]);
                        break;
                    }
                }
            }
        }
    }

    public void main(String[] args) {
        String re = "/controller".substring(0, "/controller".indexOf("controller"));
        System.out.print(re);
    }
}
