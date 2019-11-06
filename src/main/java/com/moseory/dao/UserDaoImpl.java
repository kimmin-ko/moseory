package com.moseory.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.MemberVO;
import com.moseory.domain.WishListVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Repository
public class UserDaoImpl implements UserDao {
    
    private String namespace = "com.moseory.mapper.UserMapper";
    
    @Setter(onMethod_ = @Autowired)
    private SqlSession sqlSession;

    @Override
    public MemberVO getMember(String id) {
	return sqlSession.selectOne(namespace+".getMember", id);
    }

    @Override
    public void updateMember(MemberVO vo) {
	log.info("dao member : " + vo.getPwd_confirm_a());
	sqlSession.update(namespace+".updateMember", vo);
    }

    @Override
    public void deleteMember(String id) {
	sqlSession.delete(namespace+".deleteMember", id);
    }

    @Override
    public int addWishList(Map<String, Object> param) {
	return sqlSession.insert(namespace+".addWishList", param);
    }
    
    @Override
    public void increaseWishCount(int product_code) {
	sqlSession.update(namespace+".increaseWishCount", product_code);
    }

    @Override
    public int deleteWishList(Map<String, Object> param) {
	return sqlSession.delete(namespace+".deleteWishList", param);
    }

    @Override
    public void decreaseWishCount(int product_code) {
	sqlSession.update(namespace+".decreaseWishCount", product_code);
    }
    
    @Override
    public WishListVO getWishList(String member_id) {
	return sqlSession.selectOne(namespace+".getWishList", member_id);
    }

    @Override
    public int checkWishList(Map<String, Object> param) {
	return sqlSession.selectOne(namespace+".checkWishList", param);
    }



}
