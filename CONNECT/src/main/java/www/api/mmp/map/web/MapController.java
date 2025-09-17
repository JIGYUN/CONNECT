package www.api.mmp.map.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import www.api.mmp.map.service.MapService;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MapController {

    @Autowired
    private MapService mapService;

    /**
     * 게시판 목록 조회
     */
    @RequestMapping("/api/mmp/map/selectMapList")
    @ResponseBody
    public Map<String, Object> selectMapList(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> result = mapService.selectMapList(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시판 단건 조회
     */
    @RequestMapping("/api/mmp/map/selectMapDetail")
    @ResponseBody
    public Map<String, Object> selectMapDetail(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> result = mapService.selectMapDetail(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시글 등록
     */
    @RequestMapping("/api/mmp/map/insertMap")
    @ResponseBody
    public Map<String, Object> insertMap(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("createUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        mapService.insertMap(map);
        resultMap.put("msg", "등록 성공");
        return resultMap;
    }

    /**
     * 게시글 수정
     */
    @RequestMapping("/api/mmp/map/updateMap")
    @ResponseBody
    public Map<String, Object> updateMap(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("updateUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        mapService.updateMap(map);
        resultMap.put("msg", "수정 성공");
        return resultMap;
    }

    /**
     * 게시글 삭제
     */
    @RequestMapping("/api/mmp/map/deleteMap")
    @ResponseBody
    public Map<String, Object> deleteMap(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        mapService.deleteMap(map);
        resultMap.put("msg", "삭제 성공");
        return resultMap;
    }

    /**
     * 게시글 개수
     */
    @RequestMapping("/api/mmp/map/selectMapListCount")
    @ResponseBody
    public Map<String, Object> selectMapListCount(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int count = mapService.selectMapListCount(map);
        resultMap.put("msg", "성공");
        resultMap.put("count", count);
        return resultMap;
    }
}
