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

import com.mountaintour.mountain.dto.MagazineDto;
import com.mountaintour.mountain.service.MagazineService;

import lombok.RequiredArgsConstructor;
import oracle.jdbc.proxy.annotation.Post;

@RequiredArgsConstructor
@RequestMapping("/magazine")
@Controller
public class MagazineController {
   private final MagazineService magazineService;
  
  
  
  /*************리스트컨트롤러 ***************/

  
  @GetMapping("/list.do")
  public String magazineList() {
    return "magazine/list";
  }
  
  @ResponseBody
  @GetMapping(value="/getList.do", produces="application/json" )
  public Map<String, Object> getList(HttpServletRequest request){
    return magazineService.getMagazineList(request);  
  }
  /*************작성컨트롤러 ***************/
  
  @GetMapping("/write.form")
  public String writeForm() {
    return "magazine/write";
  }
   
  @ResponseBody  
  @GetMapping(value="/getProductNo.do", produces="application/json")
  public Map<String, Object> getProductNo() { 
    return magazineService.loadProductNo();
  }
  
  @ResponseBody
  @PostMapping(value="/imageUpload.do", produces="application/json")    //매거진 작성 이미지 파일 저장
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest) {
    return magazineService.imageUpload(multipartRequest);
  }
  
 @PostMapping("/uploadOne.do")
 public String firstAdd(HttpServletRequest request, RedirectAttributes redirectAttributes) { 
   redirectAttributes.addFlashAttribute("map", magazineService.firstUpload(request));   
   return "redirect:/magazine/thumbnail.form";
 }
 
 @GetMapping("/thumbnail.form")
 public String thumbnail() {
   return "magazine/thumbnail";
 }
 
 @PostMapping("/final.do")
 public String finalAdd(MultipartHttpServletRequest multipartRequest
               , RedirectAttributes redirectAttributes) throws Exception {
   boolean addResult = magazineService.addThumbnail(multipartRequest);
   redirectAttributes.addFlashAttribute("addResult", addResult);
   return "redirect:/magazine/list.do";
 }
 /*************조회수 증가 ***************/

 @GetMapping("/increseHit.do")
 public String increseHit(HttpServletRequest request) {
   int magazineNo = Integer.parseInt(request.getParameter("magazineNo"));
   int increseResult = magazineService.increaseHit(magazineNo);
   System.out.println("-----" + increseResult + "-----");
   if(increseResult == 1) {
     return "redirect:/magazine/detail.do?magazineNo=" + magazineNo;
   } else {
     return "redirect:/magazine/list.do";
   }
 }
 /*************디테일컨트롤러 ***************/
 
 @GetMapping("/detail.do")
 public String detail(@RequestParam(value="magazineNo", required=false, defaultValue="0") int magazineNo, Model model) {
   magazineService.loadMagazine(magazineNo, model);
   return "magazine/detail";
 }
 
 @PostMapping("/modify.form")
 public String modify(@ModelAttribute("magazine") MagazineDto magazine) { 
   return "magazine/modify";  
 }
 /*************좋아요컨트롤러 ***************/
 @ResponseBody
 @PostMapping(value="/like.do", produces="application/json")
 public Map<String, Integer> like(HttpServletRequest request) {
   return magazineService.addLike(request);
 }
 
 /*************수정컨트롤러 ***************/
 
 @PostMapping("/modify.do")
 public String modifyMagazine(HttpServletRequest request, RedirectAttributes redirectAttributes) { 
   redirectAttributes.addFlashAttribute("map", magazineService.firstModify(request));
   return "redirect:/magazine/modifyThumbnail.form";
 }
 
 @GetMapping("/modifyThumbnail.form")
 public String momdifyThumbnail() {
   return "magazine/modifyThumbnail";
 }
 
 @PostMapping("finalModify.do")
 public String finalModify(MultipartHttpServletRequest multipartRequest
     , RedirectAttributes redirectAttributes) throws Exception { 
  int modifyResult = magazineService.finalModify(multipartRequest);
  redirectAttributes.addFlashAttribute("modifyResult", modifyResult);
  return "redirect:/magazine/list.do";
}
 /*************삭제컨트롤러 ***************/
 
 @PostMapping("/delete.do")
 public String delete(HttpServletRequest request, RedirectAttributes redirectAttributes)  {
   redirectAttributes.addAttribute("deleteRemove",magazineService.deleteMagazine(request));
   return "redirect:/magazine/list.do";
 }
 
 
}
