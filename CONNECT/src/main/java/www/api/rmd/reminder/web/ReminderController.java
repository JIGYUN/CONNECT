package www.api.rmd.reminder.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import www.api.rmd.reminder.service.ReminderService;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ReminderController {

    @Autowired
    private ReminderService reminderService;

    /**
     * 게시판 목록 조회
     */
    @RequestMapping("/api/rmd/reminder/selectReminderList")
    @ResponseBody
    public Map<String, Object> selectReminderList(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> result = reminderService.selectReminderList(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시판 단건 조회
     */
    @RequestMapping("/api/rmd/reminder/selectReminderDetail")
    @ResponseBody
    public Map<String, Object> selectReminderDetail(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> result = reminderService.selectReminderDetail(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시글 등록
     */
    @RequestMapping("/api/rmd/reminder/insertReminder")
    @ResponseBody
    public Map<String, Object> insertReminder(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("createUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        reminderService.insertReminder(map);
        resultMap.put("msg", "등록 성공");
        return resultMap;
    }

    /**
     * 게시글 수정
     */
    @RequestMapping("/api/rmd/reminder/updateReminder")
    @ResponseBody
    public Map<String, Object> updateReminder(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("updateUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        reminderService.updateReminder(map);
        resultMap.put("msg", "수정 성공");
        return resultMap;
    }

    /**
     * 게시글 삭제
     */
    @RequestMapping("/api/rmd/reminder/deleteReminder")
    @ResponseBody
    public Map<String, Object> deleteReminder(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        reminderService.deleteReminder(map);
        resultMap.put("msg", "삭제 성공");
        return resultMap;
    }

    /**
     * 게시글 개수
     */
    @RequestMapping("/api/rmd/reminder/selectReminderListCount")
    @ResponseBody
    public Map<String, Object> selectReminderListCount(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int count = reminderService.selectReminderListCount(map);
        resultMap.put("msg", "성공");
        resultMap.put("count", count);
        return resultMap;
    }
}
