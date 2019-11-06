package com.moseory.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moseory.dao.UserDao;
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



}
