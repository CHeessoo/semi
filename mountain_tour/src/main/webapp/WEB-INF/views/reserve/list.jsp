<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마운틴투어" name="title"/>
</jsp:include>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
      <div>
        <h2>예약내역목록</h2>
      </div>
      <div>
        <table class="table">
          <colgroup>
            <col style="width:25%;">
            <col style="width:15%;">
            <col style="width:15%;">
            <col style="width:15%;">
            <col style="width:14%;">
            <col style="width:10%;">
          </colgroup>
          <thead>
            <tr>
              <th>예약날짜/예약번호</th>
              <th>상품명</th>
              <th>상품금액</th>
              <th>인원</th>
              <th>여행일정</th>
              <th>예약상태</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${reserveList}" var="res" varStatus="vs">
              <c:if test="${sessionScope.user.auth == 0}">
                <tr>
                  <td id="resSche">
                    <a href="${contextPath}/reserve/detail.do?reserveNo=${res.reserveNo}">${res.reserveDate} / ${res.reserveNo}</a>
                  </td> 
                  <td id="prodName">${res.productDto.tripName}</td>
                  <td id="totalPrice">${res.productDto.price}~</td>
                  <td id="personCnt">${res.reservePerson}</td>
                  <td id="trvlSche">${res.reserveStart} / ${res.productDto.timetaken}</td>
                  <td id="resStatus">${res.reserveStatus}</td>
                </tr>
              </c:if>
              <c:if test="${sessionScope.user.userNo == res.userDto.userNo}">
                <tr>
                  <td id="resSche">
                    <a href="${contextPath}/reserve/detail.do?reserveNo=${res.reserveNo}">${res.reserveDate} / ${res.reserveNo}</a>
                  </td> 
                  <td id="prodName">${res.productDto.tripName}</td>
                  <td id="totalPrice">${res.productDto.price}~</td>
                  <td id="personCnt">${res.reservePerson}</td>
                  <td id="trvlSche">${res.reserveStart} / ${res.productDto.timetaken}</td>
                  <c:if test="${res.reserveStatus == 0}">
                    <td id="resStatus">정상</td>
                  </c:if>
                  <c:if test="${res.reserveStatus == 1}">
                    <td id="resStatus">대기</td>
                  </c:if>
                  <c:if test="${res.reserveStatus == 2}">
                    <td id="resStatus">불가</td>
                  </c:if>
                </tr>
              </c:if>
            </c:forEach>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="6">${paging}</td>
            </tr>
          </tfoot>
        </table>
      </div>
      <hr>
      
      <button type="button" onclick="location.href='${contextPath}/product/list.do'" class="btn btn-success btn-lg">다른상품 예약하러가기</button>
      

    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  

 
 

<%@ include file="../layout/footer.jsp" %>