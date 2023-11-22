<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마운틴투어" name="title"/>
</jsp:include>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
      <h1 class="title">로그인</h1>
      
      <form method="post" action="${contextPath}/user/login.do">
      
      <div class="mb-3 row">
      	<label for="email" class="col-sm-3 col-form-label">아이디</label>
      	<div class="col-sm-9"><input type="text" name="email" id="email" placeholder="이메일" class="form-control"></div>
      </div>
      
      <div class="mb-3 row">
      	<label for="pw" class="col-sm-3 col-form-label">비밀번호</label>
      	<div class="col-sm-9"><input type="password" name="pw" id="pw" placeholder="●●●●" class="form-control"></div>
      </div>
      
      <div class="gap-2 mb-3">
      	<input type="hidden" name="referer" value="${referer}">
      	<button type="submit" class="btn btn-success">로그인</button>
      	<a href="${naverLoginURL}">
      		<img src="${contextPath}/resources/image/btnG_완성형.png" width="200px">
      	</a>
      </div>
      
      </form>
      
      <ul class="sub_menu">
      	<li><a href="${contextPath}/user/agree.form">회원이 아니세요?
      	<button type="button" class="btn btn-primary">회원가입</button>
      	</a>
      	
      	<li><a href="${contextPath}/user/findIdCheck.form">아이디/비밀번호 찾기</a>
      	</ul>
      	
      <hr class="my-4">
      	
    </div>
    
  </div>
</div>
  
 
 
 
 
 

<%@ include file="../layout/footer.jsp" %>