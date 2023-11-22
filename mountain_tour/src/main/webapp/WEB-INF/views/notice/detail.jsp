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
  
  <style>
  .wrap1 > .box1{
  height : 120px;
  }
  
  .wrap1 > .box2{
  height : 120px;
  }
  </style>
 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid;" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
       
       
       
      <div>
        <h1 class="display-1">공지사항</h1>
        <hr>
        <div class = "wrap1">
        <div class="box1"></div>
        </div>
      </div>


      
       <table class="table">
  <thead>
    <tr>
      <th scope="col">공지번호</th>
      <th scope="col">제목</th>
      <th scope="col">내용</th>
      <th scope="col">작성일</th>
    </tr>
  </thead>
  
  
  
 
  <tbody>
    <tr>
      <th scope="row">${notice.noticeNo}</th>
      <td>${notice.title}</td>
      <td>${notice.contents}</td>
      <td>${notice.createdAt}</td>
    </tr>
  </tbody>
</table>
 
        <div class = "wrap1">
        <div class="box2"></div>
        </div>
        
        
        <div>
          <form id="frm_btn" method="post">
            <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
            <input type="hidden" name="title" value="${notice.title}">
            <input type="hidden" name="contents" value="${notice.contents}">
            <button type="button" id="btn_edit" class="btn btn-outline-success">편집</button>
            <button type="button" id="btn_remove" class="btn btn-outline-success">삭제</button>
          </form>
        </div>



      <script>
      	var frmBtn = $('#frm_btn');
      	
     
      const fnEditNotice = () => {
        $('#btn_edit').click(() => {
      	  frmBtn.attr('action', '${contextPath}/notice/edit.form');
          frmBtn.submit();
      	})
      }
      
      const fnRemoveNotice = () => {
    	  $('#btn_remove').click(() => {
      	  if(confirm('블로그를 삭제하면 모든 댓글이 함께 삭제됩니다. 삭제할까요?')){
      		frmBtn.attr('action', '${contextPath}/notice/remove.do');
      		frmBtn.submit();
      	  }
    		  
    	  })
      }
      	
      
      fnEditNotice();
      fnRemoveNotice();
      
      </script>


  
  
  
  
  
  
  
  
  
    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  

 
 
 

<%@ include file="../layout/footer.jsp" %>