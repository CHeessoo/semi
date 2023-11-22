<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="${inquiry.inquiryNo}번 문의" name="title"/>
</jsp:include>

<script>

  /* 호출 */
  $(() => {
    fnDeleteInquiry();
    fnAddAnswer();
    fnModifyAnswer();
    fnDeleteAnswer();
    fnAddAnswerResult();
    fnModifyAnswerResult();
    fnRemoveAnswerResult();
  })

  /* 문의글 삭제 취소시 서브밋 방지 */ 
  const fnDeleteInquiry = () => {
    $('#frm_removeInquiry').submit((ev) => {
      if (!confirm('문의글을 삭제하면 답변 확인이 불가능합니다. 삭제하시겠습니까?')) {
        ev.preventDefault(); 
        return;
      }
    })
  }
  
  
  
  /* 답변 작성 버튼 클릭 시 서브밋 */
  const fnAddAnswer = () => {
    $('#btn_add_answer').click(() => {
      let answerContents = "${answer.contents}";
      
	  if($('#show_answer_manager').val().trim() === ''){
	    	alert('답변을 작성하세요.');
	    	return;
	      }
	  
      // 이미 작성된 답변이 있다면 서브밋 방지
      if (answerContents.trim() !== '') {
          alert('이미 작성된 답변이 존재합니다.');
          return;
      } 
      // 기존에 작성된 데이터가 없다면 서브밋 수행
      $('#frm_answer').attr('action', '${contextPath}/cs/addAnswer.do');
      $('#frm_answer').submit(); // 폼 제출
    })
  }
  
  /* 답변 수정 버튼 서브밋 */
  const fnModifyAnswer = () => {
	$('#btn_modiy_answer').click(() => {
      $('#frm_answer').attr('action', '${contextPath}/cs/modifyAnswer.do');
      $('#frm_answer').submit(); 
	})
  }
  
  /* 답변 삭제 버튼 서브밋 */
  const fnDeleteAnswer = () => {
	$('#btn_delete_answer').click(() => {
      if(!confirm('답변을 삭제하시겠습니까?')){
  		return;
  	  }
      $('#frm_answer').attr('action', '${contextPath}/cs/removeAnswer.do');
      $('#frm_answer').submit(); 
	})
  }
  
  /* 답변 등록 시 전달되는 데이터 확인 */
  const fnAddAnswerResult = () => {
	let addAnswerResult = '${addAnswerResult}';
	if(addAnswerResult !== ''){
	  if(addAnswerResult === '1'){
		alert('답변이 등록되었습니다.');
	  } else {
		alert('답변이 등록되지 않았습니다.');
	  }
	}
  }
  
  /* 답변 수정 시 전달되는 데이터 확인 */
  const fnModifyAnswerResult = () => {
	let modifyAnswerResult = '${modifyAnswerResult}';
	if(modifyAnswerResult !== ''){
	  if(modifyAnswerResult === '1'){
		alert('답변이 수정되었습니다.');
	  } else {
		alert('답변이 수정되지 않았습니다.');
	  }
	}
  }
  
  /* 답변 삭제 시 전달되는 데이터 확인 */
  const fnRemoveAnswerResult = () => {
	let removeAnswerResult = '${removeAnswerResult}';
	if(removeAnswerResult !== ''){
	  if(removeAnswerResult === '1'){
		alert('답변이 삭제되었습니다.');
	  } else {
		alert('답변이 삭제되지 않았습니다.');
	  }
	}
  }
  
  
  

	
</script>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid;" >
      
      
      <div>
      
        <div class="form-floating mb-3">
          <input type="text" readonly class="form-control-plaintext" id="inquiry_title" value="${inquiry.inquiryTitle}">
          <label for="inquiry_title">제목</label>
        </div>
        <div class="form-floating mb-3">
          <input type="text" readonly class="form-control-plaintext" id="trip_name" value="${inquiry.productDto.tripName}">
          <label for="trip_name">관심여행</label>
        </div>
        <div class="form-floating mb-3">
          <input type="text" readonly class="form-control-plaintext" id="user_name" value="${inquiry.userDto.name}">
          <label for="user_name">작성자</label>
        </div>
        <div class="form-floating mb-3" >
          <textarea readonly class="form-control-plaintext" id="inquiry_contents" style="height: 300px">${inquiry.inquiryContents}</textarea>
          <label for="inquiry_contents">내용</label>
        </div>
      
        <div style="text-align: right; color: #696969; margin-top: 10px;">작성일 <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy/MM/dd" /></div>
        
        <div style="text-align: right; margin: 10px auto">
          <form method="post" action="${contextPath}/cs/removeInquiry.do" id="frm_removeInquiry">
            <input type="hidden" name="inquiryNo" value="${inquiry.inquiryNo}">
            <button type="submit" class="btn btn-secondary">문의삭제</button>
          </form>
        </div>
        
        
        <div>
          <%-- 회원이 답변을 확인하는 곳 --%>
          <c:if test="${sessionScope.user.auth eq 1}">
            <div class="form-floating">
              <textarea class="form-control" readonly placeholder="답변을 작성하세요." id="show_answer_user" style="height: 350px">${answer.contents}</textarea>
              <label for="show_answer_user">관리자 답변</label>
            </div>
          </c:if>
        
          <%-- 관리자가 답변 (확인/작성/수정/삭제)하는 곳 --%>
          <c:if test="${sessionScope.user.auth eq 0}">
            <form id="frm_answer" method="post" >
              <div class="form-floating">
                <textarea class="form-control" name="contents" placeholder="답변을 작성하세요." id="show_answer_manager" style="height: 350px">${answer.contents}</textarea>
                <label for="show_answer_manager">관리자 답변</label>
              </div>
              <input type="hidden" name="inquiryNo" value="${inquiry.inquiryNo}"> 
              <input type="hidden" name="answerNo" value="${answer.answerNo}">
              <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
              <div style="margin: 20px auto;">
                <button type="button" id="btn_add_answer" class="btn btn-outline-success">답변작성</button>
                <button type="button" id="btn_modiy_answer" class="btn btn-outline-success">답변수정</button>
                <button type="button" id="btn_delete_answer" class="btn btn-secondary">답변삭제</button>
              </div>
            </form>
          </c:if>
            
        </div>
        
        
        
        
        <div style="margin-top: 5%;">
          <a href="${contextPath}/cs/inquiryList.do">
            <button type="button" class="btn btn-success col-6">목록보기</button>
          </a>
          
        </div>
        
      </div>



    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 




 
 
 

<%@ include file="../layout/footer.jsp" %>