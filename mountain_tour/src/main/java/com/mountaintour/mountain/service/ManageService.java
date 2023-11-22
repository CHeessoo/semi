package com.mountaintour.mountain.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;

import com.mountaintour.mountain.dto.UserDto;

public interface ManageService {
  
  /* 기존 회원 목록 */
  public void loadUserList(HttpServletRequest request, Model model);
  
  /* 기존 회원 검색 */
  public void loadSearchUserList(HttpServletRequest request, Model model);
  
  /* 기존 회원 상세*/
  public UserDto getUser(int userNo);
  
  /* 기존 회원 정보 수정 */
  public ResponseEntity<Map<String, Object>> modifyUser(HttpServletRequest request);
  
  /* 기존 회원 비밀번호 수정 */
  public int modifyPw(HttpServletRequest request);
  
  /* 기존 회원 탈퇴 */
  public int removeMember(UserDto user);
  
  /* 탈퇴 회원 목록 */
  public void loadLeaveList(HttpServletRequest request, Model model);
  
  /* 탈퇴 회원 검색 */
  public void loadSearchLeaveList(HttpServletRequest request, Model model);
  
  /* 여행상품 목록 */
  public void loadProductList(HttpServletRequest request, Model model);
  
  /* 여행상품 검색 */
  public void loadSearchProductList(HttpServletRequest request, Model model);
  
  /* 리뷰 목록 */
  public void loadReviewList(HttpServletRequest request, Model model);
  
  /* 리뷰 검색 */
  public void loadSearchReviewList(HttpServletRequest request, Model model);
  
  /* 리뷰 삭제 */
  public int removeReview(int reviewNo);
  
}
