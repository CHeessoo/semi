package com.mountaintour.mountain.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface FaqService {
  // List
  public void loadFaqList(HttpServletRequest request, Model model);
  
  // Search
  public void loadSearchList(HttpServletRequest request, Model model);
  
  // add, modify, remove
  public int addFaq(HttpServletRequest request);
  public int modifyFaq(HttpServletRequest request);
  public int removeFaq(int faqNo);


}
