<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">
<!-- <link href="${path}/css/essayBoard.css" rel="stylesheet"> -->

<div class="container" style="margin-top: 20px;">

	

		<div class="ui special cards" style="margin: 50px;">
			<c:forEach var="e" items="${dead}">
				<div class="card">
					<div class="blurring dimmable image">
						<div class="ui inverted dimmer">
							<div class="content">
								<div class="center">
									<div class="ui primary button">Add Friend</div>
								</div>
							</div>
						</div>
						<img src="${path}${e.PATH}" style="height:200px;">
					</div>
					<div class="content">
						<a class="header">${e.CONAME}</a>
						<div class="meta">
							<span class="date">${e.TITLE}</span>
						</div>
					</div>
					<div class="extra content">
						<a> <i class="users icon"></i> 2 Members
						</a>
					</div>
				</div>
			</c:forEach>
		</div>


		



	

	<form action="${path}/recruit/select.do" method="post">

		<div class="row">



			<div class="col">
				<select class="form-control" name="cate" required="required">
					<option value="all">직군</option>
					<c:forEach var="e" items="${cate}">
						<option value="${e.CATENAME}">${e.CATENAME}</option>
					</c:forEach>
				</select>
			</div>

			<div class="col">
				<!-- <select class="form-control" name="big" onchange="getSmall(this.value);" required="required"> -->
				<select class="form-control" name="big" id="location"
					required="required">
					<option value="all">지역(대)</option>
					<c:forEach var="e" items="${big}">
						<option value="${e.BIG}">${e.BIG}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col">

				<select class="form-control" name="small" required="required"
					id="smalls">
					<option value="all">지역(소)</option>
					<option value="${e.SMALL}">${e.SMALL}</option>
				</select>
			</div>
			<div class="col">
				<select class="form-control" name="cotype" required="required">
					<option value="all">기업형태</option>
					<c:forEach var="e" items="${cotype}">
						<option value="${e.COTYPE}">${e.COTYPE}</option>
					</c:forEach>
				</select>
			</div>
			<div class="col">
				<select class="form-control" name="hireshape" required="required">
					<option value="all">고용형태</option>
					<c:forEach var="e" items="${hireshape}">
						<option value="${e.SHAPE}">${e.SHAPE}</option>
					</c:forEach>
				</select>
			</div>


		</div>
		<hr />

		<div align="right">
			<button type="submit" class="btn btn-dark">G O</button>
		</div>

	</form>

	<hr />

	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item"><a class="nav-link active" id="home-tab"
			data-toggle="tab" href="#home" role="tab" aria-controls="home"
			aria-selected="true">최근 올라온 순</a></li>
		<li class="nav-item"><a class="nav-link" id="profile-tab"
			data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
			aria-selected="false">인기 순</a></li>
		<li class="nav-item"><a class="nav-link" id="contact-tab"
			data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
			aria-selected="false">얼마 남지 않은순</a></li>
	</ul>
	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home" role="tabpanel"
			aria-labelledby="home-tab">
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">기업</th>
						<th scope="col">제목</th>
						<th scope="col">공고보러가기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${start}">

						<c:if test="${empty post.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${post.HINO}'">
								<th scope="row">#로고</th>
								<td>${post.CONAME}</td>
								<td>${post.TITLE}</td>
								<td>${post.STARTDATE}-${post.ENDDATE}</td>
							</tr>
						</c:if>
						<c:if test="${!empty post.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${post.HINO}'">
								<th scope="row">#로고</th>
								<td>${post.CONAME}</td>
								<td>[마감]${post.TITLE}</td>
								<td>마감된 공고입니다.</td>
							</tr>
						</c:if>

					</c:forEach>

				</tbody>
			</table>
		</div>
		<div class="tab-pane fade" id="profile" role="tabpanel"
			aria-labelledby="profile-tab">
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">기업</th>
						<th scope="col">제목</th>
						<th scope="col">공고보러가기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${hits}">

						<c:if test="${empty post.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${post.HINO}'">
								<th scope="row">#로고</th>
								<td>${post.CONAME}</td>
								<td>${post.TITLE}</td>
								<td>${post.STARTDATE}-${post.ENDDATE}</td>
							</tr>
						</c:if>
						<c:if test="${!empty post.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${post.HINO}'">
								<th scope="row">#로고</th>
								<td>${post.CONAME}</td>
								<td>[마감]${post.TITLE}</td>
								<td>마감된 공고입니다.</td>
							</tr>
						</c:if>

					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="tab-pane fade" id="contact" role="tabpanel"
			aria-labelledby="contact-tab">
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">기업</th>
						<th scope="col">제목</th>
						<th scope="col">공고보러가기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${end}">
						<c:if test="${empty post.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${post.HINO}'">
								<th scope="row">#로고</th>
								<td>${post.CONAME}</td>
								<td>${post.TITLE}</td>
								<td>${post.STARTDATE}-${post.ENDDATE}</td>
							</tr>
						</c:if>
						<c:if test="${!empty post.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${post.HINO}'">
								<th scope="row">#로고</th>
								<td>${post.CONAME}</td>
								<td>[마감]${post.TITLE}</td>
								<td>마감된 공고입니다.</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>


		</div>
	</div>
</div>

<script>
	/* var getSmall = function(big){
	   var xhr = new XMLHttpRequest();
	   console.log("big :" +big);
	   
	   xhr.open("post", "${path}/recruit/selectajax.do", true);
	   xhr.onreadystatechange = function(){
	      if(this.readyState==4) {
	         
	         var small =JSON.parse(this.responseText.trim());
	         
	         for(var i=0;i<small.length;i++){
	            document.getElementById("smalls").innerHTML +=
	             "<option value=\""+small[i].SMALL+"\">"+small[i].SMALL+"</option><br/>";
	             console.log(small[i].SMALL);
	
	         }
	      }
	   };
	   var param = big;

	   xhr.send(param);
	   
	}; */

	$("#location").on(
			"change",
			function() {
				var big = $("#location").val();
				console.log("val:" + big);
				var param = {
					"big" : big
				};
				$.post("${path}/recruit/selectajax.do", param).done(
						function(rst) {
							var html = "";
							for (var i = 0; i < rst.length; i++) {
								html += "<option value=\""+rst[i].SMALL+"\">"
										+ rst[i].SMALL + "</option><br/>";
								//console.log(small[i].SMALL);
							}
							$("#smalls").html(html);

						});
			});
</script>



