package www.api.brd.boardPost.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import www.com.util.CommonDao;
import www.api.com.file.service.FileService;

@Service
public class BoardPostService {

    private final String namespace = "www.api.brd.boardPost.BoardPost";

    @Autowired
    private CommonDao dao;

    @Autowired
    private FileService fileService;

    /**
     * 목록 조회 (기존)
     */
    public List<Map<String, Object>> selectBoardPostList(Map<String, Object> paramMap) {
        return dao.list(namespace + ".selectBoardPostList", paramMap);
    }

    /**
     * 목록 수 조회 (기존)
     */
    public int selectBoardPostListCount(Map<String, Object> paramMap) {
    	return dao.selectOneInt(namespace + ".selectBoardPostListCount", paramMap);
    }

    /**
     * 목록 조회 (페이징 추가)
     * 입력: paramMap 내 page/size(+ 검색필터)
     * 출력: { list, page:{page,size,total,totalPages,hasNext,hasPrev} }
     */
    public Map<String, Object> selectBoardPostListPaged(Map<String, Object> paramMap) {
        Map<String, Object> p = (paramMap == null) ? new HashMap<>() : new HashMap<>(paramMap);

        int page = parseInt(p.get("page"), 1);
        int size = parseInt(p.get("size"), 20);
        if (page < 1) page = 1;
        if (size < 1) size = 20;
        if (size > 200) size = 200;

        int offset = (page - 1) * size;
        p.put("limit", size);
        p.put("offset", offset);

        List<Map<String, Object>> list = dao.list(namespace + ".selectBoardPostList", p);
        int total = selectBoardPostListCount(p);
        long totalPages = (total + size - 1L) / size;
        boolean hasNext = page * size < total;
        boolean hasPrev = page > 1;

        Map<String, Object> meta = new HashMap<>();
        meta.put("page", page);
        meta.put("size", size);
        meta.put("total", total);
        meta.put("totalPages", totalPages);
        meta.put("hasNext", hasNext);
        meta.put("hasPrev", hasPrev);

        Map<String, Object> out = new HashMap<>();
        out.put("list", list);
        out.put("page", meta);
        return out;
    }

    /**
     * 단건 조회 (기존)
     */
    public Map<String, Object> selectBoardPostDetail(Map<String, Object> paramMap) {
        return dao.selectOne(namespace + ".selectBoardPostDetail", paramMap);
    }

    /**
     * 등록 (JSON, 기존)
     */
    @Transactional
    public void insertBoardPost(Map<String, Object> paramMap) {
        dao.insert(namespace + ".insertBoardPost", paramMap);
    }

    /**
     * 수정 (JSON, 기존)
     */
    @Transactional
    public void updateBoardPost(Map<String, Object> paramMap) {
        dao.update(namespace + ".updateBoardPost", paramMap);
    }

    /**
     * 삭제 (기존)
     */
    @Transactional
    public void deleteBoardPost(Map<String, Object> paramMap) {
        dao.delete(namespace + ".deleteBoardPost", paramMap);
    }

    /* ===================== 업로드 포함 등록/수정 (멀티파트 오케스트레이션) ===================== */

    /**
     * 등록 + 파일업로드
     */
    @Transactional
    public Long insertBoardPostWithFiles(Map<String, Object> paramMap,
                                         List<MultipartFile> files,
                                         Long fileGrpId) {
        if (files != null && !files.isEmpty()) {
            Map<String, Object> res = fileService.upload(fileGrpId, null, "BOARD 첨부", files);
            fileGrpId = ((Number) res.get("fileGrpId")).longValue();
        }
        paramMap.put("fileGrpId", fileGrpId);

        dao.insert(namespace + ".insertBoardPost", paramMap);
        Object pk = paramMap.get("boardIdx"); // 매퍼에 useGeneratedKeys 설정 시 주입됨
        return (pk == null) ? null : ((Number) pk).longValue();
    }

    /**
     * 수정 + 파일추가/선택삭제
     */
    @Transactional
    public void updateBoardPostWithFiles(Map<String, Object> paramMap,
                                         List<MultipartFile> files,
                                         Long fileGrpId,
                                         List<Long> deleteFileIds) {
        if (deleteFileIds != null && !deleteFileIds.isEmpty()) {
            for (Long fid : deleteFileIds) {
                dao.update("www.api.com.file.File.softDeleteFile", Collections.singletonMap("fileId", fid));
            }
        }

        if (files != null && !files.isEmpty()) {
            Map<String, Object> res = fileService.upload(fileGrpId, null, "BOARD 첨부", files);
            fileGrpId = ((Number) res.get("fileGrpId")).longValue();
        }

        paramMap.put("fileGrpId", fileGrpId);
        dao.update(namespace + ".updateBoardPost", paramMap);
    }

    /* ===================== 내부 유틸 ===================== */

    private int parseInt(Object v, int def) {
        if (v == null) return def;
        if (v instanceof Number) return ((Number) v).intValue();
        try { return Integer.parseInt(String.valueOf(v)); } catch (Exception e) { return def; }
    }
}