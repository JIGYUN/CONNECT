package www.api.bbs.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import www.api.com.file.service.FileService;
import www.com.util.CommonDao;

@Service
public class BoardService {

    private final String namespace = "www.api.bbs.board.Board";

    @Autowired
    private CommonDao dao;
    
    @Autowired 
    private FileService fileService; // 앞서 만든 공용 업로드 서비스

    /**
     * 템플릿 목록 조회
     */
    public List<Map<String, Object>> selectBoardList(Map<String, Object> paramMap) {
        return dao.list(namespace + ".selectBoardList", paramMap);
    }

    /**
     * 템플릿 목록 수 조회
     */
    public int selectBoardListCount(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = dao.selectOne(namespace + ".selectBoardListCount", paramMap);
        if (resultMap != null && resultMap.get("cnt") != null) {
            return Integer.parseInt(resultMap.get("cnt").toString());
        }
        return 0;
    }

    /**
     * 템플릿 단건 조회
     */
    public Map<String, Object> selectBoardDetail(Map<String, Object> paramMap) {
        return dao.selectOne(namespace + ".selectBoardDetail", paramMap);
    }

    /**
     * 템플릿 등록
     */
    @Transactional
    public void insertBoard(Map<String, Object> paramMap) {
        dao.insert(namespace + ".insertBoard", paramMap);
    }

    /**
     * 템플릿 수정
     */
    @Transactional
    public void updateBoard(Map<String, Object> paramMap) {
        dao.update(namespace + ".updateBoard", paramMap);
    }
    
    @Transactional
    public Long insertWithFiles(Map<String,Object> param, List<MultipartFile> files)  throws Exception{
        // 1) 파일이 있으면 업로드 서비스 호출 (그룹 생성/재사용)
        Long fileGrpId = (param.get("fileGrpId") == null) ? null :
                Long.valueOf(String.valueOf(param.get("fileGrpId")));

        if (files != null && !files.isEmpty()) {
            Map<String,Object> uploadRes = fileService.upload(fileGrpId, null, "BBS 첨부", files);
            fileGrpId = ((Number) uploadRes.get("fileGrpId")).longValue();
        }
        param.put("fileGrpId", fileGrpId);

        // 2) 게시글 INSERT
        dao.insert(namespace + ".insertBbs", param);  // useGeneratedKeys → param.bbsId 채워짐
        return ((Number) param.get("bbsId")).longValue();
    }

    @Transactional
    public void updateWithFiles(Map<String,Object> param, List<MultipartFile> files) throws Exception{
        Long fileGrpId = (param.get("fileGrpId") == null) ? null :
                Long.valueOf(String.valueOf(param.get("fileGrpId")));
        if (files != null && !files.isEmpty()) {
            Map<String,Object> uploadRes = fileService.upload(fileGrpId, null, "BBS 첨부", files);
            fileGrpId = ((Number) uploadRes.get("fileGrpId")).longValue();
        }
        param.put("fileGrpId", fileGrpId);

        dao.update(namespace + ".updateBbs", param);
    }

    /**
     * 템플릿 삭제
     */
    @Transactional
    public void deleteBoard(Map<String, Object> paramMap) {
        dao.delete(namespace + ".deleteBoard", paramMap);
    }
}
