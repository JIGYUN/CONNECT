package www.api.bbs.board.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import www.api.bbs.board.service.BoardService;
import www.com.user.service.UserSessionManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    /**
     * 게시판 목록 조회
     */
    @RequestMapping("/api/bbs/board/selectBoardList")
    @ResponseBody
    public Map<String, Object> selectBoardList(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> result = boardService.selectBoardList(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시판 단건 조회
     */
    @RequestMapping("/api/bbs/board/selectBoardDetail")
    @ResponseBody
    public Map<String, Object> selectBoardDetail(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> result = boardService.selectBoardDetail(map);
        resultMap.put("msg", "성공");
        resultMap.put("result", result);
        return resultMap;
    }

    /**
     * 게시글 등록
     */
    @RequestMapping("/api/bbs/board/insertBoard")
    @ResponseBody
    public Map<String, Object> insertBoard(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("createUser", UserSessionManager.getLoginUserVO().getEmail());
        	System.out.println("id = " + UserSessionManager.getLoginUserVO().getEmail()); 
        }
        Map<String, Object> resultMap = new HashMap<>();
        boardService.insertBoard(map);
        resultMap.put("msg", "등록 성공");
        return resultMap;
    }

    /**
     * 게시글 수정
     */
    @RequestMapping("/api/bbs/board/updateBoard")
    @ResponseBody
    public Map<String, Object> updateBoard(@RequestBody HashMap<String, Object> map) throws Exception {
        if (UserSessionManager.isUserLogined()) {   	
        	map.put("updateUser", UserSessionManager.getLoginUserVO().getEmail());
        }
        Map<String, Object> resultMap = new HashMap<>();
        boardService.updateBoard(map);
        resultMap.put("msg", "수정 성공");
        return resultMap;
    }
    
    // www.api.bbs.web.BbsController
    @PostMapping("/api/bbs/board/insertWithFiles")
    @ResponseBody
    public Map<String,Object> insertWithFiles(
            @RequestParam("title") String title,
            @RequestParam("contents") String contents,
            @RequestParam(value="fileGrpId", required=false) Long fileGrpId, // 수정 시 재사용 가능
            @RequestParam(value="files", required=false) List<MultipartFile> files
    ) throws Exception {
        Map<String,Object> in = new HashMap<>();
        in.put("title", title);
        in.put("contents", contents);
        in.put("fileGrpId", fileGrpId); // null 가능
        Long bbsId = boardService.insertWithFiles(in, files);  // ↓ 서비스에서 오케스트레이션
        Map<String,Object> out = new HashMap<>();
        out.put("msg","등록 성공");
        out.put("bbsId", bbsId);
        out.put("fileGrpId", in.get("fileGrpId")); // 서비스에서 최종 값 주입됨
        return out;
    }
    
    @PostMapping("/api/bbs/board/updateWithFiles")
    @ResponseBody
    public Map<String, Object> updateWithFiles(
            @RequestParam("bbsId") Long bbsId,
            @RequestParam("title") String title,
            @RequestParam("contents") String contents,
            @RequestParam(value = "fileGrpId", required = false) Long fileGrpId,      // 기존 그룹 재사용
            @RequestParam(value = "files", required = false) List<MultipartFile> files, // 새로 추가할 파일들
            @RequestParam(value = "deleteFileIds", required = false) List<Long> deleteFileIds // 선택 삭제(옵션)
    ) throws Exception{
        // 1) 본문/키 param 준비
        Map<String, Object> param = new HashMap<>();
        param.put("bbsId", bbsId);
        param.put("title", title);
        param.put("contents", contents);
        param.put("fileGrpId", fileGrpId); // null 허용(없으면 업로드 시 생성)

        // 2) 선택 삭제가 요청되면 먼저 파일 soft delete
        if (deleteFileIds != null && !deleteFileIds.isEmpty()) {
            for (Long fid : deleteFileIds) {
                // FileService에 softDelete 메서드가 있다면 호출, 없으면 매퍼 update 사용
                // fileService.softDelete(fid);
            }
        }

        // 3) 파일 추가 포함해서 업데이트
        boardService.updateWithFiles(param, files); // 내부에서 fileService.upload(...) 호출

        Map<String, Object> out = new HashMap<>();
        out.put("msg", "수정 성공");
        out.put("bbsId", bbsId);
        out.put("fileGrpId", param.get("fileGrpId")); // (추가 업로드로 새로 생성/재사용된 최종 값)
        return out;
    }

    /**
     * 게시글 삭제
     */
    @RequestMapping("/api/bbs/board/deleteBoard")
    @ResponseBody
    public Map<String, Object> deleteBoard(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        boardService.deleteBoard(map);
        resultMap.put("msg", "삭제 성공");
        return resultMap;
    }

    /**
     * 게시글 개수
     */
    @RequestMapping("/api/bbs/board/selectBoardListCount")
    @ResponseBody
    public Map<String, Object> selectBoardListCount(@RequestBody HashMap<String, Object> map) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        int count = boardService.selectBoardListCount(map);
        resultMap.put("msg", "성공");
        resultMap.put("count", count);
        return resultMap;
    }
}
