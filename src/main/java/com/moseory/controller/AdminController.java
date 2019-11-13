package com.moseory.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String productRegist(@ModelAttribute ProductVO productVO) {

		log.info("productVO : " + productVO);
		log.info("detailInfo : " + detailInfo.toString());
		System.out.println(detailInfo);

		adminService.product_regist(productVO);
		int code = adminService.setCode(productVO.getName());
		
		for(int i = 0; i < detailInfo.size(); i++) {
			ProductDetailVO productdetailVO = detailInfo.get(i);
			productdetailVO.setProduct_code(code);
			adminService.product_detail_regist(productdetailVO);
		}
		detailInfo.clear();
		/**
		ProductVO(code=0, name=moseory, high_code=1, low_code=10, price=30000, sale_count=0, wish_count=0, grade=0, file_path=this is null, file_name=this is null, product_comment=)
		ProductDetailVO(no=0, product_code=0, product_color=WH, product_size=xs,s,m, product_stock=1234)
		no = 1,2,3,4,5~~~(++1);
		product_code = select code from tbl_product;
		product_color = wh,bl,red,~~~
		product_size = xs,s,m,l,xl
		product_stock = 1,10,1,10,1

		1, 청자켓
		detail = 1, 1, wh, s, 10
					= 2, 1, wh, m, 10
					= 3, 1, wh, l, 10
					= 4, 1, bl, s, 10
					= 5, 1, bl, m, 10
					= 6, 1, bl, l, 10
					= 7, 1, bl, xl, 10
					~~~
					~~~

		for(int i = 0; i < product_color.length; i++{
			productdetailVO.setProduct_color(product_color[i]);

			for(int j = 0; j < product_size.length; j++{
				productdetailVO.setProduct_size();
			}
		}
		
		 **/

		return "redirect:/index";
	}

	
	@GetMapping("/imageUpload")
	public String uploadTest() {
		return "admin/imageUpload";
	}
	
	
	
	
	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
	public String upload(MultipartHttpServletRequest multipartRequest) throws IllegalStateException, IOException {
		//파일 이름 불러와서 폴더경로 + 파일이름
		String save_path = "/moseory/src/main/webapp/resources/images/outer/jacket/1/";
		List<MultipartFile> files = multipartRequest.getFiles("fileData");
		
		File file = new File(save_path);
		for(int i = 0; i < files.size(); i++) {
			UUID random = UUID.randomUUID();
			String fileName = random.toString()+"_"+files.get(i).getOriginalFilename();
			System.out.println("업로드된 파일 이름 = " + files.get(i).getOriginalFilename());
			file = new File(save_path+fileName);
			files.get(i).transferTo(file);
		}
		
		
		return "리다이렉트";
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
