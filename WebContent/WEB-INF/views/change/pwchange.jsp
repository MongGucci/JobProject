<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
<hr>
	
	<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/pwchange.do" method="post">
		<p style="font-size: small;">
			해당 사용자 계정의 비밀번호를 변경합니다.<br/>
		</p>
		<c:if test="${!empty err }">
			<div class="alert alert-danger" role="alert" style="width: 300px;">
				비밀번호를 잘못 입력하셨습니다.
			</div>
		</c:if>
		<input type="password" id="inputPassword" class="form-control"
			placeholder="기존 비밀번호" required autofocus name="pass" style="width: 300px;"> 
			<br>
		<input type="password" id="inputPassword" class="form-control"
			placeholder="새 비밀번호" required name="new1pass"  style="width: 300px;">
			<br>
	
		<input type="password" id="inputPassword" class="form-control"
			placeholder="비밀번호 재확인" required name="newpass"  style="width: 300px;">
		<c:if test="${!empty err1 }">
			<div class="alert alert-danger" role="alert">
				 새 비밀번호를 다시 확인해주세요
			</div>
		</c:if>
		<br>
		<button class="btn btn-lg btn-warning btn-block" type="submit"  style="width: 300px;">
			비밀번호 변경</button>
		<p class="mt-5 mb-3 text-muted">&copy; 2018 MOCKING CORP</p>
	</form>

    