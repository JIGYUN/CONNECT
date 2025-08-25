package www.com.user.service;

import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * 홈페이지 인증 된 사용자VO
 * 
 * @author cmj
 */

public class UserVO implements UserDetails, Serializable {
	
	private static final long serialVersionUID = 3258562207857181402L;

	private String mberNo;
	private String id;
	private String password;
	private String mberNm;
	private String mberPw;
	private String role;
	private String mberSeCd;
	private String cstmrNo;
	

	//권한목록
	private Collection<GrantedAuthority> authorities;
	
	public UserVO(String mberNo, String id, String mberPw, String mberNm, String role, String mberSeCd, String cstmrNo){
		this.mberNo = mberNo;
		this.id = id;
		this.mberPw = mberPw;
		this.mberNm = mberNm;
		this.role = role;
		this.mberSeCd = mberSeCd;
		this.cstmrNo = cstmrNo;
	}


	public void setAuthorities(Collection<GrantedAuthority> authorities) {
		this.authorities = Collections.unmodifiableCollection(authorities);
	}

	@Override
	public String getUsername() {
		return getMberNm();
	}

	@Override
	public String getPassword() {
		return getPassword();
	}
	

	public String getMberId() {
		return id;
	}

	public String getMberNo() {
		return mberNo;
	}


	public void setMberNo(String mberNo) {
		this.mberNo = mberNo;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getMberNm() {
		return mberNm;
	}


	public void setMberNm(String mberNm) {
		this.mberNm = mberNm;
	}
	
	public String getMberPw() {
		return mberPw;
	}


	public void setMberPw(String mberPw) {
		this.mberPw = mberPw;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}
	
	public String getMberSeCd() {
		return mberSeCd;
	}


	public void setMberSeCd(String mberSeCd) {
		this.mberSeCd = mberSeCd;
	}
	
	


	public String getCstmrNo() {
		return cstmrNo;
	}


	public void setCstmrNo(String cstmrNo) {
		this.cstmrNo = cstmrNo;
	}


	public void setPassword(String password) {  
		this.password = password;
	}


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}


}
