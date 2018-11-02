<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<h2>COMPANY</h2>
<form action="${pageContext.servletContext.contextPath}/admin/write.do" method="post" enctype="multipart/form-data">
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputEmail4">회사이름</label><br>
      <input type="text" class="form-control" id="coname" name="coname" placeholder="회사이름">
    </div>
    <div class="form-group col-md-6">
      <label for="inputPassword4">산업군</label><br>
      <input type="text" class="form-control" id="industry" name="industry" placeholder="산업군">
    </div>
  </div>
  <div class="form-group">
    <label for="inputAddress">매출액</label><br>
    <input type="text" class="form-control" id="sales" name="sales" placeholder="매출액(천만원)">
  </div>
  <div class="form-group">
    <label for="inputAddress2">CEO</label><br>
    <input type="text" class="form-control" id="ceo" name="ceo" placeholder="CEO">
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">평균연봉</label><br>
      <input type="text" class="form-control" id="salary" name="salary">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">종업원</label><br>
      <input type="text" class="form-control" id="workers" name="workers">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">위도</label><br>
      <input type="text" class="form-control" id="lat" name="lat">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">경도</label><br>
      <input type="text" class="form-control" id="lng" name="lng">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">초봉</label><br>
      <input type="text" class="form-control" id="first" placeholder="초봉(만원)" name="first">
    </div>
    <div class="form-group col-md-6">
      <label for="inputEmail4">회사 홈페이지</label><br>
      <input type="email" class="form-control" id="homepage" name="homepage" placeholder="홈페이지">
    </div>
    <div class="form-group col-md-4">
      <label for="inputState">지역(대)</label><br>
      <select id="location" name="big" class="form-control">
      	<option value="all">지역(대)</option>
        <c:forEach var="b" items="${big }">
        	<option value="${b.BIG }">${b.BIG }</option>
        </c:forEach>
      </select>
    </div>
    
    <div class="form-group col-md-6">
      <label for="inputCity">지역(소)</label><br>
      <select id="smalls" class="form-control" name="small">
      <option value="all">지역(소)</option>
        	<option value="${b.SMALL }">${b.SMALL }</option>
      </select> 
    </div>
     <div class="form-group">
    <label for="exampleFormControlFile1">기업로고</label><br>
    <input type="file" class="form-control-file" id="logo" name="attach">
  </div>
    <div class="form-group col-md-4">
      <label for="inputState">기업구분</label><br>
      <select id="cotype" name="cotype" class="form-control">
        <option selected>기업구분</option>
        <option>대기업</option>
        <option>중견기업</option>
        <option>공기업</option>
        <option>중소기업</option>
        <option>스타업</option>
        <option>외국계기업</option>
      </select>
      <br>
    </div>
  
  <br>
  <button type="submit" >회사 공고 등록</button>
</form>

<script>
// 지역 구분
$("#location").on(
        "change",
        function() {
           var big = $("#location").val();
           console.log("val:" + big);
           var param = {
              "big" : big
           };
           $.post("${pageContext.servletContext.contextPath}/admin/writeajax.do", param).done(
                 function(rst) {
                    var html = "";
                    for (var i = 0; i < rst.length; i++) {
                       html += "<option value=\""+rst[i].SMALL+"\">"
                             + rst[i].SMALL + "</option><br/>";
                    }
                    $("#smalls").html(html);

                 });
        });
</script>