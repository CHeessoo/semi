<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마운틴투어" name="title"/>
</jsp:include>
<style>
  .card {
      width: 18rem;
      margin-bottom: 20px;
  }

  .admin_btn {
      display: flex;
      justify-content: flex-end;
  }
</style>

<div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10">
    <c:if test="${sessionScope.user.auth == 0}">    
      <a href="${contextPath}/product/write.form">
        <button type="button" class="admin_btn" style="margin-left: auto;">게시글 작성</button>
      </a>
    </c:if>
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <div style="display: inline-block;"> 
         <span>${count}</span>개의 상품
        </div>
        <div class="btn-group btn-group-sm" role="group" aria-label="Small button group" style="display: inline-block;">
          <button type="button" class="btn btn-outline-dark" id="recommend">추천순</button>
          <button type="button" class="btn btn-outline-dark" id="reviewProduct">리뷰순</button>
        </div>
      </div>
      <hr>
		

		
      <div class="container">
        <div class="row" id="product_list"> <!-- Added id attribute -->
          <!-- Product cards will be appended here -->
        </div>
      </div>

    </div>
    <div class="col-1">
    </div>
  </div>
</div>

<script>

	// 전역 변수
	var page = 1;
	var totalPage = 0;

    const fnGetProductList = () => {
	  $.ajax({
	    type: 'get',
	    url: '${contextPath}/product/getList.do', 
	    data: 'page=' + page,
	    dataType: 'json',
	    success: (resData) => {  
	      totalPage = resData.totalPage;
	      if (resData.productList != null && resData.productList.length > 0) {
	        $.each(resData.productList, (i, product) => {	        	
	          let str = '<div class="col-md-4">';
	          str += '<div class="card">';
	          str += '<img src="https://github.com/skal48/portfolio/blob/main/hanla.jpg?raw=true" style="height: 150px;" class="card-img-top" alt="Product Image">';
	          str += '<div class="card-body">';
	          str += '<h5 class="card-title">' + product.tripName + '</h5>';
	          str += '<p class="card-text"></p>';
	          str += '<a href="' + '${contextPath}/product/increseHit.do?productNo=' + product.productNo + '" class="btn btn-primary">상세보기</a>';	         
	          str += '</div>';
	          str += '</div>';
	          str += '</div>';
	          $('#product_list').append(str);
	        });
	      } else {
	        console.log('데이터가 없습니다.');
	      }
	    },
	    error: (error) => {
	      console.error('Ajax 요청 에러:', error);
	    }
	  });
	  
	};

	$('#recommend').on('click', function () {
	    $.ajax({
	        type: 'get',
	        url: '${contextPath}/product/hitList.do',
	        data: 'page=' + page,
	        dataType: 'json',
	        success: (resData) => {
	            totalPage = resData.totalPage;
	            if (resData.hitList != null && resData.hitList.length > 0) {
	                // #product_list의 내용을 새로 가져온 데이터로 대체
	                $('#product_list').empty();
	                $.each(resData.hitList, (i, product) => {
	                    let str = '<div class="col-md-4">';
	                    str += '<div class="card">';
	                    str += '<img src="https://github.com/skal48/portfolio/blob/main/hanla.jpg?raw=true" style="height: 150px;" class="card-img-top" alt="Product Image">';
	                    str += '<div class="card-body">';
	                    str += '<h5 class="card-title">' + product.tripName + '</h5>';
	                    str += '<p class="card-text"></p>';
	                    str += '<a href="' + '${contextPath}/product/increseHit.do?productNo=' + product.productNo + '" class="btn btn-primary">상세보기</a>';
	                    str += '</div>';
	                    str += '</div>';
	                    str += '</div>';
	                    $('#product_list').append(str);
	                });
	            } else {
	                console.log('데이터가 없습니다.');
	            }
	        },
	        error: (error) => {
	            console.error('Ajax 요청 에러:', error);
	        }
	    });
	});
	
	
	
	$('#reviewProduct').on('click', function () {
	    $.ajax({
	        type: 'get',
	        url: '${contextPath}/product/reviewProductList.do',
	        data: 'page=' + page,
	        dataType: 'json',
	        success: (resData) => {
	            totalPage = resData.totalPage;
	            if (resData.reviewProductList != null && resData.reviewProductList.length > 0) {
	                $('#product_list').empty();
	                $.each(resData.reviewProductList, (i, product) => {
	                    let str = '<div class="col-md-4">';
	                    str += '<div class="card">';
	                    str += '<img src="https://github.com/skal48/portfolio/blob/main/hanla.jpg?raw=true" style="height: 150px;" class="card-img-top" alt="Product Image">';
	                    str += '<div class="card-body">';
	                    str += '<h5 class="card-title">' + product.productDto.tripName + '</h5>';
	                    str += '<p class="card-text"></p>';
	                    str += '<a href="' + '${contextPath}/product/increseHit.do?productNo=' + product.productDto.productNo + '" class="btn btn-primary">상세보기</a>';
	                    str += '</div>';
	                    str += '</div>';
	                    str += '</div>';
	                    $('#product_list').append(str);
	                });
	            } else {
	                console.log('데이터가 없습니다.');
	            }
	        },
	        error: (error) => {
	            console.error('Ajax 요청 에러:', error);
	        }
	    });
	});
	        
    const fnScroll = () => {
        var timerId;  // 최초 undefined 상태
        $(window).on('scroll', () => {
	        if(timerId) {  // timerId가 undefined이면 false로 인식, timerId가 값을 가지면 true로 인식
	        	clearTimeout(timerId);
	        }
        	timerId = setTimeout(() => {  // setTimeout 실행 전에는 timerId가 undefined 상태, setTimeout이 한 번이라도 동작하면 timerId가 값을 가짐
	            let scrollTop = $(window).scrollTop();     // 스크롤바 위치(스크롤 된 길이)
	            let windowHeight = $(window).height();     // 화면 전체 크기
	            let documentHeight = $(document).height(); // 문서 전체 크기
	            if((scrollTop + windowHeight + 100) >= documentHeight) {  // 스크롤이 바닥에 닿기 100px 전에 true가 됨
	              if(page > totalPage){  // 마지막 페이지를 보여준 이후에 true가 됨
	                return;              // 마지막 페이지를 보여준 이후에는 아래 코드를 수행하지 말 것 
	              }
	              page++;
	              fnGetProductList();
	            }
	        }, 200);  // 200밀리초(0.2초) 후 동작(시간은 임의로 조정 가능함)
        })
    }


    
    
    
	fnGetProductList();
	fnScroll();

</script>

<%@ include file="../layout/footer.jsp" %>
