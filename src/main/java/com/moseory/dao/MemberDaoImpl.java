package com.moseory.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.MemberVO;

import lombok.Setter;

@Repository
public class MemberDaoImpl implements MemberDao {
    
    private String namespace = "com.moseory.mapper.MemberMapper";

    @Setter(onMethod_ = @Autowired)
    private SqlSession sqlSession;
    
    @Override
    public void insertMember(MemberVO vo) {
	sqlSession.insert(namespace+".insertMember", vo);
    }

    @Override
    public void deleteAll() {
	sqlSession.delete(namespace+".deleteAll");
    }

    @Override
    public int getCount() {
	return sqlSession.selectOne(namespace+".getCount");
    }

    @Override
    public MemberVO getMember(String id) {
	return sqlSession.selectOne(namespace+".getMember", id);
    }

    @Override
    public void deleteMember(String id) {
	sqlSession.delete(namespace+".deleteMember", id);
    }

    @Override
    public int getCountMember(String id) {
	return sqlSession.selectOne(namespace+".getCountMember", id);
    }
    
    @Override
	public MemberVO loginProc(Map<String, Object> param) {
    	return sqlSession.selectOne(namespace+".loginProc", param);
	}
    
    @Override
    public List<Map<String, Object>> findIdProc(Map<String, Object> param) {
    	
    	return sqlSession.selectList(namespace+".findIdProc", param);
    }

	
        
}
