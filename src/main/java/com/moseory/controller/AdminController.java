package com.moseory.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
import com.moseory.domain.MemberVO;
import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.service.AdminService;
import com.moseory.util.PagingUtil;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@PostMapping("/productcate")
	@ResponseBody
	public List<LowCateVO> productCate(@RequestBody int high_code){
		System.out.println(high_code);
		List <LowCateVO> lowCates = new ArrayList<>();
		lowCates = adminService.getChildCategory(high_code);
		return lowCates;
	}
	
	@GetMapping("/productregist")
	public String productRegist(Model model) {
		List<HighCateVO> highCates = adminService.getPrantCategory();
		model.addAttribute("highCates", highCates);
		return "admin/productregist";
	}

	private static List<ProductDetailVO> detailInfo = new ArrayList<ProductDetailVO>();

	@PostMapping(value = "/productInfo", consumes = "application/json")
	public @ResponseBody void productInfo(@RequestBody ProductDetailVO productDetailVO) {
		detailInfo.add(productDetailVO);
		log.info("detailInfo = " + detailInfo);
	}

	@PostMapping("/productregist")
	public String productRegist(@ModelAttribute ProductVO productVO, HttpServletRequest request, @RequestParam String str_low_code)
			throws IllegalStateException, IOException {
	    
		/* 파일 시작 */
		//한글로 받아오는 low_code를 int로 변경
		int low_code = adminService.getLowCateCode(str_low_code);
		productVO.setLow_code(low_code);
		String high_cate = adminService.getHighCate(productVO.getHigh_code());
		
		// 파일 이름 불러와서 폴더경로 + 파일이름
		ServletContext context = request.getSession().getServletContext();
		String save_path = context.getRealPath("resources/images/" + high_cate + "/" + str_low_code + "/" + productVO.getName() + "/");
		System.out.println("경로 : " + save_path);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> files = multipartRequest.getFiles("files");
		List<MultipartFile> getThumbnail = multipartRequest.getFiles("thumbnail");
		
		// 경로가 없으면 디렉토리 생성
		File file = new File(save_path);
		File thumbnail = new File(save_path);
		if (file.exists() == false) {
		    	log.info("디렉토리 생성");
			file.mkdirs();
			log.info("디렉토리 경로 : " + file.getAbsolutePath());
		}
		
		//확장자를 가져옴
		int split = getThumbnail.get(0).getOriginalFilename().lastIndexOf(".");
		String ext = getThumbnail.get(0).getOriginalFilename().substring(split);
		
		//썸네일명 = 상품명 + _thumbnail.확장자
		String thumbnailName = "thumbnail_" + productVO.getName() + ext;

		System.out.println(thumbnailName);
		thumbnail = new File(save_path + thumbnailName);
		getThumbnail.get(0).transferTo(thumbnail);
		
		String file_name = "";
		for (int i = 0; i < files.size(); i++) {
			// System.out.println(thumbnail.get(i).getName());
		    
			// 파일명이 같을 수도 있기 때문에
			// 랜덤36문자_받아온파일이름으로 파일 저장
			UUID random = UUID.randomUUID();
			String fileName = random.toString() + "_" + files.get(i).getOriginalFilename();
			file_name = file_name + "@" + fileName;
//			System.out.println("file_name = " + file_name);
//			System.out.println("업로드된 파일 이름 = " + files.get(i).getOriginalFilename());
			
			file = new File(save_path + fileName);
			files.get(i).transferTo(file);
		}
		
		/* product DB */
		adminService.product_regist(productVO);
		int code = adminService.setCode(productVO.getName());
		
		//product file DB
		Map <String, Object> fileParam = new HashMap<>();
		fileParam.put("product_code", code);
		fileParam.put("thumbnail_name", thumbnailName);
		fileParam.put("file_path", save_path);
		fileParam.put("file_name", file_name);
		adminService.saveFile(fileParam);

		/* product_detail DB */
		for (int i = 0; i < detailInfo.size(); i++) {
			ProductDetailVO productdetailVO = detailInfo.get(i);
			productdetailVO.setProduct_code(code);
			adminService.product_detail_regist(productdetailVO);
		}
		
		detailInfo.clear();

		return "redirect:/index";
	}

	@GetMapping("/manage")
	public void manage() {

	}

	@GetMapping("/category")
	public String category(HttpServletRequest req, Model model) {

		List<HighCateVO> category = new ArrayList<HighCateVO>();

		category = adminService.getPrantCategory();

		model.addAttribute("parentCategoryList", category);

		String msg = req.getParameter("msg") == null ? "" : req.getParameter("msg");
		model.addAttribute("msg", msg);

		return "admin/category";
	}

	@PostMapping("/saveParentsCategory")
	public String saveParentsCategory(@RequestParam("code") List<Integer> code, @RequestParam("name") List<String> name,
			@RequestParam("kname") List<String> kname, HttpServletRequest req, HttpServletResponse res, Model model) {

		int status = 0;
		status = adminService.saveParentsCategory(code, name, kname);
		if (status == 0) {
			model.addAttribute("msg", "저장 중 오류가 발생하였습니다.");
		} else {
			model.addAttribute("msg", "저장되었습니다.");
		}
		return "redirect:/admin/category";
	}

	@PostMapping("/deleteParentsCategory")
	public @ResponseBody int deleteParentsCategory( HttpServletRequest req , HttpServletResponse res , @RequestParam(value="codes") ArrayList<Integer> codes){
		int result = 0;
		for(int i =0; i < codes.size(); i++) {
			log.info(" code : " + codes.get(i) + " deleteParentsCategory  List :");
		}
		result = adminService.deleteParentsCategory(codes);
		return result;
	}

	@GetMapping("/lowCategory")
	public String lowCategory(@RequestParam("highCode") int highCode, HttpServletRequest req, Model model) {


		List<LowCateVO> lowCategory = new ArrayList<LowCateVO>();

		lowCategory= adminService.getChildCategory(highCode);
		model.addAttribute("preHighCode", highCode);
		model.addAttribute("childCategoryList", lowCategory);
		return "admin/lowCategory";
	}

	@PostMapping("/saveChildCategory")
	public String saveChildCategory(@RequestParam("code") List<Integer> code, @RequestParam("name") List<String> name
			, @RequestParam("highCode") List<Integer> highCode , HttpServletRequest req, HttpServletResponse res, Model model) {

		int status = 0;
		status = adminService.saveChildCategory(code, name, highCode);
		if(status == 0) {
			model.addAttribute("msg", "저장 중 오류가 발생하였습니다.");
		}else {
			model.addAttribute("msg", "저장되었습니다.");
		}
		return "redirect:/admin/category";
	}

	@PostMapping("/deleteChildCategory")
	public @ResponseBody int deleteChildCategory( HttpServletRequest req , HttpServletResponse res , @RequestParam(value="codes") ArrayList<Integer> codes){
		int result = 0;
		for(int i =0; i < codes.size(); i++) {
			log.info(" code : " + codes.get(i) + " deleteChildCategory List : ");
		}
		result = adminService.deleteChildCategory(codes);
		return result;
	}

	@GetMapping("/productlist")
	public String productList(@RequestParam(defaultValue = "1") int curPage, 
			@RequestParam(defaultValue = "name") String searchType,
			@RequestParam(defaultValue = "") String keyword,
			Model model) {
		List <ProductVO> productList = new ArrayList<>();

		model.addAttribute("searchType",searchType);
		model.addAttribute("keyword",keyword);

		PagingUtil pagingUtil;
		int totalCnt = 0;

		if(keyword.equals("") != false) {	//검색 안하면
			//리스트 개수 가져옴
			totalCnt = adminService.getProductCount();
			//리스트개수, 현재페이지를 model로 보내줌
			pagingUtil = new PagingUtil(totalCnt, curPage);
			//검색할 번호를 보내줌
			//ex) 1페이지면 row 1~10까지 조회, 5페이지면 51~60까지 조회
			productList = adminService.getProductList(pagingUtil.getStart(), pagingUtil.getFinish());
			model.addAttribute("productList", productList);
			model.addAttribute("paging",pagingUtil);
		}
		else {	//검색 하면
			if(searchType.equals("name")) {
				try {
					totalCnt = adminService.getProductCount(searchType, keyword);
					pagingUtil = new PagingUtil(totalCnt, curPage);
					productList = adminService.getProductList(pagingUtil.getStart(), pagingUtil.getFinish(), searchType, keyword);
					model.addAttribute("productList", productList);
					model.addAttribute("paging",pagingUtil);
				}catch(NullPointerException e) {
				}
			}
			else if(searchType.equals("high_code")) {
				try {
					totalCnt = adminService.getProductCount(searchType, keyword);
					pagingUtil = new PagingUtil(totalCnt, curPage);
					productList = adminService.getProductList(pagingUtil.getStart(), pagingUtil.getFinish(), searchType, keyword);
					model.addAttribute("productList", productList);
					model.addAttribute("paging",pagingUtil);
				}catch(NullPointerException e) {
				}

			}
			else if(searchType.equals("low_code")) {
				try {
					keyword = Integer.toString(adminService.getLowCateCode(keyword));
					totalCnt = adminService.getProductCount(searchType, keyword);
					pagingUtil = new PagingUtil(totalCnt, curPage);
					productList = adminService.getProductList(pagingUtil.getStart(), pagingUtil.getFinish(), searchType, keyword);
					model.addAttribute("productList", productList);
					model.addAttribute("paging",pagingUtil);
				}catch(NullPointerException e) {
				}
			}
		}

		List <String> highCates = new ArrayList<String>();
		List <String> lowCates = new ArrayList<String>();
		for(int i = 0; i < productList.size(); i++) {
			highCates.add(adminService.getHighCate(productList.get(i).getHigh_code()));
			lowCates.add(adminService.getLowCate(productList.get(i).getLow_code()));
		}
		model.addAttribute("highCates", highCates);
		model.addAttribute("lowCates", lowCates);


		return "admin/productlist"; 
	}
	
	@GetMapping("/stats")
	public String stats() {
		
		return "admin/stats";
	}	
	
	@GetMapping("userManagement")
	public String userManagement(HttpServletRequest req, Model model
			,@RequestParam(required = false, defaultValue = "all") String levelType
			,@RequestParam(required = false, defaultValue = "") String searchType
			,@RequestParam(required = false, defaultValue = "") String searchValue
			,@RequestParam(required = false, defaultValue = "") String commType
			,@RequestParam(required = false, defaultValue = "") String commValue
			,@RequestParam(required = false, defaultValue = "") String searchEmail
			,@RequestParam(defaultValue = "1") int curPage) {

		HashMap<String, Object> map = new HashMap<String,Object>();
		List<MemberVO> list = new ArrayList<MemberVO>();
		
		map.put("levelType", levelType);
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);
		map.put("commType", commType);
		map.put("commValue", commValue);
		map.put("searchEmail", searchEmail);
		
		int userCount = adminService.getUserCount(map);
		
		PagingUtil pagingUtil;
		pagingUtil = new PagingUtil(userCount, curPage);
		
		map.put("start", pagingUtil.getStart());
		map.put("finish", pagingUtil.getFinish());
		
		list = adminService.getUser(map);
		System.out.println(list.toString());
		model.addAttribute("userList", list);
		model.addAttribute("levelType", levelType);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("commType", commType);
		model.addAttribute("commValue", commValue);
		model.addAttribute("searchEmail", searchEmail);
		
		String msg = (req.getParameter("msg") == null) ? "" : req.getParameter("msg");
		if(!msg.equals("")) {
			model.addAttribute("msg", msg);
		}
		
		model.addAttribute("paging",pagingUtil);
		
		return "admin/userManagement"; 
	}

	@GetMapping("getUserDetail")
	public String getUserDetail(@RequestParam(required = true, defaultValue = "") String id, HttpServletRequest req, Model model) {
		
		MemberVO member = new MemberVO();
		member = adminService.getUserDetail(id);
		System.out.println(member.toString());
		String msg = (req.getParameter("msg") == null) ? "" : req.getParameter("msg");
		if(!msg.equals("")) {
			model.addAttribute("msg", msg);
		}
		model.addAttribute("member", member);
		return "admin/userDetail";
	}
	
	@PostMapping("modifyUserInfo")
	public String modifyUserInfo(@RequestParam Map<String, Object> param, RedirectAttributes redirectAttributes, HttpServletRequest req, Model model) {
		 
		System.out.println("Contorller modifyUserInfo param ["+ param.toString() +"]");
		int result = adminService.modifyUserInfo(param);
		String msg = "";
		if(result > 0) {
			msg = "저장되었습니다.";
			redirectAttributes.addAttribute("msg", msg);
			return "redirect:/admin/userManagement";
		}else {
			msg = "시스템 에러";
			String id = (param.get("id") == null) ? "" : param.get("id").toString();
			redirectAttributes.addAttribute("id", id);
			redirectAttributes.addAttribute("msg", msg);
			return "redirect:/admin/userDetail";
		}
						
	}
	
	@GetMapping("orderManageList")
	public String orderManageList (
			@RequestParam(required = false, defaultValue = "") String searchType
			,@RequestParam(required = false, defaultValue = "") String searchValue
			,@RequestParam(required = false, defaultValue = "") String commType
			,@RequestParam(required = false, defaultValue = "") String commValue
			,@RequestParam(required = false, defaultValue = "") String searchEmail
			,@RequestParam(required = false, defaultValue = "") String startDate
			,@RequestParam(required = false, defaultValue = "") String endDate
			,@RequestParam(required = false, defaultValue = "전체 상태") String state
			,@RequestParam(required = false, defaultValue = "") String orderValue
			,@RequestParam(defaultValue = "1") int curPage, HttpServletRequest req, Model model) {
		
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);
		map.put("commType", commType);
		map.put("commValue", commValue);
		map.put("searchEmail", searchEmail);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("state", state);
		map.put("orderValue", orderValue);
		
		
		int orderCount = adminService.getOrderCount(map);
		
		PagingUtil pagingUtil;
		pagingUtil = new PagingUtil(orderCount, curPage);
		
		map.put("start", pagingUtil.getStart());
		map.put("finish", pagingUtil.getFinish());

		list = adminService.getOrder(map);
		model.addAttribute("orderList", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("commType", commType);
		model.addAttribute("commValue", commValue);
		model.addAttribute("searchEmail", searchEmail);
		model.addAttribute("orderValue",orderValue);
		model.addAttribute("paging",pagingUtil);
		
		return "admin/orderManageList";
	}
	
	@GetMapping("getOrderDetail")
	public String getOrderDetail(
			@RequestParam(required = true, defaultValue = "") String orderCode,
			@RequestParam(required = true, defaultValue = "") String productDetailNo,
			@RequestParam(required = false, defaultValue = "") String productColor,
			HttpServletRequest req, Model model) {
		
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		HashMap<String, Object> orderInfo = new HashMap<String,Object>();
		
		map.put("orderCode", orderCode);
		map.put("productDetailNo", productDetailNo);
		map.put("productColor", productColor);
		
		orderInfo = adminService.getOrderInfo(map);
		System.out.println(orderInfo.toString());
		model.addAttribute("orderInfo", orderInfo);
		
		return "admin/orderManageDetail";
	}
	
}
	


