package www.api.rmd.reminder.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.com.util.CommonDao;

@Service
public class ReminderService {

    private final String namespace = "www.api.rmd.reminder.Reminder";

    @Autowired
    private CommonDao dao;

    /**
     * 템플릿 목록 조회
     */
    public List<Map<String, Object>> selectReminderList(Map<String, Object> paramMap) {
        return dao.list(namespace + ".selectReminderList", paramMap);
    }

    /**
     * 템플릿 목록 수 조회
     */
    public int selectReminderListCount(Map<String, Object> paramMap) {
        Map<String, Object> resultMap = dao.selectOne(namespace + ".selectReminderListCount", paramMap);
        if (resultMap != null && resultMap.get("cnt") != null) {
            return Integer.parseInt(resultMap.get("cnt").toString());
        }
        return 0;
    }

    /**
     * 템플릿 단건 조회
     */
    public Map<String, Object> selectReminderDetail(Map<String, Object> paramMap) {
        return dao.selectOne(namespace + ".selectReminderDetail", paramMap);
    }

    /**
     * 템플릿 등록
     */
    @Transactional
    public void insertReminder(Map<String, Object> paramMap) {
        dao.insert(namespace + ".insertReminder", paramMap);
    }

    /**
     * 템플릿 수정
     */
    @Transactional
    public void updateReminder(Map<String, Object> paramMap) {
        dao.update(namespace + ".updateReminder", paramMap);
    }

    /**
     * 템플릿 삭제
     */
    @Transactional
    public void deleteReminder(Map<String, Object> paramMap) {
        dao.delete(namespace + ".deleteReminder", paramMap);
    }
}
