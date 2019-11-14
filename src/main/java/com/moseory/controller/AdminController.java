package com.moseory.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.annotation.MultipartConfig;
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
    public void testProductInfo(@RequestBody Map<String, Object> detailInfo) {
	log.info("detailInfo : " + detailInfo);
    }

    @PostMapping("/productregist")
    public String productRegist(
	    @ModelAttribute ProductVO productVO,
	    MultipartFile[] files,
	    HttpServletRequest request) {
	
	
	 for(MultipartFile multipartFile : files) {
	 log.info(multipartFile.toString()); }
	 

	log.info("productVO : " + productVO);
	
	return "redirect:/admin/productregist";
    }
	
/*	adminService.product_regist(productVO);
	int code = adminService.setCode(productVO.getName());

	for (int i = 0; i < detailInfo.size(); i++) {
	    ProductDetailVO productdetailVO = detailInfo.get(i);
	    productdetailVO.setProduct_code(code);
	    adminService.product_detail_regist(productdetailVO);
	}
	detailInfo.clear();

//	파일 이름 불러와서 폴더경로 + 파일이름
	String save_path = "/moseory/src/main/webapp/resources/images/bottom/jacket/2/";
	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	List<MultipartFile> files = multipartRequest.getFiles("files");
	// 경로가 없으면 디렉토리 생성
	File file = new File(save_path);
	if (file.exists() == false) {
	    file.mkdirs();
	}

	Map<String, String> result = new HashMap<>();
	for (int i = 0; i < files.size(); i++) {
	    // 파일명이 같을 수도 있기 때문에
	    // 랜덤36문자_받아온파일이름으로 파일 저장
	    UUID random = UUID.randomUUID();
	    String fileName = random.toString() + "_" + files.get(i).getOriginalFilename();
	    System.out.println("업로드된 파일 이름 = " + files.get(i).getOriginalFilename());
	    file = new File(save_path + fileName);
	    
	    try {
		files.get(i).transferTo(file);
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}

	return "redirect:/index";
    }
*/
    @GetMapping("/detailTest")
    public String testProductInfo() {

	return "admin/detailTest";
    }
    
}
