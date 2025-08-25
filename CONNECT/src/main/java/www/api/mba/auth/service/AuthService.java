package www.api.mba.auth.service;

import java.util.List;
import java.util.Map;


/**
 * 조직관리1 정보 관리 인터페이스 클래스
 *
 * @author 정지균
 * @since 2024.01.12
 */
public interface AuthService { 

    public void insertMember(Map<String, Object> params);
    
    public void insertCompanyMember(Map<String, Object> params);
    
    public void insertCompanyManager(Map<String, Object> params);

    public Map<String, Object> selectLogin(Map<String, Object> params);

    public Map<String, Object> selectIdPwFind(Map<String, Object> params);
    
    public Map<String, Object> duplicateId(Map<String, Object> params);
    
    public Map<String, Object> findId(Map<String, Object> params);
    
    public int changePassword(Map<String, Object> params);
    
    public Map<String, Object> checkDi(Map<String, Object> params);
    
    public Map<String, Object> checkBizrno(Map<String, Object> params);
    
    public List<Map<String, Object>> selectCompanyList(Map<String, Object> params);
 
}
