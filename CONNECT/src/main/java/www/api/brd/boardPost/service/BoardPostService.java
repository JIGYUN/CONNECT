package www.api.brd.boardPost.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import www.com.util.CommonDao;
import www.api.com.file.service.FileService; // ⬅ 공용 파일 서비스 (앞서 만든 것)

@Service
public class BoardPostService {

    private final String namespace = "www.api.brd.boardPost.BoardPost";

    @Autowired
    private CommonDao dao;

    @Autowired
    private FileService fileService;

    /**
     * 템플릿 목록 조회
     */
    public List<Map<String, Object>> selectBoardPostList(Map<String, Object> paramMap) {
        return dao.list(namespace + ".selectBoardPostList", paramMap);
    }

    /**
     * 템플릿 목록 수 조회
     */
    public int selectBoardPostListCount(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = dao.selectOne(namespace + ".selectBoardPostListCount", paramMap);
        if (resultMap != null && resultMap.get("cnt") != null) {
            return Integer.parseInt(resultMap.get("cnt").toString());
        }
        return 0;
    }

    /**
     * 템플릿 단건 조회
     */
    public Map<String, Object> selectBoardPostDetail(Map<String, Object> paramMap) {
        return dao.selectOne(namespace + ".selectBoardPostDetail", paramMap);
    }

    /**
     * 템플릿 등록 (JSON)
     */
    @Transactional
    public void insertBoardPost(Map<String, Object> paramMap) {
        dao.insert(namespace + ".insertBoardPost", paramMap);
    }

    /**
     * 템플릿 수정 (JSON)
     */
    @Transactional
    public void updateBoardPost(Map<String, Object> paramMap) {
        dao.update(namespace + ".updateBoardPost", paramMap);
    }

    /**
     * 템플릿 삭제
     */
    @Transactional
    public void deleteBoardPost(Map<String, Object> paramMap) {
        dao.delete(namespace + ".deleteBoardPost", paramMap);
    }

    /* ===================== 업로드 포함 등록/수정 (멀티파트 오케스트레이션) ===================== */

    /**
     * 등록 + 파일업로드
     * @param paramMap title, content, contentHtml, createUser 등
     * @param files    업로드할 파일들(없으면 null/빈 리스트)
     * @param fileGrpId 기존 그룹 재사용 시 전달(없으면 null)
     * @return boardIdx (PK)
     */
    @Transactional
    public Long insertBoardPostWithFiles(Map<String, Object> paramMap,
                                         List<MultipartFile> files,
                                         Long fileGrpId) {
        // 1) 파일 업로드 (있으면)
        if (files != null && !files.isEmpty()) {
            Map<String, Object> res = fileService.upload(fileGrpId, null, "BOARD 첨부", files);
            fileGrpId = ((Number) res.get("fileGrpId")).longValue();
        }
        // 2) 최종 그룹 키 세팅
        paramMap.put("fileGrpId", fileGrpId);

        // 3) 게시글 INSERT
        dao.insert(namespace + ".insertBoardPost", paramMap);
        // useGeneratedKeys="true" keyProperty="boardIdx" 가 매퍼에 있다면 paramMap에 채워짐
        Object pk = paramMap.get("boardIdx");
        return (pk == null) ? null : ((Number) pk).longValue();
    }

    /**
     * 수정 + 파일추가/선택삭제
     * @param paramMap boardIdx, title, content, contentHtml, updateUser 등
     * @param files 새로 추가할 파일들
     * @param fileGrpId 기존 그룹(없으면 null → 업로드 시 생성)
     * @param deleteFileIds 선택 삭제할 FILE_ID 목록
     */
    @Transactional
    public void updateBoardPostWithFiles(Map<String, Object> paramMap,
                                         List<MultipartFile> files,
                                         Long fileGrpId,
                                         List<Long> deleteFileIds) {
        // 1) 선택 삭제 먼저 처리 (soft delete)
        if (deleteFileIds != null && !deleteFileIds.isEmpty()) {
            for (Long fid : deleteFileIds) {
                // 파일 서비스에 softDelete가 있다면 호출
                // fileService.softDelete(fid);
                // 없다면 매퍼 직접 호출 (공유 XML: www.api.com.file.File.softDeleteFile)
                dao.update("www.api.com.file.File.softDeleteFile", Collections.singletonMap("fileId", fid));
            }
        }

        // 2) 파일 추가 업로드
        if (files != null && !files.isEmpty()) {
            Map<String, Object> res = fileService.upload(fileGrpId, null, "BOARD 첨부", files);
            fileGrpId = ((Number) res.get("fileGrpId")).longValue();
        }

        // 3) 최종 그룹 키 세팅 후 UPDATE
        paramMap.put("fileGrpId", fileGrpId);
        dao.update(namespace + ".updateBoardPost", paramMap);
    }
}