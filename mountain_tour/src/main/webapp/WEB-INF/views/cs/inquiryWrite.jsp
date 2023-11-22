<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="${sessionScope.user.name}님의 문의작성" name="title"/>
</jsp:include>


 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid" >
      
      
      <div>
        
        <form id="frm_write" method="post" action="${contextPath}/cs/addInquiry.do">
        
          <div class="form-floating">
            <select id="title" name="inquiryTitle"class="form-select" aria-label="Floating label select" style="margin-top: 10px;">
              <option value="기타문의">기타문의</option>
              <option value="여행문의">여행문의</option>
              <option value="예약문의">예약문의</option>
              <option value="결제문의">결제문의</option>
            </select>
            <label for="title" >제목선택</label>
          </div>
          
          <div class="form-floating">
            <select name="productNo" id="product" class="form-select" aria-label="Floating label select" style="margin-top: 10px;">
              <c:forEach items="${productList}" var="p">
                <option value="${p.productNo}">${p.tripName}</option>
              </c:forEach>
            </select>
            <label for="product" >여행선택</label>
          </div>
          
          <div class="form-floating mb-3">
            <input type="text" value="${sessionScope.user.name}" id="name" readonly class="form-control-plaintext" >
            <label for="name" >작성자</label>
          </div>
          
          <div>
            <label for="contents" class="form-label">내용</label>
            <textarea name="inquiryContents" id="contents" class="form-control" placeholder="내용을 입력하세요" style="height: 500px"></textarea>
          </div>
          
          <div>
            <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
            <button type="submit" class="btn btn-outline-success col-6" style="margin-top: 20px;">작성완료</button>
          </div>
          
        </form>
        
      </div>
      
      
      

    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 

<script>


  /* 작성 전 로그인 검사 */
  const fnAddInqiury = () => {
    if('${sessionScope.user}' === ''){
      alert('로그인 후 이용 가능합니다.');
      history.go(-1);
      return;
    }
  }
  
  /* textarea 공백 체크 */
  const fnFrmWrite = () => {
    $('#frm_write').submit((ev) => {
      /* textarea의 현재 내용을 가져와서 체크 */
      const contents = $('#contents').val().trim();

      if (contents.length === 0) {
        ev.preventDefault();
        alert("문의 내용을 입력하세요.");
        $('#contents').focus();
        return;
      }
    })
  }

  fnAddInqiury();
  fnFrmWrite();
  
</script> 
 
 

<%@ include file="../layout/footer.jsp" %>