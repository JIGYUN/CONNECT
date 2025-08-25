package www.bbs.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;

/**
 * @ClassName   : WebBoardController.java
 * @Description : 게시판 화면 호출 컨트롤러 (List, Modify)
 * @author 정지균
 * @since 2025.08.20
 */
@Controller
@RequestMapping("/bbs")
public class WebBoardController {

	/**
	 * 게시판 목록 화면 호출
	 */
	@RequestMapping(value = "/board/boardList")
	public String getBoardListPage(ModelMap model, @RequestParam HashMap<String, Object> map) throws Exception {
		if (UserSessionManager.isUserLogined()) {
			model.put("userVO", UserSessionManager.getLoginUserVO());
		}
		model.put("map", map);
		return "bbs/board/boardList";
	}

	/**
	 * 게시판 등록/수정 화면 호출
	 */
	@RequestMapping(value = "/board/boardModify")
	public String getBoardModifyPage(ModelMap model, @RequestParam HashMap<String, Object> map) throws Exception {
		if (UserSessionManager.isUserLogined()) {
			model.put("userVO", UserSessionManager.getLoginUserVO());
		}
		model.put("map", map);
		return "bbs/board/boardModify";
	}
}