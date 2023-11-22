package com.mountaintour.mountain.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.mountaintour.mountain.dao.FaqMapper;
import com.mountaintour.mountain.dto.FaqDto;
import com.mountaintour.mountain.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class FaqServiceImpl implements FaqService {
  
  private final FaqMapper faqMapper;
  private final MyPageUtils myPageUtils;


  /**
   * 전체목록 메서드
   * MVC 페이징 처리
   */
  @Transactional(readOnly=true)
  @Override
  public void loadFaqList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = faqMapper.getFaqCount();
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<FaqDto> faqList = faqMapper.getFaqList(map);

    // faqList, paging, beginNo, total 전달
    model.addAttribute("faqList", faqList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/cs/faqList.do"));
    model.addAttribute("beginNo", total - (page -1) * display);
    model.addAttribute("total", total);
    
  }
  
  /**
   * 검색 메서드
   */
  @Transactional(readOnly=true)
  @Override
  public void loadSearchList(HttpServletRequest request, Model model) {
    
    String column = request.getParameter("column");
    String query = request.getParameter("query");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("column", column);
    map.put("query", query);
    
    int total = faqMapper.getSearchCount(map);
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    String strPage = opt.orElse("1");
    int page = Integer.parseInt(strPage);
    
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<FaqDto> faqList = faqMapper.getSearchFaq(map);
    
    model.addAttribute("faqList", faqList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/cs/faqSearch.do", "column=" + column + "&query=" + query));
    model.addAttribute("beginNo", total - (page -1) * display);
    model.addAttribute("total", total);
  }
  
  /**
   * 추가 메서드 
   * (자주묻는질문 작성)
   */
  @Override
  public int addFaq(HttpServletRequest request) {
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    FaqDto faq = FaqDto.builder()
                  .title(title)
                  .contents(contents)
                  .build();
    
    int addResult = faqMapper.insertFaq(faq);
    return addResult;
  }
  
  /**
   * 수정 메서드
   */
  @Override
  public int modifyFaq(HttpServletRequest request) {
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    int faqNo = Integer.parseInt(request.getParameter("faqNo"));
    
    FaqDto faq = FaqDto.builder()
                  .title(title)
                  .contents(contents)
                  .faqNo(faqNo)
                  .build();
    int modifyResult = faqMapper.updateFaq(faq);
    return modifyResult;
  }
  
  /**
   * 삭제 메서드
   */
  @Override
  public int removeFaq(int faqNo) {
    return faqMapper.deleteFaq(faqNo);
  }
  
}



















