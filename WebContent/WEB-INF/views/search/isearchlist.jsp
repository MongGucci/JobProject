<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">
<style>
#body {
	color: #434e6e;
}

span:hover {
	color: white;
}

#searchdiv {
	border: 1px solid #434e6e;
	margin: 20px;
	background-color: white;
	padding: 10px;
	font-family: 'Nanum Gothic', sans-serif;
}

#cnt {
	font-size: 20pt;
	text-align: center;
}

#hirename {
	font-size: 17pt;
	font-weight: bolder;
	padding-top: 30px;
}

#hireinfo {
	font-size: 12pt;
}

#detail {
	margin: 5px;
}

#jaso {
	font-size: 13pt;
	margin-top: 10px;
}

#jaso:hover {
	cursor: pointer;
}

img {
	width: 140px;
}

#hirename:hover {
	cursor: pointer;
}

#searchdiv:hover {
	background-color: #434e6e;
	color: white;
}

#cnt {
	font-size: 13pt;
	text-align: center;
}
</style>
<div class="container" style="margin-top: 20px;">


	<p>기업정보</p>
	<div id="searchdiv">
		<div class="ui grid">

			<div class="four wide column" id="cnt" style="width: 100%;">
				<img src="${path}/storage/logo/korail.PNG">
			</div>
			<div class="twelve wide column">

				<div class="ui grid">

					<div class="four wide column" id="hirename"
						onclick="location.href='${path}/search/schdetail.do?cono=${l.CONO}'">회사
						이름</div>
					<div class="eight wide column" id="hireinfo">
						<div style="width: 100%" id="detail">
							<b>공고제목</b>
						</div>
						<div style="width: 100%" id="detail">
							<small>산업군</small>
						</div>
						<div style="width: 100%" id="detail">고용형태</div>
					</div>
					<div class="four wide column" align="left">
						<div
							style="padding-top: 10px; font-size: 13pt; font-weight: bolder;">몇일
							남았는지</div>
						<div>
							<i class="building icon"></i>큰구역 작은구역
						</div>
					</div>

				</div>





			</div>

		</div>
	</div>


	<p>합격자소서</p>
	<div id="searchdiv">
		<div class="ui grid">

			<div class="four wide column" id="cnt">
				<img src="${path}/storage/logo/korail.PNG">
			</div>
			<div class="twelve wide column">
				<div class="ui grid">

					<div class="four wide column" id="hirename">회사이름</div>
					<div class="twelve wide column" id="hireinfo">
						<div style="width: 100%" id="detail">
							<b>자소서 제목</b>
						</div>
						<div style="width: 100%" id="detail">
							<small>분야</small>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<p>자소서 게시판</p>
	<div id="searchdiv" align="left"
		onclick="location.href='${path}/essayBoard/essayBoardDetail.do?no=${e.NO}'">
		<div class="ui grid" id="list">

			<div class="one wide column" id="cnt" style="padding-top: 30px;">
				NO</div>
			<div class="eight wide column"
				style="padding-top: 30px; font-weight: bolder;">TITLE</div>
			<div class="four wide column" id="cnt" style="text-align: center;">

				<div style="width: 100%" id="detail">
					<b>WRITER</b>
				</div>
				<div style="width: 100%" id="detail">
					<small>CATE</small>
				</div>
				<div style="width: 100%; font-size: 10pt;" id="detail">WRITEDATE</div>
			</div>
			<div class="three wide column" id="cnt">

				<div align="left">
					<i class="heart icon" style="color: #F14444;"></i>HITS
				</div>
				<div align="left" style="margin-top: 10px;">
					<i class="eye icon" style="color: #707374;"></i>GOOD
				</div>
			</div>
		</div>
	</div>



	<p>채용공고</p>
	<div id="searchdiv">

		<div class="ui grid" id="list">

			<div class="four wide column" id="cnt">
				<img src="${path}/storage/logo/korail.PNG">
			</div>
			<div class="twelve wide column">

				<div class="ui grid">

					<div class="four wide column" id="hirename">NAME</div>
					<div class="eight wide column" id="hireinfo">
						<div style="width: 100%" id="detail">
							<b>TITLE</b>
						</div>
						<div style="width: 100%" id="detail">
							<small>JOBCATE</small>
						</div>
						<div style="width: 100%" id="detail">HIRESHAPE</div>
					</div>
					<div class="four wide column" align="right">
						<div
							style="padding-top: 10px; font-size: 13pt; font-weight: bolder;">DDAY</div>
						<div id="jaso" onclick="hino(this)" data-value="${e.HINO}"
							data-toggle="modal" data-target="#exampleModal">
							<i class="add icon"></i>자소서 쓰러가기
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>




</div>





