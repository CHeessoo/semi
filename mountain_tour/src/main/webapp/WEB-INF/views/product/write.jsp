<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마운틴투어상품게시글작성" name="title"/>
</jsp:include>
<style>

.ck.ck-editor {
  max-width: 1000px;
}
.ck-editor__editable {
  min-height: 400px;
}
.ck-content {
  color: gray;
}
#ckeditor {
  border: 1px solid silver;
}

.image_resized img {

  width: 80%;
}
   
  
</style>
  <div class="container text-center">
 <form method="post" id="frm_product_add" action="${contextPath}/product/add.do" enctype="multipart/form-data">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10">
      <!--  여기다가 작성  다 작성하고 height 지우기!!!! -->
      
	  
	 <div class="row">
    	<div class="col-8"  style="margin-top: 30px; margin-bottom: 30px;">
    	  <div class="mt-3">
		      <label for="files" class="form-label">첨부</label>
		      <input type="file" name="files" id="files" class="form-control" multiple>
		  </div>
		  <div class="attached_list mt-2" id="attached_list"></div>
    	  <hr>
    	  <div style = "text-align: left;">
    	   <div>
	        <label for="tripName" class="form-label">제목</label>
	        <input type="text" name="tripName" id="tripName" class="form-control">
	       </div>
	      </div>
    	  <div style = "text-align: right;">
    	  <div>
	        <label for="price" class="form-label">가격</label>
	        <input type="text" name="price" id="price" class="form-control">
	      </div>
	      </div>


    	  <div class="mb-3">
    	  <div class="choice">주요 여행일정</div>
    		<label for="plan" class="form-label"></label>
 		    <textarea class="form-control" id="plan" name="plan" rows="10"></textarea>
    	  </div>
    	  
    	  <div>
    	   <div class="choice">상품정보</div>
    	    <label for="tripContents">내용</label>
			<textarea name="tripContents" id="tripContents" style="display: none;"></textarea>
            <div id="toolbar-container"></div>
            <div id="ckeditor"></div>  
           </div>	     	    
    	  
    	  <div>
    	    <label for="guide" class="form-label">가이드</label>
	        <input type="text" name="guide" id="guide" class="form-control">
    	  </div>
    	  
    	  <div>
    	  	<label for="timetaken" class="form-label">소요시간</label>
	        <input type="text" name="timetaken" id="timetaken" class="form-control">
    	  </div>
    	  
    	  <div class="mb-3">
    	  <div class="choice">주의사항</div>
    		<label for="danger" class="form-label"></label>
 		    <textarea class="form-control" id="danger" name="danger" rows="10"></textarea>
    	  </div>
    	  
    	  <div class="mb-3">
    	  <div class="choice">약관/정보</div>
    		<label for="termUse" class="form-label"></label>
 		    <textarea class="form-control" id="termUse" name="termUse" rows="10"></textarea>
    	  </div>
    	  
    	  
    	  
    	</div>   	   
    	<div class="col-4"> 
       <div>
	   <div style="position: sticky; top: 80px;">
	   <div><div>
	   <div>
	   <div>
	   <div>
	   	<div>
	      
	       </div>
	    </div>
	   </div>
	   <hr>
	   <div>행사금액</div>
	   <div>
	   <div>
	   <div>
	        
	   </div>
	   </div>
	   </div>
	   </div>
	   </div>
	   </div>
	   </div>
	  </div>
    	</div>  	
  	  </div>

    </div>	  
	    <div class="d-grid gap-2 col-6 mx-auto">
	      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
	      <button type="submit" class="btn btn-primary" style="margin: 32px;">작성완료</button>
	    </div>
    </div>
	  </form>
    <div class="col-1">
    </div>
  </div>

  
 
<script>


const fnThumbnailCheck = () => {
    $('#files').change((ev) => {
      $('#attached_list').empty();
      let maxSize = 1024 * 1024 * 100;
      let maxSizePerFile = 1024 * 1024 * 10;
      let totalSize = 0;
      let files = ev.target.files;
      for(let i = 0; i < files.length; i++){
        totalSize += files[i].size;
        if(files[i].size > maxSizePerFile){
          alert('각 첨부파일의 최대 크기는 10MB입니다.');
          $(ev.target).val('');
          $('#attached_list').empty();
          return;
        }
        $('#attached_list').append('<div>' + files[i].name + '</div>');
      }
      if(totalSize > maxSize){
        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
        $(ev.target).val('');
        $('#attached_list').empty();
        return;
      }
    })
  }



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

	      // 이미지 초기화 시에 style 및 다른 속성 제거
	      editor.model.schema.extend('$image', { allowAttributes: ['style'] });
	      editor.model.schema.setAttribute('image', 'style', true);

	      // 이미지 크기 조절 옵션 추가
	      editor.ui.componentFactory.add('resizeImage', locale => {
	        const view = new ButtonView(locale);

	        view.set({
	          label: 'Resize Image',
	          tooltip: true
	        });

	        // 클릭 이벤트 핸들러
	        view.on('execute', () => {
	          // 이미지 크기 조절 로직 추가
	          // 아래는 예시로 50%로 크기를 조절하는 코드
	          const imageElement = editor.model.document.selection.getSelectedElement();
	          const newSize = '50%';

	          editor.model.change(writer => {
	            writer.setAttribute('style', `width: ${newSize}`, imageElement);
	          });
	        });

	        return view;
	      });
	    })
	    .catch(error => {
	      console.error(error);
	    });
	}


  const fnProductAdd = () => {
    $('#frm_product_add').submit((ev) => {
      if ($('#tripName').val() === '') {
        alert('제목은 반드시 입력해야 합니다.');
        ev.preventDefault();
        return;
      }
      $('#tripContents').val($('#ckeditor').html());
    });
  };

  
  
  fnThumbnailCheck();
  fnProductAdd();
  fnCkeditor();
</script>
 
 
 

<%@ include file="../layout/footer.jsp" %>