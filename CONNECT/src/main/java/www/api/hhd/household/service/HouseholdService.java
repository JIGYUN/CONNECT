package www.api.hhd.household.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.com.util.CommonDao;

@Service
public class HouseholdService {

    private final String namespace = "www.api.hhd.household.Household";

    @Autowired
    private CommonDao dao;

    /**
     * 템플릿 목록 조회
     */
    public List<Map<String, Object>> selectHouseholdList(Map<String, Object> paramMap) {
        return dao.list(namespace + ".selectHouseholdList", paramMap);
    }

    /**
     * 템플릿 목록 수 조회
     */
    public int selectHouseholdListCount(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = dao.selectOne(namespace + ".selectHouseholdListCount", paramMap);
        if (resultMap != null && resultMap.get("cnt") != null) {
            return Integer.parseInt(resultMap.get("cnt").toString());
        }
        return 0;
    }

    /**
     * 템플릿 단건 조회
     */
    public Map<String, Object> selectHouseholdDetail(Map<String, Object> paramMap) {
        return dao.selectOne(namespace + ".selectHouseholdDetail", paramMap);
    }

    /**
     * 템플릿 등록
     */
    @Transactional
    public void insertHousehold(Map<String, Object> paramMap) {
        dao.insert(namespace + ".insertHousehold", paramMap);
    }

    /**
     * 템플릿 수정
     */
    @Transactional
    public void updateHousehold(Map<String, Object> paramMap) {
        dao.update(namespace + ".updateHousehold", paramMap);
    }

    /**
     * 템플릿 삭제
     */
    @Transactional
    public void deleteHousehold(Map<String, Object> paramMap) {
        dao.delete(namespace + ".deleteHousehold", paramMap);
    }
}
