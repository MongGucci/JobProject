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


<link rel="stylesheet" href="${path}/assets/css/main.css" />
<link rel="stylesheet" href="${path}/css/default.css" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${path}/semantic/semantic.css">
<title>Insert title here</title>
<style>
#plus{
width:100%;
border: 3px solid #434e6e;
 background-color: Transparent;
 border-radius: 4px;
 color: #434e6e;
}
#plus:hover{
background-color:#434e6e;
opacity: 80%; 
border-radius: 4px;

}
span:hover{
color: white;
}
</style>
</head>
<body style="background-color: #F4F4F4;">

	<div class="container-fluid">

		<div class="row">

			<div class="col" style="overflow-y: scroll; height: 780px;">
				<div style="margin-top: 15px;">
					<div class="ui secondary  menu" style="font-size:15pt; font-weight: bolder;">
						<a class="item active" onclick="menu(this)" data-value="hire">
							채용공고 </a> <a class="item" onclick="menu(this)" data-value="pass">
							합격자소서 </a> <a class="item" > 내가 쓴 자소서 </a>

					</div>
				</div>




				<div style="margin-top: 30px;" id="listarea">
					<div class="ui cards" id="list">
						<c:forEach var="e" items="${list}">

							<div class="card" style="width: 100%;">
								<div class="content">
									<div class="header" style="font-family: 'Song Myung', serif; font-weight: lighter;">${e.NAME}</div>
									<div class="row">
										<div class="col-9"
											style="font-size: 17pt; font-weight: bolder;">${e.TITLE}</div>
										<div class="col-3" style="text-align: right; font-size: 17pt;">${e.DDAY}</div>
									</div>

								</div>
								<div class="ui bottom attached button" onclick="hino(this)"
									data-value="${e.HINO}" style="background-color: #465674; font-size: 17pt; font-family: 'Song Myung', serif;">
									<i class="add icon"></i> 자소서 쓰기
								</div>
							</div>



						</c:forEach>
					</div>
				</div>
			</div>

			<%-- ---------------------------오른쪽 시작----------------------------------- --%>
			<div class="col" style="margin-top: 20px;">

				<div class="row">
					<div class="col-9">
						<label style="font-size: 15pt;">TITLE</label> <input
							type="text" name="title" placeholder="제목" id="title"
							style="background: transparent; width: 100%; font-size: 15pt; border: none; outline: none; border-bottom: 2px solid rgba(0, 0, 0, 5);">
					</div>

					<div class="col-3">
						<label style="font-size: 15pt; margin-bottom: 25px;">직군</label> <select
							class="form-control" name="job" required="required"
							style="font-size: 13pt; width: 100%; ">
							<option>직군</option>
							<c:forEach var="e" items="${cate}">
								<option value="${e.CATENAME}">${e.CATENAME}</option>
							</c:forEach>

						</select>
					</div>
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
  <div class="four wide column"><button id="plus" ><span style="color: #434e6e;">추가하기</span></button></div>
 
</div>
				

			</div>
			
			
			
		</div>
	</div>

	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true"></div>

</body>
<!-- Scripts -->


<script>
	var count = 1;
	$("#plus").on("click", function() {
		count++;
		console.log(count);

		
	
		if(count > 4){
			count--;
			window.alert("4개 까지!!")
			
		}else{
			var html ="<div class=\"form-group\"><label><span id=\"question\">Q"+count+".</span></label>";
			html += "<textarea class=\"form-control\" id=\"Q"+count+"\" rows=\"1\" name=\"Q"+count+"\" placeholder=\"질문을 입력해주세요\"></textarea>";
			html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A"+count+"\" rows=\"5\" name=\"A"+count+"\"></textarea>";
			html += "</div><div align=\"right\"><span id=\"countA"+count+"\"></span>/1000</div>"
			var before = $("#textarea").html();
			var after = before + html;
			console.log(before);
			console.log(after);
			$("#textarea").html( after);
			//$("#textarea").html() = $("#textarea").html() + html;
			
		}
		

	});
 
	var hino = function(obj) {
		console.log(obj.dataset.value);

		var param = {
			"hino" : obj.dataset.value
		};

		$.post("${path}/essay/essayPostAjax.do", param).done(function(rst) {
			console.log(rst);
			if (rst != null) {
				var before = $("#textarea").html();
				$("#title").val(rst.TITLE);
				$("#job").val(rst.JOBCATE);
				
				if(rst.Q2 != null){
					var html ="<div class=\"form-group\"><label><span id=\"question\">Q2.</span></label>";
					html += "<textarea class=\"form-control\" id=\"Q2\" rows=\"1\" name=\"Q2\" placeholder=\"질문을 입력해주세요\"></textarea>";
					html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A2\" rows=\"5\" name=\"A2\"></textarea>";
					html += "</div><div align=\"right\"><span id=\"countA2\"></span>/1000</div>"
						var after = before + html;
				}
				if(rst.Q3 != null){
					var html ="<div class=\"form-group\"><label><span id=\"question\">Q3.</span></label>";
					html += "<textarea class=\"form-control\" id=\"Q3\" rows=\"1\" name=\"Q3\" placeholder=\"질문을 입력해주세요\"></textarea>";
					html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A3\" rows=\"5\" name=\"A3\"></textarea>";
					html += "</div><div align=\"right\"><span id=\"countA3\"></span>/1000</div>"
						after += html;
				}
				if(rst.Q4 != null){
					var html ="<div class=\"form-group\"><label><span id=\"question\">Q4.</span></label>";
					html += "<textarea class=\"form-control\" id=\"Q4\" rows=\"1\" name=\"Q4\" placeholder=\"질문을 입력해주세요\"></textarea>";
					html += "</div><div class=\"form-group\"><textarea class=\"form-control\" id=\"A4\" rows=\"5\" name=\"A4\"></textarea>";
					html += "</div><div align=\"right\"><span id=\"countA4\"></span>/1000</div>"
						after += html;
				}
				$("#textarea").html( after);
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