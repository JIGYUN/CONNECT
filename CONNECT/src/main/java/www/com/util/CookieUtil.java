package www.com.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Cookie util
 * 
 * @author cmj
 *
 */
public class CookieUtil {
	
	/**
	 * 쿠키를 가져온다.
	 * 
	 * @param request
	 * @param key 쿠키 key
	 * @return
	 */
	public static Cookie getCookie(HttpServletRequest request, String key){
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies){
			if(key.equals(cookie.getName())){
				return cookie;
			}
		}
		
		return null;
	}
	
	/**
	 * 쿠키를 세팅한다.
	 * 
	 * @param response
	 * @param key 쿠키 key
	 * @param value 쿠키 value
	 */
	public static void setCookie(HttpServletResponse response, String key, String value, int maxAge){
		setCookie(response, key, value, maxAge, "/");
		
	}
	
	/**
	 * 쿠키를 세팅한다.
	 * 
	 * @param response
	 * @param key 쿠키 key
	 * @param value 쿠키 value
	 * @param path 쿠키 저장 path
	 */
	public static void setCookie(HttpServletResponse response, String key, String value, int maxAge, String path){
		setCookie(response, key, value, maxAge, "/", null);
	}
	
	/**
	 * 쿠키를 세팅한다.
	 * 
	 * @param response
	 * @param key 쿠키 key
	 * @param value 쿠키 value
	 * @param path 쿠키 저장 path
	 * @param domain 쿠키 저장 domain
	 */
	public static void setCookie(HttpServletResponse response, String key, String value, int maxAge, String path, String domain){
		//Cookie cookie = new Cookie(key, value);
		//개행문자 제거 StringUtil.newLineToBrTag(value)
		Cookie cookie = new Cookie(key, StringUtil.newLineToBrTag(value));
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		if(domain != null && domain.length() > 0){
			cookie.setDomain(domain);
		}
		
		response.addCookie(cookie);
	}
	
	/**
	 * 쿠키를 삭제한다.
	 * 
	 * @param response
	 * @param key 쿠키 key
	 */
	public static void removeCookie(HttpServletResponse response, String key){
		removeCookie(response, key, "/");
	}
	
	/**
	 * 쿠키를 삭제한다.
	 * 
	 * @param response
	 * @param key 쿠키 key
	 * @param path 쿠키 삭제 path
	 */
	public static void removeCookie(HttpServletResponse response, String key, String path){
		removeCookie(response, key, path, null);
	}
	
	/**
	 * 쿠키를 삭제한다.
	 * 
	 * @param response
	 * @param key 쿠키 key
	 * @param path 쿠키 삭제 path
	 * @param domain 쿠키 삭제 domain
	 */
	public static void removeCookie(HttpServletResponse response, String key, String path, String domain){
		Cookie cookie = new Cookie(key, "");
		cookie.setMaxAge(0);
		cookie.setPath(path);
		if(domain != null && domain.length() > 0){
			cookie.setDomain(domain);
		}
		
		response.addCookie(cookie);
	}
}
