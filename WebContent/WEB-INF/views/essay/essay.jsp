<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>Insert title here</title>
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

#cnt {
	font-size: 20pt;
	text-align: center;
	padding-top: 30px;
}

#hirename {
	font-size: 17pt;
	font-weight: bolder;
	padding-top: 30px;
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
</style>
</head>
<body style="background-color: #F4F4F4;">

	<div class="container-fluid">

		<div class="row" style="height: 950px;">

			<div class="col" style="overflow-y: scroll; height: 100%;">
				<div style="margin: 20px;">
					<div class="ui secondary  menu"
						style="font-size: 15pt; font-weight: bolder; font-family: 'Nanum Gothic', sans-serif;">
						<a class="item active" onclick="menu(this)" data-value="hire">
							채용공고 </a> <a class="item" onclick="menu(this)" data-value="pass">
							합격자소서 </a> <a class="item"> 내가 쓴 자소서 </a>

					</div>
				</div>
<div id="left">
				<c:forEach var="e" items="${list}" varStatus="status">
					<div id="hirediv">
						<div class="ui grid" id="list">

							<div class="two wide column" id="cnt">${status.count}.</div>
							<div class="fourteen wide column">

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
										<div id="jaso" onclick="hino(this)" data-value="${e.HINO}">
											<i class="add icon"></i> 자소서 쓰기
										</div>
									</div>

								</div>





							</div>

						</div>
					</div>
				</c:forEach>
				</div>


			</div>
			
			
			
			
			<div id="hirediv">
						<div class="ui grid" id="list">

							<div class="two wide column" id="cnt">${status.count}.</div>
							<div class="fourteen wide column">

								<div class="ui grid">

									<div class="four wide column" id="hirename">${e.NAME}</div>
									<div class="twelve wide column" id="hireinfo">
										<div style="width: 100%" id="detail">
											<b>${e.TITLE}</b>
										</div>
										<div style="width: 100%" id="detail">
											<small>${e.JOBCATE}</small>
										</div>
										<div style="width: 100%" id="detail">${e.HIRESHAPE}</div>
									</div>
									

								</div>





							</div>

						</div>
					</div>

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

					<div >
						<div style="margin-top: 20px; margin-bottom: 20px;">
							<button type="button" id="outside" class="btn btn-outline-dark"
								style="margin-right: 20px;">외부에서 파일 불러오기</button>
						</div>
						<div class="form-group" id="file"></div>

					</div>
					<div id="textarea" style="margin-top: 20px;">
					<!-- 질문1번째 -->


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




					</div>
					<div class="ui grid">

						<div class="twelve wide column"></div>
						<div class="four wide column" align="right"
							style="margin-top: 20px;">
							<button class="ui inverted secondary button" id="plus">저장하기</button>
						</div>

					</div>

				</form>
			</div>




		</div>
	</div>

	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true"></div>

</body>
<!-- Scripts -->


<script>
	var count = 1;
	$("#plus")
			.on(
					"click",
					function() {
						count++;
						console.log(count);

						if (count > 4) {
							count--;
							window.alert("4개 까지!!")

						} else {
							var html = "<div class=\"form-group\"><label><span id=\"question\">Q"
									+ count + ".</span></label>";
							html += "<textarea class=\"form-control\" id=\"Q"+count+"\" rows=\"1\" name=\"Q"+count+"\" placeholder=\"질문을 입력해주세요\"></textarea>";
							html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A"+count+"\" rows=\"5\" name=\"A"+count+"\"></textarea>";
							html += "</div><div align=\"right\"><span id=\"countA"+count+"\"></span>/1000</div>"
							var before = $("#textarea").html();
							var after = before + html;
							console.log(before);
							console.log(after);
							$("#textarea").html(after);
							//$("#textarea").html() = $("#textarea").html() + html;

						}

					});

	var hino = function(obj) {
		console.log(obj.dataset.value);

		var param = {
			"hino" : obj.dataset.value
		};

		$
				.post("${path}/essay/essayPostAjax.do", param)
				.done(
						function(rst) {
							console.log(rst);
							if (rst != null) {
								var before = $("#textarea").html();
								$("#title").val(rst.TITLE);
								$("#job").val(rst.JOBCATE);

								if (rst.Q2 != null) {
									var html = "<div class=\"form-group\"><label><span id=\"question\">Q2.</span></label>";
									html += "<textarea class=\"form-control\" id=\"Q2\" rows=\"1\" name=\"Q2\" placeholder=\"질문을 입력해주세요\"></textarea>";
									html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A2\" rows=\"5\" name=\"A2\"></textarea>";
									html += "</div><div align=\"right\"><span id=\"countA2\"></span>/1000</div>"
									var after = before + html;
								}
								if (rst.Q3 != null) {
									var html = "<div class=\"form-group\"><label><span id=\"question\">Q3.</span></label>";
									html += "<textarea class=\"form-control\" id=\"Q3\" rows=\"1\" name=\"Q3\" placeholder=\"질문을 입력해주세요\"></textarea>";
									html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A3\" rows=\"5\" name=\"A3\"></textarea>";
									html += "</div><div align=\"right\"><span id=\"countA3\"></span>/1000</div>"
									after += html;
								}
								if (rst.Q4 != null) {
									var html = "<div class=\"form-group\"><label><span id=\"question\">Q4.</span></label>";
									html += "<textarea class=\"form-control\" id=\"Q4\" rows=\"1\" name=\"Q4\" placeholder=\"질문을 입력해주세요\"></textarea>";
									html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A4\" rows=\"5\" name=\"A4\"></textarea>";
									html += "</div><div align=\"right\"><span id=\"countA4\"></span>/1000</div>"
									after += html;
								}
								$("#textarea").html(after);
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

	var menu = function(obj) {

		console.log(obj.dataset.value);

		var param = {
			"menu" : obj.dataset.value
		};
		$.post("${path}/essay/essayMenuAjax.do", param).done(function(rst) {
			console.log(rst);
			for(var i=0;i<rst.length;i++){
				var html = $("#left").html();
				console.log(html);
			}

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