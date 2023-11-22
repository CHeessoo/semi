<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="매거진" name="title"/>
</jsp:include>
  <style>
    .magazineKing {
      width: 60%;
      margin: auto;
    }
    h3 {
      margin-top: 40px;
      text-align: left;
      font-weight: 700;
      
    }
    .big_magazine {         
      height: 410px;
      width: 100%;
      margin-top:15px; 
      cursor: pointer;
    }    
    .big_picture {
      height: 270px;
      width:100%;
      margin-top: 10px;
      margin-bottom: 30px;
    }
    .big_title {
      text-align: left;
      margin-left: 40px;
      font-weight: 600;
      font-family: strong;
      font-size: 24px;
    }
    .big_date {
      margin-bottom: 15px;
      margin-left: 40px;
     
    }
    .big_hit {
      width : 100px;
      margin-bottom: 15px;
    }
    .magazine {
      margin-bottom: 50px;
    }    
    .small_magazine {      
      margin-top: 20px;
    }
    
    .small_picture {
      height: 200px;
      width: 100%;
    }
    .small_title {
      margin-top: 20px;
      font-weight: 600;
      font-family: strong;
      font-size: 24px;
    }
    .small_summary {
      margin: 10px;   
    }
  
  </style>
 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    
    <div class="col-10" style = "border: 1px gray solid; " >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
      <div class="magazineKing">
        <h3>매거진</h3>
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
          <button type="button" class="m_write btn btn-secondary">작성</button>
        </div>  
        <div class="big_wrapper">
  	      
  	     </div>
	       
	      <div class="small_magazine" id="small_wrapper" style = "border: 1px gray solid;">
                 
	      </div>          
   </div>
  </div> 
    <div class="col-1">
    </div>
 	 
  </div>
 </div> 

<script>
	
  var page = 1;
  var totalPage = 0;
	
  const fnMagazineWrite = () => {
  	$('.btn').click(() => {
  		location.href = '${contextPath}/magazine/write.form';  		
  	})
  }

  const fnGetUploadList = () => {
	    $.ajax({
	      // 요청
	      type: 'get',
	      url: '${contextPath}/magazine/getList.do',
	      data: 'page=' + page,
	      // 응답
	      dataType: 'json',
	      success: (resData) => {  // resData = {"uploadList": [], "totalPage": 10}
	    	  totalPage = resData.totalPage;
	    	  $.each(resData.magazineList, (i, upload) => {
	        if(page === 1 && i === 0){
	        	let big = '<form class="frm_click" action="${contextPath}/magazine/increseHit.do" method="get">';
	        			big += '<input type="hidden" name ="magazineNo" value="'+ upload.magazineNo +'">';
  	      	    big += '<div class="big_magazine magazine" style = "border: 1px gray solid;">';
  	      		if(upload.magazineMultiDto.isThumbnail === 1){
  			        big += '<img class="big_picture"src="${contextPath}'+upload.magazineMultiDto.multiPath+'/'+upload.magazineMultiDto.filesysName+'" alt="썸네일" >';
  	      		}
  			        big += '<div class="big_title">'+ upload.title +'</div>';
  			        big += '<span class="big_date position-absolute bottom-0 start-0">date   '+ new Date(upload.createAt).toLocaleDateString().replace(/\./g, '').replace(/\s/g, '-')   +'</span>';
  	            big += '<span class="big_hit position-absolute bottom-0">조회수' + upload.hit +'</span> </div></form>';
  	      	$('.big_wrapper').append(big);
	        } else {
	        	let small = '<form class="frm_click" action="${contextPath}/magazine/increseHit.do" method="get">';
	        			small += '<div class="row magazine"><div class="col">';
	        			small += '<input type="hidden" name ="magazineNo" value="'+ upload.magazineNo +'">';
	        			 if(upload.magazineMultiDto.isThumbnail === 1){
	        			small += '<img class="small_picture" src="${contextPath}'+upload.magazineMultiDto.multiPath+'/'+upload.magazineMultiDto.filesysName+'" style = "border: 1px gray solid;"></div>';
	        			 }
	        			small += '<div class="col"><div class="small_title">'+upload.title+'</div>';
	        			small += '<div class="small_summary">'+upload.summary+'</div>';
	        			small += '<span class="small_date position-absolute bottom-0 start-0">date'+ new Date(upload.createAt).toLocaleDateString().replace(/\./g, '').replace(/\s/g, '-') +'</span>';
	        			small += '<span class="small_hit position-absolute bottom-0">조회수' + upload.hit +' </span></div></div></form>';
	        	$('#small_wrapper').append(small);  
	        	}
	    	  })
	      }
	    })
  }
  
  const fnClickHit = () => {
	  
	  $(document).on('click', '.frm_click', function() {
				$(this).submit();
		})
  }
   
  
  const fnScroll = () => {
	    
	    var timerId;  // 최초 undefined 상태
	    
	    $(window).on('scroll', () => {
	      
	      if(timerId){  // timerId가 undefined이면 false로 인식, timerId가 값을 가지면 true로 인식
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
	          fnGetUploadList();
	        }
	        
	      }, 200);  // 200밀리초(0.2초) 후 동작(시간은 임의로 조정 가능함)
	      
	    })
	    
	  }
 const fnModifyResult = () => {
	 let modifyResult = '${modifyResult}';
	 if(modifyResult !== ''){
		 if(modifyResult === 'true'){
        alert('수정을 성공했습니다. ');
     } else {
       alert('수정을 실패하였습니다.');
     }
	 }
	 
 }
  
  
  
  
  
  fnGetUploadList();
  fnScroll();
  fnModifyResult();
  fnMagazineWrite();	
  fnClickHit();


</script>
  
 
 
 
 
 

<%@ include file="../layout/footer.jsp" %>