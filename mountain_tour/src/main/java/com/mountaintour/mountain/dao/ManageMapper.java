package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.LeaveUserDto;
import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.dto.ReviewDto;
import com.mountaintour.mountain.dto.UserDto;

@Mapper
public interface ManageMapper {

  /* 회원 관리 목록 */
  public int getUserCount();
  public List<UserDto> getUserList(Map<String, Object> map);



  /* 회원 검색결과 목록 */
  public int getSearchUserCount(Map<String, Object> map);
  public List<UserDto> getSearchUser(Map<String, Object> map);
  
  /* 탈퇴 회원 관리 목록 */
  public int getLeaveUserCount();
  public List<LeaveUserDto> getLeaveUserList(Map<String, Object> map);
  
  /* 탈퇴 회원 검색 목록 */
  public int getSearchLeaveCount(Map<String, Object> map);
  public List<LeaveUserDto> getSearchLeaveList(Map<String, Object> map);
  
  /* 여행상품 검색 목록 */
  public int getSearchProductCount(Map<String, Object> map);
  public List<ProductDto> getSearchProductList(Map<String, Object> map);
  
  /* 리뷰 관리 목록 */
  public int getReviewCount();
  public List<ReviewDto> getReviewList(Map<String, Object> map);
  
  /* 리뷰 검색 목록 */
  public int getSearchReviewCount(Map<String, Object> map);
  public List<ReviewDto> getSearchReviewList(Map<String, Object> map);
  
  /* 리뷰 삭제 */
  public int deleteReview(int reviewNo);

}