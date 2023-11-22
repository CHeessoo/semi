package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.InquiryDto;
import com.mountaintour.mountain.dto.ProductDto;

@Mapper
public interface InquiryMapper {
  
  /* 1:1문의 전체 목록 보기 */
  public int getInquiryCount();
  public List<InquiryDto> getInquiryList(Map<String, Object> map);
  
  /* 1:1문의 검색결과 보기 */
  public int getSearchCount(Map<String, Object> map);
  public List<InquiryDto> getSearchInquiry(Map<String, Object> map);
  
  /* 1:1문의 상세페이지 보기 */
  public InquiryDto getInquiry(int inquiryNo);
  
  /* 1:1문의 작성(추가)하기 */
  public int insertInquiry(InquiryDto inquiry);
  public List<ProductDto> getProductList(); // product 목록 가져오기
  
  /* 1:1문의 삭제하기 */
  public int deleteInquiry(int inquiryNo);
  

}
