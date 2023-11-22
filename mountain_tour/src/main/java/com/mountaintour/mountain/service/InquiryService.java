package com.mountaintour.mountain.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.mountaintour.mountain.dto.InquiryAnswerDto;
import com.mountaintour.mountain.dto.InquiryDto;
import com.mountaintour.mountain.dto.ProductDto;

public interface InquiryService {
  
  /* 문의 목록 */
  public void loadInquiryList(HttpServletRequest request, Model model);
  
  /* 문의 검색 */
  public void loadSearchList(HttpServletRequest request, Model model);
  
  /* 문의 상세 */
  public InquiryDto getInquiry(int inquiryNo);
  
  /* 문의 등록 */
  public int addInquiry(HttpServletRequest request);
  public void getProductList(Model model);
  
  /* 문의 삭제 */
  public int removeInquiry(int inquiryNo);


  /* 답변 등록 */
  public int addAnswer(HttpServletRequest request);
  
  /* 답변 상세 */
  public InquiryAnswerDto getAnswer(int inquiryNo);
  
  /* 답변 수정 */
  public int modifyAnswer(HttpServletRequest request);
  
  /* 답변 삭제 */
  public int removeAnswer(HttpServletRequest request);
  
  
}