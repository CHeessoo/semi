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
          <h2>예약하기</h2>
        </div>
        <hr>
        <div>
          <h4>상품정보</h4>
        </div>
        <div>
          <table class="table">
            <colgroup>
              <col style="width:100px;">
              <col style="width:*;">
            </colgroup>
            <tbody>
              <tr>
                <td class="table-active"><strong>상품명</strong></td>
                <td>${product.tripName}</td> <!-- 상품명이 들어가야함 -->
              </tr>
              <tr>
                <td class="table-active"><strong>일정</strong></td>
                <td>
                  <div>
                    출발일 : 
                    <fmt:parseDate value="${resDate}" var="parsedDate" pattern="MM/dd/yyyy" />
                    <fmt:formatDate value="${parsedDate}" pattern="yyyy/MM/dd (E)" type="date"/>
                  </div>
                  <div>
                    소요시간 : 
                    <span>${product.timetaken}</span>
                  </div>
                </td> 
              </tr>      
            </tbody>
          </table>
        </div>
        <!-- 요금 및 여행인원 -->
        <div style="margin-top: 50px;">
          <h4>요금 및 여행인원</h4>
        </div>
        <div>
          <table class="table">
            <colgroup>
              <col>
              <col style="width:11%;">
              <col style="width:11%;">
              <col style="width:10%;">
              <col style="width:10%;">
              <col style="width:14%;">
            </colgroup>
            <thead>
              <tr class="table-active">
                <th>요금구분</th>
                <th>성인요금</th>
                <th>소아요금</th>
                <th>성인인원</th>
                <th>소아인원</th>
                <th>합계</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td></td>
                <td id="adultPrice">${product.price}</td> <!-- 상품가격 -->
                <td id="childPrice">${product.price}</td> <!-- 성인요금에서 금액변동 적용하기 -->
                <td>
                  <select name="adultCnt">
                    <c:forEach var="cnt" begin="0" end="20" step="1"> <!-- end값으로 product.person(최대인원수) 적용하기 -->
                      <option class="adtCnt" value="${cnt}">${cnt}명</option>
                    </c:forEach>
                  </select>
                </td>
                <td>
                  <select name="childCnt">
                    <c:forEach var="cnt" begin="0" end="20" step="1"> <!-- end값으로 product.person(최대인원수) 적용하기 -->
                      <option class="cldCnt" value="${cnt}">${cnt}명</option>
                    </c:forEach>
                  </select>
                </td>
                <td>
                  <span id="totalPriceOne">
                  <!-- 계산된 총 금액 -->
                  
                  </span>
                  원
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="3">총계</td>
                <td>
                  <span class="adultCntVal">0</span>명
                </td>
                <td>
                  <span class="childCntVal">0</span>명
                </td>
              </tr>
            </tfoot>
          </table>
        </div>
        
        <!-- 여행자 정보 -->
        <form id="frm_tourist"  method="post">
          <div>
            <div>
              <h4>여행자 정보</h4>
              <span id="msg_mobile"></span>
            </div>
            <table class="table">
              <colgroup>
                <col style="width:5%;">
                <col style="width:11%;">
                <col style="width:10%;">
                <col style="width:10%;">
                <col style="width:30%;">
              </colgroup>
              <thead>
                <tr>
                  <th>구분</th>
                  <th>이름</th>
                  <th>생년월일</th>
                  <th>성별</th>
                  <th>연락처</th>
                </tr>
              </thead>
              <tbody id="inp_tourist">
              <!-- 여행인원 선택시 선택한만큼 추가되어야 함 -->
              </tbody>
            </table>
               
          </div>
        </form>
        
        
        <!-- 예약 정보 -->
        <!-- 받아올 정보 : userNo, productNo -->  
        <form id="frm_reserve" >
          <div style="margin-top: 50px;">
            <h4>예약자 정보</h4>
          </div>
          <div>
            <table class="table">
              <colgroup>
                <col style="width:11%;">
                <col style="width:*;">
              </colgroup>
              <tbody>
                <tr>
                  <td class="table-active">예약자명</td>
                  <td>${sessionScope.user.name}</td> <!-- 로그인한 회원의 이름 -->
                </tr>
                <tr>
                  <td class="table-active">연락처</td>
                  <td>
                    <span>${sessionScope.user.mobile}</span>
                  </td>
                </tr>
                <tr>
                  <td class="table-active">요청사항</td>
                  <td>
                    <textarea class="textarea form-control" name="resReq" id="resReq" cols="30" rows="5" placeholder="좌석배정 불가능"></textarea>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
          <input type="hidden" name="productNo" value="${product.productNo}">
          <input type="hidden" name="resStart" value="${resDate}">
          <!-- 
          <input type="hidden" name="resFinish" value="${resDate}">
          -->
        
          <!-- 픽업장소 선택 -->
          <div>
            <h4>승차장소 선택</h4>
          </div>
          <div>
            총<span class="totalPerson">0</span>명
            <input type="hidden" id="reservePerson" name="reservePerson" class="totalPerson">
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
            
          <hr>  
          
    
          <!-- 약관 동의 -->
          <div class="agreeFrom">
            <h4>약관 동의</h4>
          </div>
            <div>
              <table class="table">
                <tbody class="d-grid gap-2 col-6 mx-auto">
                  <tr>
                    <td>
                      <div>
                        <span>
                          <input type="checkbox" id="chkAgree" name="chkAgree" value="0" class="chk_each">
                          <label for="chkAgree">개인정보 수집에 동의합니다(필수)</label>
                        </span>
                      </div>
                    </td>
                    <td>
                      <a href="#" >자세히</a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <div>
                        <span>
                          <input type="checkbox" id="chkMarketing" name="chkAgree" value="1" class="chk_each">
                          <label for="chkMarketing">마케팅 이용 정보 수집에 동의합니다(선택)</label>
                        </span>
                      </div>
                    </td>
                    <td>
                      <a href="#" >자세히</a>
                    </td>
                  </tr>
                </tbody>
                <tfoot class="d-grid gap-2 col-6 mx-auto">
                  <tr>
                    <td>
                      <div>
                        <span>
                          <input type="checkbox" id="chkAll">
                          <label for="chkAll">모든 약관에 동의합니다.</label>
                        </span>
                      </div>
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
         
          
          <div class="d-grid gap-2 col-6 mx-auto" >
            <button type="button" id="btn_reserve" class="btn btn-success">예약하기</button>
            
          </div>
        </form>

        <!-- 결제정보 -->
        <!-- 따로 구현 -->
        <div>
          <form id="frm_pay" name="frmPay" method="post">
            <div>
              <h4>결제정보</h4>
            </div>
            <table >
              <colgroup>
                <col style="width:13%;">
                <col style="width:*;">
              </colgroup>
              <tbody>
                <tr>
                  <th>총 여행인원</th>
                  <td>
                    성인 : 
                    <span class="adultCntVal">0</span>
                     명 / 소아 : 
                    <span class="childCntVal">0</span>
                     명
                  </td>
                </tr>
                <tr>
                  <th>결제방식</th>
                  <td>
                    <input type="radio" name="opt1" id="deposit">
                    <label for="deposit">무통장입금</label>
                    <input type="radio" name="opt1" id="card">
                    <label for="card">카드결제</label>
                    <br>
                    
                    <div>
                      <span>[입금자명]</span>
                      <input type="text" name="depositNm" id="depositNm">
                      <input type="checkbox" name="sameResName" id="sameResName">
                      <label for="sameResName">예약자와 동일</label>
                    </div>
                    <div>
                      <!-- 카드결제버튼? -->
                    </div>
                    
                    <span>[입금정보]</span>
                    (구디)1111-111-11, (예금주)주식회사 마운틴투어 
                  </td>
                </tr>
                <tr>
                  <th>최종결제가격</th>
                  <td>
                    <span id="totalPrice">?</span>
                    원
                  </td>
                </tr>
              </tbody>
            </table>
          </form>
        </div>
        
        <hr>
        
      </div>

    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 



