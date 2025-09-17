package www.com.util;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("CommonDAO")
public class CommonDaoImpl implements CommonDao {
	
	@Autowired
	protected SqlSessionTemplate template;
	
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate template) {
		this.template = template;
	}
	
	@Override
	public Object insert(String queryId, Object parameterObject)
	{
		return template.insert(queryId, parameterObject);
	}

	@Override
	public int update(String queryId, Object parameterObject)
	{
		return template.update(queryId, parameterObject);
	}

	@Override
	public int delete(String queryId, Object parameterObject)
	{
		return template.delete(queryId, parameterObject);
	}

	@Override
	public Map<String, Object> selectOne(String queryId, Object parameterObject)
	{
		return template.selectOne(queryId, parameterObject);
	}

	@Override
	public List<Map<String, Object>> list(String queryId, Object parameterObject)
	{
		return template.selectList(queryId, parameterObject);
	}
}