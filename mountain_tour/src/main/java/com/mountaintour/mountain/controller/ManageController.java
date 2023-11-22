package com.mountaintour.mountain.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mountaintour.mountain.dto.UserDto;
import com.mountaintour.mountain.service.ManageService;
import com.mountaintour.mountain.service.UserService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/manage")
@RequiredArgsConstructor
@Controller
public class ManageController {
  
  private final ManageService manageService;
  
  /* 기존 회원 목록 페이지 */
  @GetMapping("/memberList.form")
  public String memberList(HttpServletRequest request, Model model) {
    manageService.loadUserList(request, model);
    return "manage/memberList";
  }
  
  /* 기존 회원 검색 */
  @GetMapping("/memberSearchList.do")
  public String memberSearchList(HttpServletRequest request, Model model) {
    manageService.loadSearchUserList(request, model);
    return "manage/memberList";
  }
  
  /* 기존 회원 상세 */
  @GetMapping("/member.form")
  public String member(@RequestParam(value="userNo", required=false, defaultValue="0") int userNo
                     , Model model) {
    UserDto user = manageService.getUser(userNo);
    model.addAttribute("user", user);
    return "manage/memberDetail";
  }
  
  /* 기존 회원 정보 수정 */
  @PostMapping(value="/modifyMember.do", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<Map<String, Object>> modifyMember(HttpServletRequest request){
    return manageService.modifyUser(request);
  }
  
  /* 기존 회원 비밀번호 수정 폼으로 이동 */
  @GetMapping("/modifyMemberPw.form")
  public String modifyMemberPwForm(@Param(value="userNo") int userNo, Model model) {
    model.addAttribute("userNo", userNo);
    return "manage/modifyMemberPw";
  }
  
  /* 기존 회원 비밀번호 수정하기 */
  @PostMapping("/modifyMemberPw.do")
  public String modifyMemberPw(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int modifyPwResult = manageService.modifyPw(request);
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    redirectAttributes.addFlashAttribute("modifyPwResult", modifyPwResult);
    redirectAttributes.addFlashAttribute("userNo", userNo);
    return "redirect:/manage/modifyMemberPw.form?userNo=" + userNo;
  }
  
  /* 기존 회원 탈퇴 */
  @PostMapping(value="/removeMember.do")
  public String removeMember(UserDto user, RedirectAttributes redirectAttributes) {
    int removeResult = manageService.removeMember(user);
    redirectAttributes.addFlashAttribute("removeResult", removeResult);
    return "redirect:/manage/memberList.form";
  }
  
  /* 탈퇴 회원 목록 페이지 */
  @GetMapping("/leaveMemberList.form")
  public String leaveMemberList(HttpServletRequest request, Model model) {
    manageService.loadLeaveList(request, model);
    return "manage/leaveMemberList";
  }
  
  /* 탈퇴 회원 검색 */
  @GetMapping("/leaveMemberSearch.do")
  public String leaveMemberSearch(HttpServletRequest request, Model model) {
    manageService.loadSearchLeaveList(request, model);
    return "manage/leaveMemberList";
  }
  
  /* 여행상품 목록 페이지 */
  @GetMapping("/productList.form")
  public String productList(HttpServletRequest request, Model model) {
    manageService.loadProductList(request, model);
    return "manage/productList";
  }
  
  /* 여행상품 검색 */
  @GetMapping("/productSearch.do")
  public String productSearch(HttpServletRequest request, Model model) {
    manageService.loadSearchProductList(request, model);
    return "manage/productList";
  }
  
  /* 전체 리뷰 목록 페이지 */
  @GetMapping("/reviewList.form")
  public String reviewList(HttpServletRequest request, Model model) {
    manageService.loadReviewList(request, model);
    return "manage/reviewList";
  }
  
  /* 리뷰 검색 */
  @GetMapping("/searchReview.do")
  public String searchReview(HttpServletRequest request, Model model) {
    manageService.loadSearchReviewList(request, model);
    return "manage/reviewList";
  }
  
  /* 리뷰 삭제 */
  @PostMapping("/removeReview.do")
  public String removeReview(@RequestParam(value="reviewNo") int reviewNo, RedirectAttributes redirectAttributes) {
    int removeReviewResult = manageService.removeReview(reviewNo);
    redirectAttributes.addFlashAttribute("removeReviewResult", removeReviewResult);
    return "redirect:/manage/reviewList.form";
  }

  
}