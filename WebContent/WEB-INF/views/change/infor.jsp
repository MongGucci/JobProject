<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link href="${path}/css/index.css" rel="stylesheet">

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

span:hover {
	color: white;
}

#hirediv {
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
	padding-top: 40px;
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
	width: 100px;
}
#tag{
width: 100px;
}


#hirename:hover {
	cursor: pointer;
}

table {
  border-spacing: 7px;
  border-collapse: separate;
}
</style>
<hr />

<%-- 본인 아이디 띄우기 --%>
<h3 style="text-align: center;">사용자 정보</h3>
<table style="margin: auto; text-align: left;font-size: 15pt; font-weight: bolder; ">
	<tr>
		<td id="tag" align="right">아이디 : </td>
		<td >&nbsp; ${u.ID }</td>
	</tr>
	<tr>
	<td id="tag" align="right">이메일 : </td>
		<td >&nbsp; ${u.EMAIL }</td>
	</tr>
	<tr>
	<td id="tag" align="right">이름 : </td>
		<td>&nbsp; ${u.NAME }</td>
	</tr>
	
</table>
<hr />
<div align="right">
<form class="form-signin"
	action="${pageContext.servletContext.contextPath }/pwchange.do">
	<button id="down">비밀번호 변경하기</button>
</form>
</div>
<%-- 찝한 기업  --%>
<h3 style="text-align: left;">내가 찜한 공고</h3>
<c:choose>
	<c:when test="${empty r }">
	내가 찜한 공고가 없습니다.
	</c:when>
	<c:otherwise>
		<c:forEach var="i" items="${r }" varStatus="status">
			<div id="hirediv">
				<div class="ui grid">
					<div class="four wide column" id="cnt" style="width: 100%;">
						<img src="${path}${i.LOGO}">
					</div>
					<div class="twelve wide column">

						<div class="ui grid">
							<div class="four wide column" id="hirename"
								onclick="location.href='${path}/recruit/jobpost.do?hino=${i.HINO}'">${i.NAME }</div>
							<div class="eight wide column" id="hireinfo">
								<div style="width: 100%" id="detail">${i.TITLE}</div>
								<div style="width: 100%" id="detail">

									<div style="width: 100%" id="detail">${i.COTYPE }</div>
								</div>
								<div class="four wide column" align="left">
									<div id="jaso" onclick="hino(this)" data-value="${i.HINO}">
										<i class="building icon"></i>${i.JOBCATE}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:otherwise>
</c:choose>
<hr />
<h3 style="text-align: left;">관심 기업</h3>
<c:choose>
	<c:when test="${empty r }">
	등록한 관심 기업이 없습니다.
	</c:when>
	<c:otherwise>
		<c:forEach var="a" items="${c }" varStatus="status">
			<div id="hirediv">
				<div class="ui grid">
					<div class="four wide column" id="cnt" style="width: 100%;">
						<img src="${path}${a.LOGO}">
					</div>
					<div class="twelve wide column">

						<div class="ui grid">
							<div class="four wide column" id="hirename"
								onclick="location.href='${path}/search/schdetail.do?cono=${a.CONO}'">${a.CONAME }</div>
							<div class="eight wide column" id="hireinfo">
								<div style="width: 100%" id="detail">CEO : ${a.CEO }</div>
								<div style="width: 100%" id="detail">

									<div style="width: 100%" id="detail">${a.COTYPE }</div>
								</div>
								<div class="four wide column" align="left">
									<i class="building icon"></i>${a.BIG} ${a.SMALL }
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</c:forEach>
	</c:otherwise>
</c:choose>
<hr />
<h3 style="text-align: left;">내가 쓴 기업 후기</h3>
<c:choose>
	<c:when test="${empty p }">
	등록된 기업 후기가 없습니다.
	</c:when>
	<c:otherwise>
		<div>
			<c:forEach var="d" items="${p }">
				<div id="hirediv">
					<div class="ui grid">

						<div class="four wide column" id="cnt" style="width: 100%;">
							<img src="${path}${d.LOGO}">
						</div>
						<div class="twelve wide column">

							<div class="ui grid">

								<div class="four wide column" id="hirename"
									onclick="location.href='${path}/search/schdetail.do?cono=${d.CONO}'">${d.CONAME }</div>
								<div class="eight wide column" id="hireinfo">
									<div style="width: 100%" id="detail">${d.INDUSTRY }</div>
									<div style="width: 100%" id="detail">${d.COTYPE }</div>
									<i class="building icon"></i>${d.BIG} ${d.SMALL }
								</div>
								<div class="four wide column" align="left">
									<div
										style="padding-top: 10px; font-size: 13pt; font-weight: bolder;"></div>
									<c:forEach var ="i" begin="1" end="${d.STAR }"><i style="font-size: 12pt; color: orange;"class="star icon"></i></c:forEach><br>
									<span style="color: blue;">장점</span><br> ☞ ${d.GOOD } <Br> 
									<span style="color: red;">단점 </span><br>☞ ${d.BAD }
								</div>
							</div>

						</div>
					</div>
				</div>
			</c:forEach>
		</div>

	</c:otherwise>
</c:choose>
<hr />
<%--내가 쓴 자소서 --%>
<div style="text-align: center;">
	<b>내가 쓴 자소서</b> <br />
	<c:choose>
		<c:when test="${empty j }">
			<br>내가 쓴 자기소개서가 없습니다.<br>
		☞ <a href="${path }/essay/essay.do">자소서 쓰러가기</a>
			<br>
		</c:when>
		<c:otherwise>
			<div class="row" align="center">
				<c:forEach var="e" items="${j}">


					<div class="card col-3" style="margin: 0px; padding: 0px;"
						onclick="location.href='${path}/essay/myEssayDetail.do?no=${e.JASONO}'">
						<div class="card-body">
							<h5 class="card-title" style="font-size: 10pt;">${e.ID}</h5>
							<p class="card-text" style="font-size: 10pt;">${e.TITLE}</p>
							<h6 class="card-subtitle mb-2 text-muted" style="font-size: 9pt;">${e.LASTDATE}</h6>
							<a href="${path}/essay/essayChange.do?no=${e.JASONO}"
								class="card-link" style="font-size: 10pt;">수정하기</a> <a href="#"
								class="card-link" style="font-size: 10pt;">삭제하기</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<hr />

