package com.mountaintour.mountain.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mountaintour.mountain.dto.InquiryAnswerDto;
import com.mountaintour.mountain.dto.InquiryDto;
import com.mountaintour.mountain.service.InquiryService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/cs")
@Controller
public class InquiryController {
  
  private final InquiryService inquiryService;
  
  /* 1:1문의 전체 목록 보기 */
  @GetMapping("/inquiryList.do")
  public String inquiryList(HttpServletRequest request, Model model) {
    inquiryService.loadInquiryList(request, model);
    return "cs/inquiryList";
  }
  
  /* 1:1문의 검색 목록 보기 */
  @GetMapping("/inquirySearch.do")
  public String inquirySearch(HttpServletRequest request, Model model) {
    inquiryService.loadSearchList(request, model);
    return "cs/inquiryList";
  }
  
  /* 1:1문의 / 답변 상세 페이지 보기 */
  @GetMapping("/inquiryDetail.do")
  public String inquiryDetail(@RequestParam(value="inquiryNo", required=false, defaultValue="0") int inquiryNo
                            , Model model) {
    InquiryDto inquiry = inquiryService.getInquiry(inquiryNo);
    InquiryAnswerDto answer = inquiryService.getAnswer(inquiryNo);
    model.addAttribute("inquiry", inquiry);
    model.addAttribute("answer", answer);
    return "cs/inquiryDetail";
  }
  
  /* 1:1문의 작성 폼으로 이동 */
  @GetMapping("/addInquiry.form")
  public String addInquiryForm (Model model) {
    inquiryService.getProductList(model);
    return "cs/inquiryWrite";
  }
  
  /* 1:1문의 작성하기 */
  @PostMapping("/addInquiry.do")
  public String addInquiry(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int addResult = inquiryService.addInquiry(request);
    redirectAttributes.addFlashAttribute("addResult", addResult);
    return "redirect:/cs/inquiryList.do";
  }
  
  /* 1:1문의 삭제하기 */
  @PostMapping("/removeInquiry.do")
  public String removeInquiry(@RequestParam(value="inquiryNo") int inquiryNo, RedirectAttributes redirectAttributes) {
    int removeResult = inquiryService.removeInquiry(inquiryNo);
    redirectAttributes.addFlashAttribute("removeResult", removeResult);
    return "redirect:/cs/inquiryList.do";
  }
  
  /* 답변 작성 */
  @PostMapping("/addAnswer.do")
  public String addAnswer(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int addAnswerResult = inquiryService.addAnswer(request);
    redirectAttributes.addFlashAttribute("addAnswerResult", addAnswerResult);
    return "redirect:/cs/inquiryDetail.do?inquiryNo=" + request.getParameter("inquiryNo");
  }
  
  /* 답변 수정 */
  @PostMapping("/modifyAnswer.do")
  public String modifyAnswer(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int modifyAnswerResult = inquiryService.modifyAnswer(request);
    redirectAttributes.addFlashAttribute("modifyAnswerResult", modifyAnswerResult);
    return "redirect:/cs/inquiryDetail.do?inquiryNo=" + request.getParameter("inquiryNo");
  }
  
  /* 답변 삭제 */
  @PostMapping("/removeAnswer.do")
  public String removeAnswer(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int removeAnswerResult = inquiryService.removeAnswer(request);
    redirectAttributes.addFlashAttribute("removeAnswerResult", removeAnswerResult);
    return "redirect:/cs/inquiryDetail.do?inquiryNo=" + request.getParameter("inquiryNo");
  }
  
}
