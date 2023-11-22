package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.HeartDto;
import com.mountaintour.mountain.dto.ImageDto;
import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.dto.ReviewDto;

@Mapper
public interface ProductMapper {
	public int insertProduct(ProductDto product);
	public int insertProductImage(ImageDto image);
	public List<ImageDto> getProductImageInYesterday();
	public int getProductCount();
	public List<ProductDto> getProductList(Map<String, Object> map);
	public ImageDto getThumbnail(int thumbnailNo);
	public ProductDto getProduct(int productNo);
	public int productHit(int productNo);
	public int updateProduct(ProductDto product);
	public List<ImageDto> getProductImageList(int productNo);
	public int deleteProductImage(String filesystemName);
	public int deleteProductImageList(int productNo);
	public int deleteProduct(int productNo);
	public int insertThumbnail(ImageDto image);
	public int heartProduct(HeartDto heart);
	public void getcalendar(Map<String, Object> map);
	public List<ProductDto> getHitList(Map<String, Object> map);
	public List<ProductDto> getProductReviewList(Map<String, Object> map);
	
	// 리뷰
	public int insertReview(ReviewDto review);
	public int getReviewCount(int productNo);
	public List<ReviewDto> getReviewList(Map<String, Object> map);
	public int deleteReview(int reviewNo);
}
