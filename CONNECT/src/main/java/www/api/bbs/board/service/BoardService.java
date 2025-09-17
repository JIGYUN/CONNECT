package www.api.bbs.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.com.util.CommonDao;

@Service
public class BoardService {

    private final String namespace = "www.api.bbs.board.Board";

    @Autowired
    private CommonDao dao;

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

    /**
     * 템플릿 삭제
     */
    @Transactional
    public void deleteBoard(Map<String, Object> paramMap) {
        dao.delete(namespace + ".deleteBoard", paramMap);
    }
}
