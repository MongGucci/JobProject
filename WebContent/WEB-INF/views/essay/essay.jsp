<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>




<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${path}/semantic/semantic.css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic"
	rel="stylesheet">
<title>JOB Go</title>
<style>
span:hover {
	color: white;
}

#hirediv {
	border: 1px solid #434e6e;
	margin: 20px;
	background-color: white;
	padding: 10px;
	font-family: 'Nanum Gothic', sans-serif;
}

#hirediv:hover {
	background-color: #434e6e;
	color: white;
}

#passdiv:hover {
	background-color: #434e6e;
	color: white;
}

#passdiv {
	border: 1px solid #434e6e;
	margin: 20px;
	background-color: white;
	padding: 10px;
	font-family: 'Nanum Gothic', sans-serif;
}

#cnt {
	font-size: 20pt;
	text-align: center;
}

#hirename {
	font-size: 15pt;
	font-weight: bolder;
	padding-top: 30px;
}

#hirename:hover {
	cursor: pointer;
}

#hireinfo {
	font-size: 12pt;
}

#detail {
	margin: 5px;
}

#jaso {
	font-size: 13pt;
	margin-top: 10px;
}

#jaso:hover {
	cursor: pointer;
}

#jobgo {
	font-size: 15pt;
}

#btn {
	background-color: rgba(0, 0, 0, 0);
	border: none;
	color: #434e6e;
	padding: 15px;
	font-size: 15pt;
	border-radius: 5%;
}

#btn:hover {
	background-color: #434e6e;
	color: white;
	padding: 15px;
	font-size: 15pt;
	border-radius: 5%;
	padding: 15px
}

#myessay {
	background-color: rgba(0, 0, 0, 0);
	border: none;
	color: #434e6e;
	padding: 15px;
	font-size: 15pt;
	border-radius: 5%;
}

#myessay:hover {
	background-color: #434e6e;
	color: white;
	padding: 15px;
	font-size: 15pt;
	border-radius: 5%;
}
#jasodiv{
border: 1px solid #434e6e;
	font-weight:bolder;
	font-size:13pt;
	background-color: white;
	padding: 10px;
	font-family: 'Nanum Gothic', sans-serif;

}
</style>
</head>
<nav style="margin: 20px;">
	<div class="ui grid" align="right">
		<div class="two wide column" align="left">
			<a href="${path}" id="logo"><b id="jobgo">JOB Go</b></a>
		</div>
		<div class="twelve wide column"></div>
		<div class="two wide column">
			<c:if test="${empty userId}">
				<a class="btn btn-sm btn-outline-secondary"
					href="${pageContext.servletContext.contextPath }/login.do"
					id="signin">Sign in</a>
				<a class="btn btn-sm btn-outline-secondary"
					href="${pageContext.servletContext.contextPath}/join/join.do"
					id="Sign up">Sign up</a>
			</c:if>
			<c:if test="${!empty userId}">
				<a class="btn btn-sm btn-outline-secondary"
					href="${pageContext.servletContext.contextPath}/infor.do"
					id="Sign out">MyPage</a>
				<a class="btn btn-sm btn-outline-secondary"
					href="${pageContext.servletContext.contextPath}/logout.do"
					id="Sign out">Sign out</a>
			</c:if>
		</div>
	</div>

</nav>


<%-- ──────────────────────────── 모달시작  ───────────────────────────────────────────────────--%>
<c:if test="${empty userId}">
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">JOB GO</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">로그인이 필요한 서비스 입니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<a href="${path}/login.do"><button type="button"
							class="btn btn-primary">Login</button></a>
				</div>
			</div>
		</div>
	</div>
</c:if>
<%-- ──────────────────────────── 모달끝  ───────────────────────────────────────────────────--%>



