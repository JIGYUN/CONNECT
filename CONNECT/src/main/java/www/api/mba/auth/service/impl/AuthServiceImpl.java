package www.api.mba.auth.service.impl;

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
import www.api.mba.auth.service.AuthService;

/**
 * 조직관리1 정보 관리 구현 클래스
 *
 * @author 정지균
 * @since 2024.01.12
 */
@Service
public class AuthServiceImpl extends EgovAbstractServiceImpl implements AuthService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private CommonDao dao;

    
    private String namespace = "www.api.mba.auth.Auth";

    /**
     * 회원가입
     *
     * @author 정지균
     * @since 2024.01.12
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void insertMember(Map<String, Object> params) {
    	Map<String, Object> rMap = new HashMap<>();
    	Map<String, Object> aMap = new HashMap<>();
    	/* 1.mberNo 추출	*/
    	rMap = dao.selectOne(namespace + ".selectMberNo", params);
    	aMap = dao.selectOne(namespace + ".selectCstmrNo", params);
//    	params.put("mberNo", rMap.get("mberNo")); //카멜케이스 적용되면 사용
    	params.put("mberNo", rMap.get("mberNo"));
    	params.put("cstmrNo", aMap.get("cstmrNo"));
    	params.put("indvdlCstmrNo", aMap.get("cstmrNo")); 
    	params.put("cstmrNm", params.get("mberNm"));
    	params.put("registerId", params.get("id"));
    	params.put("changerId", params.get("id"));
    	
    	Sha256 sha256 = new Sha256();
    	params.put("password", sha256.encrypt(String.valueOf(params.get("password"))));
    	
        dao.insert(namespace+".mergeMember", params);  		//마스터 인서트
        dao.insert(namespace+".mergeMemberDetail", params);	//상세 인서트 
        dao.insert(namespace+".mergeCustomer", params);  		//마스터 인서트
        dao.insert(namespace+".mergeCustomerDetail", params);	//상세 인서트 
//        dao.insert("www.api.mba.auth.Auth.insertMember", params);
    }
    
    /**
     * 회원가입
     *
     * @author 정지균
     * @since 2024.01.12
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void insertCompanyMember(Map<String, Object> params) {
    	Sha256 sha256 = new Sha256();
    	params.put("password", sha256.encrypt(String.valueOf(params.get("password"))));
    	
        dao.insert(namespace+".insertMember", params);  		//마스터 인서트
//        dao.insert("www.api.mba.auth.Auth.insertMember", params);
    }
    
    /**
     * 회원가입
     *
     * @author 정지균
     * @since 2024.01.12
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void insertCompanyManager(Map<String, Object> params) {
    	Map<String, Object> rMap = new HashMap<>(); 
    	/* 1.mberNo 추출	*/
    	rMap = dao.selectOne(namespace + ".selectMberNo", params);
    	params.put("mberNo", rMap.get("mberNo"));
    	params.put("registerId", params.get("id"));
    	params.put("changerId", params.get("id"));
    	
    	Sha256 sha256 = new Sha256();
    	params.put("password", sha256.encrypt(String.valueOf(params.get("password"))));
    	
        dao.insert(namespace+".mergeMember", params);  		//마스터 인서트
    }

    /**
     * 로그인
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> selectLogin(Map<String, Object> params) {
        return dao.selectOne(namespace + ".selectLogin", params);
    }

    /**
     * 아이디비밀번호찾기
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> selectIdPwFind(Map<String, Object> params) {
        return dao.selectOne(namespace + ".selectIdPwFind", params);
    }
    
    /**
     * 아이디 중복체크 
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> duplicateId(Map<String, Object> params) {
        return dao.selectOne(namespace + ".duplicateId", params);
    }
    
    
    /**
     * 아이디 찾기 
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> findId(Map<String, Object> params) {
        return dao.selectOne(namespace + ".findId", params);
    }
    
    /**
     * 비밀번호 변경 
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public int changePassword(Map<String, Object> params) {
    	Sha256 sha256 = new Sha256();
    	params.put("password", sha256.encrypt(String.valueOf(params.get("password"))));
        return dao.update(namespace + ".changePassword", params);
    }
    
    /**
     * DI값 체크
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> checkDi(Map<String, Object> params) {
        return dao.selectOne(namespace + ".checkDi", params);
    }
    
    /**
     * 사업자등록번호 체크
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public Map<String, Object> checkBizrno(Map<String, Object> params) {
        return dao.selectOne(namespace + ".checkBizrno", params);
    }
    
    /**
     * 회사 목록 조회
     *
     * @author 정지균
     * @since 2024.01.12
     * @param Map 조회 조건
     * @return List 조회 결과
     */
    @Override
    public List<Map<String, Object>> selectCompanyList(Map<String, Object> params) {
        return dao.list(namespace + ".selectCompanyList", params);
    }
 
}
