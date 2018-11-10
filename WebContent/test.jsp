<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/search/dynamic.do"
		method="post">
		<div>


			<h1>기업 검색</h1>
			<p style="color: white;">
				이 기업의 연봉정보,<br> 입사지원서 내기 전에 확인하세요!
			</p>
		</div>
		<div class="ui grid">
			<div class="five wide column"></div>
			<div class="eleven wide column">
				<div class="ui search">
					<div class="ui icon input" style="width: 100%;">
						<input class="prompt" list="some" type="text"
							placeholder="궁금하신 회사의 이름을 입력해주세요." name="search"
							onkeyup="sch(this)"> <i class="search icon"></i>
						<datalist id="some">
							<option></option>
						</datalist>
					</div>
					<div class="results"></div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>