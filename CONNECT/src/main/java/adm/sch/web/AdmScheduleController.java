package adm.sch.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;

/**
 * @ClassName   : WebScheduleController.java
 * @Description : 스케줄 화면(Web) : 스케줄 위한 클래스로 CRUD에 대한 컨트롤을 관리한다.
 * @author      : 정지균
 * @since       : 2025. 09. 15.
 */
@Controller
@RequestMapping("/adm/sch") // 예) /bbs
public class AdmScheduleController {

    /** 기본 페이지 */
    @RequestMapping("/schedule/schedule")
    public String page(ModelMap model, @RequestParam HashMap<String,Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {
            model.put("userVO", UserSessionManager.getLoginUserVO());
        }
        model.put("map", map);
        return "adm/sch/schedule/schedule"; // 예) bbs/board/board.jsp
    }

    /** 목록 페이지 */
    @RequestMapping("/schedule/scheduleList")
    public String list(ModelMap model, @RequestParam HashMap<String,Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {
            model.put("userVO", UserSessionManager.getLoginUserVO());
        }
        model.put("map", map);
        return "adm/sch/schedule/scheduleList"; // 예) bbs/board/boardList.jsp
    }

    /** 등록/수정 페이지 */
    @RequestMapping("/schedule/scheduleModify")
    public String modify(ModelMap model, @RequestParam HashMap<String,Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {
            model.put("userVO", UserSessionManager.getLoginUserVO());
        }
        model.put("map", map);
        return "adm/sch/schedule/scheduleModify"; // 예) bbs/board/boardModify.jsp
    }
}
