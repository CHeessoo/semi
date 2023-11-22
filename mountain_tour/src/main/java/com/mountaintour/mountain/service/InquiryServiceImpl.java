package com.mountaintour.mountain.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.mountaintour.mountain.dao.InquiryAnswerMapper;
import com.mountaintour.mountain.dao.InquiryMapper;
import com.mountaintour.mountain.dto.InquiryAnswerDto;
import com.mountaintour.mountain.dto.InquiryDto;
import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.dto.UserDto;
import com.mountaintour.mountain.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class InquiryServiceImpl implements InquiryService {
  
  private final InquiryMapper inquiryMapper;
  private final InquiryAnswerMapper inquiryAnswerMapper;
  private final MyPageUtils myPageUtils;
  
  /**
   * 전체 목록 보기
   * MVC 페이징 처리
   */
  @Transactional(readOnly=true)
  @Override
  public void loadInquiryList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = inquiryMapper.getInquiryCount();
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<InquiryDto> inquiryList = inquiryMapper.getInquiryList(map);
    
    
    model.addAttribute("inquiryList", inquiryList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/cs/inquiryList.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("total", total);
  }
  
  /**
   * 검색 결과 보기
   */
  @Transactional(readOnly=true)
  @Override
  public void loadSearchList(HttpServletRequest request, Model model) {
    
    String column = request.getParameter("column");
    String query = request.getParameter("query");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("column", column);
    map.put("query", query);
    
    int total = inquiryMapper.getSearchCount(map);
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<InquiryDto> inquiryList = inquiryMapper.getSearchInquiry(map);
    
    model.addAttribute("inquiryList", inquiryList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/cs/inquirySearch.do", "column=" + column + "&query=" + query));
    model.addAttribute("beginNo", total - (page -1) * display);
    model.addAttribute("total", total);
  }
  
  /**
   * 상세 페이지 보기
   */
  @Override
  public InquiryDto getInquiry(int inquiryNo) {
    return inquiryMapper.getInquiry(inquiryNo);
  }
  
  /**
   * 문의글 등록하기
   */
  @Override
  public int addInquiry(HttpServletRequest request) {
    
    String inquiryTitle = request.getParameter("inquiryTitle");
    String inquiryContents = request.getParameter("inquiryContents");
    String ip = request.getRemoteAddr();
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    
    InquiryDto inquiry = InquiryDto.builder()
                          .inquiryTitle(inquiryTitle)
                          .inquiryContents(inquiryContents)
                          .ip(ip)
                          .userDto(UserDto.builder()
                                    .userNo(userNo)
                                    .build())
                          .productDto(ProductDto.builder()
                                        .productNo(productNo)
                                        .build())
                          .build();
    
    int addResult = inquiryMapper.insertInquiry(inquiry);
    return addResult;
  }

  @Override
  public void getProductList(Model model) {
    List<ProductDto> productList = inquiryMapper.getProductList();
    model.addAttribute("productList", productList);
  }
  
  
  /**
   * 문의글 삭제하기
   */
  @Override
  public int removeInquiry(int inquiryNo) {
    return inquiryMapper.deleteInquiry(inquiryNo);
  }
  
  /**
   * 답변 작성하기
   */
  @Override
  public int addAnswer(HttpServletRequest request) {
    
    int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    String contents = request.getParameter("contents");
    
    InquiryAnswerDto answer = InquiryAnswerDto.builder()
                                .inquiryDto(InquiryDto.builder()
                                              .inquiryNo(inquiryNo)
                                              .build())
                                .userDto(UserDto.builder()
                                            .userNo(userNo)
                                            .build())
                                .contents(contents)
                                .build();
    
    int addAnswerResult = inquiryAnswerMapper.insertAnswer(answer);
    return addAnswerResult;
  }
  
  /**
   * 답변 상세
   */
  @Transactional(readOnly=true)
  @Override
  public InquiryAnswerDto getAnswer(int inquiryNo) {
    return inquiryAnswerMapper.getAnswer(inquiryNo);
  }
  
  /**
   * 답변 수정
   */
  @Override
  public int modifyAnswer(HttpServletRequest request) {
    String contents = request.getParameter("contents");
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    int answerNo = Integer.parseInt(request.getParameter("answerNo"));
    
    InquiryAnswerDto inquiryAnswer = InquiryAnswerDto.builder()
                                        .contents(contents)
                                        .userDto(UserDto.builder()
                                                  .userNo(userNo)
                                                  .build())
                                        .answerNo(answerNo)
                                        .build();
    int modifyAnswerResult = inquiryAnswerMapper.updateAnswer(inquiryAnswer);
    return modifyAnswerResult;
  }
  
  /**
   * 답변 삭제
   */
  @Override
  public int removeAnswer(HttpServletRequest request) {
    int answerNo = Integer.parseInt(request.getParameter("answerNo"));
    return inquiryAnswerMapper.deleteAnswer(answerNo);
  }
  
  
  
}




















