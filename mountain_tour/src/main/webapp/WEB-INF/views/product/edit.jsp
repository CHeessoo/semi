<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${product.productNo}상품수정" name="title"/>
</jsp:include>
<style>
 
   .ck.ck-editor {
     max-width: 1000px;
   }
   .ck-editor__editable {
     min-height: 300px;
   }
  
.ck-content {
  color: gray;
}
#ckeditor {
  border: 1px solid silver;
}
</style>
 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10">
      <!--  여기다가 작성  다 작성하고 height 지우기!!!! -->
      
	  
	 <div class="row">
    	<div class="col-8" style="margin-top: 30px; margin-bottom: 30px;">
    	 <form id="frm_product_modify" method="post" action="${contextPath}/product/modifyProduct.do">
    	  <div class="text-center">
			<img src="https://github.com/skal48/portfolio/blob/main/seolark2.jpg?raw=true" class="rounded" alt="..."  width="500px" height="400px">
		  </div>
    	  <hr>
    	  <div style = "text-align: left;">
    	   <div>
	        <label for="tripName" class="form-label">제목</label>
	        <input type="text" name="tripName" value="${product.tripName}" id="tripName" class="form-control">
	       </div>
	      </div>
    	  <div style = "text-align: right;">
    	  <div>
	        <label for="price" class="form-label">가격</label>
	        <input type="text" name="price" value="${product.price}" id="price" class="form-control">
	      </div>
	      </div>



    	  <div class="mb-3">
    	  <div class="choice">주요 여행일정</div>
    		<label for="plan" class="form-label"></label>
 		    <textarea name="plan" id="plan" class="form-control" rows="10">${product.plan}</textarea>
    	  </div>
    	  
    	  <div>
    	  <div class="choice">상품정보</div>
    	    <label for="tripContents">내용</label>
			<textarea name="tripContents" id="tripContents" style="display: none;">${product.tripContents}</textarea>
            <div id="toolbar-container"></div>
            <div id="ckeditor"></div>  
          </div>	 
    	        	       	  
    	  <div>
    	    <label for="guide" class="form-label">가이드</label>
	        <input type="text" name="guide" id="guide" value="${product.guide}" class="form-control">
    	  </div>
    	  
    	  <div>
    	  	<label for="timetaken" class="form-label">소요시간</label>
	        <input type="text" name="timetaken" id="timetaken" value="${product.timetaken}" class="form-control">
    	  </div>
    	  
    	  <div class="mb-3">
    	  <div class="choice">주의사항</div>
    		<label for="danger" class="form-label"></label>
 		    <textarea class="form-control" id="danger" name="danger" rows="10">${product.danger}</textarea>
    	  </div>
    	  
    	  <div class="mb-3">
    	  <div class="choice">약관/정보</div>
    		<label for="termUse" class="form-label"></label>
 		    <textarea class="form-control" id="termUse" name="termUse" rows="10">${product.termUse}</textarea>
    	  </div>
    	  <div class="d-grid gap-2 col-6 mx-auto">
	      <input type="hidden" name="productNo" value="${product.productNo}">
	      <button type="submit" class="btn btn-primary" style="margin: 32px;">수정완료</button>
	    </div>
    	  </form>
    	</div>   	   
    	<div class="col-4"> <!-- style="border-left: 2px solid gray;" -->
       <div>

	  </div>
    	</div>  	
  	  </div>
	  
	  
	  
		       
      
      
      
      
      
      
      

    </div>
	  
	    

	       
      
      
      
      
      
      
      

    </div>
    <div class="col-1">
    </div>
  </div>

  
   <script>
   const fnCkeditor = () => {
		  DecoupledEditor
	    .create(document.getElementById('ckeditor'), {
	  	  ckfinder: {
	        // 이미지 업로드 경로
	        uploadUrl: '${contextPath}/product/imageUpload.do'
	 			
	  		}
		  })
	    .then(editor => {
	      const toolbarContainer = document.getElementById('toolbar-container');
	      toolbarContainer.appendChild(editor.ui.view.toolbar.element);
	      
	    })
	    .catch(error => {
	      console.error(error);
	    });
	}
   
   fnCkeditor();
	</script>
 
 
 
 
 

<%@ include file="../layout/footer.jsp" %>