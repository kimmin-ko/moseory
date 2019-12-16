package com.moseory.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.moseory.dao.MemberDao;
import com.moseory.domain.MemberVO;
import com.moseory.util.MailUtil;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberDao memberDao;

	@Setter(onMethod_ = @Autowired)
	private MailUtil mail;
	
	@Setter(onMethod_ = @Autowired)
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// 회원 등록
	@Override
	public void registerMember(MemberVO vo) {
		String encodePassword = bcryptPasswordEncoder.encode(vo.getPassword());
		vo.setPassword(encodePassword);
		log.info("encodePassword : " + encodePassword);
		memberDao.insertMember(vo);
	}

	// 회원 모두 삭제
	@Override
	public void deleteAll() {
		memberDao.deleteAll();
	}

	// 로그인
	@Override
	public MemberVO loginProc(Map<String, String> param) {
		// param -> inputId, inputPassword matches(입력받은 텍스트 패스워드, DB에 저장되어있는 암호화된 패스워드)
		boolean isAccord = bcryptPasswordEncoder.matches(param.get("inputPassword"), memberDao.getMemberPassword(param.get("inputId")));
		
		if(isAccord) { // 패스워드가 일치하면 id에 해당하는 회원 정보 조회
			return memberDao.loginProc(param.get("inputId"));
		} else {
			return null;
		}
		
	}

	// ID찾기
	@Override
	public List<Map<String, Object>> findIdProc(Map<String, Object> param) {
		String findType = (String) param.get("findType");
		if (findType.equals("phone")) {
			String phone = "";
			phone += (String) param.get("phone1");
			phone += (String) param.get("phone2");
			phone += (String) param.get("phone3");
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
	public int findPwProc(Map<String, Object> param) {

		int status = 0;
		String findType = (String) param.get("findType");
		Map<String, Object> map = new HashMap<String, Object>();
		try {

			if (findType.equals("phone")) {
				String phone = "";
				phone += (String) param.get("phone1");
				phone += (String) param.get("phone2");
				phone += (String) param.get("phone3");
				param.put("phone", phone);
			}

			map = memberDao.findPwProc(param);
			if (map != null && !map.isEmpty()) {
				// 입력한 정보가 존재하면 패스워드를 임의로 변경해주고 return
				String randomPwd = RandomStringUtils.randomAlphanumeric(10);
				// DB에 패스워드 변경할 때는 패스워드 암호화 한 후 전송
				map.put("pw", bcryptPasswordEncoder.encode(randomPwd));
				status = memberDao.pwChange(map);
				
				// mail 보낼 때는 암호화되지 않은 텍스트 패스워드 전송
				map.put("pw", randomPwd);
				System.out.println(map.toString());
				mail.sendMail(map);
				return status;
			} else {
				// 입력한 정보가 없으면 error return
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 3;
		}
	}

	@Override
	public MemberVO kakaoLogin(MemberVO vo) {

		/*
		 * 카카오 연동을 통해 들어온 user가 member Table에 들어가있는지 Check 후 없으면 신규회원, 있으면 정보를 VO에 담는다.
		 */

		int count = 0;
		String kakaoID = "";
		kakaoID = "K_" + vo.getId();
		vo.setId(kakaoID);
		count = memberDao.getCountMember(vo.getId());

		if (1 > count) {
			// 신규가입
			memberDao.insertKakaoMember(vo);
		} else {
			// 기존회원 정보
			vo = memberDao.selectKakaoMember(vo);
		}

		return vo;
	}
}
