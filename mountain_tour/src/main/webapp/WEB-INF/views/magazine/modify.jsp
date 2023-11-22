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
  .title{
    width: 60%;
    display: inline-block;
  }
  .title_wrapper {
    text-align: center;
  }
  
  .ck-editor__editable { 
      height: 400px;   
   }
  .ck-content { 
      font-size: 12px; 
   }
  .ck.ck-editor { 
        
   }
   .contents {
      width:60%;
      margin: auto;
      
   }
   p {
    margin-top: 15px;
   } 
   select {
    margin-top: 10px;
    width:20%;
    color: black;
   }
  
    
  </style>

  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
       <form action="${contextPath}/magazine/modify.do" class="modify_form" method="post">
      <div class="wrapper">   
        <h4>제목</h4>
        
        <div class="title_wrapper">
        <input type="text" id="title" name="title" class="title form-control mb-3" value="${magazine.title}"></div>
      </div>
      <div class="contents">
        <h4>내용</h4>
               
          <textarea name="contents" id="contents" style="display: none;" ></textarea>
          <div id="toolbar-container"></div>
          <div id="ckeditor">${magazine.contents}</div>
          <div>
              <select id="productNo" name="productNo" onclick="fnSelect();">                
                 <!-- <option disabled selected>상품 목록</option> -->
              </select>
          </div>
          <input type="hidden" name="magazineNo" value="${magazine.magazineNo}">
          <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
          <p><button type="submit" class="btn btn-secondary">다음</button></p>        
      </div> 
      </form>     
     </div> 
      
    </div>
    <div class="col-1">
    </div>
  </div>
  
 
  
<script>

		function fnProductNo() {
		    $.ajax({
		      type: 'get',
		      url: '${contextPath}/magazine/getProductNo.do',
		      dataType: 'json',
		      success: (function(resData){
		        $('#productNo').empty();
		        var str = "";
		        for(var i = 0; i < resData.list.length; i++){
		        	if(resData.list[i].productNo === ${magazine.productNo}){ 
		        		var add = 'selected ="selected"'
		        			str += '<option name="productNo" value="'+resData.list[i].productNo+'"'+add+'>'+resData.list[i].productNo+'</option>';             	
		        	}else {
		        		str += '<option name="productNo" value="'+resData.list[i].productNo+'">'+resData.list[i].productNo+'</option>';             
		        	}
		          
		        }  
		          $('#productNo').append(str);
		      })      
		    })  
		  }
		  fnProductNo();


		const fnCkeditor = () => {
		    DecoupledEditor
		      .create(document.getElementById('ckeditor'), {
		        ckfinder: {
		          // 이미지 업로드 경로
		          uploadUrl: '${contextPath}/magazine/imageUpload.do'         
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
		
		   function fnSelect() {
		       $(document).on('change', '#productNo', function(){
		         var value = $(this).val();
		         //$('#productNo').attr('value',value);
		       })
		    }
		   
		   const fnMagazineModify = () => {
			   $('.modify_form').submit((ev) => {
				   $('#contents').val($('#ckeditor').html());
			   })			   
		   }
		   
		   
		fnMagazineModify();   
		fnCkeditor();
		
		
		
		
		
</script>
 
 
 

<%@ include file="../layout/footer.jsp" %>