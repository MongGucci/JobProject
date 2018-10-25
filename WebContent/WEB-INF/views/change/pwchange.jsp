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
		<input type="password" id="cpass" onchange="checkPass(this);" class="form-control"
			placeholder="새 비밀번호" required style="width: 300px;"><span></span>
			<br>
		<input type="password" id="confirm" onkeyup="ckpass(this);" class="form-control"
			placeholder="비밀번호 재확인" required name="newpass"  style="width: 300px;"><span></span>
		<br>
		<button class="btn btn-lg btn-warning btn-block" type="submit"  style="width: 300px;">
			비밀번호 변경</button>
		<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB'A CORP</p>
	</form>
	<script>
		var ckpass = function(a) {
			var c1 = document.getElementById("confirm").value;
			var c2 = document.getElementById("cpass").value;
			
			if(c1.length == 0) {
				return;	
			}
			if(c1 == c2) {
				document.getElementsByTagName("span")[1].innerHTML = "<small>비밀번호가 일치합니다.</small>";
				document.getElementsByTagName("span")[1].style.color = "blue";
			}else {
				document.getElementsByTagName("span")[1].innerHTML = "<small>비밀번호가 일치하지 않습니다.</small>";
				document.getElementsByTagName("span")[1].style.color = "red";
			}
		};
		var checkPass = function(b) {
			var p1 = new RegExp("^[a-z0-9][a-z0-9_\-]{4,19}$");
			var passInput = b.value;
			
			if(passInput.match(p1) != null) {
				document.getElementsByTagName("span")[0].innerHTML = "";
				document.getElementsByTagName("span")[0].style.color = "blue";
			}else {
				document.getElementsByTagName("span")[0].innerHTML = "<small>비밀번호를 영문숫자 포함 4자리 이상을 입력해주세요.</small>";
				document.getElementsByTagName("span")[0].style.color = "red";
			}
		}
	</script>

    