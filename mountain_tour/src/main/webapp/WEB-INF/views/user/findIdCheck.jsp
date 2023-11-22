<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis() %>"/>

<jsp:include page="../layout/header.jsp">
  <jsp:param value="회원가입" name="title"/>
</jsp:include>



<style>
 #modal.modal-overlay {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(1.5px);
            -webkit-backdrop-filter: blur(1.5px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        #modal .modal-window {
            background: rgba( 0, 0, 0, 0.70 ); // 69, 139, 197
            box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
            width: 400px;
            height: 300px;
            position: relative;
            top: -100px;
            padding: 10px;
        }
        #modal .title {
            padding-left: 10px;
            display: inline;
            text-shadow: 1px 1px 2px gray;
            color: white;
            
        }
        #modal .title h2 {
            display: inline;
        }
        #modal .close-area {
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
        
        #modal .content {
            margin-top: 20px;
            padding: 0px 10px;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
</style>
</head>
<!-- 모달창 따로 만들어서 파일 불러오기 -->
<%@ include file="../user/Modal.jsp" %>

<div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; " >
      <!--  여기다가 작성 다 작성하고 height 지우기!!!! -->

<form id="findForm" action="${contextPath}/user/findIdCheck" method="post">
	
		<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			
				<div class="w3-center w3-large w3-margin-top">
					<h3>아이디 찾기</h3>
				</div>
				<div>
					<p>
						<label>name</label>
						<input class="w3-input" type="text" id="name" name="name" placeholder="이름을 입력해주세요." required>
					</p>
					
					<p>
						<label>Tel</label>
						<input class="w3-input" type="text" id="mobile" name="mobile" placeholder="핸드폰 번호를 입력해주세요." required>
					</p>
					
					<p class="w3-center">
						<button type="button" id='find_id' class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</p>
				</div>
			
		</div>
	</div>
	</form>
	
<script src="${contextPath}/resources/js/user_findid.js?dt=${dt}"></script>


	 <div class="col-1">      
    </div>
	</div>
	</div>
</div>
<%@ include file="../layout/footer.jsp" %>