<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">
<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="home" role="tabpanel"
			aria-labelledby="home-tab">
			<h3>기업정보</h3>
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">기업 </th>
						<th scope="col">업종</th>
						<th scope="col">기업 구분</th>
						<th scope="col">CEO</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var = "i" items="${isch }">
				<tr class="table" onclick="location.href='${pageContext.servletContext.contextPath }/search/schdetail.do?cono=${i.CONO }'">
				<th scope="row">${i.CONAME }</td>
				<td>${i.INDUSTRY }</td> 
				<td>${i.COTYPE }</td>
				<td><small>${i.CEO }</small></td>

				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<h3>채용 정보</h3>
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
					<c:forEach var="s" items="${isch}">

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