package com.dgut.shr.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * @author shijie_liu
 * @date 2020/4/4 16:13
 */
public class CookieUtil {

    public static String getCookieValue(HttpServletRequest request, String key){
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (key.equals(cookie.getName())){
                return cookie.getValue();
            }
        }
        return null;
    }
}
