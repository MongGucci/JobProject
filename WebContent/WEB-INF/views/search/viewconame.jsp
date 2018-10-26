<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="${path}/css/essay.css" rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/css/tableboder.css">
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
<style type="text/css">
.line {
	border-bottom: 1px solid black;
}
</style>
<hr />
<body style="text-align: center;">
	<img alt="" src="${pageContext.servletContext.contextPath }${dt.LOGO }"
		style="float: left;">???
	<h3>${dt.CONAME }</h3>
	<small>가족친화</small>
	<br>
	<a href="${dt.HOMEPAGE }">${dt.HOMEPAGE }</a>
	<br>
	<br>
	<c:if test = "${!empty ok }">
		<script>
			alert("관심 기업으로 등록되었습니다.");
		</script>
	</c:if>
	<form
		action="${pageContext.servletContext.contextPath }/search/schbtn.do"
		id="f"></form>
	<button class="alert alert-warning" style="height: 50px;" id="bt">+
		관심 기업등록</button>
	<hr />
	<c:if test = "${!empty btn }">
		<script>
			alert("이미 등록된 기업입니다.");
		</script>
	</c:if>
	<table style="margin: auto">
		<tr>
			<td>대표자 : ${dt.CEO } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 기업 형태
				: ${dt.COTYPE }</td>
		</tr>
		<tr>
			<td>매출액 : ${dt.SALES }
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 사원수 :
				${dt.WORKERS }명</td>
		</tr>
		<tr>
			<td>업종 : ${dt.INDUSTRY } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 초봉 :
				${dt.FIRST }만원</td>
		</tr>
		<tr>
			<td>위치 : ${dt.BIG }&nbsp;${dt.SMALL }</td>
		</tr>
	</table>
	<hr />
	<p class="mt-5 mb-3 text-muted">&copy; 2018 JOB'A CORP</p>
	<c:choose>
		<c:when test="${userId eq null}">
			<script>
				$("#bt").on("click", function() {
					var t = window.confirm("로그인 인증이 필요합니다.\n로그인 하시겠습니까?");
					if (t) {
						$("#f").trigger("submit");
					}
				});
			</script>
		</c:when>
		<c:otherwise>
			<script>
				$("#bt").on("click", function() {
					$("#f").trigger("submit");
				});
			</script>
		</c:otherwise>
	</c:choose>
</body>