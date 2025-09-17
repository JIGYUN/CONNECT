package www.api.brd.boardPost.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.com.util.CommonDao;

@Service
public class BoardPostService {

    private final String namespace = "www.api.brd.boardPost.BoardPost";

    @Autowired
    private CommonDao dao;

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
     * 템플릿 등록
     */
    @Transactional
    public void insertBoardPost(Map<String, Object> paramMap) {
        dao.insert(namespace + ".insertBoardPost", paramMap);
    }

    /**
     * 템플릿 수정
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
}
