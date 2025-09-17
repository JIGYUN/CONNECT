package www.api.sch.schedule.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.com.util.CommonDao;

@Service
public class ScheduleService {

    private final String namespace = "www.api.sch.schedule.Schedule";

    @Autowired
    private CommonDao dao;

    /**
     * 템플릿 목록 조회
     */
    public List<Map<String, Object>> selectScheduleList(Map<String, Object> paramMap) {
        return dao.list(namespace + ".selectScheduleList", paramMap);
    }

    /**
     * 템플릿 목록 수 조회
     */
    public int selectScheduleListCount(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = dao.selectOne(namespace + ".selectScheduleListCount", paramMap);
        if (resultMap != null && resultMap.get("cnt") != null) {
            return Integer.parseInt(resultMap.get("cnt").toString());
        }
        return 0;
    }

    /**
     * 템플릿 단건 조회
     */
    public Map<String, Object> selectScheduleDetail(Map<String, Object> paramMap) {
        return dao.selectOne(namespace + ".selectScheduleDetail", paramMap);
    }

    /**
     * 템플릿 등록
     */
    @Transactional
    public void insertSchedule(Map<String, Object> paramMap) {
        dao.insert(namespace + ".insertSchedule", paramMap);
    }

    /**
     * 템플릿 수정
     */
    @Transactional
    public void updateSchedule(Map<String, Object> paramMap) {
        dao.update(namespace + ".updateSchedule", paramMap);
    }

    /**
     * 템플릿 삭제
     */
    @Transactional
    public void deleteSchedule(Map<String, Object> paramMap) {
        dao.delete(namespace + ".deleteSchedule", paramMap);
    }
}
