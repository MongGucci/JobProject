<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/index.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/tableboder.css">
<body style="text-align: center;">
	<c:forEach var="l" items="${sli }">
		${l.CONAME }  / ${l.COTYPE }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<br>
		<a
			href="${pageContext.servletContext.contextPath }/search/schdetail.do?cono=${l.CONO }">
			${l.INDUSTRY }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 위치 : ${l.BIG }&nbsp;${l.SMALL }<br>
			<div style="float: right;">
				<small>대표 : ${l.CEO }</small>
			</div>
		</a>
		<hr />
	</c:forEach>
</body>