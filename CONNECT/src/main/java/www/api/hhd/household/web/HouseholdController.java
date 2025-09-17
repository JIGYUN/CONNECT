package www.api.hhd.household.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import www.api.hhd.household.service.HouseholdService;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HouseholdController {

    @Autowired
    private HouseholdService householdService;

    /**
     * 게시판 목록 조회
     */
    @RequestMapping("/api/hhd/household/selectHouseholdList")
    @ResponseBody
    public Map<String, Object> selectHouseholdList(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> result = householdService.selectHouseholdList(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시판 단건 조회
     */
    @RequestMapping("/api/hhd/household/selectHouseholdDetail")
    @ResponseBody
    public Map<String, Object> selectHouseholdDetail(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> result = householdService.selectHouseholdDetail(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시글 등록
     */
    @RequestMapping("/api/hhd/household/insertHousehold")
    @ResponseBody
    public Map<String, Object> insertHousehold(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("createUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        householdService.insertHousehold(map);
        resultMap.put("msg", "등록 성공");
        return resultMap;
    }

    /**
     * 게시글 수정
     */
    @RequestMapping("/api/hhd/household/updateHousehold")
    @ResponseBody
    public Map<String, Object> updateHousehold(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("updateUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        householdService.updateHousehold(map);
        resultMap.put("msg", "수정 성공");
        return resultMap;
    }

    /**
     * 게시글 삭제
     */
    @RequestMapping("/api/hhd/household/deleteHousehold")
    @ResponseBody
    public Map<String, Object> deleteHousehold(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        householdService.deleteHousehold(map);
        resultMap.put("msg", "삭제 성공");
        return resultMap;
    }

    /**
     * 게시글 개수
     */
    @RequestMapping("/api/hhd/household/selectHouseholdListCount")
    @ResponseBody
    public Map<String, Object> selectHouseholdListCount(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int count = householdService.selectHouseholdListCount(map);
        resultMap.put("msg", "성공");
        resultMap.put("count", count);
        return resultMap;
    }
}
