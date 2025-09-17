package www.api.sch.schedule.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import www.api.sch.schedule.service.ScheduleService;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;

    /**
     * 게시판 목록 조회
     */
    @RequestMapping("/api/sch/schedule/selectScheduleList")
    @ResponseBody
    public Map<String, Object> selectScheduleList(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> result = scheduleService.selectScheduleList(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시판 단건 조회
     */
    @RequestMapping("/api/sch/schedule/selectScheduleDetail")
    @ResponseBody
    public Map<String, Object> selectScheduleDetail(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> result = scheduleService.selectScheduleDetail(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시글 등록
     */
    @RequestMapping("/api/sch/schedule/insertSchedule")
    @ResponseBody
    public Map<String, Object> insertSchedule(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("createUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        scheduleService.insertSchedule(map);
        resultMap.put("msg", "등록 성공");
        return resultMap;
    }

    /**
     * 게시글 수정
     */
    @RequestMapping("/api/sch/schedule/updateSchedule")
    @ResponseBody
    public Map<String, Object> updateSchedule(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("updateUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        scheduleService.updateSchedule(map);
        resultMap.put("msg", "수정 성공");
        return resultMap;
    }

    /**
     * 게시글 삭제
     */
    @RequestMapping("/api/sch/schedule/deleteSchedule")
    @ResponseBody
    public Map<String, Object> deleteSchedule(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        scheduleService.deleteSchedule(map);
        resultMap.put("msg", "삭제 성공");
        return resultMap;
    }

    /**
     * 게시글 개수
     */
    @RequestMapping("/api/sch/schedule/selectScheduleListCount")
    @ResponseBody
    public Map<String, Object> selectScheduleListCount(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int count = scheduleService.selectScheduleListCount(map);
        resultMap.put("msg", "성공");
        resultMap.put("count", count);
        return resultMap;
    }
}
