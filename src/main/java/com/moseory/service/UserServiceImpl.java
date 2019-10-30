package com.moseory.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.UserDao;
import com.moseory.domain.MemberVO;

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

}
