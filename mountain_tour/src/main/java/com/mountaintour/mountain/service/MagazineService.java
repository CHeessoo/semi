package com.mountaintour.mountain.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface MagazineService {
  
  public Map<String, Object> getMagazineList(HttpServletRequest request);
  public Map<String, Object> loadProductNo();
  public Map<String, Integer> firstUpload(HttpServletRequest request);  
  public Map<String, Object> imageUpload(MultipartHttpServletRequest mnultipartRequest);
  public List<String> getEditorImageList(String contents);
  public boolean addThumbnail(MultipartHttpServletRequest multipartRequest) throws Exception;
  public void loadMagazine(int magazineNo, Model model);  
  public int deleteMagazine(HttpServletRequest request);
  public Map<String, Object> firstModify(HttpServletRequest request); 
  public int finalModify(MultipartHttpServletRequest multipartRequest) throws Exception; 
  public int increaseHit(int magazineNo);
  public Map<String, Integer> addLike(HttpServletRequest request);
}
