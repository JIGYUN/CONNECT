package www.api.mpg.mypage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import www.com.util.CommonDao;
import www.com.util.Sha256;
import www.api.mpg.mypage.service.MypageService;

/**
 * 조직관리1 정보 관리 구현 클래스
 *
 * @author 정지균
 * @since 2024.01.12
 */
@Service
public class MypageServiceImpl extends EgovAbstractServiceImpl implements MypageService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CommonDao dao;

    
    private String namespace = "www.api.mpg.mypage.Mypage";
    
    private String authNamespace = "www.api.mba.auth.Auth";

    /**
     * 회원수정
     *
     * @author 정지균
     * @since 2024.01.12
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED) 
    public void modifyMember(Map<String, Object> params) {
        dao.insert(namespace+".modifyMember", params);  		//마스터 인서트

    }
      
    /**
     * 비밀번호 체크
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> checkPassword(Map<String, Object> params) {
    	Sha256 sha256 = new Sha256();
    	params.put("password", sha256.encrypt(String.valueOf(params.get("password"))));
        return dao.selectOne(authNamespace + ".selectLogin", params);
    }
    
    /**
     * 회원정보 상세
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> selectMember(Map<String, Object> params) {
        return dao.selectOne(namespace + ".selectMember", params);
    }
    
    /**
     * 담당자 목록 조회
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public List<Map<String, Object>> selectManagerList(Map<String, Object> params) {
        return dao.list(namespace + ".selectManagerList", params);
    }
    
    /**
     * 회원 승인
     *
     * @author 정지균
     * @since 2024.01.12
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED) 
    public void approveMember(Map<String, Object> params) {
        dao.insert(namespace+".approveMember", params);  		//마스터 인서트

    }
    
    
    /**
     * 담당자 지정 목록 조회
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public List<Map<String, Object>> selectSpecifyManagerList(Map<String, Object> params) {
        return dao.list(namespace + ".selectSpecifyManagerList", params);
    }
    
    /**
     * 담당자 지정
     *
     * @author 정지균
     * @since 2024.01.12
     */  
    @Override
    @Transactional(propagation = Propagation.REQUIRED) 
    public void specifyMember(Map<String, Object> params) {
        dao.insert(namespace+".specifyMember", params);  		//마스터 인서트
    }
}
