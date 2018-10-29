<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/search.css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/button.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>

<title>Job'A</title>
</head>
<body style="text-align: center; background-color: orange;">
	<div class="container" style="margin-top: 20px; float: none;">
		<nav class="navbar navbar-default" color-on-scroll="200px;">
			<div>
				<p id="#cm" class="hc vc">
				<form class="form-signin"
					action="${pageContext.servletContext.contextPath }/search/search.do"
					method="post">
					<h1>기업 검색</h1>
					<p style="color: white;">
						이 기업의 연봉정보,<br> 입사지원서 내기 전에 확인하세요!
					</p>
			</div>
			<div>
				<input type="text" list="some" placeholder="궁금하신 회사의 이름을 입력해주세요."
					name="search" onkeyup="sch(this)" />
				<datalist id="some">
					<option></option>
				</datalist>
				<button type="submit" style="height: 40px;">
					<img class=""
						src="${pageContext.servletContext.contextPath }/image/dop.PNG"
						style="width: 30px; height: 30px; padding: 0px;" border="0" />
				</button>
			</div>
			</form>

			<br> <br> <br>
			<p>실시간 인기검색어</p>

			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br>
			<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB'A CORP</p>
		</nav>
	</div>
	<script>
		var sch = function(target) {
			var xhr = new XMLHttpRequest();
			var param = target.value;
			console.log("쳐봐 :" + param);

			xhr.open("get", "${path}/search/searchajax.do?coname="+param, true);
			xhr.onreadystatechange = function() {
				if (this.readyState == 4) {
					var html = "";
					var obj = JSON.parse(this.responseText.trim());
					for (var i = 0; i < obj.length; i++) {
						html += "<option value =" + obj[i].CONAME + ">"
								+ obj[i].CONAME + "</option>";
					}
					document.getElementById("some").innerHTML =  html;
				}
			};
			xhr.send(param);

		};
	</script>
</body>
</html>
