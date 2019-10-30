package com.moseory.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.MemberVO;

import lombok.Setter;

@Repository
public class UserDaoImpl implements UserDao {
    
    private String namespace = "com.moseory.mapper.MemberMapper";
    
    @Setter(onMethod_ = @Autowired)
    private SqlSession sqlSession;

    @Override
    public MemberVO getMember(String id) {
	return sqlSession.selectOne(namespace+".getMember", id);
    }

    @Override
    public void updateMember(MemberVO vo) {
	sqlSession.update(namespace+".updateMember", vo);
    }

}
