package com.mountaintour.mountain.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.mountaintour.mountain.dao.ManageMapper;
import com.mountaintour.mountain.dao.ProductMapper;
import com.mountaintour.mountain.dao.UserMapper;
import com.mountaintour.mountain.dto.LeaveUserDto;
import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.dto.ReviewDto;
import com.mountaintour.mountain.dto.UserDto;
import com.mountaintour.mountain.util.MyPageUtils;
import com.mountaintour.mountain.util.MySecurityUtils;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class ManageServiceImpl implements ManageService {

  private final UserMapper userMapper;
  private final ManageMapper manageMapper;
  private final ProductMapper productMapper;
  private final MyPageUtils myPageUtils;
  private final MySecurityUtils mySecurityUtils;
  
  
  /**
   * 기존 회원 목록
   * MVC 페이징 처리
   * 
   * @author 심희수
   * @param request
   * @param model
   */
  @Transactional(readOnly=true)
  @Override
  public void loadUserList(HttpServletRequest request, Model model) {

    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = manageMapper.getUserCount();
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<UserDto> userList = manageMapper.getUserList(map);
    
    model.addAttribute("userList", userList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/memberList.form"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("total", total);
    
  }
  
  /**
   * 기존 회원 검색
   * 
   * @author 심희수
   * @param request
   * @param model
   */
  @Transactional(readOnly=true)
  @Override
  public void loadSearchUserList(HttpServletRequest request, Model model) {
    
    String column = request.getParameter("column");
    String query = request.getParameter("query");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("column", column);
    map.put("query", query);
    
    int total = manageMapper.getSearchUserCount(map);
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    String strPage = opt.orElse("1");
    int page = Integer.parseInt(strPage);
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<UserDto> userList = manageMapper.getSearchUser(map);
    
    model.addAttribute("userList", userList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/memberSearchList.do", "column=" + column + "&query=" + query));
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("total", total);
    
  }
  
  /**
   * 기존 회원 상세
   * 
   * @author 심희수
   * @param userNo 회원번호
   * @return 회원번호를 Map에 담아서 반환
   */
  @Transactional(readOnly=true)
  @Override
  public UserDto getUser(int userNo) {
    return userMapper.getUser(Map.of("userNo", userNo));
  }
  
  /**
   * 기존 회원 정보 수정
   * 
   * @author 심희수
   * @param request
   */
  @Override
  public ResponseEntity<Map<String, Object>> modifyUser(HttpServletRequest request) {
    
    String name = mySecurityUtils.preventXSS(request.getParameter("name"));
    String gender = request.getParameter("gender");
    String mobile = request.getParameter("mobile");
    String postcode = request.getParameter("postcode");
    String roadAddress = request.getParameter("roadAddress");
    String jibunAddress = request.getParameter("jibunAddress");
    String detailAddress = mySecurityUtils.preventXSS(request.getParameter("detailAddress"));
    String event = request.getParameter("event");
    int agree = event.equals("on") ? 1 : 0;
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    UserDto user = UserDto.builder()
                    .name(name)
                    .gender(gender)
                    .mobile(mobile)
                    .postcode(postcode)
                    .roadAddress(roadAddress)
                    .jibunAddress(jibunAddress)
                    .detailAddress(detailAddress)
                    .agree(agree)
                    .userNo(userNo)
                    .build();
    
    int modifyResult = userMapper.updateUser(user);
    
    return new ResponseEntity<Map<String,Object>>(Map.of("modifyResult", modifyResult), HttpStatus.OK);
  }
  
  /**
   * 기존 회원 비밀번호 수정
   * 
   * @author 심희수
   * @param request 
   * @return
   */
  @Override
  public int modifyPw(HttpServletRequest request) {
    
    String pw = mySecurityUtils.getSHA256(request.getParameter("pw"));
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    UserDto user = UserDto.builder()
                    .pw(pw)
                    .userNo(userNo)
                    .build();
    
    int modifyPwResult = userMapper.updateUserPw(user);
    
    return modifyPwResult;
  }
  
  
  /**
   * 기존 회원 탈퇴
   * 
   * @author 심희수
   * @param  userNo 회원번호
   * @return 삭제할 회원번호를 반환
   */
  @Override
  public int removeMember(UserDto user) {
    return userMapper.deleteUser(user);
  }
  
  /**
   * 탈퇴 회원 목록
   * MVC페이징 처리
   * @author 심희수
   * @param request
   * @param model
   * @return 탈퇴한 회원 리스트, 페이징 정보, 총 탈퇴 회원수를 반환
   */
  @Transactional(readOnly=true)
  @Override
  public void loadLeaveList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = manageMapper.getLeaveUserCount();
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<LeaveUserDto> leaveUserList = manageMapper.getLeaveUserList(map);
    
    model.addAttribute("leaveUserList", leaveUserList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/leaveMemberList.form"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("total", total);
    
  }
  
  /**
   * 탈퇴 회원 검색
   * 
   * @author 심희수
   * @param request
   * @param model
   * @return 검색된 탈퇴 회원 목록, 페이징 정보, 검색된 총 탈퇴 회원수를 반환
   */
  @Transactional(readOnly=true)
  @Override
  public void loadSearchLeaveList(HttpServletRequest request, Model model) {

    String column = request.getParameter("column");
    String query = request.getParameter("query");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("column", column);
    map.put("query", query);
    
    int total = manageMapper.getSearchLeaveCount(map);
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<LeaveUserDto> leaveUserList = manageMapper.getSearchLeaveList(map);
    
    model.addAttribute("leaveUserList", leaveUserList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/leaveMemberSearch.do", "column=" + column + "&query=" + query));
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("total", total);
  }
  
  /**
   * 여행 상품 관리 목록
   * 
   * @author 심희수
   * @param request
   * @param model
   * @return 여행상품 관리목록, 페이징 정보, 총 상품 수 반환
   */
  @Transactional(readOnly=true)
  @Override
  public void loadProductList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = productMapper.getProductCount();
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<ProductDto> productList = productMapper.getProductList(map);
    
    model.addAttribute("productList", productList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/productList.form"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("total", total);
  }
  
  /**
   * 여행상품 검색
   * 
   * @author 심희수
   * @param request
   * @param model
   * @return 검색된 여행상품 목록, 페이징 정보, 검색된 총 여행상품 수 반환 
   */
  @Transactional(readOnly=true)
  @Override
  public void loadSearchProductList(HttpServletRequest request, Model model) {
    
    String column = request.getParameter("column");
    String query = request.getParameter("query");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("column", column);
    map.put("query", query);
    
    int total = manageMapper.getSearchProductCount(map);
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<ProductDto> productList = manageMapper.getSearchProductList(map);
    
    model.addAttribute("productList", productList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/productSearch.do", "column=" + column + "&query=" + query));
    model.addAttribute("beginNo", total - (page -1) * display);
    model.addAttribute("total", total);
  }
  
  /**
   * 전체 리뷰 목록
   * 
   * @author 심희수
   * @param request
   * @param model
   * @return 전체 리뷰 목록, 페이징 정보, 총 리뷰 수 반환
   */
  @Transactional(readOnly=true)
  @Override
  public void loadReviewList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = manageMapper.getReviewCount();
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<ReviewDto> reviewList = manageMapper.getReviewList(map);
    
    model.addAttribute("reviewList", reviewList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/reviewList.form"));
    model.addAttribute("beginNo", total - (page -1) * display);
    model.addAttribute("total", total);
    
  }
  
  /**
   * 리뷰 검색
   * 
   * @author 심희수
   * @param request
   * @param model
   * @return 검색한 리뷰 목록, 페이징 정보, 검색한 총 리뷰 수 반환
   */
  @Transactional(readOnly=true)
  @Override
  public void loadSearchReviewList(HttpServletRequest request, Model model) {
    
    String column = request.getParameter("column");
    String query = request.getParameter("query");
    
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("column", column);
    map.put("query", query);
    
    int total = manageMapper.getSearchReviewCount(map);
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int display = 20;
    
    myPageUtils.setPaging(page, total, display);
    
    map.put("begin", myPageUtils.getBegin());
    map.put("end", myPageUtils.getEnd());
    
    List<ReviewDto> reviewList = manageMapper.getSearchReviewList(map);
    
    model.addAttribute("reviewList", reviewList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/manage/searchReview.do", "column=" + column + "&query=" + query));
    model.addAttribute("beginNo", total - (page -1) * display);
    model.addAttribute("total", total);
    
  }
  
  /**
   * 리뷰삭제
   */
  @Override
  public int removeReview(int reviewNo) {
    return manageMapper.deleteReview(reviewNo);
  }
  
}