package com.mountaintour.mountain.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.service.ProductService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/product")
@Controller
public class ProductController {

  private final ProductService productService;
	
  @GetMapping("/list.do")
  public String list(Model model) {
	  model.addAttribute("count", productService.getTotalProductCount());
	 return "product/list"; 
	}
  
  @GetMapping("/write.form")
  public String write() {
	 return "product/write"; 
	}
  @PostMapping("/add.do")
  public String add(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) throws Exception {
      int addResult = productService.addProduct(multipartRequest);

      if (addResult == 1) {
          redirectAttributes.addFlashAttribute("successMessage", "Product added successfully!");
      } else {
          redirectAttributes.addFlashAttribute("errorMessage", "Failed to add product. Please try again.");
      }
  
      return "redirect:/product/list.do";
  }

  @GetMapping("/increseHit.do")
  public String increseHit(@RequestParam(value="productNo", required=false, defaultValue="0") int productNo) {
    int increseResult = productService.increseHit(productNo);
    if(increseResult == 1) {
      return "redirect:/product/detail.do?productNo=" + productNo;
    } else {
      return "redirect:/product/list.do";
    }
  }
  
  @PostMapping(value="/heartProduct.do" , produces="application/json")
  public String heart(HttpServletRequest request, RedirectAttributes redirectAttributes) {
	int heartResult = productService.addHeart(request);
	redirectAttributes.addFlashAttribute("heartResult", heartResult);
	return "redirect:/product/detail.do?productNo=" + request.getParameter("productNo"); 
  }
  
  
  @ResponseBody
  @PostMapping(value="/addThumbnail.do", produces="application/json")
  public Map<String, Object> addThumbnail(MultipartHttpServletRequest multipartRequest) throws Exception {
    return productService.addThumbnail(multipartRequest);
  }
  
  @ResponseBody
  @PostMapping(value="/imageUpload.do", produces="application/json")
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest) {
    return productService.imageUpload(multipartRequest);
  }
  
  @ResponseBody
  @GetMapping(value="/getList.do", produces="application/json")
  public Map<String, Object> getList(HttpServletRequest request){
    return productService.getProductList(request);
  }  

  @GetMapping("/detail.do")
  public String detail(@RequestParam(value="productNo", required=false, defaultValue="0") int productNo
          , Model model) {
	 ProductDto product = productService.getProduct(productNo);
	 model.addAttribute("product", product);
	 return "product/detail"; 
	}
  
  @PostMapping("/edit.do")
  public String edit(@ModelAttribute("product") ProductDto product) {
    return "product/edit";
  }
  
  @PostMapping("/modifyProduct.do")
  public String modifyProduct(HttpServletRequest request, RedirectAttributes redirectAttributes) {
	  int modifyResult = productService.modifyProduct(request);
	  redirectAttributes.addFlashAttribute("modifyResult", modifyResult);
	  return "redirect:/product/detail.do?productNo=" + request.getParameter("productNo"); 
	}
  
  @PostMapping("/remove.do")
  public String remove(@RequestParam(value="productNo", required=false, defaultValue="0") int productNo
                     , RedirectAttributes redirectAttributes) {
    int removeResult = productService.removeProduct(productNo);
    redirectAttributes.addFlashAttribute("removeResult", removeResult);
    return "redirect:/product/list.do";
  }
  
  @ResponseBody
  @GetMapping(value="/hitList.do", produces="application/json")
  public Map<String, Object> hitList(HttpServletRequest request){
    return productService.getHit(request);
  }
  
  @ResponseBody
  @GetMapping(value="/reviewProductList.do", produces="application/json")
  public Map<String, Object> reviewProductList(HttpServletRequest request){
	  return productService.getReviewProductList(request);
  }
  
  @ResponseBody
  @PostMapping(value="/addReview.do", produces="application/json")
  public Map<String, Object> addReview(HttpServletRequest request) {
    return productService.addReview(request);
  }
  
  
  
  @ResponseBody
  @GetMapping(value="/reviewList.do", produces="application/json")
  public Map<String, Object> ReviewList(HttpServletRequest request){
    return productService.loadReviewList(request);
  }
  
  @ResponseBody
  @PostMapping(value="/removeReview.do", produces="application/json")
  public Map<String, Object> removeReview(@RequestParam(value="reviewNo", required=false, defaultValue="0") int reviewNo) {
    return productService.removeReview(reviewNo);
  }
  
}
