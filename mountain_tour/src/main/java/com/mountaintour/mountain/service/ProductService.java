package com.mountaintour.mountain.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mountaintour.mountain.dto.ImageDto;
import com.mountaintour.mountain.dto.ProductDto;

public interface ProductService {
  public Map<String, Object> addThumbnail(MultipartHttpServletRequest multipartRequest) throws Exception;
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest);
  public ImageDto getThumbnail(int productNo);
  public int addProduct(MultipartHttpServletRequest multipartRequest) throws Exception;
  public int getTotalProductCount();
  public List<String> getEditorImageList(String contents);
  public void productImageBatch();
  public Map<String, Object> getProductList(HttpServletRequest request);
  // public void attachUpload(HttpServletRequest request, Model model);
  public ProductDto getProduct(int productNo);
  public int increseHit(int productNo);
  public int modifyProduct(HttpServletRequest request);
  public int removeProduct(int productNo);
  public int addHeart(HttpServletRequest request);
  public Map<String, Object> getReviewProductList(HttpServletRequest request);
  public Map<String, Object> getHit(HttpServletRequest request);
  public Map<String, Object> addReview(HttpServletRequest request);
  public Map<String, Object> loadReviewList(HttpServletRequest request);
  public Map<String, Object> removeReview(int reviewNo);
}
