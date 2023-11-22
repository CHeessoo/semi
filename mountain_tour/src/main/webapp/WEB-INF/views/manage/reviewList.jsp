<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="리뷰관리" name="title"/>
</jsp:include>

<style>


  .listWrap1 {
    display: flex;
    flex-direction: row;
  }
  
  .member, .product, .review {
    flex: 1;
    margin: 5px;
  }
  
  /* 링크 스타일 */
  .member a, .product a, .review a {
    text-decoration: none;
    color: #333; /* 링크 색상 조절 */
    display: block;
    padding: 10px;
    text-align: center;
    background-color: #f2f2f2; /* 배경색 조절 */
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 15px; 
  }
  
  /* 호버 시 배경색 조절 */
  .member a:hover, .product a:hover, .review a:hover {
    background-color: #ddd; 
  }

  .listWrap1 a {
    color: #333333;
    font-size: large;
  }
  
  .listWrap1 .review a{
    background-color: #ddd; /* 배경색 조절 */
  }
  
  .listWrap2 {
    margin-top: 10%;
  }
  
  .blind {
    display: none;
  }
  .open_contents {
    cursor: pointer;
  }
  
  .btn_remove {
    text-align: right;
  }
  
</style>
<script>

  /* 호출 */
  $(() => {
	fnSubstring();
	fnBlind();
	fnBtnRemoveReview();
	fnRemoveReview();
  })


  /* 내용의 일부만 보여주기 */
  const fnSubstring = () => {
    $('.open_contents').each(function() {
      var text = $(this).text().trim();
      var truncatedText = text.length > 10 ? text.substring(0, 10) + '...' : text;
      $(this).text(truncatedText);
    })
  }
  
  
  /* 게시글 내용을 클릭하면 전체 내용 나타내기 */
  const fnBlind = () => {
	$('.open_contents').click((ev) => {
	  let openContents = $(ev.target).parent().next();
	  if(openContents.hasClass('blind')){
		$('.show_content').addClass('blind');
		openContents.removeClass('blind');
	  } else {
		openContents.addClass('blind');
	  }
	})
  }
  
  /* 리뷰 삭제 취소시 서브밋 방지 */
  const fnBtnRemoveReview = () => {
	$('.frm_remove_review').click((ev) => {
	  if(!confirm('관리자 권한으로 리뷰를 삭제하시겠습니까?')){
		ev.preventDefault();
		return;
	  }
	})
  }
  
  /* 리뷰 삭제시 전달되는 데이터 값 */
  const fnRemoveReview = () => {
	let removeReviewResult = '${removeReviewResult}';
	if(removeReviewResult !== ''){
	  if(removeReviewResult === '1'){
		alert('댓글이 삭제되었습니다.');
	  } else {
		alert('댓글이 삭제되지 않았습니다.');
	  }
	}
  }
  

  
</script>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid;" >
      
      <div class="mainWrap">
      
      
      <%-- 각 관리 페이지로 이동 가능한 목록 --%>
        <div class="listWrap1">
          <div class="member">
            <a href="${contextPath}/manage/memberList.form">회원관리</a>
          </div>
          <div class="product">
            <a href="${contextPath}/manage/productList.form">상품/예약</a>
          </div>
          <div class="review">
            <a href="${contextPath}/manage/reviewList.form">리뷰관리</a>
          </div>
        </div>


        <%-- 관리 리뷰목록이 표시될 div --%>
        <div class="listWrap2">
          
          <%-- 총 리뷰 수를 표시 --%>
          <div style="text-align: right;">
            <span>총 ${total}개</span>
          </div>
          
          <%-- 전체 목록을 나타내는 테이블 --%>
          <div>
            <table border="1" class="table">
              <thead>
                <tr>
                  <th scope="col">리뷰번호</th>
                  <th scope="col">상품번호</th>
                  <th scope="col">작성자</th>
                  <th scope="col">내용</th>
                  <th scope="col">작성일</th>
                  <th scope="col">수정일</th>
                  <th scope="col">별점</th>
                </tr>
              </thead>
              <tbody class="table-group-divider">
                <c:forEach items="${reviewList}" var="r" >
                  <tr>
                    <th scope="row">${r.reviewNo}</th>
                    <td>${r.productDto.productNo}</td>
                    <td>${r.userDto.name}</td>
                    <td class="open_contents">${r.contents}</td>
                    <td>
                      <fmt:formatDate value="${r.createdAt}" pattern="yy/MM/dd" />
                    </td>
                    <td>
                      <fmt:formatDate value="${r.modifiedAt}" pattern="yy/MM/dd" />
                    </td>
                    <td>${r.star}</td>
                  </tr>
                  <tr class="blind show_content">
                    <td colspan="8">
                      ${r.contents}
                      <div class="btn_remove">
                        <form class="frm_remove_review" method="post" action="${contextPath}/manage/removeReview.do">
                          <input type="hidden" name="reviewNo" value="${r.reviewNo}">
                          <button type="submit" class="btn btn-secondary">댓글삭제</button>
                        </form>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
              <%-- 페이징 처리 --%>
              <tfoot>
                <tr>
                  <td colspan="7">${paging}</td>
                </tr>
              </tfoot>
            </table>
            
            <%-- 검색기능 --%>
            <div>
              <form method="get" action="${contextPath}/manage/searchReview.do" >
                <select name="column" class="form-select-sm" style="height: 40px">
                  <option value="REVIEW_NO">리뷰번호</option>
                  <option value="PRODUCT_NO">상품번호</option>
                  <option value="NAME">작성자</option>
                  <option value="CONTENTS">내용</option>
                  <option value="STAR">별점</option>
                </select>
                <input type="text" name="query" class="form-control-sm" placeholder="검색어 입력" >
                <button type="submit" class="btn btn-outline-success" >검색</button>
              </form>
            </div>
          

          
          </div>




      
        </div>
      

      </div>

      
      

    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 
 
 
 
 

<%@ include file="../layout/footer.jsp" %>