
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE HTML>
<html>
<head>
<title>Urban by TEMPLATED</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="${path}/assets/css/main.css" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${path}/semantic/semantic.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script src="${path}/semantic/semantic.js"></script>

</head>
<body>
<header id="header" class="alt">
				<div class="logo"><a href="${path}/job/index.do">JOB <span>Go</span></a></div>
				<div style="margin-right: 20px;">
				<c:if test="${empty userId}">
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath }/login.do"
						id="signin">Sign in</a>
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath}/join/join.do"
						id="Sign up">Sign up</a>
				</c:if>
				<c:if test="${!empty userId}">
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath}/pwchange.do"
						id="Sign out">MyPage</a>
					<a class="btn btn-sm btn-outline-secondary"
						href="${pageContext.servletContext.contextPath}/logout.do"
						id="Sign out">Sign out</a>
				</c:if>
				</div>
			</header>


	<!-- Banner -->
	<section id="banner">
		<div class="inner">
			<header>
				<h1>이것이 현실이다.</h1>
				<p>
					뽑아주세요.<br />취직하고 싶어요.
				</p>
			</header>
			<a href="#main" class="button big scrolly">Learn More</a>
		</div>
	</section>

	<!-- Main -->
	<div id="main">

		<div class="container-fluid">
			<div class="row">
				<div id="leftdiv" class="col-2">
					<tiles:insertAttribute name="left" />
				</div>
				<div id="centerdiv" class="col-8">
					<section class="wrapper style1">
						<div class="inner">
							<header class="align-center">
								<h2>Aliquam ipsum purus dolor</h2>
								<p>Cras sagittis turpis sit amet est tempus, sit amet
									consectetur purus tincidunt.</p>
							</header>
							<div class="flex flex-3">
								<div class="col align-center">
									<div class="image round fit">
										<img src="images/pic03.jpg" alt="" />
									</div>
									<p>Sed congue elit malesuada nibh, a varius odio vehicula
										aliquet. Aliquam consequat, nunc quis sollicitudin aliquet.</p>
									<a href="${path}/search/search.do" class="button">기업정보</a>
								</div>
								<div class="col align-center">
									<div class="image round fit">
										<img src="images/pic05.jpg" alt="" />
									</div>
									<p>Sed congue elit malesuada nibh, a varius odio vehicula
										aliquet. Aliquam consequat, nunc quis sollicitudin aliquet.</p>
									<a href="${path}/recruit/select.do" class="button">채용정보</a>
								</div>
								<div class="col align-center">
									<div class="image round fit">
										<i class="address card outline icon" style="font-size: 30pt;"></i>
									</div>
									<p>Sed congue elit malesuada nibh, a varius odio vehicula
										aliquet. Aliquam consequat, nunc quis sollicitudin aliquet.</p>
									<a href="${path}/essayBoard/shareEssayList.do" class="button">자기소개서</a>
								</div>
							</div>
						</div>
					</section>

				</div>
				<div id="rightdiv" class="col-2">
					<tiles:insertAttribute name="right" />
				</div>
			</div>
		</div>





	</div>




	<!-- Scripts -->
	<script src="${path}/assets/js/jquery.min.js"></script>
	<script src="${path}/assets/js/jquery.scrolly.min.js"></script>
	<script src="${path}/assets/js/jquery.scrollex.min.js"></script>
	<script src="${path}/assets/js/skel.min.js"></script>
	<script src="${path}/assets/js/util.js"></script>
	<script src="${path}/assets/js/main.js"></script>

</body>
</html>