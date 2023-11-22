<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="자주묻는질문" name="title"/>
</jsp:include>

<style>
  .mainWrap {
  display: flex;
  }

  .listWrap1 {
    justify-content: center;
    width: 20%;
    border-right: 1px solid gray;
    margin-top: 50px;
    padding-bottom: 30px;
  }

  .listWrap1 a {
    color: #1a1a1a;
    font-size: large;
    font-weight: bold;
  }
  
  .listWrap1 .faq {
    text-decoration: underline;
    text-underline-position: under;
  }

  #faqList a {
    color: #1a1a1a;
  }
  
  
  .listWrap2 {
    justify-content: center;
    width: 70%;
    margin: 10% auto;
    
  }
  
  .blind {
    display: none;
  }
  .btn_title {
    cursor: pointer;
  }
  
</style>
<script>

  /* 함수 호출 */
  $(() => {
    fnBlindAdd();
    fnAddFaq();
    fnBlind();
    fnBlindModify(); 
    fnModifyResult();
    fnRemove();
    fnRemoveResult();
  })

  // 작성하기 버튼을 누르면 작성 폼이 나타난다. (관리자만 사용가능)
  const fnBlindAdd = () => {
  $('#btn_faq_write').click((ev) => {
      let write = $('.faq_add');
      if(write.hasClass('blind')){
      $('.show_content').addClass('blind');
      $('.frm_modifyFaq').addClass('blind');
      write.removeClass('blind');
      } else {
      write.addClass('blind');
      }
    })
  }
  
  // 작성 데이터가 전달되면 alert창으로 표시한다.
  const fnAddFaq = () => {
    let addResult = '${addResult}';
    if(addResult !== ''){
      if(addResult === '1'){
      alert('자주묻는질문이 작성되었습니다.');
      } else {
      alert('자주묻는질문이 작성되지 않았습니다.');
      }
    }
  }

  // 게시글의 제목을 클릭하면 내용이 나타난다.
  const fnBlind = () => {
  $('.open_content').click((ev) => {
      let openContent = $(ev.target).parent().next();
      if(openContent.hasClass('blind')){
      $('.show_content').addClass('blind');
      $('.frm_modifyFaq').addClass('blind');
      $('.faq_add').addClass('blind');
      openContent.removeClass('blind');
      } else {
      openContent.addClass('blind');
      }
    })
  }
  
  // 수정버튼을 클릭하면 수정폼이 나타난다. (관리자만 사용 가능)
  const fnBlindModify = () => {
  $('.btn_modify').click((ev) => {
      let modify = $(ev.target).parent().next();
      if(modify.hasClass('blind')){
      modify.removeClass('blind');
      } else {
      modify.addClass('blind');
      }
    })
  }
  
  // 수정 데이터가 전달되면 alert창으로 표시한다.
  const fnModifyResult = () => {
    let modifyResult = '${modifyResult}';
    if(modifyResult !== ''){
      if(modifyResult === '1'){
        alert('자주묻는질문이 수정되었습니다.');
      } else {
      alert('자주묻는질문이 수정되지 않았습니다.');
      }
    }
  }

  // 삭제 버튼이 눌리면 확인후 submit을 진행하거나 막는다.
  const fnRemove = () => {
  $('.frm_removeFaq').submit((ev) => {
      if(!confirm('자주묻는질문을 삭제할까요?')){
      ev.preventDefault();
      return;
      }
    })
  }
  
  // 삭제 데이터가 전달되면 alert창으로 표시한다
  const fnRemoveResult = () => {
    let removeResult = '${removeResult}';
    if(removeResult !== ''){
      if(removeResult === '1'){
      alert('자주묻는질문이 삭제되었습니다.');
      } else {
      alert('자주묻는질문이 삭제되지 않았습니다.');
      }
    }
  }
  
 
  
