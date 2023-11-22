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
    .thumbnail { 
      margin: auto;     
      margin-top: 20px;
      width: 60%;
      height: 800px;    
      
    }
    .image_wrapper {   
      width: 560px;
      text-align: center;
      margin:auto;
    }
    .big_magazine {         
      height: 410px;
      margin-top:15px; 
    }    
    #previewId {
      width: 560px;
      height: 270px;
      margin-top: 20px;
      margin-bottom: 30px;
      
    }
    #image{
      width: 100%;
    }
    .big_title {
      text-align: left;
      margin-left: 40px;
      margin-bottom: 10px;
      font-weight: 600;
      font-family: strong;
      font-size: 24px;
    }
  
   

</style>
 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
      <form class="thumbnail" method="post" action="${contextPath}/magazine/final.do" enctype="multipart/form-data" style = "border: 1px gray solid;" >
          <div class="image_wrapper">
            <div id="previewId"></div>
		        <input type="file" id="image" name="files" class="input-group-text" onchange="previewImage(this,'previewId')" accept="image/gif,image/jpeg,image/png" required/>
          
          </div>		               
		      <div class="big_title">summary</div>
          <textarea rows="10" cols="60" name="summary"></textarea>
          <div>
          <input type="hidden" value="${map.magazineNo}" name="magazineNo">
          <input type="hidden" name="isThumbnail" value="1">        
		      <button type="submit" class="btn btn-secondary">완료</button>
          </div>
	    </form>
      




    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
<script>
	function previewImage(targetObj, previewId) {
		
		  var preview = document.getElementById(previewId); //div id   
	     var ua = window.navigator.userAgent;
	
	     var files = targetObj.files;
	     for ( var i = 0; i < files.length; i++) {
	
	         var file = files[i];
	
	         var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
	         if (!file.type.match(imageType))
	             continue;
	
	         var prevImg = document.getElementById("prev_" + previewId); //이전에 미리보기가 있다면 삭제
	         if (prevImg) {
	             preview.removeChild(prevImg);
	         }
	         var img = document.createElement("img"); //크롬은 div에 이미지가 뿌려지지 않는다. 그래서 자식Element를 만든다.
	         img.id = "prev_" + previewId;
	         img.classList.add("obj");
	         img.file = file;
	         img.style.width = '560px'; //기본설정된 div의 안에 뿌려지는 효과를 주기 위해서 div크기와 같은 크기를 지정해준다.
	         img.style.height = '270px';
	         
	         preview.appendChild(img);
	
	         if (window.FileReader) { // FireFox, Chrome, Opera 확인.
	             var reader = new FileReader();
	             reader.onloadend = (function(aImg) {
	                 return function(e) {
	                     aImg.src = e.target.result;
	                 };
	             })(img);
	             reader.readAsDataURL(file);
	         }   
	     }       
	  }

	 const fnFileCheck = () => {
		    $('#image').change((ev) => {
		      let maxSize = 1024 * 1024 * 100;
		      let maxSizePerFile = 1024 * 1024 * 10;
		      let totalSize = 0;
		      let files = ev.target.files;
		      for(let i = 0; i < files.length; i++){
		        totalSize += files[i].size;
		        if(files[i].size > maxSizePerFile){
		          alert('각 첨부파일의 최대 크기는 10MB입니다.');
		          $(ev.target).val('');
		          return;
		        }
		      }
		      if(totalSize > maxSize){
		        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
		        $(ev.target).val('');
		        return;
		      }
		    })
		  }
  	
  fnFileCheck();
  fnFileCheck();
  	
</script>
 
 
 
 

<%@ include file="../layout/footer.jsp" %>