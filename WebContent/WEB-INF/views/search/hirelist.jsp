<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">
	<div class="container" style="margin-top: 20px;">
	<div align="center">
			<form class="form-signin"
		action="${pageContext.servletContext.contextPath }/recruit/hiresearch.do"
		method="post">
		<div>
			<input type="text" list="some" placeholder="궁금하신 채용 정보를 검색해주세요."
				name="hsearch" style="width: 250px; height: 40px;  border: 0px;"/>
			<button type="submit" style="height: 40px; background: #ffffff; outline: none; border: 0px;">
				<img class=""
					src="${pageContext.servletContext.contextPath }/image/dop.PNG"
					style="width: 30px; height: 30px; padding: 0px;" border="0" />
			</button>
		</div>
		<br>
	</form>
	</div>

<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item"><a class="nav-link active" id="home-tab"
			data-toggle="tab" href="#home" role="tab" aria-controls="home"
			aria-selected="true">채용 정보</a></li>
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
						<c:forEach var="s" items="${hir}">

						<c:if test="${empty s.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${s.HINO}'">
								<th scope="row">#로고</th>
								<td>${s.CONAME}</td>
								<td>${s.TITLE}</td>
								<td>${s.STARTDATE}-${s.ENDDATE}</td>
							</tr>
						</c:if>
						<c:if test="${!empty s.MAGAM}">
							<tr class="table"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${s.HINO}'">
								<th scope="row">#로고</th>
								<td>${s.CONAME}</td>
								<td>[마감]${s.TITLE}</td>
								<td>마감된 공고입니다.</td>
							</tr>
						</c:if>

					</c:forEach>

				</tbody>
			</table>



		</div>
		</div>
</div>