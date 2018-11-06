
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE HTML>
<html>
<head>
<title>JOB Go</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="stylesheet" href="${path}/assets/css/main.css" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${path}/semantic/semantic.css">

<style type="text/css">
#btn {
	border-radius: 4px;
	font-family: 'Patua One', cursive;
	background-color: #465674;
	font-size: 13pt;
	width: 100%;
}

#rank {
	font-size: 15pt;
	color: white;
	margin: 10px;
}

a:link {
	color: white;
}
</style>


</head>

<header id="header" class="alt">
	<div class="logo">
		<a href="${path}/job/index.do">JOB <span>Go</span></a>
	</div>
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
<section id="banner" style="height: 400px;">
	<div class="inner">
		<header>
			<h1 style="font-family: 'Song Myung', serif;">이것이 현실이다.</h1>
			<p>
				뽑아주세요.<br />취직하고 싶어요.
			</p>
			<div class="ui category search">
				<div class="ui icon input" style="width: 100%;">
					<input class="prompt" type="text" placeholder="Search"> <i
						class="search icon"></i>
				</div>
				<div class="results"></div>
			</div>
			<div class="ui grid">
  
  <div class="two wide column"></div>
   <div class="twelve wide column" style="text-align: left; padding:30px;"><div class="ui list" style="width: 100%;">
				<div class="item">

					<div class="content" style="color: white; font-size: 15pt; ">
						<i class="users icon"></i>인기 기업
					</div>
					<div id="list" style="margin: 10px;" ></div>



				</div>
			</div></div>
  <div class="two wide column"></div>
  
</div>
			
		</header>


	</div>
</section>

<!-- Main -->
<div id="main">

	<div class="container-fluid" style="background-color: #F4F4F4;">
		<div class="row">
			<div id="leftdiv" class="col-2">
				<tiles:insertAttribute name="left" />
			</div>
			<div id="centerdiv" class="col-8" style="margin-bottom: 80px;">


				<header class="align-center">
					<h2
						style="font-family: 'Patua One', cursive; font-size: 30pt; margin-bottom: 25px;">JOB
						Go</h2>
				</header>
				<div class="flex flex-3">
					<div class="col align-center">
						<div style="margin: 20px;">

							<img src="${path}/images/company.png" style="width: 100%;">
						</div>
						<p style="font-size: 12pt; color: #465674; font-weight: bolder;">관심있는
							기업을 검색해보세요.</p>
						<a href="${path}/search/search.do"><button id="btn">Search
								Company</button></a>
					</div>
					<div class="col align-center">
						<div style="margin: 20px;">

							<img src="${path}/images/human-resources.png"
								style="width: 100%;">
						</div>
						<p style="font-size: 12pt; color: #465674; font-weight: bolder;">기업의
							채용공고를 검색해보세요.</p>
						<a href="${path}/recruit/select.do"><button id="btn">Employment
								Information</button></a>
					</div>
					<div class="col align-center">


						<div style="margin: 20px;">

							<img src="${path}/images/hiring.png" style="width: 100%;">
						</div>

						<p style="font-size: 12pt; color: #465674; font-weight: bolder;">여러분의
							자소서를 작성하고 공유해보세요.</p>
						<a href="${path}/essayBoard/shareEssayList.do"><button
								id="btn">A Letter Of Self-Introduction</button></a>
					</div>
				</div>


			</div>
			<div id="rightdiv" class="col-2">
				<tiles:insertAttribute name="right" />
			</div>
		</div>
	</div>





</div>
<script type="text/javascript">
	setInterval(
			function() {
				$
						.get("${path}/indexAjax.do")
						.done(
								function(rst) {
									console.log(rst[i]);
									var html = "";
									for (var i = 0; i < 5; i++) {
										console.log(rst[i]);
										if (rst[i] != null) {
											html += "<div class=\"content\" id=\"rank\">"
											html += (i + 1)
													+ ". <a href=\"${path}/search/schdetail.do?cono="
													+ rst[i].cono + "\"> "
													+ rst[i].coname + " </a>";
											html += "</div>";

										} else {
											html += "<div class=\"content\" id=\"rank\">"
											html += (i + 1)
													+ ". <a href=\"#\"> - - </a>";
											html += "</div>";
										}

									}
									$("#list").html(html);

								});
			}, 60000);
</script>




<!-- Scripts -->

<script src="${path}/assets/js/jquery.min.js"></script>
<script src="${path}/assets/js/jquery.scrolly.min.js"></script>
<script src="${path}/assets/js/jquery.scrollex.min.js"></script>
<script src="${path}/assets/js/skel.min.js"></script>
<script src="${path}/assets/js/util.js"></script>
<script src="${path}/assets/js/main.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>


</html>