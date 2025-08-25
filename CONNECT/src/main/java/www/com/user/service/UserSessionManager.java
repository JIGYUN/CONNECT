package www.com.user.service;

import www.com.session.AuthenticationException;

import org.springframework.security.core.context.SecurityContextHolder;

/**
 * 홈페이지 사용자의 인증 정보 객체를 가져온다.
 * 
 * @author cmj
 *
 */
public abstract class UserSessionManager {

	/**
	 * 사용자 인증 정보 vo를 가져온다.
	 * 
	 * @return 인증된 사용자 UserVO, 인증이 안되었을 시 null 리턴.
	 */
	public static UserVO getLoginUserVO(){
		if(isUserLogined()){
			return (UserVO)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		}
		
		//사용자 세션이 없으면 AuthenticationException을 발생시킨다.
		// /WEB-INF/jsp/www/com/error/error.jsp 에서 처리한다.
		AuthenticationException authenticationException = new AuthenticationException();
		throw authenticationException;
	}
	
	/**
	 * 사용자 인증 여부
	 * 
	 * @return 인증 시 true, 그 외 false
	 */
	public static boolean isUserLogined(){
		if(SecurityContextHolder.getContext().getAuthentication().getPrincipal() != null
				&& SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof UserVO){
			return true;
		}
		else{
			return false;
		}
	}	
}
