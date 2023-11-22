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
      .content > .form-control {
        height: 400px;
      }
      
      .wrap1 > .box1{
        height: 50px;
      }
      
      .wrap2 > .box2{
        height: 50px;
      }
      
      .wrap3 > .box3{
        height: 30px;
      }
    </style>

  
  
  
  
  
    <div class="container text-center">
    <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
     
     
     
     
      <div>

      <form id="frm_notice_modify" method="post" action="${contextPath}/notice/modifyNotice.do">
        
        <h1 style="text-align: center;">${notice.noticeNo}번 공지사항 편집</h1>
        
        
        <div class ="wrap2">
         <div class="box2"></div>
        </div>
        
        
        <!-- 제목  -->
        <div>
          <label for="title">제목</label>
          <input type="text" name="title" id="title" class="form-control" value="${notice.title}">
        </div>
        
        <div class ="wrap1">
         <div class="box1"></div>
        </div>
      
        <!-- 내용  -->  
        <div>
          <label for="contents">내용</label>
        </div>
        <div class="content">  
          <input type="text" name="contents" id="contents" class="form-control" value="${notice.contents}">  
        </div>
        
        <div class ="wrap3">
         <div class="box3"></div>
        </div>
      
        
      <!-- 수정완료 submit  -->  
      <div>
        <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
        <button class="btn btn-primary col-12" type="submit">수정완료</button>
      </div>
        
      </form>
      </div>
      
      
    
    
    
    
    
    
    <script>
    
    const fnNoticeModify = () => {
    	  $('#frm_notice_modify').submit(() => {
    	    $('#contents').val();
    	  })
    	}

    	fnNoticeModify();
    </script>  
    
      
      
      
      
    
      
      
      
      
      

       
       
       
       
       
       
       
       
       
       
       
       



    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 
 
 
 
 

<%@ include file="../layout/footer.jsp" %>