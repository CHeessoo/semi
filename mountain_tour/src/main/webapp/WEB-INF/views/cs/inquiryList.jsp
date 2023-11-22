<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="문의하기" name="title"/>
</jsp:include>

<style>
  .mainWrap {
  display: flex;
  }

  .listWrap1 {
    justify-content: center;
    width: 20%;
    border-right: 1px solid gray;
    margin-top: 50px;
    padding-bottom: 30px;
  }

  .listWrap1 a {
    color: #1a1a1a;
    font-size: large;
    font-weight: bold;
  }
  .title {
    color: #1a1a1a;
    cursor: pointer;
  }
  
  .listWrap1 .inquiry {
    text-decoration: underline;
    text-underline-position: under;
  }

  
  
  .listWrap2 {
    justify-content: center;
    width: 75%;
    margin: 10% auto;
    
  }
  
</style>
<script>

  /* 호출 */
  $(() => {
    fnWrite();
    fnDetail();
    fnAddResult();
    fnRemove();
  })


  /* 로그인 검사 */
  const fnloginCheck = () => {
    if('${sessionScope.user}' === ''){
      if(confirm('로그인 후 이용 가능합니다. 로그인 하시겠습니까?')){
      location.href = '${contextPath}/user/login.form';
      return;
      } 
    }
  }
  
  /* 작성하기 가능 유무 */
  const fnWrite = () => {
  $('#btn_inquiry_write').click(() => {
      if('${sessionScope.user}' !== ''){
      location.href = '${contextPath}/cs/addInquiry.form';
      return;
      }
      fnloginCheck();
    })
  }

  
  /* 상세보기 가능 유무 */
  const fnDetail = () => {
    $('.title').click(() => {
      fnloginCheck();
    })
  }
  
  /* 문의 작성시 전달되는 데이터 값 */
  const fnAddResult = () => {
    let addResult = '${addResult}';
    if(addResult !== ''){
      if(addResult === '1'){
      alert('문의글이 등록되었습니다.');
      } else {
      alert('문의글이 등록되지 않았습니다.');
      }
    }
  }
  
  /* 문의 삭제시 전달되는 데이터 값 */
  const fnRemove = () => {
    let removeResult = '${removeResult}';
    if(removeResult !== ''){
      if(removeResult === '1'){
      alert('문의글이 삭제되었습니다.');
      } else {
      alert('문의글이 삭제되지 않았습니다.');
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
      
        <%-- 각 문의 페이지로 이동가능한 목록 --%>
        <div class="listWrap1">
          <div class="faq">
            <a href="${contextPath}/cs/faqList.do" >자주 묻는 질문</a>
          </div>
          <div class="inquiry">
            <a href="${contextPath}/cs/inquiryList.do">1:1 문의하기</a>
          </div>
        </div>
        
        <%-- 자주묻는질문 목록이 표시될 div --%>
        <div class="listWrap2">
          <div style="text-align: right;">
            <button id="btn_inquiry_write"  class="btn btn-success">문의작성</button>
          </div>
          <div style="text-align: left;">총 ${total}개</div>
          <div>
            <table border="1" class="table table-hover">
              <thead>
                <tr>
                  <th scope="col">문의번호</th>
                  <th scope="col">여행번호</th>
                  <th scope="col">제목</th>
                  <th scope="col">작성자</th>
                  <th scope="col">작성일</th>
                  <th scope="col">답변여부</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${inquiryList}" var="inq" >
                  <tr>
                    <th scope="row">${inq.inquiryNo}</th>
                    <td>${inq.productDto.productNo}</td>
                    <td> 
                      <c:if test="${sessionScope.user.auth == 0 or sessionScope.user.userNo == inq.userDto.userNo}">                      
                        <a href="${contextPath}/cs/inquiryDetail.do?inquiryNo=${inq.inquiryNo}" class="title">${inq.inquiryTitle}</a>
                      </c:if>
                      <c:if test="${sessionScope.user.auth != 0 and sessionScope.user.userNo != inq.userDto.userNo}">                      
                        <a class="title">${inq.inquiryTitle}</a>
                      </c:if> 
                    </td>
                    <td>${inq.userDto.name}</td>
                    <td><fmt:formatDate value="${inq.createdAt}" pattern="yy/MM/dd" /></td>
                    <td>
                      <c:if test="${inq.answerNo != 0}">
                        <div>답변완료</div>
                      </c:if>
                      <c:if test="${inq.answerNo == 0}">
                        <div>예정</div>
                      </c:if>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="6">${paging}</td>
                </tr>
              </tfoot>
            </table>
            <div>
              <form method="get" action="${contextPath}/cs/inquirySearch.do">
                <select name="column" class="form-select-sm" style="height: 40px">
                  <option value="INQUIRY_TITLE">제목</option>
                  <option value="NAME">작성자</option>
                  <option value="INQUIRY_NO">문의번호</option>
                  <option value="PRODUCT_NO">여행번호</option>
                </select>
                <input type="text" name="query" id="query" class="form-control-sm" placeholder="검색어 입력" >
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