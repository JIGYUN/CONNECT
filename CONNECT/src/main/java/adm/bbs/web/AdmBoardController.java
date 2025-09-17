package adm.bbs.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;

/**
 * @ClassName   : WebBoardController.java
 * @Description : 게시판 화면(Web) : 게시판 위한 클래스로 CRUD에 대한 컨트롤을 관리한다.
 * @author      : 정지균
 * @since       : 2025. 08. 28.
 */
@Controller
@RequestMapping("/adm/bbs") // 예) /bbs
public class AdmBoardController {

    /** 기본 페이지 */
    @RequestMapping("/board/board")
    public String page(ModelMap model, @RequestParam HashMap<String,Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {
            model.put("userVO", UserSessionManager.getLoginUserVO());
        }
        model.put("map", map);
        return "adm/bbs/board/board"; // 예) bbs/board/board.jsp
    }

    /** 목록 페이지 */
    @RequestMapping("/board/boardList")
    public String list(ModelMap model, @RequestParam HashMap<String,Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {
            model.put("userVO", UserSessionManager.getLoginUserVO());
        }
        model.put("map", map);
        return "adm/bbs/board/boardList"; // 예) bbs/board/boardList.jsp
    }

    /** 등록/수정 페이지 */
    @RequestMapping("adm/board/boardModify")
    public String modify(ModelMap model, @RequestParam HashMap<String,Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {
            model.put("userVO", UserSessionManager.getLoginUserVO());
        }
        model.put("map", map);
        return "adm/bbs/board/boardModify"; // 예) bbs/board/boardModify.jsp
    }
}