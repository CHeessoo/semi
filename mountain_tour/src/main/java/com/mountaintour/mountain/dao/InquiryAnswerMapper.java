package com.mountaintour.mountain.dao;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.InquiryAnswerDto;

@Mapper
public interface InquiryAnswerMapper {
  
  /* 답변 등록 */
  public int insertAnswer(InquiryAnswerDto inquiryAnswer);
  
  /* 답변 상세 */
  public InquiryAnswerDto getAnswer(int inquiryNo);
  
  /* 답변 수정 */
  public int updateAnswer(InquiryAnswerDto inquiryAnswer);
  
  /* 답변 삭제 */
  public int deleteAnswer(int answerNo);

}
