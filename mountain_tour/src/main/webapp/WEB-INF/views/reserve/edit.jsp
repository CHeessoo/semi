<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<jsp:include page="../layout/header.jsp">
  <jsp:param value="예약" name="title"/>
</jsp:include>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 100%;" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
      
      
      
      <!-- <a href="${contextPath}/reserve/detail.do?resDate=20231111">예약</a> -->
      
      
      
      <div id="contents">
        <div class="subtitle_wrap">
          <h2>예약수정하기</h2>
        </div>
        <hr>
        
        <!-- 예약 정보 -->
        <form id="frm_modify" method="post">
          <div>
            <h4>예약자 정보</h4>
          </div>
          <div class="d-grid gap-2 col-8  mx-auto">
            <table class="table">
              <colgroup>
                <col style="width:20%;">
                <col style="width:*;">
              </colgroup>
              <tbody>
                <tr>
                  <td>예약자명</td>
                  <td>${sessionScope.user.name}</td> <!-- 로그인한 회원의 이름 -->
                </tr>
                <tr>
                  <td>연락처</td>
                  <td>
                    <span>${sessionScope.user.mobile}</span>
                  </td>
                </tr>
                <tr>
                  <td>요청사항</td>
                  <td>
                    <textarea class="textarea form-control" name="resReq" id="resReq" cols="30" rows="5" >${reserve.request}</textarea>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
          <input type="hidden" name="reserveNo" value="${reserve.reserveNo}">
        
          
          <!-- 픽업장소 선택 -->
          <div>
            <h4>승차장소 선택</h4>
          </div>
          <div class="d-grid gap-2 col-2 mx-auto">
            <ul class="list-group">
              <li class="list-group-item">
                <input class="form-check-input me-1" type="radio" name="pickupLoc" id="byOwn" value="자차" checked>
                <label class="form-check-label" for="byOwn">자차 이용</label> 
              </li>
              <li class="list-group-item">
                <input class="form-check-input me-1" type="radio" name="pickupLoc" id="pickupSeoul" value="서울역" >
                <label class="form-check-label" for="pickupSeoul">서울역</label> 
              </li>
              <li class="list-group-item">
                <input class="form-check-input me-1" type="radio" name="pickupLoc" id="pickupDDP" value="동대문">
                <label class="form-check-label" for="pickupDDP">동대문</label> 
              </li>
            </ul>
          </div>
            
          <div style="margin-top: 20px;">
            <button class="btn btn-success btn-lg" type="button" id="btn_modify">수정하기</button>
          </div>
        </form>
        
      </div>

    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 



<script>

	function fnResModify(){
		$('#btn_modify').click(function(){
			if(confirm('수정하시겠습니까?')){
				$('#frm_modify').attr('action', '${contextPath}/reserve/modifyReserve.do');
				$('#frm_modify').submit();
			} else {
				return;
			}
		})
	}

	fnResModify();

</script> 
 
 
 

<%@ include file="../layout/footer.jsp" %>