<body style="background-color: #F4F4F4;">

	<div class="container-fluid">

		<div class="row" style="height: 950px;">

			<div class="col" style="overflow-y: scroll; height: 100%;">
				<div class="ui grid" style="margin: 20px;">

					<div class="four wide column">
						<button id="btn" onclick="menu(this)" data-value="hire">
							<b>채용공고</b>
						</button>
					</div>
					<div class="four wide column">
						<button id="btn" onclick="menu(this)" data-value="pass">
							<b>합격자소서</b>
						</button>
					</div>
					<div class="six wide column">
						<button id="myessay" data-toggle="modal"
							data-target="#exampleModal" data-value="myessay"
							onclick="menu(this)">
							<b>내가 쓴 자소서</b>
						</button>
					</div>
					<div class="two wide column"></div>

				</div>

				<%-- ──────────────────────────── 중앙  ───────────────────────────────────────────────────--%>
				<div id="left">
				



					<div align="right" style="margin-right: 20px;">
						<div class="ui search">
							<div class="ui icon input" style="">
								<input class="prompt" type="text" placeholder="검색어를 입력해주세요."
									id="hiresearch" name="hiresearch" style="width: 300px;">
								<div onclick="hiresearch()" style="margin-top: 10px;">
									<i class="search icon"></i>
								</div>
							</div>
							<div class="results"></div>
						</div>

					</div>


					<c:forEach var="e" items="${list}" varStatus="status">
						<div id="hirediv">

							<div class="ui grid" id="list">

								<div class="four wide column" id="cnt">
									<img src="${path}${e.LOGO}">
								</div>
								<div class="twelve wide column">

									<div class="ui grid">

										<div class="four wide column" id="hirename">${e.NAME}</div>
										<div class="eight wide column" id="hireinfo">
											<div style="width: 100%" id="detail">
												<b>${e.TITLE}</b>
											</div>
											<div style="width: 100%" id="detail">
												<small>${e.JOBCATE}</small>
											</div>
											<div style="width: 100%" id="detail">${e.HIRESHAPE}</div>
										</div>
										<div class="four wide column" align="right">
											<div
												style="padding-top: 10px; font-size: 13pt; font-weight: bolder;">${e.DDAY}</div>
											<div id="jaso" onclick="hino(this)" data-value="${e.HINO}"
												data-toggle="modal" data-target="#exampleModal">
												<i class="add icon"></i> 자소서 쓰기
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

				<%-- ──────────────────────────── 페이징시작  ───────────────────────────────────────────────────--%>



				<%-- ──────────────────────────── 모달끝  ───────────────────────────────────────────────────--%>
			</div>






			<c:choose>
				<c:when test="${!empty userId}">


				</c:when>
				<c:otherwise>


				</c:otherwise>
			</c:choose>




			<%-- ---------------------------오른쪽 시작----------------------------------- --%>

			<div class="col" style="margin-top: 20px;">
				<form action="${path}/essay/essayWrite.do" method="post"
					enctype="multipart/form-data">
					<div class="row">
						<div class="col-9">
							<label style="font-size: 15pt;">TITLE</label> <input type="text"
								name="title" placeholder="제목" id="title"
								style="background: transparent; width: 100%; font-size: 15pt; border: none; outline: none; border-bottom: 2px solid rgba(0, 0, 0, 5);">
						</div>

						<div class="col-3">
							<label style="font-size: 15pt; margin-bottom: 25px;">직군</label> <select
								class="form-control" name="job" required="required"
								style="font-size: 13pt; width: 100%;">
								<option>직군</option>
								<c:forEach var="e" items="${cate}">
									<option value="${e.CATENAME}">${e.CATENAME}</option>
								</c:forEach>

							</select>
						</div>
					</div>

					
					<div id="textarea" style="margin-top: 20px;">
						<!-- 질문1번째 -->

						<input type="hidden" name="hino" id="hino">
						<div class="form-group">

							Q1.
							<textarea class="form-control" id="Q1" rows="1" name="Q1"
								placeholder="질문을 입력해주세요" style="resize: none;"></textarea>
						</div>
						<div class="form-group">

							<textarea class="form-control" id="A1" rows="5" name="A1"></textarea>
						</div>
						<div align="right">
							<span id="countA1"></span>/1000
						</div>
						<div id="jaso2" style="display: none;">

							<div class="form-group">

								Q2.
								<textarea class="form-control" id="Q2" rows="1" name="Q2"
									placeholder="질문을 입력해주세요" style="resize: none;"></textarea>
							</div>
							<div class="form-group">

								<textarea class="form-control" id="A2" rows="5" name="A2"></textarea>
							</div>
							<div align="right">
								<span id="countA2"></span>/1000
							</div>

						</div>
						<div id="jaso3" style="display: none;">

							<div class="form-group">

								Q3.
								<textarea class="form-control" id="Q3" rows="1" name="Q3"
									placeholder="질문을 입력해주세요" style="resize: none;"></textarea>
							</div>
							<div class="form-group">

								<textarea class="form-control" id="A3" rows="5" name="A3"></textarea>
							</div>
							<div align="right">
								<span id="countA3"></span>/1000
							</div>

						</div>
						<div id="jaso4" style="display: none;">

							<div class="form-group">

								Q4.
								<textarea class="form-control" id="Q4" rows="1" name="Q4"
									placeholder="질문을 입력해주세요" style="resize: none;"></textarea>
							</div>
							<div class="form-group">

								<textarea class="form-control" id="A4" rows="5" name="A4"></textarea>
							</div>
							<div align="right">
								<span id="countA4"></span>/1000
							</div>

						</div>




					</div>
					<div class="ui grid" align="right">
						<div class="six wide column"></div>
						<div class="ten wide column"
							style="margin-top: 20px; width: 100%;">

							<select class="ui dropdown" id="lang">
								<option value="">번역 할 언어</option>
								<option value="en">영어</option>
								<option value="zh-CN">중국어 간체</option>

								<option value="es">스페인어</option>
								<option value="fr">프랑스어</option>

							</select>
							<button type="button" class="ui inverted secondary button"
								id="trans">번역하기</button>


							<button type="button" class="ui inverted secondary button"
								id="plus">추가하기</button>

							<button class="ui inverted secondary button" id="save">저장하기</button>
						</div>

					</div>

				</form>


			</div>




		</div>
	</div>
	
