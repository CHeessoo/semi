package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.FaqDto;

@Mapper
public interface FaqMapper {
  
  // get list
  public int getFaqCount();
  public List<FaqDto> getFaqList(Map<String, Object> map);
  
  // search
  public int getSearchCount(Map<String, Object> map);
  public List<FaqDto> getSearchFaq(Map<String, Object> map);
  
  // insert, update, delete
  public int insertFaq(FaqDto faq);
  public int updateFaq(FaqDto faq);
  public int deleteFaq(int faqNo);
  

}
