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

 <meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
    .table-container {
      display: grid;
      grid-template-columns: 1fr 1fr 1fr; /* 3개의 열로 나누기 */
      gap: 10px; /* 열 사이의 간격 설정 */
    }

    .table-container > div {
      border: 1px solid #dddddd;
      padding: 8px;
      text-align: center;
    }
  </style>
</head>
<body>

    <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 1200px" >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->
     
      <div>
    <div>
      <button type="button" id="btn_remove_list">선택삭제</button>
    </div>
    <table border="1">
      <thead>
        <tr>
          <td><input type="checkbox" id="chk_all"><label for="chk_all">전체선택</label></td>
          <td>상품번호</td>
          <td>상품이름</td>
          <td>가이드</td>
          <td>가격</td>
          <td></td>
        </tr>
      </thead>
      <tbody id="member_list"></tbody>
      <tfoot>
        <tr>
          <td colspan="6" id="paging"></td>
        </tr>
      </tfoot>
    </table>
  </div>
  
    </div>
    <div class="col-1">
    </div>
  </div>
</div>
</body>

<script>

$(function(){
    //fnChkAll();
    //fnChkOne();
      fnHeartList();
   // fnRemoveMember();
   // fnRemoveMembers();
  })

// 전체 선택을 클릭하면 개별 선택에 영향을 미친다.
function fnChkAll(){
  $('#chk_all').click(function(){
    $('.chk_one').prop('checked', $(this).prop('checked'));
  })
}

// 개별 선택을 클릭하면 전체 선택에 영향을 미친다.
function fnChkOne(){
  $(document).on('click', '.chk_one', function(){
    var total = 0;
    $.each($('.chk_one'), function(i, elem){
      total += $(elem).prop('checked');
    })
    $('#chk_all').prop('checked', total === $('.chk_one').length);
  })
}

var page = 1;

// 회원 목록
function fnHeartList(){
	var userNo = ${sessionScope.user.userNo}
	console.log(page);
  $.ajax({
    // 요청
    type: 'get',
    url: '${contextPath}/heartList.do?page='+page,    	
    // 응답
    dataType: 'json',
    success: function(resData){
      // 회원 목록을 테이블로 만들기
      $('#member_list').empty();
      $.each(resData.heartList, function(i, heart){
        var tr = '<tr>';
        tr += '<td><input type="checkbox" class="chk_one" value="'+heart.productDto.productNo+'"></td>';
        tr += '<td>'+heart.productDto.productNo+'</td>';
        tr += '<td>'+heart.productDto.productName+'</td>';
        tr += '<td>'+heart.productDto.guide+'</td>';
        tr += '<td>'+heart.productDto.price+'</td>';
        tr += '<td><button type="button" class="btn_detail" data-member_no="'+heart.productDto.productNo+'">조회</button></td>';
        tr += '</tr>';
        $('#member_list').append(tr);
      })
      // 페이징
      $('#paging').html(resData.paging);
    }
  })
}

//페이지를 바꿀때마다 호출되는 fnAjaxPaging 함수
// PageUtil의 getAjaxPaging() 메소드에서 언제 호출되는지 확인 가능함
function fnAjaxPaging(p){
  page = p;        // 페이지 번호를 바꾼다.
  fnMemberList();  // 새로운 목록을 가져온다.
}

//회원 정보 삭제
function fnRemoveMember(){
  $('#btn_remove').click(function(){
    if(!confirm('회원 정보를 삭제할까요?')){
      return;
    }
    $.ajax({
      // 요청
      type: 'delete',
      url: '${contextPath}/member/' + $('#memberNo').val(),
      // 응답
      dataType: 'json',
      success: function(resData){
        if(resData.removeResult === 1){
          alert('회원 정보가 삭제되었습니다.');
          page = 1;
          fnMemberList();
          fnInit();
        } else {
          alert('회원 정보가 삭제되지 않았습니다.');
        }
      }
    })
  })
}

// 회원들의 정보 삭제
function fnRemoveMembers(){
  $('#btn_remove_list').click(function(){
    // 체크된 요소의 value를 배열 arr에 저장하기(push 메소드)
    var arr = [];
    var chkOne = $('.chk_one');
    $.each(chkOne, function(i, elem){
      if($(elem).is(':checked')){  // if($(elem).prop('checked'))
        arr.push($(elem).val());
      }
    })
    // 체크된 요소가 없으면 삭제 중지
    if(arr.length === 0){
      alert('선택된 회원 정보가 없습니다. 다시 시도하세요.');
      return;
    }
    // 선택된 회원 삭제
    $.ajax({
      // 요청
      type: 'delete',
      url: '${contextPath}/members/' + arr.join(','),
      // 응답
      dataType: 'json',
      success: function(resData){
        if(resData.removeResult > 0){
          alert('선택한 회원 정보들이 삭제되었습니다.');
          page = 1;
          fnMemberList();
          fnInit();
        } else {
          alert('선택한 회원 정보들이 삭제되지 않았습니다.');
        }
      }
    })
  })
}
</script>
	

<%@ include file="../layout/footer.jsp" %>