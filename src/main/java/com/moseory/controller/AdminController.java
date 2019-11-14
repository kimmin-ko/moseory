package com.moseory.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.service.AdminService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	@GetMapping("/productregist")
	public String productRegist() {

		return "admin/productregist";
	}

	private static List<ProductDetailVO> detailInfo = new ArrayList<ProductDetailVO>();
	private Map<String, Object> map = new HashMap<>();
	@PostMapping(value = "/productInfo", consumes = "application/json")
	public void testProductInfo(@RequestBody Map<String,Object> detailInfo) {
		System.out.println(detailInfo);
		log.info("detailInfo = " + detailInfo);
//	public void productInfo(@RequestBody ProductDetailVO productDetail) {
//		detailInfo.add(productDetail);
//		
//		log.info("productDetail : " + productDetail);
	}

	@PostMapping("/productregist")
//	public String productRegist(@ModelAttribute ProductVO productVO) throws IllegalStateException, IOException {
		public String productRegist(@ModelAttribute ProductVO productVO,
//				 MultipartHttpServletRequest multipartRequest,
				 HttpServletRequest request) throws IllegalStateException, IOException {
		
//		log.info("productVO : " + productVO);
//		log.info("detailInfo : " + detailInfo.toString());
//		System.out.println(detailInfo);
		System.out.println("productVO = " + productVO);
		adminService.product_regist(productVO);
		int code = adminService.setCode(productVO.getName());
		
		for(int i = 0; i < detailInfo.size(); i++) {
			ProductDetailVO productdetailVO = detailInfo.get(i);
			productdetailVO.setProduct_code(code);
			adminService.product_detail_regist(productdetailVO);
		}
		detailInfo.clear();
		
//		파일 이름 불러와서 폴더경로 + 파일이름
		String save_path = "/moseory/src/main/webapp/resources/images/bottom/jacket/2/";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		List<MultipartFile> files = multipartRequest.getFiles("files");
		//경로가 없으면 디렉토리 생성
		File file = new File(save_path);
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		Map<String,String> result = new HashMap<>();
		for(int i = 0; i < files.size(); i++) {
			//파일명이 같을 수도 있기 때문에
			//랜덤36문자_받아온파일이름
			//으로 파일 저장
			UUID random = UUID.randomUUID();
			String fileName = random.toString()+"_"+files.get(i).getOriginalFilename();
			System.out.println("업로드된 파일 이름 = " + files.get(i).getOriginalFilename());
			file = new File(save_path+fileName);
			files.get(i).transferTo(file);
			
			//db에 있는 파일명과 경로를 불러와서 result 반환
//			result.put(key, value);
			
		}
				
		
		return "redirect:/index";
	}

	
	@GetMapping("/imageUpload")
	public String uploadTest() {
		return "admin/imageUpload";
	}
	
	
	
	
	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
	public void upload(MultipartHttpServletRequest multipartRequest) throws IllegalStateException, IOException {
		
		//파일 이름 불러와서 폴더경로 + 파일이름
		String save_path = "/moseory/src/main/webapp/resources/images/bottom/jacket/2/";
		List<MultipartFile> files = multipartRequest.getFiles("files");
		
		//경로가 없으면 디렉토리 생성
		File file = new File(save_path);
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		Map<String,String> result = new HashMap<>();
		for(int i = 0; i < files.size(); i++) {
			//파일명이 같을 수도 있기 때문에
			//랜덤36문자_받아온파일이름
			//으로 파일 저장
			UUID random = UUID.randomUUID();
			String fileName = random.toString()+"_"+files.get(i).getOriginalFilename();
			System.out.println("업로드된 파일 이름 = " + files.get(i).getOriginalFilename());
			file = new File(save_path+fileName);
			files.get(i).transferTo(file);
			
			//db에 있는 파일명과 경로를 불러와서 result 반환
			//result.put(key, value);
			
		}
		
		
	}
	
	
	
	
	
	@GetMapping("/detailTest")
	public String testProductInfo() {
		
		return "admin/detailTest";
	}
//	private static List<ProductDetailVO> testDetailInfo = new ArrayList<ProductDetailVO>();
//	private Map<String, Object> mapTest = new HashMap<>();
//	@PostMapping(value = "/detailTest", consumes = "application/json")
//	public void testProductInfo(@RequestBody Map<String,Object> detailInfo) {
//		System.out.println(detailInfo);
//		log.info("detailInfo = " + detailInfo);
//	public void testProductInfo(@RequestBody ProductDetailVO productDetail) {
//		testDetailInfo.add(productDetail);
		
//		log.info("productDetail : " + productDetail);
//	}
	
	
}
