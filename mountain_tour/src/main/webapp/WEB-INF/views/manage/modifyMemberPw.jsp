<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="회원 비밀번호 변경" name="title"/>
</jsp:include>

<style>
  #pw_box {
    margin: 10% auto;
  }
</style>

<script>

  
  
  /* 함수 호출 */
  $(() => {
	fnCheckPw();
    fnModifyResult();
    fnBack();
  })
  
  
  /* 함수 정의 */
  
  // 비밀번호 빈문자열 방지
  const fnCheckPw = () => {
	$('#frm_modify_pw').submit((ev) => {
  	  if($('#pw').val().trim() === ''){
  	    ev.preventDefault();
  	    alert('회원 비밀번호는 한글자 이상 입력해야합니다.');
  	    return;
  	  }
	})
  }
 
  
  const fnModifyResult = () => {
    let modifyPwResult = '${modifyPwResult}';
    if(modifyPwResult !== ''){
      if(modifyPwResult === '1'){
      alert('회원의 비밀번호가 변경되었습니다.');
      } else {
      alert('회원의 비밀번호가 변경되지 않았습니다.');
      }
    }
  }
  
  const fnBack = () => {
	$('#back').click(() => {
	  history.back();
	})
  }  
 
</script> 

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid;" >
      
      <div>

        <form id="frm_modify_pw" method="post" action="${contextPath}/manage/modifyMemberPw.do">
          
          <h2>${userNo}번 회원 비밀번호 변경하기</h2>
          
            

          
          <div class="container text-center">
            <div class="row justify-content-center align-items-center" id="pw_box">
              <div class="col-auto">
                <label for="pw" class="col-form-label">비밀번호</label>
              </div>
              <div class="col-auto">
                <input type="password" name="pw" id="pw" class="form-control">
              </div>
            </div>
          </div>
          
          
          <div style="margin-top: 10%; margin-bottom: 10%;">
            <input type="hidden" name="userNo" value="${userNo}">
            <button type="submit" class="btn btn-outline-success col-5">비밀번호변경하기</button>
          </div>
          
        </form>
        
        <div>
          <button type="button" id="back" class="btn btn-secondary">뒤로가기</button>
        </div>
    
      </div>

      
      

    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 
 

 
 

<%@ include file="../layout/footer.jsp" %>