<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">

<div class="container" style="margin-top: 20px;">
<hr/>
<p>
	
	직군 : <a class="btn btn-outline-secondary" href="${path}/recruit/buttonselect.do?cate=${condition.cate}&big=all&small=all&cotype=all&hireshape=all" role="button">${condition.cate}</a> | 
	지역 : <a class="btn btn-outline-secondary" href="${path}/recruit/buttonselect.do?cate=all&big=${condition.big}&small=${condition.small}&cotype=all&hireshape=all" role="button"> ${condition.big}-${condition.small}</a> |
	기업 형태 : <a class="btn btn-outline-secondary" href="${path}/recruit/buttonselect.do?cate=all&big=all&small=all&cotype=${condition.cotype}&hireshape=all" role="button">${condition.cotype}</a> |
	고용 형태 : <a class="btn btn-outline-secondary" href="${path}/recruit/buttonselect.do?cate=all&big=all&small=all&cotype=all&hireshape=${condition.hireshape}" role="button">${condition.hireshape} </a>
	에 대한 검색결과입니다. <a role="button" class="btn btn-secondary" href="${path}/recruit/select.do">다시조건검색으로</a>
</p>	
<hr/>
	<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item"><a class="nav-link active" id="home-tab"
			data-toggle="tab" href="#home" role="tab" aria-controls="home"
			aria-selected="true">검색 결과</a></li>
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
					<c:forEach var="post" items="${lists}">
						<tr class="table"
							onclick="location.href='${path}/recruit/jobpost.do?hino=${post.HINO}'">
							<th scope="row">#로고</th>
							<td>${post.CONAME}</td>
							<td>${post.TITLE}</td>
							<td>${post.STARTDATE}-${post.ENDDATE}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>