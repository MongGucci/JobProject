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
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${path}/semantic/semantic.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>

<script src="${path}/semantic/semantic.js"></script>
<title>회사별 자소서 폼</title>
</head>
<body>
<div class="container" style="margin-top: 20px; margin-bottom: 50px;">
	

	<form action="${path}/admin/companyjaso.do" method="post"
		>



		<div class="row">
			<div class="col-4">
				<label for="exampleFormControlInput1">TITLE</label> <input
					type="text" name="title" placeholder="제목" id="title"
					style="background: transparent; width: 100%; font-size: 15pt; border: none; outline: none; border-bottom: 2px solid rgba(0, 0, 0, 5);">
			</div>

			<div class="col-2" align="right">
				<label for="exampleFormControlInput1">회사</label> <select
					class="form-control" name="cono" required="required">
					<option>회사 선택</option>
					<c:forEach var="e" items="${list}">
						<option value="${e.CONO}">${e.CONAME}</option>
					</c:forEach>

				</select>
			</div>
			<div class="col-2" align="right">
				<label for="exampleFormControlInput1">직무</label> <select
					class="form-control" name="job" required="required">
					<option>직군</option>
					<c:forEach var="e" items="${cate}">
						<option value="${e.CATENAME}">${e.CATENAME}</option>
					</c:forEach>

				</select>
			</div>
			
			<div class="col-2" align="right">
				<label for="exampleFormControlInput1">채용</label> <select
					class="form-control" name="hino" required="required">
					<option>회사 선택</option>
					<c:forEach var="e" items="${hire}">
						<option value="${e.HINO}">${e.NAME}(${e.HINO})</option>
					</c:forEach>

				</select>
			</div>
			
		</div>
		<!-- 질문1번째 -->
		<div class="form-group">
			<label><span id="question">Q1.</span></label>
			<textarea class="form-control" id="Q1" rows="1" name="Q1"
				placeholder="질문을 입력해주세요"></textarea>
		</div>
	

		<!-- 질문2번째 -->
		<div class="form-group">
			<label><span id="question">Q2.</span></label>
			<textarea class="form-control" id="Q2" rows="1" name="Q2"
				placeholder="질문을 입력해주세요"></textarea>
		</div>
		

		<!-- 질문3번째 -->
		<div class="form-group">
			<label><span id="question">Q3.</span></label>
			<textarea class="form-control" id="Q3" rows="1" name="Q3"
				placeholder="질문을 입력해주세요"></textarea>
		</div>
		

		<!-- 질문4번째 -->
		<div class="form-group">
			<label><span id="question">Q4.</span></label>
			<textarea class="form-control" id="Q4" rows="1" name="Q4"
				placeholder="질문을 입력해주세요"></textarea>
		</div>
		
		<div class="form-group">
		<button>보내기</button>
		</div>
		


	</form>
</div>


</body>
</html>
