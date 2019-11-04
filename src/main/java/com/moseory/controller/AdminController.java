package com.moseory.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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

	@PostMapping(value = "/productInfo", consumes = "application/json")
	public @ResponseBody List<ProductDetailVO> productInfo(@RequestBody ProductDetailVO productDetail,
												Model model) {
		List<ProductDetailVO> detailInfo = new ArrayList<ProductDetailVO>();
		detailInfo.add(productDetail);
		System.out.println("detailInfo = " + detailInfo);
		return detailInfo;
	}
	
	@PostMapping("/productregist")
	public String productRegist(
			@ModelAttribute ProductVO productVO,
			@ModelAttribute ProductDetailVO productdetailVO
			) {
		
		System.out.println(productVO);
		System.out.println(productdetailVO);
		
		
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
		
		
		
		
		
		
		
		
//		productVO.setHigh_cate(HighCate.OUTER);
//		System.out.println(productVO.getHigh_cate().getCode());
		//1. product에 데이터 등록
		adminService.product_regist(productVO);
		//2. sequence로 code가 들어가기 때문에 받아오는 productVO로는 code를 모름
		int code = adminService.setCode(productVO.getName());
		//3. 중복되지 않는 name으로 code를 조회해옴
		productdetailVO.setProduct_code(code);
		//4. detail에 데이터 등록
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
                    + "','�̹����� ���ε� �Ͽ����ϴ�.'"
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
//	System.out.println("int�� ���� �ڵ� = " + code);
////	productVO = adminService.getCode(productVO);
////	System.out.println("�ڵ� = " + productVO.getCode());
//	List<ProductVO> list = adminService.getListCode(productVO);
//	for(ProductVO pVO : list) {
//		System.out.println("list�� ���� �ڵ� = " + pVO);
//	}
//	productdetailVO.setProduct_code(productVO.getCode());
//	adminService.pdetail_regist(productdetailVO);

	
	
	
}
