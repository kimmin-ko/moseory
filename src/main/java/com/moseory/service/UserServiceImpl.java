package com.moseory.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.UserDao;
import com.moseory.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
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
	log.info("service member : " + vo.getPwd_confirm_a());
	System.out.println("service member : " + vo.getPwd_confirm_a());
	userDao.updateMember(vo);
    }

    @Override
    public void removeMember(String id) {
	userDao.deleteMember(id);
    }

}
