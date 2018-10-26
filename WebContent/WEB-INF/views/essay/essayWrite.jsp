<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">
	<div align="right">
		<a class="btn btn-dark" href="${path}/essayBoard/essayBoard.do"
			role="button">게시판 목록</a>
	</div>

	<form action="${path}/essay/essayWrite.do" method="post"
		enctype="multipart/form-data">



		<div class="row">
			<div class="col-9">
				<label for="exampleFormControlInput1">TITLE</label> <input
					type="text" name="title" placeholder="제목"
					style="background: transparent; width: 100%; font-size: 15pt; border: none; outline: none; border-bottom: 2px solid rgba(0, 0, 0, 5);">
			</div>

			<div class="col-3" align="right">
				<label for="exampleFormControlInput1">직군</label> <select
					class="form-control" name="job" required="required">
					<option>직군</option>
					<c:forEach var="e" items="${list}">
						<option value="${e.CATENAME}">${e.CATENAME}</option>
					</c:forEach>

				</select>
			</div>
		</div>
		<!-- 질문1번째 -->
		<div class="form-group">
			<label><span id="question">Q1.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q1" placeholder="질문을 입력해주세요"></textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="A1" rows="5" name="A1"></textarea>
		</div>
		<div align="right">
			<span id="countA1"></span>/1000
		</div>

		<!-- 질문2번째 -->
		<div class="form-group">
			<label><span id="question">Q2.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q2" placeholder="질문을 입력해주세요"></textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="A2" rows="5" name="A2"></textarea>
		</div>
		<div align="right">
			<span id="countA2"></span>/1000
		</div>

		<!-- 질문3번째 -->
		<div class="form-group">
			<label><span id="question">Q3.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q3" placeholder="질문을 입력해주세요"></textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="A3" rows="5" name="A3"></textarea>
		</div>
		<div align="right">
			<span id="countA3"></span>/1000
		</div>

		<!-- 질문4번째 -->
		<div class="form-group">
			<label><span id="question">Q4.</span></label>
			<textarea class="form-control" id="exampleFormControlTextarea1"
				rows="1" name="Q4" placeholder="질문을 입력해주세요"></textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="A4" rows="5" name="A4"></textarea>
		</div>
		<div align="right">
			<span id="countA4"></span>/1000
		</div>



		<div align="right">
			<button class="btn btn-dark">올리기</button>
		</div>
	</form>
</div>

<script>
	$("#A1").keyup(function() {
		$("#countA1").html($("#A1").val().length);
		if ($("#A1").val().length > 1000) {

			$("#A1").val(($("#A1").val().substr(0, 1000)));
		}
	});

	$("#A2").keyup(function() {
		$("#countA2").html($("#A2").val().length);
		if ($("#A2").val().length > 1000) {

			$("#A2").val(($("#A2").val().substr(0, 1000)));
		}
	});

	$("#A3").keyup(function() {
		$("#countA3").html($("#A3").val().length);
		if ($("#A3").val().length > 1000) {

			$("#A3").val(($("#A3").val().substr(0, 1000)));
		}
	});

	$("#A4").keyup(function() {
		$("#countA4").html($("#A4").val().length);
		if ($("#A4").val().length > 1000) {

			$("#A4").val(($("#A4").val().substr(0, 1000)));
		}
	});
</script>