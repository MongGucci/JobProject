<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${path}/semantic/semantic.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>

<script src="${path}/semantic/semantic.js"></script>
<link href="${path}/css/index.css" rel="stylesheet">
<link href="${path}/css/default.css" rel="stylesheet">


<title>JOB GO</title>
</head>
<body>
	<nav>
		<tiles:insertAttribute name="nav" />
	</nav>
	<div class="container-fluid">
		<div class="row">
			<div id="leftdiv" class="col-2">
				<tiles:insertAttribute name="left" />
			</div>
			<div id="centerdiv" class="col-8">
				<tiles:insertAttribute name="center" />
			</div>
			<div id="rightdiv" class="col-2">
				<tiles:insertAttribute name="right" />
			</div>
		</div>
	</div>

</body>
</html>