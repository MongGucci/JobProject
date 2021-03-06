<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#down {
	background-color: rgba(0, 0, 0, 0);
	border: 1px solid #434e6e;
	color: #434e6e;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}

#down:hover {
	background-color: #434e6e;
	color: white;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}

#trans {
	background-color: rgba(0, 0, 0, 0);
	border: 1px solid #434e6e;
	color: #434e6e;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}

#trans:hover {
	background-color: #434e6e;
	color: white;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}
</style>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">
	<div class="three wide column" align="right"
		style="margin-bottom: 10px;">
		<a href="${path}/essayBoard/shareEssayList.do"><button id="down">글
				목록가기</button></a>
	</div>

	<form action="${path}/essayBoard/shareEssay.do" method="post"
		enctype="multipart/form-data">



		<div class="row">
			<div class="col-9">
				<label for="exampleFormControlInput1">TITLE</label> <input
					type="text" id="title" name="title" placeholder="제목"
					style="background: transparent; width: 100%; font-size: 15pt; border: none; outline: none; border-bottom: 2px solid rgba(0, 0, 0, 5);">
			</div>

			<div class="col-3" align="right">
				<label style="font-size: 15pt;">직군</label> <select
					class="form-control" id="job" name="job" required="required">
					<option>직군</option>
					<c:forEach var="e" items="${list}">
						<option value="${e.CATENAME}">${e.CATENAME}</option>
					</c:forEach>

				</select>
			</div>
		</div>

		<div class="form-check form-check-inline">
			<div style="margin-top: 20px; margin-bottom: 20px;">
				<button type="button" id="outside" class="btn btn-outline-dark"
					style="margin-right: 20px;">외부에서 파일 불러오기</button>
			</div>

			<select class="form-control" id="myessay" name="myessay"
				required="required"
				style="width: 100%; border-color: black; color: black;">
				<option>내 자소서 가져오기</option>
				<c:forEach var="e" items="${essaylist}">
					<option value="${e.JASONO}">${e.TITLE}-${e.LASTDATE}</option>
				</c:forEach>

			</select>
		</div>

		<div class="form-group" id="file"></div>
		<div class="form-group">
			<label for="exampleFormControlTextarea1">CONTENT</label>
			<textarea class="form-control" name="content" rows="3"
				placeholder="보내는 내용" required="required" id="content"></textarea>
		</div>

		<!-- 질문1번째 -->
		<div class="form-group">
			<label><span id="question">Q1.</span></label>
			<textarea class="form-control" rows="1" id="Q1" name="Q1"
				placeholder="질문을 입력해주세요"></textarea>
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
			<textarea class="form-control" rows="1" id="Q2" name="Q2"
				placeholder="질문을 입력해주세요"></textarea>
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
			<textarea class="form-control" rows="1" id="Q3" name="Q3"
				placeholder="질문을 입력해주세요"></textarea>
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
			<textarea class="form-control" rows="1" id="Q4" name="Q4"
				placeholder="질문을 입력해주세요"></textarea>
		</div>
		<div class="form-group">

			<textarea class="form-control" id="A4" rows="5" name="A4"></textarea>
		</div>
		<div align="right">
			<span id="countA4"></span>/1000
		</div>



		<div align="right">
			<div class="ui grid" align="right">
				<div class="six wide column"></div>
				<div class="ten wide column" style="margin-top: 20px; width: 100%;">

					<select class="ui dropdown" id="lang">
						<option value="">번역 할 언어</option>
						<option value="en">영어</option>
						<option value="zh-CN">중국어 간체</option>

						<option value="es">스페인어</option>
						<option value="fr">프랑스어</option>

					</select>
					<button type="button" id="trans">번역하기</button>

					<button id="down">글 올리기</button>

				</div>

			</div>

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

	$("#outside")
			.click(
					function() {
						$("#file")
								.html(
										"<label for=\"exampleFormControlInput1\">FILE</label>"
												+ "<input type=\"file\"name=\"attach\" placeholder=\"첨부파일\">");
					});
	$("#trans").on("click", function() {
		var lang = $("#lang").val();
		var title = $("#title").val();
		var content = $("#content").val();
		var Q1 = $("#Q1").val();
		var Q2 = $("#Q2").val();
		var Q3 = $("#Q3").val();
		var Q4 = $("#Q4").val();
		var A1 = $("#A1").val();
		var A2 = $("#A2").val();
		var A3 = $("#A3").val();
		var A4 = $("#A4").val();

		var param = {
			"lang" : lang,
			"title" : title,
			"content" : content,
			"Q1" : Q1,
			"Q2" : Q2,
			"Q3" : Q3,
			"Q4" : Q4,
			"A1" : A1,
			"A2" : A2,
			"A3" : A3,
			"A4" : A4

		};
		console.log(param);
		$.post("${path}/translate/trans.do", param).done(function(rst) {
			console.log(rst);
			$("#title").val(rst.title);
			$("#content").val(rst.content);
			$("#Q1").val(rst.Q1);
			$("#A1").val(rst.A1);
			$("#Q2").val(rst.Q2);
			$("#A2").val(rst.A2);
			$("#Q3").val(rst.Q3);
			$("#A3").val(rst.A3);
			$("#Q4").val(rst.Q4);
			$("#A4").val(rst.A4);

		});

	});

	$("#myessay").on("change", function() {
		var myessay = $("#myessay").val();
		console.log("val:" + myessay);
		var param = {
			"jasono" : myessay
		};

		$.post("${path}/essayBoard/essayAjax.do", param).done(function(rst) {
			console.log(rst);
			$("#title").val(rst.TITLE);
			$("#job").val(rst.JOBCATE);
			$("#Q1").val(rst.Q1);
			$("#A1").val(rst.A1);
			$("#Q2").val(rst.Q2);
			$("#A2").val(rst.A2);
			$("#Q3").val(rst.Q3);
			$("#A3").val(rst.A3);
			$("#Q4").val(rst.Q4);
			$("#A4").val(rst.A4);

		});

	});
</script>
