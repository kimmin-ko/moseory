package com.moseory.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.MemberDao;
import com.moseory.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
    
    @Setter(onMethod_ = @Autowired)
    private MemberDao memberDao;
    
    // 회원 등록
    @Override
    public void registerMember(MemberVO vo) {
	memberDao.insertMember(vo);
    }

    // 회원 모두 삭제
    @Override
    public void deleteAll() {
	memberDao.deleteAll();
    }

    //로그인
	@Override
	public MemberVO loginProc(Map<String, Object> param) {
		return memberDao.loginProc(param);
	}
    
    // ID찾기
	@Override
	public List<Map<String, Object>> findIdProc(Map<String, Object> param) {
		String findType = (String)param.get("findType");
		if(findType.equals("phone")) {
			String phone = "";
			phone += (String)param.get("phone1");
			phone += (String)param.get("phone2");
			phone += (String)param.get("phone3");
			param.put("phone", phone);
		}
		return memberDao.findIdProc(param);
	}
	
    // 회원 아이디 여부
    @Override
    public int isMember(String id) {
	return memberDao.getCountMember(id);
    }

    @Override
    public MemberVO readMember(String id) {
	return memberDao.getMember(id);
    }

}

















