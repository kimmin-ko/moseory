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
		sqlSession.insert(namespace + ".insertMember", vo);
	}

	@Override
	public void deleteAll() {
		sqlSession.delete(namespace + ".deleteAll");
	}

	@Override
	public int getCount() {
		return sqlSession.selectOne(namespace + ".getCount");
	}

	@Override
	public int getCountMember(String id) {
		return sqlSession.selectOne(namespace + ".getCountMember", id);
	}

	@Override
	public MemberVO loginProc(String inputId) {
		return sqlSession.selectOne(namespace + ".loginProc", inputId);
	}

	@Override
	public List<Map<String, Object>> findIdProc(Map<String, Object> param) {

		return sqlSession.selectList(namespace + ".findIdProc", param);
	}

	@Override
	public Map<String, Object> findPwProc(Map<String, Object> param) {

		return sqlSession.selectOne(namespace + ".findPwProc", param);
	}

	@Override
	public int pwChange(Map<String, Object> param) {

		return sqlSession.update(namespace + ".pwChange", param);
	}

	@Override
	public void insertKakaoMember(MemberVO vo) {
		sqlSession.insert(namespace + ".insertKakaoMember", vo);
	}

	@Override
	public MemberVO selectKakaoMember(MemberVO vo) {
		return sqlSession.selectOne(namespace + ".selectKakaoMember", vo);
	}

	@Override
	public String getMemberPassword(String inputId) {
		return sqlSession.selectOne(namespace + ".getMemberPassword", inputId);
	}

}
