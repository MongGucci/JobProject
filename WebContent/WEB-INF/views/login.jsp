<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Job아주세요</title>
</head>
<body class="text-center">
<form class="form-signin" action="${pageContext.servletContext.contextPath }/login.do" method="post">	
	<h1 class="h3 mb-3 font-weight-normal">로그인</h1>
	 <input type="id" id="inputid" class="form-control"placeholder="아이디" required autofocus name="id"><br>
	 <input type="password" id="inputPassword" class="form-control" placeholder="비밀번호" required name="pass">
	 <br>
	<button class="btn btn-lg btn-warning btn-block" type="submit">로그인</button>
	<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB'A CORP</p>
</form>	
</body>
</html>