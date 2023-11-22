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
 
   
  .title_left{
  text-align:left;
  }
  
  .title_align{
  text-align:left;
  }
  
  .title_move{
  display:inline-block;
     text-align:center;
     width: 95px;
     margin-left:236px;
     height: 45px;
  }
  
  .search_input{
     display:inline-block;
     width :  443px;
     margin-bottom: 30px;
     margin-top:13px;
     height : 43px;
     padding-top: 15px;
  }
   
  .search_btn{
    height: 40px;
    }
  
 
  .wrap1 > .box1{
  width : 100px;
  height : 80px;
  }

 .wrap1 > .box2{
  width : 100px;
  height : 80px;
  
  }
  .wrap1 > .box3{
  height : 40px;
  
  }
  

  .qna_table{
  width: 600px;
  }
  
  .search {
  position: relative;
  width: 300px;
}

input {
  width: 100%;
  border: 1px solid #bbb;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}


img {
  position : absolute;
  width: 17px;
  top: 10px;
  right: 12px;
  margin: 0;
  }

</style>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid;" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
       
       <h1>춘 하 추 동</h1>
       <hr>
       
        <div class = "wrap1">
         <div class="box1"></div>
        </div>
      
      <div>
        <a href="${contextPath}/notice/list.do">
          <button type="button" class="btn btn-outline-success">공지사항</button>
        </a>
        
        <a href="${contextPath}/cs/faqList.do">
          <button type="button" class="btn btn-outline-success">자주묻는질문</button>
        </a>
        
        <a href="${contextPath}/notice/write.form">
        <button type="button" class="btn btn-outline-success">새글작성</button>
       </a>
        
      </div>
    
       <div class = "wrap1">
        <div class="box2"></div>
       </div>
      



    

<div style="display: flex; justify-content: center;">
<table class="table">
  <thead>
    <tr>
      <th scope="col">공지번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성일</th>
      <th scope="col">수정일</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${noticeList}"  var="n" varStatus="vs">
    <tr>
      <th scope="row">${beginNo - vs.index}</th>
            <td>
             <a href="${contextPath}/notice/detail.do?noticeNo=${n.noticeNo}">${n.title}</a>
            </td>
            <td>${n.createdAt}</td>
            <td>${n.modifiedAt}</td>
    </tr>
  </c:forEach>
  </tbody>
  <tfoot>
    <tr>
     <td colspan="5">${paging}
    </tr>
  </tfoot>
  </table>
  </div>
  

   
    
    
    
    
    
    
    
    
    
    
    <div class = "wrap1">
      <div class="box3"></div>
    </div>
   
    <div class = "title_left">
      <form method="get" action="${contextPath}/notice/search.do">
          <select name="column" class="title_move form-select form-select-lg mb-3" aria-label="Large select example">
            <option value="TITLE" class="title_align">제목</option>
          </select>
          <input type="text" name="query" placeholder="검색어 입력" class="search_input">
          <button type="submit" class="btn btn-outline-success search_btn">검색</button>
      </form>
    </div>

    
    
    
    
    
    
    
      
      </div>
      </div>
      </div>
      
      
      
      
      
      <script>

      
      </script>
      
      
      
      
      
      
      
      
      
      


 
    <div class="col-1">
    
    </div>
  
 
 
 
 

<%@ include file="../layout/footer.jsp" %>