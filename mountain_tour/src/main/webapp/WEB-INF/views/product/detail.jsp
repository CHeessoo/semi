<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<jsp:include page="../layout/header.jsp">
  <jsp:param value="${product.productNo}번 상품" name="title"/>
</jsp:include>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>여행상품</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  $( function() {
	    $( "#datepicker" ).datepicker();
	  } );

  </script>
  <style>
  .image img {

  width:100%;
}
   

  
  </style>
</head>
<body>


  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style="padding-top: 0;">
      <div class="text-center">
		</div>

      <div class="row">
    	<div class="col-8" style="margin-top: 30px; margin-bottom: 30px;">
    	
    	 <div style = "text-align: left; margin: 0;">조회수 : <fmt:formatNumber value="${product.hit}" pattern="#,##0"></fmt:formatNumber></div>
    	  <div class="text-center">
			<img src="https://github.com/skal48/portfolio/blob/main/hanla.jpg?raw=true" width="600px;" height="400px;" style="margin-top: 20px;">
		  </div>
    	  <hr>
    	  <c:if test="${sessionScope.user.auth == 0}">
    	   <form id="frm_btn" method="post">
    	   	  <input type="hidden" name="productNo" class="heart" value="${product.productNo}">
    	   	  <input type="hidden" name="usertNo" class="heart2" value="${sessionScope.user.userNo}">
    	   	  <input type="hidden" name="tripName" value="${product.tripName}">
    	   	  <input type="hidden" name="price" value="${product.price}">	    	
    	   	  <input type="hidden" name="plan" value="${product.plan}">	    	
    	   	  <input type="hidden" name="tripContents" value="<c:out value='${product.tripContents}' />">
    	   	  <input type="hidden" name="guide" value="${product.guide}">
    	   	  <input type="hidden" name="timetaken" value="${product.timetaken}">
    	   	  <input type="hidden" name="danger" value="${product.danger}">
    	   	  <input type="hidden" name="termUse" value="${product.termUse}">
	    	  <button type="button" id="btn_edit">편집</button> <!-- 관리자만 보이게 -->
	    	  <button type="button" id="btn_remove">삭제</button> <!-- 관리자만 보이게 -->
	       </form>
    	  </c:if>    	  
    	  
    	  <input type="hidden" name="productNo" class="heart" value="${product.productNo}">
    	  <input type="hidden" name="usertNo" class="heart2" value="${sessionScope.user.userNo}">
    	
    	  
    	 <div style="text-align: left;">
			 <span class="badge text-bg-success">단순코스</span>
			 <span class="badge text-bg-warning">난이도하</span>
			 <span class="badge text-bg-secondary">트레킹</span>
		 </div>
		 
		<div style="text-align: left; margin-top: 20px">
		 <div style="font-weight: bolder;">${product.tripName}</div>
		 <div>${product.price}원</div>
		</div>
		
    	  <div class="choice">상품선택</div>
    	  <div class="calender">
    	  <div style = "text-align: left; font-size:16px;">출발일 선택</div>
	    	 <div class="calender_mini">
	    	  <div class="row">
			    <div class="col">
			     <div id="datepicker"></div>
			    </div>
			    <div class="col" style = "border: 1px #1f753d solid; margin-right: 20px;">
			     <div style="margin: 60px 20px;"> 
			      예약이 가능해요!<br>
			      인원수를 정해주시고<br>
			      예약하기를 클릭해주세요!
			     </div>
			    </div>
			  </div>
	    	 
    
			

	    	  
	    	 </div>
	      <div style="text-align: left; font-weight: bold; color: red;">상품 선택</div>
    	  <div style = "text-align: left; font-size:16px; border: 1px red solid; margin: 0;">
    	  
    	  <span class="badge text-bg-dark" style="margin: 10px ">예약가능</span>
    	  <div style="margin: 10px">  	    
	    	  <div>${product.tripName}상품</div>
			  <div>예약가능인원수</div>
		      <div>현재예약</div>
    	  </div>  
    	  </div>
	    <div> 

		<div style="text-align: right;">

		    <a style="display: inline-block; margin-top: 20px">
		        <button type="button" id="btn_reserve" class="btn btn-outline-success">예약하기</button>
		    </a>
		</div>
	    	  
	    	  
	    	  
	    	 </div>
    	  </div>
    	  <div class="choice">주요 여행일정</div>
    	    <div style="text-align: left; margin-left: 20px;">
    	  	${product.plan} 
 	     </div>
 	     
 	      <div>
    	   <div class="choice" >상품정보</div>
    	    <div class="mt-3" style="text-align: left; margin-left: 20px;">
    	  	${product.tripContents} 
    	    </div>
    	  </div>
    	    
    	    <div class="choice" >소요시간</div>
    	    <div style="text-align: left; margin-left: 20px;">
    	  	${product.timetaken}
    	    </div>
    	    <div class="choice">가이드</div>
    	    <div style="text-align: left; margin-left: 20px;">
    	  	${product.guide}
    	    </div>
    	    <div class="choice">주의사항</div>
			<div style="text-align: left; margin-left: 20px;">
    	  	${product.danger}
    	    </div>
  
    	    
    	  <div class="choice">약관/정보</div>
    	    <div style="text-align: left; margin-left: 20px;">	  
    	    ${product.termUse}
    	    </div>
    	
	    <div class="choice">리뷰</div> 
	    <c:if test="${sessionScope.user.userNo != null}">
	 	<form class="mb-3 frm_review_add" id="myform" method="post">
		<fieldset>
			<span class="text-bold"> ❤️ 별점을 선택해주세요</span>
			<input type="radio" name="star" value="5" id="rate1"><label
				for="rate1">★</label>
			<input type="radio" name="star" value="4" id="rate2"><label
				for="rate2">★</label>
			<input type="radio" name="star" value="3" id="rate3"><label
				for="rate3">★</label>
			<input type="radio" name="star" value="2" id="rate4"><label
				for="rate4">★</label>
			<input type="radio" name="star" value="1" id="rate5"><label
				for="rate5">★</label>
		</fieldset>
		
			<div>
				<input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
        		<input type="hidden" name="productNo" value="${product.productNo}">
				<textarea class="col-auto form-control" id="contents" name="contents" placeholder="행복했던 여행후기를 남겨보세요🙂"></textarea>   <!-- 예약한사람만 보이게 -->
				<button type="button" class="btn btn-success btn-sm" id="btn_review_add" style="margin-top: 20px; margin-left: 600px">작성완료</button>
			</div>
		 </form>
		 </c:if>	
	    
    <div style="overflow: hidden;">
	    <div style="height: 100px; float: right;">
	        <select class="form-select form-select-sm mb-3 h-50 d-inline-block" style="width: 120px;" aria-label=".form-select-sm example">
	            <option value="1" selected>최신순</option>
	            <option value="2">별점순</option>
	        </select>
	    </div>
	</div>
	<div id="reviewAccordion">
	  	 <input type="hidden" id="productNo" name="productNo" value="${product.productNo}">  		
	  	  		
	</div>	
    	</div>   	
    	   
    	<div class="col-4"> <!-- style="border-left: 2px solid gray;" -->
       <div style="margin-top: 200px;">
	   <div style="position: sticky; top: 80px;">
	   <div><div class="css-a5xtki">
	   <div style="text-align: left;">
	   <div>
	   <div style="font-size: large; font-weight: bolder;">선택중인 행사</div>
	   <div>${product.tripName}</div>
	   </div>
	   <hr>
	   <div>행사금액</div>
	   <div>
	   <div style="font-weight: bolder;">${product.price}원</div>
	   </div>
	   <button class="btn btn-success"  style="margin: 20px auto;">
	   <div>
		<div id="heartButton" style="color: white; cursor: pointer;">찜하기♥</div>
	   </div>
	   </button>
	   </div>
	   </div>
	   </div>
	   </div>
	  </div>
    	</div>  	

  	  </div>
	  


      

    </div>
    <div class="col-1">
    </div>
  </div>
