<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="탈퇴회원관리" name="title"/>
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
  
  .listWrap2 {
    margin-top: 10%;
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
            <a href="${contextPath}/manage/memberList.form">기존회원관리</a>
          </div>
          <div class="product">
            <a href="${contextPath}/manage/productList.form">상품/예약</a>
          </div>
          <div class="review">
            <a href="${contextPath}/manage/reviewList.form">리뷰관리</a>
          </div>
        </div>
        

        <%-- 관리 회원목록이 표시될 div --%>
        <div class="listWrap2">
          
          <%-- 총 회원 수를 표시 --%>
          <div style="text-align: right;">총 ${total}명</div>
          
          <%-- 전체 목록을 나타내는 테이블 --%>
          <div>
            <table border="1" class="table">
              <thead>
                <tr>
                  <th scope="col">No</th>
                  <th scope="col">이메일</th>
                  <th scope="col">가입일</th>
                  <th scope="col">탈퇴일</th>
                </tr>
              </thead>
              <tbody class="table-group-divider">
                <c:forEach items="${leaveUserList}" var="leave" varStatus="vs">
                  <tr>
                    <th scope="row">${beginNo - vs.index}</th>
                    <td>${leave.email}</td>
                    <td>
                      <fmt:formatDate value="${leave.joinedAt}" pattern="yyyy/MM/dd" />
                    </td>
                    <td>
                      <fmt:formatDate value="${leave.leavedAt}" pattern="yyyy/MM/dd" />
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
              <%-- 페이징 처리 --%>
              <tfoot>
                <tr>
                  <td colspan="4">${paging}</td>
                </tr>
              </tfoot>
            </table>
            
            <%-- 검색기능 --%>
            <div>
              <form method="get" action="${contextPath}/manage/leaveMemberSearch.do" >
                <select name="column" class="form-select-sm" style="height: 40px">
                  <option value="EMAIL">이메일</option>
                  <option value="JOINED_AT">가입일</option>
                  <option value="LEAVED_AT">탈퇴일</option>
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