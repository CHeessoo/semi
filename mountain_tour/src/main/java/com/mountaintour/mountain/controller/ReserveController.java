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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.dto.ReserveDto;
import com.mountaintour.mountain.service.ProductService;
import com.mountaintour.mountain.service.ReserveService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/reserve")
@Controller
public class ReserveController {
  
  private final ReserveService reserveService;
  private final ProductService productService;
  

  // 상품상세에서 요청이 올 때 데이터 받아서 저장하기
  @GetMapping("/write.form")
  public String reserve(HttpServletRequest request, Model model) {
    ProductDto product = productService.getProduct(Integer.parseInt(request.getParameter("productNo")));
    model.addAttribute("product", product);
    model.addAttribute("resDate", request.getParameter("resDate"));
    return "reserve/write";
  }
  
  @GetMapping("/detail.do")
  public String detail(@RequestParam(value="reserveNo", required = false, defaultValue = "0") int reserveNo, Model model) {
    ReserveDto reserve = reserveService.loadReserve(reserveNo);
    model.addAttribute("reserve", reserve);
    return "reserve/detail";
  }
  
  @GetMapping("/list.do")
  public String list(HttpServletRequest request, Model model) {
    if(request.getParameter("userNo") != null) { // userNo가 파라미터로 넘어오는 경우 
      reserveService.loadReserveListByUser(request, model);
    } else { // 파라미터가 없는 경우
      reserveService.loadReserveList(request, model);
    }
    return "reserve/list";
  }
  
  @PostMapping("/edit.form")
  public String edit(@ModelAttribute("reserve") ReserveDto reserve) {
    return "reserve/edit";
  }
  
  @PostMapping("/modifyReserve.do")
  public String modifyBlog(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int modifyResult = reserveService.modifyReserve(request);
    redirectAttributes.addFlashAttribute("modifyResult", modifyResult);
    return "redirect:/reserve/detail.do?reserveNo=" + request.getParameter("reserveNo");
  }
  
  
  @PostMapping("/delete.do")
  public String removeReserve(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("removeResult", reserveService.removeReserve(request));
    return "redirect:/reserve/list.do?" + request.getParameter("userNo");
  }
  
  @ResponseBody
  @PostMapping(value="/addReserve.do", produces="application/json")
  public Map<String, Object> addReserve(HttpServletRequest req, RedirectAttributes redirectAttributes) throws Exception {
    return reserveService.addReserve(req);
  }
  
  @PostMapping("/addTourist.do")
  public String addTourist(HttpServletRequest req, RedirectAttributes redirectAttributes) throws Exception {
    int addTouristResult = reserveService.addTourist(req);
    redirectAttributes.addFlashAttribute("addTouristResult", addTouristResult);
    return "redirect:/reserve/detail.do?reserveNo=" + req.getParameter("reserveNo");
  }

  @ResponseBody
  @GetMapping(value="/getTouristInfo.do", produces="application/json")
  public Map<String, Object> getTourists(HttpServletRequest request) {
    return reserveService.loadTourists(request);
  }
  
}
