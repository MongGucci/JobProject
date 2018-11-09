<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/signin.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
	<link href="${path}/css/default.css" rel="stylesheet">
	
<title>JOB Go</title>
</head>
<body class="text-center">
	<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/login.do"
		method="post">
		<div style="text-align: center;">
		<h1 class="h3 mb-3" style="color: #465674; font-size: 30pt; font-weight: bolder;">로그인</h1>
		<p>
			<input type="text" id="inputid" class="form-control" placeholder="아이디"
				required autofocus name="id" style="font-size: 17pt; "> 
		</p>
		<input type="password" id="inputPassword" class="form-control"
			placeholder="비밀번호" name="pass" required  style="font-size: 17pt; ">
		<label class="btn btn-secondary active">
		   <input type="radio" name="remember" value="week" id="option" autocomplete="off"> OneWeek
		</label>
	<!-- 
		<script>
		$('#option').on('click',function(){
			console.log($('#option').value);
			if($('#option').attr('checked')==true){
				$('#option').attr('checked',false);
			}else{
				$('#option').attr('checked',true);
			}
		});
		</script> -->
		<c:if test="${!empty err }">
			<div class="alert alert-danger" role="alert">정보를 잘못 입력하셨습니다.</div>
		</c:if>

		<button class="btn btn-lg btn-warning btn-block" type="submit" style="background-color:#465674; color: white; font-size: 20pt; font-weight: bolder;">로그인</button>
		<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB Go CORP</p>
		</div>
	</form>
</body>
</html>


