<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essayBoard.css" rel="stylesheet">

<div class="container">
	<header class="blog-header py-3">
		<div
			class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-4 pt-1">
				<a class="text-muted" href="#" id="etc">Subscribe</a>
			</div>
			<div class="col-4 text-center">
				<a class="blog-header-logo text-dark" href="${path}/job/index.do"
					id="logo"><b>JOB'A</b></a>
			</div>

			<div class="col-4 d-flex justify-content-end align-items-center">

				<div class="col-4 d-flex justify-content-end align-items-center">
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath }/login.do"
						id="signin">Sign in</a> <br> <a class="nav-link"
						href="${pageContext.servletContext.contextPath }/pwchange.do">변경</a>

					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath}/join.do"
						id="Sign up">Sign up</a>
				</div>
			</div>
		</div>

	</header>
	<hr>

	<div class="nav-scroller py-1 mb-2">
		<nav class="nav d-flex justify-content-between">
			<a class="p-2 text-muted" id="list" href="${path}/search/search.do">기업정보</a>
			<a class="p-2 text-muted" id="list" href="${path}/recruit/select.do">채용공고</a>
			<a class="p-2 text-muted" id="list"
				href="${path}/essayBoard/shareEssayList.do">자기소개서 공유 게시판</a> <a
				class="p-2 text-muted" id="list" href="${path}/essay/myEssay.do">자기소개서</a>

		</nav>
	</div>
</div>