package www.api.mpg.mypage.service;

import java.util.List;
import java.util.Map;


/**
 * 조직관리1 정보 관리 인터페이스 클래스
 *
 * @author 정지균
 * @since 2024.01.12
 */
public interface MypageService { 

    public void modifyMember(Map<String, Object> params);
    
    public Map<String, Object> checkPassword(Map<String, Object> params);
    
    public Map<String, Object> selectMember(Map<String, Object> params);
    
    public List<Map<String, Object>> selectManagerList(Map<String, Object> params);
    
    public void approveMember(Map<String, Object> params);
    
    public List<Map<String, Object>> selectSpecifyManagerList(Map<String, Object> params);
    
    public void specifyMember(Map<String, Object> params);

}
