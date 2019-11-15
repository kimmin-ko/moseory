package com.moseory.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moseory.domain.AddedOrderInfoVO;
import com.moseory.domain.CartVO;
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

    @Override
    public void addToCart(Map<String, Object> param) {
	sqlSession.insert(namespace+".addToCart", param);
    }

    @Override
    public int isExistProductInCart(Map<String, Object> param) {
	return sqlSession.selectOne(namespace+".isExistProductInCart", param);
    }

    @Override
    public List<CartVO> getCartList(String member_id) {
	return sqlSession.selectList(namespace+".getCartList", member_id);
    }

    @Override
    public int getCartCount(String member_id) {
	return sqlSession.selectOne(namespace+".getCartCount", member_id);
    }

    @Override
    public int updateCartQuantity(int no, int quantity) {
	Map<String, Integer> param = new HashMap<String, Integer>();
	param.put("no", no);
	param.put("quantity", quantity);
	
	return sqlSession.update(namespace+".updateCartQuantity", param);
    }

    @Override
    public int getCartQuantity(int no) {
	return sqlSession.selectOne(namespace+".getCartQuantity", no);
    }

    @Override
    public void deleteCartList(int no) {
	sqlSession.delete(namespace+".deleteCartList", no);
    }

    @Override
    public void deleteCartAll(String member_id) {
	sqlSession.delete(namespace+".deleteCartAll", member_id);
    }

    @Override
    public AddedOrderInfoVO getAddedOrderInfo(int product_detail_no) {
	return sqlSession.selectOne(namespace+".getAddedOrderInfo", product_detail_no);
    }

}
