<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essay.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/tableboder.css">
<style>
#down {
	background-color: rgba(0, 0, 0, 0);
	border: 1px solid #434e6e;
	color: #434e6e;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}

#down:hover {
	background-color: #434e6e;
	color: white;
	padding: 10px;
	font-size: 10pt;
	border-radius: 5%;
}
</style>
<body style="text-align: center;">
	<div style="text-align: center; margin-top: 50px;">

		<h4 style="font-size: 20pt;">'${conames}'에 대한 검색결과가 없습니다.</h4>
		<small style="margin-top: 30px;"> ＊ 단어의 철자가 정확한지 확인해 보세요.</small>

		<form action="${path}/search/search.do">
			<button id="down" style="margin-top: 30px;">
				<b>다시 검색하기</b>
			</button>
		</form>
	</div>
</body>