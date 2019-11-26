package com.moseory.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.moseory.domain.HighCateVO;
import com.moseory.domain.LowCateVO;
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
	public void productInfo(@RequestBody ProductDetailVO productDetailVO) {
		detailInfo.add(productDetailVO);
		log.info("detailInfo = " + detailInfo);
	}

	@PostMapping("/productregist")
	public String productRegist(@ModelAttribute ProductVO productVO, HttpServletRequest request)
			throws IllegalStateException, IOException { 
		
		/* 파일 시작 */
		String high_cate = adminService.getHighCate(productVO.getHigh_code());
		String low_cate = adminService.getLowCate(productVO.getLow_code());
		//	파일 이름 불러와서 폴더경로 + 파일이름
		String save_path = "/moseory/src/main/webapp/resources/images/" + high_cate + "/" + low_cate + "/" + productVO.getName() + "/";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> files = multipartRequest.getFiles("files");
		// 경로가 없으면 디렉토리 생성
		File file = new File(save_path);
		if (file.exists() == false) {
			file.mkdirs();
		}
		String file_name = "";
		for (int i = 0; i < files.size(); i++) {
			// 파일명이 같을 수도 있기 때문에
			// 랜덤36문자_받아온파일이름
			// 으로 파일 저장
			UUID random = UUID.randomUUID();
			String fileName = random.toString() + "_" + files.get(i).getOriginalFilename();
			file_name = file_name + "@" + fileName;
			System.out.println("file_name = " + file_name);
			System.out.println("업로드된 파일 이름 = " + files.get(i).getOriginalFilename());
			file = new File(save_path + fileName);
			files.get(i).transferTo(file);
		}

		productVO.setFile_name(file_name);
		productVO.setFile_path(save_path);

		/* product DB */
		adminService.product_regist(productVO);
		int code = adminService.setCode(productVO.getName());

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
			totalCnt = adminService.getProductCount();
			pagingUtil = new PagingUtil(totalCnt, curPage);

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
					keyword = Integer.toString(adminService.getHighCateCode(keyword));
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
	public String userManagement() {
	
//		adminService.getUser();
		return "admin/userManagement"; 
	}
}
	
