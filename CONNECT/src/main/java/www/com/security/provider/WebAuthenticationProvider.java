package www.com.security.provider;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import www.api.mba.auth.service.AuthService;
import www.com.spring.web.HttpServletRequestProvider;
import www.com.util.Sha256;
import www.com.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import www.com.user.service.UserVO;

/**
 * 실명(휴대폰)인증, IPIN 인증 체크 provider
 * 
 * @author cmj
 *
 */
public class WebAuthenticationProvider implements AuthenticationProvider {
	
	private static final Logger logger = LoggerFactory.getLogger(WebAuthenticationProvider.class);

    @Autowired
    private AuthService authService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		HttpServletRequest request = HttpServletRequestProvider.getHttpServletRequest();
		String loginType = (String) request.getParameter("loginType");
		String mberId = (String) request.getParameter("mberId");
		String mberPw = (String) request.getParameter("mberPw");

		try {
			if (!"".equals(StringUtil.nullConvert(loginType))) {
				authentication = checkLogin(request, loginType, mberId, mberPw);
			} else {
				//removeSession(request);
				throw new UsernameNotFoundException("exception");
			}
		} catch (NullPointerException ne) {
			logger.error(ne.getMessage(), ne);
		} catch (Exception e) {
			//removeSession(request);
			throw new UsernameNotFoundException("exception");
		}
		//removeSession(request);
		return authentication;
	}

	private void removeSession(HttpServletRequest request) {
		HttpSession session = request.getSession();
		//session.removeAttribute("uniqId");
		//session.removeAttribute("subUniqId");
		//session.removeAttribute("name");
		//session.removeAttribute("tel");
	}

	private Authentication checkLogin(HttpServletRequest request, String loginType, String mberId, String mberPw) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();

    	Sha256 sha256 = new Sha256();

		params.put("id", mberId);
		params.put("password", sha256.encrypt(mberPw));
		
		map = authService.selectLogin(params);
		 
		if (map != null) {
			UserVO userVO = new UserVO(String.valueOf(map.get("id"))
													,String.valueOf(map.get("id"))
													,String.valueOf(map.get("password"))
													,String.valueOf(map.get("mberNm"))
													,String.valueOf(map.get("role"))
													,String.valueOf(map.get("mberSeCd"))
													,String.valueOf(map.get("cstmrNo")));
			/*userVO.setTel(tel);
			userVO.setLoginType(loginType);*/

			//로그인 성공시 update 처리.

			List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
			roles.add(new SimpleGrantedAuthority("EXTERNAL_AUTH"));

			UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(userVO, null, roles);
			return result;
		} else {
			throw new UsernameNotFoundException("has no uniqid");
		}
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}
}
