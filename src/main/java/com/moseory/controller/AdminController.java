package com.moseory.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.moseory.domain.ProductDetailVO;
import com.moseory.domain.ProductVO;
import com.moseory.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@GetMapping("/productregist")
	public String productRegist() {
		
		return "admin/productregist";
	}

	@PostMapping("/productregist")
	public String productRegist(
			@ModelAttribute ProductVO productVO,
			@ModelAttribute ProductDetailVO productdetailVO
			) {
		
		System.out.println(productVO);
		System.out.println(productdetailVO);
		//1. product테이블에 제품정보 넣음
		adminService.product_regist(productVO);
		//2. sequence로 넣은 product테이블의 code가 필요함
		int code = adminService.setCode(productVO.getName());
		//3. 가져온 코드로 detail 등록
		productdetailVO.setProduct_code(code);
		//4. detail테이블에 등록
		adminService.product_detail_regist(productdetailVO);
		
		return "redirect:/index";
	}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value="/imageUpload", method=RequestMethod.POST)
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
								@RequestParam(value="upload") MultipartFile upload) {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        
        OutputStream out = null;
        PrintWriter printWriter = null;
        
        try{
        	String fileName = upload.getOriginalFilename();
        	byte[] bytes = upload.getBytes();
        	String uploadPath = request.getSession().getServletContext().getRealPath("/")+"/admin/imageUpload/"+fileName;
        	out = new FileOutputStream(new File(uploadPath));
        	out.write(bytes);
        	String callback = request.getParameter("CKEditorFuncNum");
        	
        	printWriter = response.getWriter();
        	String fileUrl = request.getContextPath() + "/admin/imageUpload/"+fileName;
        	
        	printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                    + callback
                    + ",'"
                    + fileUrl
                    + "','이미지를 업로드 하였습니다.'"
                    + ")</script>");
        	
        	printWriter.flush();
        }catch(IOException e){
        	e.printStackTrace();
        }finally{
        	try{
        		if(out != null) out.close();
        		if(printWriter != null) printWriter.close();
        	}catch(IOException e){
        		e.printStackTrace();
        	}
        }
	}
	
//	int code = adminService.getIntCode(productVO);
//	System.out.println("int로 받은 코드 = " + code);
////	productVO = adminService.getCode(productVO);
////	System.out.println("코드 = " + productVO.getCode());
//	List<ProductVO> list = adminService.getListCode(productVO);
//	for(ProductVO pVO : list) {
//		System.out.println("list로 받은 코드 = " + pVO);
//	}
//	productdetailVO.setProduct_code(productVO.getCode());
//	adminService.pdetail_regist(productdetailVO);

	
	
	
}
