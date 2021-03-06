<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essay.css" rel="stylesheet">
<link href="${path}/css/default.css" rel="stylesheet">
<div class="container" style="margin-top: 20px;">


	<h1>내가 쓴 자기소개서</h1>
	
		<div class="row"> 
		<c:forEach var="e" items="${myEssay}">


			<div class="card col-3" style="margin: 0px; padding: 0px; " 
				onclick="location.href='${path}/essay/myEssayDetail.do?no=${e.JASONO}'">
				<div class="card-body">
					<h5 class="card-title">${e.ID}</h5>
					<p class="card-text">${e.TITLE}</p>
					<h6 class="card-subtitle mb-2 text-muted">${e.LASTDATE}</h6>
					<a href="${path}/essay/essayChange.do?no=${e.JASONO}"
						class="card-link">수정하기</a> <a href="#" class="card-link">게시판에
						올리기</a>
				</div>
			</div>
		</c:forEach>
		</div>
	

	<div align="right">
		<a href="${path}/essay/essayWrite.do"><button
				class="btn btn-outline-dark btn-md">자기소개서 쓰러가기</button></a>
	</div>
</div>