</div>
 
</body>
</html>
<style>
.admin_btn {
	display: flex;
 	justify-content: flex-end;
}
.choice{
    box-sizing: border-box;
    margin: 0px 0px 28px;
    min-width: 0px;
    line-break: anywhere;
    font-size: 20px;
    letter-spacing: -0.02em;
    line-height: 30px;
    font-weight: 700;
    border-top: 1px solid rgb(25, 25, 25);
    border-bottom: 1px solid rgb(237, 237, 237);
    width: 100%;
	text-align: left;
    justify-content: space-between;
    background: rgb(251, 251, 251);
    padding: 8px 16px;
    margin-top: 80px;
}
.calender{
  margin: 20px 20px;
}

.calender_mini {
  margin: 20px auto;
}

 
 #myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#contents {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
</style>
 

  <script>


  $( function() {
	    $( "#datepicker" ).datepicker();
	  } );

  var frmBtn = $('#frm_btn');
  
  const fnEditProduct = () => {
    $('#btn_edit').click(() => {
      frmBtn.attr('action', '${contextPath}/product/edit.do');
      frmBtn.submit();
    })
  }

  const fnRemoveProduct = () => {
      $('#btn_remove').click(() => {
        if(confirm('상품을 삭제할까요?')){
          frmBtn.attr('action', '${contextPath}/product/remove.do');
          frmBtn.submit();          
        }
      })
    }
  
  
  function fnGoReserve(){
      $('#btn_reserve').click(function(){
         location.href='${contextPath}/reserve/write.form?productNo=${product.productNo}&resDate=' + $("#datepicker").val();
      })
   }
  
  $(document).ready(function () {
	    $('#heartButton').on('click', function () {
	        addHeart();
	    });
	});

  function addHeart() {
	    var productNo = $('.heart').val();
	    var userNo = $('.heart2').val();

	    var confirmResult = confirm('찜하기 페이지로 이동하시겠습니까?');

	    if (confirmResult) {
	        $.ajax({
	            type: 'post',
	            url: '${contextPath}/product/heartProduct.do',
	            data: {
	                productNo: productNo,
	                userNo: userNo
	            },
	            success: function (response) {
	                console.log('찜하기 성공');
	                window.location.href = '${contextPath}/user/heartProduct.do';
	            },
	            error: function (error) {
	                console.error('찜하기 실패:', error);
	            }
	        });
	    } else {	        
	        console.log('아니오');
	    }
	}

  

  fnGoReserve();
  fnEditProduct();
  fnRemoveProduct();
  
  
  // 리뷰
  
  const fnReviewAdd = () => {
      $('#btn_review_add').click(() => {
        if('${sessionScope.user}' === ''){
          if(confirm('로그인이 필요한 기능입니다. 로그인할까요?')){
            location.href = '${contextPath}/user/login.form';
          } else {
            return;
          }
        }
        $.ajax({
          // 요청
          type: 'post',
          url: '${contextPath}/product/addReview.do',
          data: $('.frm_review_add').serialize(),
          // 응답
          dataType: 'json',
          success: (resData) => {          	  
            if(resData.addReviewResult === 1){
              alert('리뷰가 등록되었습니다.');
              $('#contents').val('');
              fnReviewList();
            }
          }
        })
      })
    }
  
  
  
  var page = 1;
  var totalPage = 0;

  const productNo = $('#productNo').val();

  const fnReviewList = () => { 
    $.ajax({
      type: 'get',
      url: '${contextPath}/product/reviewList.do',
      data: { page: page, productNo: productNo},
      dataType: 'json',
      success: (resData) => {
        totalPage = resData.totalPage;
        $('#reviewAccordion').empty();
        if (resData.reviewList != null && resData.reviewList.length > 0) {
        	$.each(resData.reviewList, (i, review)=> {
        	  let str = '<div class="accordion accordion-flush">';
        	  str += '<div class="accordion-item">';
        	  str += '<h2 class="accordion-header">';
        	  str += '<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse' + i + '" aria-expanded="false" aria-controls="flush-collapse' + i + '">' + review.userDto.userNo + '님의 리뷰</button>';
        	  str += '</h2>';
        	  str += '<div id="flush-collapse' + i + '" class="accordion-collapse collapse" data-bs-parent="#accordionFlushExample">';
        	  str += '<div class="accordion-body">' + review.contents + '</div>';
        	  str += '  <div>';
        	  if('${sessionScope.user.userNo}' == review.userDto.userNo){                
                  str += '  <input type="hidden" value="' + review.reviewNo + '">';
                  str += '  <button type="button" class="btn remove_Review" style="margin-left: 550px;">삭제하기</button>';
                }
                  str += '  </div>';
        	  str += '</div>';
        	  str += '</div>';
        	  str += '</div>';
              $('#reviewAccordion').append(str);         
          });
        } else {
          // 리뷰가 없을 때
          $('#reviewAccordion').append('<div class="text-center">등록된 리뷰가 없습니다.</div>');
        }
      },
      error: (error) => {
        console.error('Ajax 요청 에러:', error);
      }
    });
  };

  // 문서가 완전히 로드된 후에 함수 호출
  $(document).ready(() => {
    fnReviewList();
  });

  
  // 페이지 로딩 시 호출
  $(document).ready(() => {
	  const productNo = $('#productNo').val();
	  fnReviewList(productNo);
  });

  const fnReviewRemove = () => {
      $(document).on('click', '.remove_Review', (ev) => {
        if(!confirm('리뷰를 삭제할까요?')){
          return;
        }
        $.ajax({
          // 요청
          type: 'post',
          url: '${contextPath}/product/removeReview.do',
          data: 'reviewNo=' + $(ev.target).prev().val(),
          // 응답
          dataType: 'json',
          success: (resData) => { 
            if(resData.removeResult === 1){
              alert('해당 리뷰가 삭제되었습니다.');
              fnReviewList();
            } else {
              alert('리뷰가 삭제되지 않았습니다.');
            }
          }
        })
      })
    }
  

	    
  
  fnReviewAdd();
  fnReviewList();
  fnReviewRemove();
  
  </script>



<%@ include file="../layout/footer.jsp" %>