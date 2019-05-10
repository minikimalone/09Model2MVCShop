package com.model2.mvc.web.product;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;


//==> 占쏙옙품占쏙옙占쏙옙 Controller
@Controller
@RequestMapping("/product/*") 
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	
	private ProductService productService;
	@Qualifier("purchaseServiceImpl")
	@Autowired
	private PurchaseService purchaseService;
	
	
	//setter Method 占쏙옙占쏙옙 占쏙옙占쏙옙
		
	
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 占쏙옙占쏙옙 占쌀곤옙
	//==> 占싣뤄옙占쏙옙 占싸곤옙占쏙옙 占쌍쇽옙占쏙옙 풀占쏙옙 占실미몌옙 확占쏙옙 占쌀곤옙
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProductView() throws Exception {

		System.out.println("/addProductView.do");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	//@RequestMapping("/addProduct.do")
	public String addProduct( @ModelAttribute("product") Product product, @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("/addProduct.do");
		System.out.println(file.getOriginalFilename());
		//Business Logic
		
		
		
		String path="C:\\workspace\\09.Model2MVCShop(jQuery)\\WebContent\\images\\uploadFiles";
		String fileName=file.getOriginalFilename();
		product.setFileName(fileName);
		FileOutputStream fileOutputStream;
		
		try {
			
			//nf.createNewFile();
			fileOutputStream= new FileOutputStream(path+"\\"+fileName);
			fileOutputStream.write(file.getBytes());
			fileOutputStream.close();
		}
		catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
			

		product.setManuDate(product.getManuDate().replace("-", ""));
	

		productService.addProduct(product);
		

		
		return "forward:/product/addProduct.jsp";
	}
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct( @RequestParam("prodNo") int prodNo ,  @RequestParam("menu") String menu , Model model, @CookieValue(value="history", required=false) Cookie cookie, HttpServletResponse response) throws Exception {
		
		System.out.println("/getProduct.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
	
		String page=null;
		
		// Model 占쏙옙 View 占쏙옙占쏙옙
		model.addAttribute("product", product);
		
		
		if(cookie!=null) {
			cookie.setValue(cookie.getValue()+","+Integer.toString(prodNo));
		}else {
		cookie= new Cookie("history", Integer.toString(prodNo));
	}
		cookie.setPath("/");
		cookie.setMaxAge(60*60);
		response.addCookie(cookie);
		
		
		
		if(menu.equals("manage")){
		page = "forward:/product/updateProductView.jsp";
		}else {
		
		
		page = "forward:/product/getProduct.jsp";
		
		
		}
	
		return page;
		}

	
	
	@RequestMapping( value="updateProductView", method=RequestMethod.GET )
	//@RequestMapping("/updateProductView.do")
	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/updateProductView.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 占쏙옙 View 占쏙옙占쏙옙
		
		
		model.addAttribute("product", product);
		
		
		
		return "forward:/product/updateProductView.jsp";
	}
	
	
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	//@RequestMapping("/updateProduct.do")
	public String updateProduct( @ModelAttribute("product") Product product, @RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response)  throws Exception{

		System.out.println("/updateProduct");
		//Business Logic
		System.out.println(file.getOriginalFilename());
		//Business Logic
		
		
		
		String path="C:\\workspace\\09.Model2MVCShop(jQuery)\\WebContent\\images\\uploadFiles";
		String fileName=file.getOriginalFilename();
		product.setFileName(fileName);
		FileOutputStream fileOutputStream;
		
		try {
			
			//nf.createNewFile();
			fileOutputStream= new FileOutputStream(path+"\\"+fileName);
			fileOutputStream.write(file.getBytes());
			fileOutputStream.close();
		}
		catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
			
		productService.updateProduct(product);
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=update";
	
	
		//return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=update";
	}
	
	
	
	@RequestMapping( value="listProduct" )

	public String listProduct( @ModelAttribute("search") Search search ,@ModelAttribute("purchase") Purchase purchase, Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		// Business logic 占쏙옙占쏙옙
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		String tranCode= purchase.getTranCode();
		
		System.out.println(resultPage);
		
		
		
		System.out.println(tranCode);
		
		// Model 占쏙옙 View 占쏙옙占쏙옙
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		return "forward:/product/listProduct.jsp";
	}
	
	
//		@RequestMapping("/product/updateTranCodeByProdAction")
//		//@RequestMapping("/updateTranCodeByProdAction.do")
//		public String updateTranCodeByProdAction( @RequestParam("prodNo") int prodNo, @RequestParam("tranCode") String tranCode, @ModelAttribute("product") Product product ) throws Exception{
//
//			System.out.println("/updateTranCodeByProdAction.do");
//			//Business Logic
//
//			PurchaseService purchaseService = new PurchaseServiceImpl();
//			Purchase purchase = purchaseService.getPurchase2(prodNo);
//			purchase.setTranCode(tranCode);
//			
//			purchaseService.updateTranCode(purchase);
//			
//			
//			
//			return "redirect:/product/listProduct?menu=manage";
//		}
		
		


	}