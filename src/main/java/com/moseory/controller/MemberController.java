package com.moseory.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.MemberVO;
import com.moseory.service.HomeService;
import com.moseory.service.MemberService;
import com.moseory.util.KakaoConnectionUtil;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*") // 로그인 정보가 필요하지 않음
public class MemberController {

	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;

	@Setter(onMethod_ = @Autowired)
	private KakaoConnectionUtil kakao;

	@Setter(onMethod_ = @Autowired)
	private HomeService homeService;

	@Setter(onMethod_ = @Autowired)
	private ServletContext application;

	// 요청 시 해당 필드만 데이터 입력 허용
	@InitBinder
	public void InitBinder(WebDataBinder dataBinder) {
		dataBinder.setAllowedFields("id", "password", "pwd_confirm_*", "name", "zipcode", "address*", "tel", "phone",
				"email", "birth");
	}

	@GetMapping("/login")
	public void login() {
		// HighCate를 가져옴
		List<HighCateVO> highCateList = homeService.readHighCate();

		application.setAttribute("highCateList", highCateList);

	}

	@PostMapping("/loginProc")
	public String loginProc(@RequestParam Map<String, String> param, HttpServletRequest req, HttpServletResponse res,
			Model model) {
		log.info("Contorller loginProc param [" + param.toString() + "]");

		if (req.getParameter("inputPassword") == null || req.getParameter("inputPassword").toString().equals("")) {
			model.addAttribute("msg", "비밀번호를 입력해주세요");
			return "member/login";
		}

		MemberVO vo = memberService.loginProc(param);

		if (vo == null) {
			model.addAttribute("msg", "일치하는 회원 정보가 없습니다.");
			return "member/login";
		} else {
			model.addAttribute("user", vo);
			return "index";
		}

	}

	@GetMapping("/findId")
	public void fintId() {

	}

	@PostMapping("/findIdProc")
	public String fintIdProc(@RequestParam Map<String, Object> param, Model model) {
		log.info("Contorller findIdProc param [" + param.toString() + "]");

		List<Map<String, Object>> findIds = new ArrayList<Map<String, Object>>();
		findIds = memberService.findIdProc(param);

		if (findIds.isEmpty()) {
			model.addAttribute("msg", "입력하신 정보로 검색된 결과가 없습니다.");
			return "/member/findId";
		} else {
			model.addAttribute("findIds", findIds);
			model.addAttribute("findIdCount", findIds.size());
			return "/member/findIdProc";
		}
	}

	@GetMapping("/findPw")
	public void findPw() {

	}

	@PostMapping("/findPwProc")
	public @ResponseBody int findPwProc(@RequestParam Map<String, Object> param) {
		log.info("Contorller findPwProc param [" + param.toString() + "]");
		int result = 0;
		result = memberService.findPwProc(param);
		return result;
	}

	@GetMapping("/join")
	public void joinForm() {

	}

	@PostMapping("/join")
	public String join(@ModelAttribute("member") MemberVO vo) {

		memberService.registerMember(vo);

		// 회원 가입 응답 페이지에서 새로고침 시 데이터 등록이 중복되지 않도록 redirect를 이용
		// 시스템(session, DB)에 변화가 생기지 않는 단순조회(리스트, 검색)의 경우 forward 이용
		return "redirect:joinOk";
	}

	// 회원가입 시 아이디 중복 체크
	@GetMapping("/checkDuplId/{id}")
	public @ResponseBody ResponseEntity<String> checkDuplId(@PathVariable("id") String id) {

		int result = memberService.isMember(id);
		String resultStr = "";
		
		
		if (result > 0) // 중복인 경우
			resultStr = "duplicaiton";
		else // 중복이 아닌 경우
			resultStr = "";
		
		return new ResponseEntity<String>(resultStr, HttpStatus.OK);
	}

	// 회원 가입 성공 페이지
	@GetMapping("/joinOk")
	public void joinOk() {

	}

	@GetMapping("/kakaoLogin")
	public String kakaoLogin(@RequestParam("code") String code, RedirectAttributes ra, Model model, HttpSession session,
			HttpServletResponse res) throws Exception {

		String accessToken = kakao.getAccessToken(code);
		MemberVO vo = kakao.getUserInfo(accessToken);

		log.info("kakao getUserInfo : " + vo);

		vo = memberService.kakaoLogin(vo);
		model.addAttribute("user", vo);
		return "/index";
	}

}
