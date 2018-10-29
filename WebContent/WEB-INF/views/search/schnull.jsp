<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essay.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/tableboder.css">
<body style="text-align: center;">
	<br>
	<br>
	<br> <h4>'${conames}'에 대한 검색결과가 없습니다.</h4><br>
	
	<small>
		＊ 단어의 철자가 정확한지 확인해 보세요.<br><br>
	</small>
	<br>
	<form action="${path}/search/search.do">
		<button type="submit">검색하기</button>
	</form>
</body>