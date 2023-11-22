package com.mountaintour.mountain.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.mountaintour.mountain.dto.ReserveDto;

public interface ReserveService {
  
  public Map<String, Object> addReserve(HttpServletRequest req) throws Exception;
  public int addTourist(HttpServletRequest req) throws Exception;
  
  public ReserveDto loadReserve(int reserveNo);
  public void loadReserveList(HttpServletRequest request, Model model);
  public void loadReserveListByUser(HttpServletRequest request, Model model);
  
  public int modifyReserve(HttpServletRequest request);
  public int removeReserve(HttpServletRequest request);
  
  public Map<String, Object> loadTourists(HttpServletRequest request);
}
