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
  .wapper {
   
   
  }
  .btn_wrapper{
    text-align: right;
  }
  .btn {    
    margin: 15px;
  }
  h1 {
    font-size: 55px;
  }
  .date_hit {
    text-align: right;
    margin-right: 20px; 
    margin-bottom: 90px;
  }
  .date_hit > span {
    margin-right: 20px;
  }
 .contents {
    width: 80%;
    margin: auto;
 }
 .btn_like {
    border: none;
    background-color: white;
    margin-top: 70px;   
 }
 .like_num {
    color: gray;
 }
 
 img {
  max-width: 100%;
  height: auto;
 }
 .ck.ck-reset_all.ck-widget__resizer {
  display: none;
 }
 path {
  display: none;
 
 }
 </style>
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
      <div class="wapper">
	      <div class="btn_wrapper">
          <c:if test="${sessionScope.user.auth == 1}">  <!-- 바꿔야해 관리자로 -->
            <form id="btn_frm" method="post">
              <input type="hidden" class ="magazineNo" name="magazineNo" value="${magazine.magazineNo}">
              <input type="hidden" class ="userNo" name="userNo" value="${sessionScope.user.userNo}">
              <input type="hidden" name="title" value="${magazine.title}">
              <input type="hidden" class = "hidden_contents" name="contents" value="<c:out value = '${magazine.contents}' />">
              <input type="hidden" name="productNo" value="${magazine.magazineNo}">
    	        <button type="button" class="goDelete btn btn-secondary">삭제</button>
    	        <button type="button" class="goModify btn btn-secondary">수정</button>
             </form> 
          </c:if>
	      </div>
	      <div>
	        <h1>${magazine.title}</h1>
	        <div class="date_hit">
		        <span>${magazine.createAt}</span>
		        <span>조회수   ${magazine.hit}</span>
	        </div>
	        <div class="contents">${magazine.contents}</div>
	        <div class="like">
              <input type="hidden" class ="magazineNoLike" name="magazineNo" value="${magazine.magazineNo}">
              <input type="hidden" class ="userNoLike" name="userNo" value="${sessionScope.user.userNo}">
	          <button type="button" class="btn_like"><i class="fa-regular fa-thumbs-up fa-bounce fa-2xl" style="color: #1f753d;"></i></button>
	          <div class="like_num">${like} </div> 
	        </div>
	      </div>
      </div>
      <!-- 좋아요 누르면  <i class="fa-solid fa-thumbs-up fa-2xl" style="color: #1f753d;"></i> 이거로 바뀌어야함-->


    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
<script>

	var btn_frm = $('#btn_frm');
	
  const fnModify = () => {
	  $('.goModify').click(() => {
		  btn_frm.attr('action', '${contextPath}/magazine/modify.form');
		  btn_frm.submit();
	  })  
  }
  
  
  
  const fnDelete = () => {
	  $('.goDelete').click(() => {
		  if(confirm('매거진을 삭제할까요?')){
			  btn_frm.attr('action', '${contextPath}/magazine/delete.do');
			  btn_frm.attr('method', 'post');
			  btn_frm.submit();
		  }		  
	  })
  }
  
  const fnLike = () => {
	  $('.btn_like').click(() => { 		 
		  $.ajax({
			  type: 'post',
	      url: '${contextPath}/magazine/like.do',
	      data: {userNo: $('.userNoLike').val(), magazineNo: $('.magazineNoLike').val()},
	      dataType: 'json',
	      success: (resData) => {  
	    	  console.log(resData.existMaUser+'qweqwe');
	    	  let str;
			  	if(resData.existMaUser === 1){				  		
			  		$('.btn_like').empty();
			  		str += '<i class="fa-solid fa-thumbs-up fa-2xl" style="color: #1f753d;"></i>';
			  		$('.btn_like').append(str);
			  	} else if(resData.existMaUser === 0){	
			  		$('.btn_like').empty();
			  		str += '<i class="fa-regular fa-thumbs-up fa-bounce fa-2xl" style="color: #1f753d;"></i>';
			  		$('.btn_like').append(str);
			  	}			  				 
			  	$('.like_num').text(resData.countLike);
		  },
		  error : (error) => {
			  console.log('못가져왔어');
		  }
	  })
  })
 }
  
  
  fnModify();
  fnDelete();
  fnLike();
  
</script>
 
 
 
 

<%@ include file="../layout/footer.jsp" %>