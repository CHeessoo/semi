<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="header.jsp">
  <jsp:param value="마운틴투어" name="title"/>
</jsp:include>
  
  <div class="ad_wrapper">
     <!-- 캐러셀 및 이미지         -->
        <div class="owl-carousel owl-theme">
          <!-- 이미지의 위치에 맞게 src 경로 설정. 여기서는 index.html과 image1,2,3이 같은 폴더 내에 같은 위계에 위치     -->
            <div class="item1"><img class="owl_img" src="#" ></div>
            <div class="item2"><img class="owl_img" src="#" ></div>
            <div class="item3"><img class="owl_img" src="#" ></div>
        </div>        
  </div>

 

  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10">
      <!--  여기다가 작성 -->
      <div class="best_wrapper">
        <div class="best">
          BEST 3
        </div>
        <div class="best_card">
          <div class="container text-center">
            <div class="row">
              <div class="col">
                <div class="card" style="width: 18rem;">
                  <img src="..." class="card-img-top" alt="...">
                  <div class="card-body">
                    <p class="card-text">TITLE</p>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="card" style="width: 18rem;">
                  <img src="..." class="card-img-top" alt="...">
                  <div class="card-body">
                    <p class="card-text">TITLE</p>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="card" style="width: 18rem;">
                  <img src="..." class="card-img-top" alt="...">
                  <div class="card-body">
                    <p class="card-text">TITLE</p>
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
</div>
</div>


<script>
  const fnBest = () => {
	  $.ajax({ 
		    method: 'get', 
		    url: '${contextPath}/mountain/main/best.do' , 
		    dataType: 'json',  
		    success : function (resData) {
		        console.log(resData.product+'123');
		        
		    },
		    error: function () {
		        console.log('asd')
		    }
		})
  	
  }

fnBest(); 
</script>
  
  

<%@ include file="footer.jsp" %>