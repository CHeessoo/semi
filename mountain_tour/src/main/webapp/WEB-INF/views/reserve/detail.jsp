<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마운틴투어" name="title"/>
</jsp:include>
<style>
  .blind {
    display: none;
  }
</style>
 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
  
    <div>
      <h2>예약내역상세</h2>
    </div>
    
    <div>
      <h4>예약상품정보</h4>
    </div>
  
    
    <div class="d-grid gap-2 col-8  mx-auto">
      <table class="table">
        <colgroup>
          <col style="width:20%;">
          <col style="width:*;">
        </colgroup>
        <tr>
          <td>상품명</td>
          <td>${reserve.productDto.tripName}</td>
        </tr>
        <tr>
          <td>여행시작일</td>
          <td>${reserve.reserveStart}</td>
        </tr>
        <tr>
          <td>소요시간</td>
          <td>${reserve.productDto.timetaken}</td>
        </tr>
        
        <tr>
          <td>여행객정보</td>
          <td>
            총 ${reserve.reservePerson}명
            <span>
              <button type="button" id="btn_peopleInfo" class="btn btn-outline-success btn-sm" style="margin-left: 10px;">상세보기</button>
            </span>
            <div class="blind">
              <table class="table">
                <thead>
                  <tr>
                    <th>성인/소아</th>
                    <th>이름</th>
                    <th>생년월일</th>
                    <th>성별</th>
                    <th>연락처</th>
                  </tr>
                </thead>
                <tbody id="tourPeopleInfo">
                <!-- 여행자 정보가 추가되는 부분 -->
                </tbody>
              </table>
            </div>
          </td>
        </tr>
        
        <tr>
          <td>픽업장소</td>
          <td>${reserve.pickupLoc}</td>
        </tr>
        <tr>
          <td>예약상태</td>
          <c:if test="${reserve.reserveStatus == 0}">
            <td>정상</td>
          </c:if>
          <c:if test="${reserve.reserveStatus == 1}">
            <td>대기</td>
          </c:if>
          <c:if test="${reserve.reserveStatus == 2}">
            <td>불가</td>
          </c:if>
        </tr>
        <tr>
          <td>요청사항</td>
          <td>${reserve.request}</td>
        </tr>
        <tr>
          <td>주의사항</td>
          <td>${reserve.productDto.danger}</td>
        </tr>
        <tr>
          <td>결제금액</td>
          <td>???원(결제 여부?)</td>
        </tr>
      </table>
    </div>
    
    <div style="margin-top: 40px">
      <h4>예약자정보</h4>
    </div>
  
    <div class="d-grid gap-2 col-8  mx-auto">
      <table class="table">
        <colgroup>
          <col style="width:20%;">
          <col style="width:*;">
        </colgroup>
        <tr>
          <td>이름</td>
          <td>${reserve.userDto.name}</td>
        </tr>
        <tr>
          <td>이메일</td>
          <td>${reserve.userDto.email}</td>
        </tr>
        <tr>
          <td>휴대폰번호</td>
          <td>${reserve.userDto.mobile}</td>
        </tr>
        <tr>
          <td>결제금액</td>
          <td>???원(결제 여부?)</td>
        </tr>
      </table>
    </div>
    
    <hr>
    <div>
      <form id="frm_btn" method="post">
        <input type="hidden" name="reserveNo" value="${reserve.reserveNo}">
        <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
        <input type="hidden" name="request" value="${reserve.request}">
        <input type="hidden" name="pickupLoc" value="${reserve.pickupLoc}">
        <button class="btn btn-success" type="button" onclick="location.href='${contextPath}/product/list.do'">다른상품 예약하러가기</button>
        <button type="button" onclick="location.href='${contextPath}/reserve/list.do?userNo=' + '${sessionScope.user.userNo}'" class="btn btn-success">나의예약목록</button>
        <button class="btn btn-outline-secondary" type="button" id="btn_res_modify">예약 수정하러가기</button>
        <button class="btn btn-outline-danger" type="button" id="btn_res_cancel">예약 취소하기</button>
      </form>
      
    </div>
    
    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
<script>
	
	function fnShowTourist(){
		$('#btn_peopleInfo').click(function(){
			fnBlind();
			$.ajax({
				type: 'get',
				url: '${contextPath}/reserve/getTouristInfo.do',
				data: 'reserveNo=${reserve.reserveNo}',
				dataType: 'json',
				success:(function(resData){
					console.log(resData.tourists);
					$('#tourPeopleInfo').empty();
					if(resData.tourists.length === 0){
						alert('여행자 정보가 없습니다.')
						return;
					}
					$.each(resData.tourists, function(i, c){
						let str = '';
						str += '<tr>';
						if(c.ageCase === 0){
							str += '	<td>성인</td>';
						} else {
							str += '	<td>소아</td>';
						}
						str += '	<td>'+ c.name +'</td>';
						str += '	<td>'+ c.birthDate + '</td>';
						if(c.gender == 'M'){
	  						str += '	<td>남</td>';
						} else if(c.gender == 'F'){
							str += '	<td>여</td>';	
						} else {
							str += '	<td>선택안함</td>';
						}
						str += '	<td>'+ c.contact +'</td>';
						str += '</tr>';
						$('#tourPeopleInfo').append(str);
					})
				})
			})
		})
	}
	
	function fnBlind(){
			var blindTarget = $('#btn_peopleInfo').parent().next();
			if(blindTarget.hasClass('blind')){
				blindTarget.removeClass('blind');
			} else {
				blindTarget.addClass('blind');
			}
	}
	
	function fnCheckCurrUser(){
		if('${sessionScope.user}' === ''){
			if(confirm('로그인이 필요한 기능입니다. 로그인 할까요?')){
				location.href = '${contextPath}/user/login.form';
			}
		} else if('${sessionScope.user.userNo}' !== '${reserve.userDto.userNo}') {
			alert('내 예약 목록으로 이동합니다.')
			location.href = '${contextPath}/reserve/list.do?userNo=${sessionScope.user.userNo}';
			return;
		} else {
			return;
		}
	}
	
	function fnChkCancel(){
		$('#btn_res_cancel').click(function(){
			if(confirm('예약을 취소하면 여행자 정보도 함께 삭제됩니다. 취소할까요?')){
				$('#frm_btn').attr('action', '${contextPath}/reserve/delete.do')
				$('#frm_btn').submit();
			} 
		})
	}
	function fnGoModify(){
		$('#btn_res_modify').click(function(){
			if(confirm('예약 수정화면으로 이동하시겠습니까? 여행자 정보는 수정 불가능합니다.')){
				$('#frm_btn').attr('action', '${contextPath}/reserve/edit.form');
				$('#frm_btn').submit();
			} 
		})
	}
	function fnChkModify(){
		if('${modifyResult}' == 1){
			alert('수정되었습니다.');
		} 
	}
	fnChkCancel();
	fnGoModify();
	fnChkModify();
	fnCheckCurrUser();
	fnShowTourist();
</script>
 
 
 
 

<%@ include file="../layout/footer.jsp" %>