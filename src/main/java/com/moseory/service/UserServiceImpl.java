package com.moseory.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.dao.UserDao;
import com.moseory.domain.CartVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.WishListVO;

import lombok.Setter;

@Service
public class UserServiceImpl implements UserService {
    
    @Setter(onMethod_ = @Autowired)
    private UserDao userDao;

    @Override
    public MemberVO readMember(String id) {
	return userDao.getMember(id);
    }

    @Override
    public void modifyMember(MemberVO vo) {
	userDao.updateMember(vo);
    }

    @Override
    public void removeMember(String id) {
	userDao.deleteMember(id);
    }

    @Override
    @Transactional
    public int addWishList(Map<String, Object> param) {
	userDao.increaseWishCount(Integer.valueOf((String) param.get("product_code")));
	
	return userDao.addWishList(param);
    }

    @Override
    @Transactional
    public int deleteWishList(Map<String, Object> param) {
	userDao.decreaseWishCount((Integer)(param.get("product_code")));
	
	return userDao.deleteWishList(param);
    }
    
    @Override
    public WishListVO getWishList(String member_id) {
	return userDao.getWishList(member_id);
    }

    @Override
    public int checkWishList(Map<String, Object> param) {
	return userDao.checkWishList(param);
    }

    @Override
    public int addToCart(Map<String, Object> param) {
	int count = userDao.isExistProductInCart(param);
	
	// 장바구니에 해당 상품이 없다면 INSERT INTO CART
	if (count == 0) {
	    userDao.addToCart(param);
	    return count;
	} else { // 해당 상품이 이미 존재한다면 INSERT 생략 
	    return count;
	}
    }

    @Override
    public List<CartVO> getCartList(String member_id) {
	return userDao.getCartList(member_id);
    }

    @Override
    public int getCartCount(String member_id) {
	return userDao.getCartCount(member_id);
    }

    @Override
    public int modifyCartQuantity(int no, int quantity) {
	return userDao.updateCartQuantity(no, quantity);
    }

    @Override
    public int getCartQuantity(int no) {
	return userDao.getCartQuantity(no);
    }

    @Override
    public void deleteCartOne(int no) {
	userDao.deleteCartList(no);
    }

    @Transactional
    @Override
    public void deleteCartList(List<Integer> noList) {
	// 삭제할 장바구니 상품 목록의 번호를 List로 가져와서 반복문으로 호출
	for(int no : noList) {
	    userDao.deleteCartList(no);
	}
    }

    @Override
    public void deleteCartAll(String member_id) {
	userDao.deleteCartAll(member_id);
    }

}
