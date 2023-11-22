package com.mountaintour.mountain.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mountaintour.mountain.service.MainServce;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/main")
@Controller
public class MainController {
  
  private final MainServce mainServce;
  
  @ResponseBody
  @GetMapping(value="/best.do", produces="application/json")
  public Map<String, Object> getBest(){
    return mainServce.getProductBest();
  }
}