<script>


	var mobilePassed = false;
	
	// insertReserve 필요한 데이터
	// frm_res_user : userNo,productNo 'hidden', resReq
	// frm_pickup : pickupLoc, reservePerson(총예약인원수)
	// frm_agree : chkAgree


	/*

	function fnReserve(){
  	  $("#btn_reserve").click(function(e) {
      	
        var userData = $("#frm_res_user").serialize();
        var pickupData = $('#frm_pickup').serialize();
        var agreeData = $('#frm_agree').serialize();
        var formData = userData + "&" + pickupData + "&" + agreeData;
        $.post('${contextPath}/reserve/addReserve.do', formData)
          .done(function(resData) {
            // 요청이 성공적으로 완료된 후의 동작을 여기에 작성합니다.
            if(resData.addResult !== 0){
              alert('예약등록 성공');
            	
            }
          })
          .fail(function() {
            // 요청이 실패한 경우의 동작을 여기에 작성합니다.
            alert('예약실패');
          });
      });
	}

	*/
	
	function fnAddReserve(){
		$('#btn_reserve').click(function(ev){
			/*
			if(!$('#chkAgree').is(':checked')){
	  			  alert('필수 약관에 동의하세요.');
	  			  this.preventDefault();
	  			  return;
	  		}*/
	  		fnRegTotalPerson();
	  		fnRegInputName();
	  		fnRegInputMobile();
	  		fnRegAgree();
			$.ajax({
				type: 'post',
				url: '${contextPath}/reserve/addReserve.do',
				data: $('#frm_reserve').serialize(),
				dataType: 'json',
				success: function(resData){
					if(resData.addReserveResult === 1){
						alert('예약이 등록되었습니다.');
						fnAddTourist(resData.reserveNo);
					}
				}
			})
		})
	}	
	
	
	function fnAddTourist(reserveNo){  // reserveNo를 인수로 받음
		$('#frm_tourist').append($('<input>').attr({
			type: 'hidden',
			name: 'reserveNo',
			value: reserveNo  // reserveNo를 폼에 추가
		}));
		$('#frm_tourist').attr('action', '${contextPath}/reserve/addTourist.do');
		$('#frm_tourist').submit();
	}
	

	//  요금 옵션 선택시 총금액, 총인원수 반영
	function fnChangeTotalPrice(){
	  $(document).ready(function() {
        $('select[name="adultCnt"], select[name="childCnt"]').change(function() {
          var adultCount = parseInt($('select[name="adultCnt"]').val());
          var childCount = parseInt($('select[name="childCnt"]').val());
          
          var adultPrice = parseInt($('#adultPrice').text());
          var childPrice = parseInt($('#childPrice').text());
          
          var totalPrice = (adultCount * adultPrice) + (childCount * childPrice);
          $('#totalPriceOne').text(totalPrice);
          $('#totalPrice').text(totalPrice);
          $('.adultCntVal').text(adultCount);
          $('.childCntVal').text(childCount);
          $('.totalPerson').text(adultCount + childCount);
          $('.totalPerson').attr('value', (adultCount + childCount));
        });
      });
	}
	
	// 성인, 소아 선택한 만큼 입력창 생성메소드
	function fnAddTouristForm(){
	  	$(document).ready(function() {
        	$('select[name="adultCnt"], select[name="childCnt"]').change(function() {
          		var adultCount = parseInt($('select[name="adultCnt"]').val());
          		var childCount = parseInt($('select[name="childCnt"]').val());
          		
          		$('#inp_tourist').empty();
    	  		let str = '';
    	  		if(adultCount !== 0){
    	  		  for(let i = 1; i <= adultCount; i++){
    		  	  	  str += '<tr>';
        		  	  str += '  <td><span>성인 </span><span class="ageNum">' + i + '</span></td>';
        		  	  str += '  <input type="hidden" name="ageCase" value="0">';
    		  	  	  str += '  <td><input type="text" name="touristName" maxlength="10"></td>';
          		      str += '  <td><input type="date" name="birthDate" max="9999-12-31"></td>';
          		      str += '  <td>';
          	          str += '    <select name="gender">';
          	          str += '		<option value="">선택</option>';
          	          str += '  	<option value="M">남</option>';
          	          str += '  	<option value="F">여</option>';
          	   	      str += '     </select>';
          	   	      str += '  </td>';
          		      str += '  <td>'; 
         		      str += '    <input type="text" class="inpMob tourContact" name="tourContact" maxlength="11">';
      			      str += '  </td>';
          		      str += '</tr>';
        	      }
    	  		}
    	  		if(childCount !== 0){
    	  			for(let i = 1; i <= childCount; i++){
      		  	  	  str += '<tr>';
          		  	  str += '  <td><span>소아 </span><span class="ageNum">' + i + '</span></td>';
          		  	  str += '  <input type="hidden" name="ageCase" value="1">';
      		  	  	  str += '  <td><input type="text" name="touristName" maxlength="10"></td>';
            		  str += '  <td><input type="date" name="birthDate" max="9999-12-31"></td>';
            		  str += '  <td>';
            	      str += '    <select name="gender">';
            	      str += '		<option value="">선택</option>';
            	      str += '  	<option value="M">남</option>';
            	      str += '  	<option value="F">여</option>';
            	   	  str += '     </select>';
            	   	  str += '  </td>';
            		  str += '  <td>'; 
            		  str += '    <input type="text" class="inpMob tourContact" name="tourContact" maxlength="11">';
        			  str += '  </td>';
            		  str += '</tr>';
          	      }
    	  		}
    			$('#inp_tourist').append(str);
            });
        });
	}
  
	function fnRegTotalPerson(){
		var reservePerson = parseInt($('#reservePerson').val());
		if(isNaN(reservePerson) || reservePerson < 1){
			alert('여행 인원을 선택해주세요');
			ev.preventDefault();
			return;
		}
	}
	
	
	function fnRegInputName(){
		var inputs = document.getElementsByName("touristName");
		var hasEmptyValue = false;
    	for (var i = 0; i < inputs.length; i++) {
    	  var inputValue = inputs[i].value.trim();
    
    	  if (inputValue === "") {
    	    hasEmptyValue = true;
    	    break;
    	  }
    	}
    
    	if (hasEmptyValue) {
    	  alert("이름은 필수 항목입니다.");
    	  ev.preventDefault();
    	  return;
    	}
	}
	
	function fnRegInputMobile(){
		var inputM = document.getElementsByName("tourContact");
		var hasEmptyM = false;
    	for (var i = 0; i < inputM.length; i++) {
    	  var inputValue = inputM[i].value.trim();
    	  let regMobile = /^010[0-9]{8}$/;
    	  mobilePassed = regMobile.test(inputM.value);
    	  if (inputValue === "" && !mobilePassed) {
    	    hasEmptyM = true;
    	    break;
    	  }
    	}
    	if (hasEmptyM) {
    	  alert("연락처를 확인해주세요.");
    	  ev.preventDefault();
    	  return;
    	}
	}
	
	
    function fnRegAgree(){
	  if(!$('#chkAgree').is(':checked')){
		  alert('필수 약관에 동의하세요.');
		  ev.preventDefault();
		  return;
	  }
    }
  
    
    function fnChkAll(){
    	  $('#chkAll').click(function(){
    		  $('#chkAgree').prop('checked', $(this).prop('checked'));
    		  $('#chkMarketing').prop('checked', $(this).prop('checked'));
    	  })
    }
    
    
    function fnChkEach(){
    	$('.chk_each').click(function(){
    		  var total = 0;
  			  total += $('#chkAgree').prop('checked');
  			  total += $('#chkMarketing').prop('checked');
    		  $('#chkAll').prop('checked', total === $('.chk_each').length);
    	})
    }	
    
	fnChangeTotalPrice();
	fnAddTouristForm();
	fnAddReserve();
	fnChkAll();
	fnChkEach();
</script> 
 
 
 

<%@ include file="../layout/footer.jsp" %>