</script>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid;" >
      
      
      
      <div class="mainWrap">
      
      
        <%-- 각 문의 페이지로 이동가능한 목록 --%>
        <div class="listWrap1">
          <div class="faq">
            <a href="${contextPath}/cs/faqList.do" >자주 묻는 질문</a>
          </div>
          <div class="inquiry">
            <a href="${contextPath}/cs/inquiryList.do">1:1 문의하기</a>
          </div>
        </div>
        
        <%-- 자주묻는질문 목록이 표시될 div --%>
        <div class="listWrap2">
        
          <%-- 자주묻는질문 작성버튼(관리자만 사용 가능) --%>
          <c:if test="${sessionScope.user.auth == 0 }">
            <div style="text-align: right;"><button id="btn_faq_write"  class="btn btn-success">작성하기</button></div>
          </c:if>
          
          <form method="post" action="${contextPath}/cs/addFaq.do" class="faq_add blind">
            <label for="title" style="margin-top: 2%;">제목</label>
            <input type="text" name="title" id="title" class="form-control" placeholder="제목을 입력하세요." >
            <label for="contents" style="margin-top: 2%;">내용</label>
            <textarea rows="5" cols="50" name="contents" id="contents" class="form-control" placeholder="내용을 입력하세요."></textarea>
            <button type="submit" class="btn btn-outline-success col-6" style="margin-top: 5%;">작성완료</button>
            <div style="margin-top: 5%;"><button type="reset" class="btn btn-outline-secondary">초기화</button></div>
          </form>
          
          <%-- 총 게시글 수를 표시 --%>
          <div style="text-align: left;">총 ${total}개</div>
          
          <%-- 전체 목록을 나타내는 테이블 --%>
          <div>
            <table border="1" class="table table-hover">
              <thead>
                <tr >
                  <th scope="col">번호</th>
                  <th scope="col" >제목</th>
                </tr>
              </thead>
              <tbody id="faqList">
                <c:forEach items="${faqList}" var="f" varStatus="vs">
                    <tr>
                      <th scope="row">${beginNo - vs.index}</th>
                      <td class="open_content btn_title" style="text-align: left; padding-left: 25%">${f.title}</td>
                    </tr>
                    <tr class="blind show_content">
                      <td colspan="2">
                        <div>${f.contents}</div>
                        
                        <%-- 삭제 form (관리자만 삭제/수정 버튼사용 가능) --%>
                        <form method="post" action="${contextPath}/cs/removeFaq.do" class="frm_removeFaq">
                          <c:if test="${sessionScope.user.auth == 0 }">
                            <input type="hidden" name="faqNo" value="${f.faqNo}">
                            <button type="submit" class="btn btn-outline-secondary" style="margin-top: 5%;">삭제</button>
                            <button type="button" class="btn btn-outline-secondary btn_modify" style="margin-top: 5%;">수정</button>
                          </c:if>
                        </form>
                        
                        <%-- 수정 form --%>
                        <form method="post" action="${contextPath}/cs/modifyFaq.do" class="frm_modifyFaq blind">
                          <input type="text" name="title" class="title form-control" value="${f.title}">
                          <textarea rows="5" cols="50" name="contents" class="contents form-control">${f.contents}</textarea>
                          <input type="hidden" name="faqNo" value="${f.faqNo}">
                          <button type="submit" class="btn btn-outline-secondary btn_modified_faq" style="margin-top: 5%;">수정완료</button>
                          <button type="reset" class="btn btn-outline-secondary" style="margin-top: 5%;">초기화</button>
                        </form>
                        
                      </td>
                    </tr>
                </c:forEach>
              </tbody>
              <tfoot>
                <tr>
                  <%-- 페이징 처리 --%>
                  <td colspan="2">${paging}</td>
                </tr>
              </tfoot>
            </table>
            
            <%-- 검색기능 --%>
            <div>
              <form method="get" action="${contextPath}/cs/faqSearch.do" >
                <select name="column" class="form-select-sm" style="height: 40px">
                  <option value="TITLE">제목</option>
                  <option value="CONTENTS">내용</option>
                  <option value="FAQ_NO">번호</option>
                </select>
                <input type="text" name="query" class="form-control-sm" placeholder="검색어 입력" >
                <button type="submit" class="btn btn-outline-success" >검색</button>
              </form>
            </div>
          </div>
        </div>
        
      </div>




    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
















<%@ include file="../layout/footer.jsp" %>