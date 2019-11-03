package com.moseory.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moseory.dao.MemberDao;
import com.moseory.domain.MemberVO;
import com.moseory.util.MailUtil;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
public class MemberServiceImpl implements MemberService {
    
	
	
    @Setter(onMethod_ = @Autowired)
    private MemberDao memberDao;
    
    @Setter(onMethod_ = @Autowired)
    private MailUtil mail;
    
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

	@Override
	public int findPwProc(Map<String, Object> param) {
		
		int status = 0;
		String findType = (String)param.get("findType");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			if(findType.equals("phone")) {
				String phone = "";
				phone += (String)param.get("phone1");
				phone += (String)param.get("phone2");
				phone += (String)param.get("phone3");
				param.put("phone", phone);
			}

			map = memberDao.findPwProc(param);
			if(map != null && !map.isEmpty()) {
				//입력한 정보가 존재하면 패스워드를 임의로 변경해주고 return
				map.put("pw", RandomStringUtils.randomAlphanumeric(10));
				System.out.println(map.toString());
				status = memberDao.pwChange(map);
				
				mail.sendMail(map);
				return status;
			}else {
				//입력한 정보가 없으면 error return
				return 0;
			}
		}catch(Exception e) {
			e.printStackTrace();
			return 3;
		}
	}
}

















