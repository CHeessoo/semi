<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="상품/예약관리" name="title"/>
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
  
  .listWrap1 .product a{
    background-color: #ddd; /* 배경색 조절 */
  }
  
  .listWrap2 {
    margin-top: 10%;
  }
  
  .table_to_detail a {
    color: #1a1a1a;
    cursor: pointer;
  }
  
</style>

 
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


        <%-- 관리 여행목록이 표시될 div --%>
        <div class="listWrap2">
          
          <%-- 총 상품 수를 표시 --%>
          <div style="text-align: right;">
            <span>총 ${total}개</span>
          </div>
          
          <%-- 전체 목록을 나타내는 테이블 --%>
          <div>
            <table border="1" class="table">
              <thead>
                <tr>
                  <th scope="col">상품번호</th>
                  <th scope="col">여행이름</th>
                  <th scope="col">가이드</th>
                  <th scope="col">가격</th>
                  <th scope="col">인원수</th>
                  <th scope="col">예약상태</th>
                  <th scope="col">등록일</th>
                </tr>
              </thead>
              <tbody class="table-group-divider table_to_detail">
                <c:forEach items="${productList}" var="p">
                  <tr>
                    <th scope="row">${p.productNo}</th>
                    <td>
                      <a href="${contextPath}/product/detail.do?productNo=${p.productNo}">${p.tripName}</a>
                    </td>
                    <td>${p.guide}</td>
                    <td>${p.price}</td>
                    <td>${p.people}</td>
                    <td>
                      <c:if test="${p.status == 0}">예약가능</c:if>
                      <c:if test="${p.status == 1}">마감</c:if>
                    </td>
                    <td>
                      <fmt:formatDate value="${p.registeredAt}" pattern="yyyy/MM/dd"/>
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
              <form method="get" action="${contextPath}/manage/productSearch.do" >
                <select name="column" class="form-select-sm" style="height: 40px">
                  <option value="PRODUCT_NO">상품번호</option>
                  <option value="TRIP_NAME">여행이름</option>
                  <option value="GUIDE">가이드</option>
                  <option value="PRIZE">가격</option>
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