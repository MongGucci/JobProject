<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
<hr>

<%-- 본인 아이디 띄우기 --%>
<h3 style="text-align: center;">사용자 정보</h3>
<table style="margin: auto; text-align: left;">
	<tr>
		<td>아이디 : ${u.ID }</td>
	</tr>
	<tr>
		<td>이메일 : ${u.EMAIL}</td>
	</tr>
	<tr>
		<td>이 름 : ${u.NAME }</td>
	</tr>
</table>

<hr />
<br>
<%-- 찝한 기업  --%>
<table style="margin: auto; text-align: left; width: 50%; float: left;">
	<tr>
		<td><b>내가 찜한 공고</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<c:forEach var="i" items="${r }">
		<tr>
			<td><a
				href="${pageContext.servletContext.contextPath }/recruit/jobpost.do?hino=${i.HINO}">
					${i.NAME}</a><Br> <small>${i.TITLE  }</small></td>
		</tr>
	</c:forEach>
</table>

<table
	style="margin: auto; width: 50%; float: left; border-left: 1px black solid;">
	<tr style="text-align: left;">
		<td>&nbsp;</td>
		<td><B>내가 쓴 기업 후기</B></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<c:forEach var="a" items="${p }">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td><a
				href="${pageContext.servletContext.contextPath }/search/schdetail.do?cono=${a.CONO}">
					${a.CONAME } - ${a.INDUSTRY } </a> <br> <small> <span
					style="color: blue;">장점</span> : ${a.GOOD } <Br> <span
					style="color: red;">단점 </span>: ${a.BAD }
			</small></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</c:forEach>
</table>
<div style="clear: both;"></div>
<hr />
<%--내가 쓴 자소서 --%>
<div style="text-align: center;">
	<b>내가 쓴자소서</b> <br />
	<c:choose>
		<c:when test="${empty j }">
         -
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
								class="card-link" style="font-size: 10pt;">수정하기</a> <a
								href="${path}/essay/essayDelete.do?no=${e.JASONO}"
								class="card-link" style="font-size: 10pt;">삭제하기</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<hr />
<form class="form-signin"
	action="${pageContext.servletContext.contextPath }/pwchange.do">
	<button class="btn btn-lg btn-warning btn-block" type="submit"
		style="margin: auto; width: 50%;">비밀번호 변경</button>
</form>
<br>
<br>
<br>
</main>