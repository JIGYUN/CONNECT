package www.api.mpg.mypage.web;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import www.api.mpg.mypage.service.MypageService;
import www.com.user.service.UserSessionManager;

/**
 * 조직관리1 정보 관리 Request를 Servlet으로 Mapping하고 ViewPage로 결과값을 리턴해주는 컨트롤 클래스
 *
 * @author 정지균
 * @since 2024.01.12
 */
@Controller
public class MypageController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private MypageService mypageService;

    /**
     * 회왼 수정
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 저장할 데이터
     * @param Model 저장 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/modifyMember")
    @ResponseBody
    public Map<String, Object> modifyMember(@RequestBody HashMap<String, Object> map) throws Exception
    {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("mberNo", UserSessionManager.getLoginUserVO().getMberNo());
        	map.put("mberId", UserSessionManager.getLoginUserVO().getMberId());
        }
        Map<String, Object> resultMap = new HashMap<>();
        mypageService.modifyMember(map);
        
        resultMap.put("msg", "성공적으로 등록되었습니다.");
        return resultMap;
    }
    
    /**
     * 비밀번호 체크
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 조회 조건
     * @param Model 조회 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/checkPassword")
    @ResponseBody
    public Map<String, Object> checkPassword(@RequestBody HashMap<String, Object> map) throws Exception
    {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg", "성공");
        resultMap.put("result", mypageService.checkPassword(map));
        return resultMap;
    }
    
    /**
     * 비밀번호 체크
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 조회 조건
     * @param Model 조회 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/selectMember")
    @ResponseBody
    public Map<String, Object> selectMember(@RequestBody HashMap<String, Object> map) throws Exception
    {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("mberNo", UserSessionManager.getLoginUserVO().getMberNo());
        }
    	
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg", "성공");
        resultMap.put("result", mypageService.selectMember(map));
        return resultMap;
    }
    
    
    
    /**
     * 담당자 목록 조회
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 조회 조건
     * @param Model 조회 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/selectManagerList")
    @ResponseBody
    public Map<String, Object> selectManagerList(@RequestBody HashMap<String, Object> map) throws Exception
    {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("cstmrNo", UserSessionManager.getLoginUserVO().getCstmrNo());
        }
    	
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg", "성공");
        resultMap.put("result", mypageService.selectManagerList(map));
        return resultMap;
    }
    
    /**
     * 회원 승인
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 저장할 데이터
     * @param Model 저장 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/approveMember")
    @ResponseBody
    public Map<String, Object> approveMember(@RequestBody HashMap<String, Object> map) throws Exception
    {
        Map<String, Object> resultMap = new HashMap<>();
        mypageService.approveMember(map);
        
        resultMap.put("msg", "성공적으로 등록되었습니다.");
        return resultMap;
    }
    
    
    
    /**
     * 담당자 지정 목록 조회
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 조회 조건
     * @param Model 조회 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/selectSpecifyManagerList")
    @ResponseBody
    public Map<String, Object> selectSpecifyManagerList(@RequestBody HashMap<String, Object> map) throws Exception
    {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("cstmrNo", UserSessionManager.getLoginUserVO().getCstmrNo());
        }
    	
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("msg", "성공");
        resultMap.put("result", mypageService.selectSpecifyManagerList(map));  
        return resultMap;
    }
    
    
    /**
     * 담당자 지정
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 저장할 데이터
     * @param Model 저장 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/specifyMember")
    @ResponseBody
    public Map<String, Object> specifyMember(@RequestBody HashMap<String, Object> map) throws Exception
    {
        Map<String, Object> resultMap = new HashMap<>();
        mypageService.specifyMember(map); 
        
        resultMap.put("msg", "성공적으로 등록되었습니다."); 
        return resultMap;
    }
    
    
    /**
     * 회왼 수정
     *
     * @author 정지균
     * @since 2024.01.12
     * @param MciRequest 저장할 데이터
     * @param Model 저장 결과
     * @return
     * @throws Exception
     */
    @RequestMapping("/api/mypage/modifyManager")
    @ResponseBody
    public Map<String, Object> modifyManager(@RequestBody HashMap<String, Object> map) throws Exception
    {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("mberId", UserSessionManager.getLoginUserVO().getMberId());
        }  
        
        Map<String, Object> resultMap = new HashMap<>();
        mypageService.modifyMember(map);
        
        resultMap.put("msg", "성공적으로 등록되었습니다.");
        return resultMap;
    }


  
    
}
