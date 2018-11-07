<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">

<div class="container-fluid" style="margin-top: 30px;">
<div class="row">
	<div class="col-2"></div>
	

	
	<div class="col-8">
	<header class="blog-header py-3">
		<div
			class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-4 pt-1">
				<a class="text-muted" href="#" id="etc">Subscribe</a>
			</div>
			<div class="col-4 text-center">
				<a class="blog-header-logo text-dark" href="${path}" id="logo"><b id="jobgo">JOB Go</b></a>
			</div>

			<div class="col-4 d-flex justify-content-end align-items-center">

				<c:if test="${empty userId}">
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath }/login.do"
						id="signin">Sign in</a>
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath}/join/join.do"
						id="Sign up">Sign up</a>
				</c:if>
				<c:if test="${!empty userId}">
				
					<div class="dropdown show" style="margin-top: 15px;">
					  <a class="btn btn-secondary dropdown-toggle"  role="button" id="recentcookie" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    최근 본 채용공고
					  </a>
					
					  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" id ="hilist">
					    
					  </div>
					</div> 
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath}/pwchange.do"
						id="Sign out">MyPage</a>
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath}/logout.do"
						id="Sign out">Sign out</a>
				</c:if>

			</div>
		</div>

	</header>
	<hr>
	
	<nav class="nav d-flex justify-content-between">
			<a class="p-2 text-muted" id="list" href="${path}/search/search.do">기업정보</a>
			<a class="p-2 text-muted" id="list" href="${path}/recruit/select.do">채용공고</a>
			<a class="p-2 text-muted" id="list"
				href="${path}/essayBoard/shareEssayList.do">자기소개서 공유 게시판</a> <a
				class="p-2 text-muted" id="list" href="${path}/essay/essay.do">자기소개서</a>

		</nav></div>
	<div class="col-2"></div>
		
	</div>
</div>

<script>

	$("#recentcookie").on(
		"click",
		function() {
			
			$.get("${path}/recruit/recenthireajax.do").done(
					function(rst) {
						var html = "";
						console.log(rst);
						for (var i = 0; i < rst.length; i++) {
							console.log(rst[i].HINO+"/"+rst[i].NAME);
							html+= "<a class=\"dropdown-item\" href=\"${path}/recruit/jobpost.do?hino="+rst[i].HINO+"\">"+rst[i].NAME+"</a>";
							
						}
						$("#hilist").html(html);

					});
		}); 
	
	</script>