</body>
<!-- Scripts -->
<c:if test="${!empty userId}">
<script>

var hino = function(obj) {
	console.log(obj.dataset.value);

	var param = {
		"hino" : obj.dataset.value
	};
	$("#hino").val(obj.dataset.value);

	$.post("${path}/essay/essayPostAjax.do", param).done(function(rst) {
		console.log(rst);
		if (rst != null) {
			var before = $("#textarea").html();
			$("#title").val(rst.TITLE);
			$("#job").val(rst.JOBCATE);

			if (rst.Q2 != null) {
				$("#jaso2").show();

			}
			if (rst.Q3 != null) {
				$("#jaso3").show();

			}
			if (rst.Q4 != null) {
				$("#jaso4").show();

			}

			$("#Q1").val(rst.Q1);
			$("#Q2").val(rst.Q2);
			$("#Q3").val(rst.Q3);
			$("#Q4").val(rst.Q4);

		} else {
			$("#title").val("");
			$("#job").val("");
			$("#Q1").val("");
			$("#Q2").val("");
			$("#Q3").val("");
			$("#Q4").val("");
		}

	});
}

</script>
</c:if>

<script>
	var count = 1;

	$("#plus").on("click", function() {
		count++;
		console.log(count);

		if (count > 4) {
			count--;
			window.alert("4개 까지!!")

		} else {
			$("#jaso" + count).show();

		}

	});

	
	var menu = function(obj) {

		var param = {
			"menu" : obj.dataset.value
		};
		$
				.post("${path}/essay/essayMenuAjax.do", param)
				.done(
						function(rst) {
							console.log(rst);
							var html = "";
							var page = "";
							if (rst[0].mode == 'hire') {
								html += "<div align=\"right\" style=\"margin-right: 20px;\"><div class=\"ui search\">"
								html += "<div class=\"ui icon input\"><input class=\"prompt\" type=\"text\""
									html +=	"placeholder=\"검색어를 입력해주세요.\" id = \"hiresearch\" name=\"hiresearch\" style=\"width: 300px;\"> <div onclick=\"hiresearch()\" style=\" margin-top: 10px;\"> <i"
									html += " class=\"search icon\"></i></div><div class=\"results\"></div></div></div></div>"
								for (var i = 0; i < rst.length; i++) {

									html += "<div id=\"hirediv\"><div class=\"ui grid\" id=\"list\">"
									html += "<div class=\"four wide column\" id=\"cnt\"><img src=\"${path}"+rst[i].LOGO +"\"></div>"
									html += "<div class=\"twelve wide column\"><div class=\"ui grid\"><div class=\"four wide column\" id=\"hirename\" onclick=\"location.href='${path}/search/schdetail.do?cono="
											+ rst[i].CONO
											+ "'\">"
											+ rst[i].NAME + "</div>";
									html += "<div class=\"eight wide column\" id=\"hireinfo\"><div style=\"width: 100%\" id=\"detail\"><b>"
											+ rst[i].TITLE + "</b>"
									html += "</div><div style=\"width: 100%\" id=\"detail\"><small>"
											+ rst[i].JOBCATE + "</small></div>"
									html += "<div style=\"width: 100%\" id=\"detail\">"
											+ rst[i].HIRESHAPE
											+ "</div></div><div class=\"four wide column\" align=\"right\">"
									html += "<div style=\"padding-top: 10px; font-size: 13pt; font-weight: bolder;\">"
											+ rst[i].DDAY
											+ "</div><div id=\"jaso\" onclick=\"hino(this)\" data-value=\""
											+ rst[i].HINO + "\""
									html += "data-toggle=\"modal\" data-target=\"#exampleModal\"><i class=\"add icon\"></i> 자소서 쓰기</div></div></div></div></div></div>"

								}
							} else if (rst[0].mode == 'pass') {
								html += "<div align=\"right\" style=\"margin-right: 20px;\"><div class=\"ui search\">"
								html += "<div class=\"ui icon input\"><input class=\"prompt\" type=\"text\""
									html +=	"placeholder=\"검색어를 입력해주세요.\" id = \"passsearch\" name=\"passsearch\" style=\"width: 300px;\">  <div onclick=\"passsearch()\"  style=\" margin-top: 10px;\"><i"
									html += " class=\"search icon\"></i></div><div class=\"results\"></div></div></div></div>"
								for (var i = 0; i < rst.length; i++) {

									html += "<div id=\"passdiv\" data-value=\""
											+ rst[i].PASSNO
											+ "\" onclick=\"passjaso(this)\"><div class=\"ui grid\" id=\"list\">"

									html += "<div class=\"four wide column\" id=\"cnt\"><img src=\"${path}"+rst[i].LOGO+"\"></div>"
									html += "<div class=\"twelve wide column\"><div class=\"ui grid\">"

									html += "<div class=\"four wide column\" id=\"hirename\">"
											+ rst[i].CONAME + "</div>"
									html += "<div class=\"twelve wide column\" id=\"hireinfo\"><div style=\"width: 100%\" id=\"detail\">"
									html += "<b>"
											+ rst[i].TITLE
											+ "</b></div><div style=\"width: 100%\" id=\"detail\"><small>"
											+ rst[i].CATE + "</small>"
									html += "</div></div></div></div></div></div>"
								}

							} else {
								for (var i = 0; i < rst.length; i++) {
									html += "<div id=\"passdiv\" data-value=\""
											+ rst[i].JASONO
											+ "\" onclick=\"myjaso(this)\"><div class=\"ui grid\" id=\"list\">"

									html += "<div class=\"twelve wide column\" id=\"cnt\"><b>"
											+ rst[i].TITLE + "</b></div>"
									html += "<div class=\"four wide column\"><div>"
											+ rst[i].JOBCATE
											+ "</div><div><small>"
											+ rst[i].LASTDATE
											+ "</small></div></div>"

									html += "</div></div>"
								}

							}
							$("#left").html(html);

						});

	}
	$("#outside")
			.click(
					function() {
						$("#file")
								.html(
										"<label for=\"exampleFormControlInput1\">FILE</label>"
												+ "<input type=\"file\"name=\"attach\" placeholder=\"첨부파일\">");
					});

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

	$("#trans").on("click", function() {
		var lang = $("#lang").val();
		var title = $("#title").val();
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
			"Q1" : Q1,
			"Q2" : Q2,
			"Q3" : Q3,
			"Q4" : Q4,
			"A1" : A1,
			"A2" : A2,
			"A3" : A3,
			"A4" : A4

		};
		$.post("${path}/translate/trans.do", param).done(function(rst) {
			console.log(rst);
			$("#title").val(rst.title);

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

	var passjaso = function(obj) {
		console.log(obj.dataset.value);

		var param = {
			"passno" : obj.dataset.value
		};

		$
				.post("${path}/essay/passJasoAjax.do", param)
				.done(
						function(rst) {
							console.log(rst);

							var html = "";
							html +="<div id=\"jasodiv\">"
								html += "<div class=\"ui grid\"><div class=\"twelve wide column\">"
								html += rst.TITLE + "</div><div class=\"four wide column\">"+rst.CATE+"</div></div></div>"

							html += "<div class=\"accordion\" id=\"accordionExample\"><div id=\"accordion\" role=\"tablist\">"
<%-- 노가다1--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 13pt;\">Q1.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
					html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q1 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A1
									+ "</div></div></div>"
<%-- 노가다2--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 13pt;\">Q2.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
						html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q2 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A2
									+ "</div></div></div>"
<%-- 노가다3--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 13pt;\">Q3.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
							html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q3 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A3
									+ "</div></div></div>"
<%-- 노가다4--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 13pt;\">Q4.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
		html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q4 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A4
									+ "</div></div></div>"
							console.log(html);
							$("#left").html(html);
						});

	}

	var myjaso = function(obj) {
		console.log(obj.dataset.value);

		var param = {
			"jasono" : obj.dataset.value
		};

		$
				.post("${path}/essay/myJasoAjax.do", param)
				.done(
						function(rst) {
							console.log(rst);

							var html = "";
							html +="<div id=\"jasodiv\">"
							html += "<div class=\"ui grid\"><div class=\"twelve wide column\">"
							html += rst.TITLE + "</div><div class=\"four wide column\">"+rst.JOBCATE+"</div></div></div>"
							html += "<div class=\"accordion\" id=\"accordionExample\"><div id=\"accordion\" role=\"tablist\">"
<%-- 노가다1--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 20pt;\">Q1.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
					html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q1 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A1
									+ "</div></div></div>"
<%-- 노가다2--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 20pt;\">Q2.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
						html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q2 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A2
									+ "</div></div></div>"
<%-- 노가다3--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 20pt;\">Q3.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
							html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q3 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A3
									+ "</div></div></div>"
<%-- 노가다4--%>
	html += "<div class=\"card\"><div class=\"card-header\" role=\"tab\" id=\"headingOne\"><h5 class=\"mb-0\">"
							html += "<span style=\"font-size: 20pt;\">Q4.</span> <a data-toggle=\"collapse\" href=\"#collapseOne\" aria-expanded=\"true\" "
								html +=	"aria-controls=\"collapseOne\">"
									+ rst.Q4 + "</a></h5></div>"
							html += "<div id=\"collapseOne\" class=\"collapse show\" role=\"tabpanel\" aria-labelledby=\"headingOne\" data-parent=\"#accordion\">"
							html += "<div class=\"card-body\">" + rst.A4
									+ "</div></div></div>"

							html += "</div></div>"
							console.log(html);
							$("#left").html(html);
						});

	}

	var hiresearch = function() {
		console.log("11111");
		console.log($("#hiresearch").val());
		var word = $("#hiresearch").val();
		var html = "";
		var param = {
			"hiresearch" : word
		};
		$
				.post("${path}/essay/searchHireAjax.do", param)
				.done(
						function(rst) {
							console.log(rst);

							html += "<div align=\"right\" style=\"margin-right: 20px;\"><div class=\"ui search\">"
							html += "<div class=\"ui icon input\"><input class=\"prompt\" type=\"text\""
									html +=	"placeholder=\"검색어를 입력해주세요.\" id = \"hiresearch\" name=\"hiresearch\" style=\"width: 300px;\"> <div onclick=\"hiresearch()\" style=\" margin-top: 10px;\"> <i"
									html += " class=\"search icon\"></i></div><div class=\"results\"></div></div></div></div>"

							for (var i = 0; i < rst.length; i++) {

								html += "<div id=\"hirediv\"><div class=\"ui grid\" id=\"list\">"
								html += "<div class=\"four wide column\" id=\"cnt\"><img src=\"${path}"+rst[i].LOGO +"\"></div>"
								html += "<div class=\"twelve wide column\"><div class=\"ui grid\"><div class=\"four wide column\" id=\"hirename\" onclick=\"location.href='${path}/search/schdetail.do?cono="
										+ rst[i].CONO
										+ "'\">"
										+ rst[i].NAME
										+ "</div>";
								html += "<div class=\"eight wide column\" id=\"hireinfo\"><div style=\"width: 100%\" id=\"detail\"><b>"
										+ rst[i].TITLE + "</b>"
								html += "</div><div style=\"width: 100%\" id=\"detail\"><small>"
										+ rst[i].JOBCATE + "</small></div>"
								html += "<div style=\"width: 100%\" id=\"detail\">"
										+ rst[i].HIRESHAPE
										+ "</div></div><div class=\"four wide column\" align=\"right\">"
								html += "<div style=\"padding-top: 10px; font-size: 13pt; font-weight: bolder;\">"
										+ rst[i].DDAY
										+ "</div><div id=\"jaso\" onclick=\"hino(this)\" data-value=\""
										+ rst[i].HINO + "\""
								html += "data-toggle=\"modal\" data-target=\"#exampleModal\"><i class=\"add icon\"></i> 자소서 쓰기</div></div></div></div></div></div>"
							}
							console.log(html);
							$("#left").html(html);
						});

	}

	var passsearch = function() {
		console.log("11111");
		console.log($("#passsearch").val());
		var word = $("#passsearch").val();
		var html = "";
		var param = {
			"passsearch" : word
		};
		$
				.post("${path}/essay/searchPassAjax.do", param)
				.done(
						function(rst) {
							console.log(rst);

							html += "<div align=\"right\" style=\"margin-right: 20px;\"><div class=\"ui search\">"
							html += "<div class=\"ui icon input\"><input class=\"prompt\" type=\"text\""
									html +=	"placeholder=\"검색어를 입력해주세요.\" id = \"hiresearch\" name=\"hiresearch\" style=\"width: 300px;\"> <div onclick=\"hiresearch()\" style=\" margin-top: 10px;\"> <i"
									html += " class=\"search icon\"></i></div><div class=\"results\"></div></div></div></div>"

							for (var i = 0; i < rst.length; i++) {

								html += "<div id=\"passdiv\" data-value=\""
										+ rst[i].PASSNO
										+ "\" onclick=\"passjaso(this)\"><div class=\"ui grid\" id=\"list\">"

								html += "<div class=\"four wide column\" id=\"cnt\"><img src=\"${path}"+rst[i].LOGO+"\"></div>"
								html += "<div class=\"twelve wide column\"><div class=\"ui grid\">"

								html += "<div class=\"four wide column\" id=\"hirename\">"
										+ rst[i].CONAME + "</div>"
								html += "<div class=\"twelve wide column\" id=\"hireinfo\"><div style=\"width: 100%\" id=\"detail\">"
								html += "<b>"
										+ rst[i].TITLE
										+ "</b></div><div style=\"width: 100%\" id=\"detail\"><small>"
										+ rst[i].CATE + "</small>"
								html += "</div></div></div></div></div></div>"

							}
							console.log(html);
							$("#left").html(html);
						});

	}
</script>

<script src="${path}/assets/js/jquery.min.js"></script>
<script src="${path}/assets/js/jquery.scrolly.min.js"></script>
<script src="${path}/assets/js/jquery.scrollex.min.js"></script>
<script src="${path}/assets/js/skel.min.js"></script>
<script src="${path}/assets/js/util.js"></script>
<script src="${path}/assets/js/main.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

</html>