package www.api.brd.boardPost.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import www.api.brd.boardPost.service.BoardPostService;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardPostController {

    @Autowired
    private BoardPostService boardPostService;

    /**
     * 게시판 목록 조회
     */
    @RequestMapping("/api/brd/boardPost/selectBoardPostList")
    @ResponseBody
    public Map<String, Object> selectBoardPostList(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> result = boardPostService.selectBoardPostList(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시판 단건 조회
     */
    @RequestMapping("/api/brd/boardPost/selectBoardPostDetail")
    @ResponseBody
    public Map<String, Object> selectBoardPostDetail(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> result = boardPostService.selectBoardPostDetail(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시글 등록
     */
    @RequestMapping("/api/brd/boardPost/insertBoardPost")
    @ResponseBody
    public Map<String, Object> insertBoardPost(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("createUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        boardPostService.insertBoardPost(map);
        resultMap.put("msg", "등록 성공");
        return resultMap;
    }

    /**
     * 게시글 수정
     */
    @RequestMapping("/api/brd/boardPost/updateBoardPost")
    @ResponseBody
    public Map<String, Object> updateBoardPost(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("updateUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        boardPostService.updateBoardPost(map);
        resultMap.put("msg", "수정 성공");
        return resultMap;
    }

    /**
     * 게시글 삭제
     */
    @RequestMapping("/api/brd/boardPost/deleteBoardPost")
    @ResponseBody
    public Map<String, Object> deleteBoardPost(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        boardPostService.deleteBoardPost(map);
        resultMap.put("msg", "삭제 성공");
        return resultMap;
    }

    /**
     * 게시글 개수
     */
    @RequestMapping("/api/brd/boardPost/selectBoardPostListCount")
    @ResponseBody
    public Map<String, Object> selectBoardPostListCount(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int count = boardPostService.selectBoardPostListCount(map);
        resultMap.put("msg", "성공");
        resultMap.put("count", count);
        return resultMap;
    }
}
