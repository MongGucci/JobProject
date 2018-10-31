<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<h2>COMPANY</h2>
<form action="${path }/admin/write.do">
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputEmail4">회사이름</label><br>
      <input type="text" class="form-control" id="coname" placeholder="회사이름">
    </div>
    <div class="form-group col-md-6">
      <label for="inputPassword4">산업군</label><br>
      <input type="text" class="form-control" id="industry" placeholder="산업군">
    </div>
  </div>
  <div class="form-group">
    <label for="inputAddress">매출액</label><br>
    <input type="text" class="form-control" id="sales" placeholder="매출액(천만원)">
  </div>
  <div class="form-group">
    <label for="inputAddress2">CEO</label><br>
    <input type="text" class="form-control" id="ceo" placeholder="CEO">
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">평균연봉</label><br>
      <input type="text" class="form-control" id="sales">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">종업원</label><br>
      <input type="text" class="form-control" id="workers">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">위도</label><br>
      <input type="text" class="form-control" id="lat">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">경도</label><br>
      <input type="text" class="form-control" id="lng">
    </div>
    <div class="form-group col-md-6">
      <label for="inputCity">초봉</label><br>
      <input type="text" class="form-control" id="first" placeholder="초봉(만원)">
    </div>
    <div class="form-group col-md-6">
      <label for="inputEmail4">회사 홈페이지</label><br>
      <input type="email" class="form-control" id="homepage" placeholder="홈페이지">
    </div>
    <div class="form-group col-md-4">
      <label for="inputState">BIG</label><br>
      <select id="big" class="form-control">
        <c:forEach var="b" items="${wt }">
        	<option value="${b }">${b.BIG }</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">SMALL</label><br>
      <%-- <select id="small" class="form-control">
        <c:forEach var="s" items="${ww }">
        	<option value="${s }">${s.SMALL }</option>
        </c:forEach>
      </select> --%>
    </div>
     <div class="form-group">
    <label for="exampleFormControlFile1">기업로고</label><br>
    <input type="file" class="form-control-file" id="logo">
  </div>
    <div class="form-group col-md-4">
      <label for="inputState">기업구분</label><br>
      <select id="cotype" class="form-control">
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
  </div>
  <br>
  <button type="submit" class="btn btn-primary">Sign in</button>
</form>