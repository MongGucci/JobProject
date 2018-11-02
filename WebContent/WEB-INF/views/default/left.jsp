<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />


<c:if test="${!empty userId }">
	<div style="margin-top: 20px;">
		<c:choose>
			<c:when test="${!empty today or !empty three }">
				<span style="font-size: 11pt; font-weight: bolder;">내가 찜한 기업에
					대한 정보입니다.</span>
			</c:when>
			<c:otherwise>
				<span style="font-size: 11pt; font-weight: bolder;">기업을 찜하면 그
					기업의 공고 알림을 제공해드려요!</span>
				<br />
				<a href="${path}/search/search.do">원하는 기업을 찜해주세요!</a>
			</c:otherwise>
		</c:choose>
		<c:if test="${!empty today}">
			<div style="font-size: 15pt; margin-top: 20px;">
				<span style="font-size: 13pt; font-weight: bolder;">[오늘 마감하는
					채용공고]</span>
				<div class="ui link list">

					<c:forEach var="h" items="${today}">
						<a href="${path}/recruit/jobpost.do?hino=${h.HINO}" class="item"
							style="font-size: 13pt; font-weight: bolder; color: #465674;"><i
							class="bell outline icon"></i>${h.CONAME} | 공고보러가기</a>
					</c:forEach>
				</div>

			</div>
			<hr>
		</c:if>

		<c:if test="${!empty three}">
			<div style="font-size: .75em;">
				<span style="font-size: 13pt; font-weight: bolder;">[3일 남은
					채용공고]</span>
				<div class="ui link list">

					<c:forEach var="h" items="${three}">
						<a href="${path}/recruit/jobpost.do?hino=${h.HINO}" class="item"
							style="font-size: 13pt; font-weight: bolder; color: #465674;"><i
							class="bell outline icon"></i>${h.CONAME} | 공고보러가기</a>
					</c:forEach>
				</div>
			</div>
			<hr>
		</c:if>
	</div>
</c:if>


<div id="alert" style="font-size: .75em; width: 100%;"></div>

<script type="text/javascript">

<c:if test="${!empty userId}">
	
console.log("연결");
	var ws = new WebSocket("ws://" + location.host + "${path}/conn.do");
	console.log("안녕");
	ws.onmessage = function(evt) { //매개변수설정하면
		//받은 메세지에 관련된 객체를 넘겨주면서 콜이 일어나고
		console.log(evt.data);
		var obj = JSON.parse(evt.data);

		switch (obj.mode) {
		case "reply":
			replyAlertHandle(obj);
			break;

		case "newpost":
			newpostHandle(obj);
			break;

		}
	};

	var replyAlertHandle = function(obj) {

		var html = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">";
		html += "<strong>"
				+ obj.msg
				+ "</strong><a href=\"${path}/essayBoard/essayBoardDetail.do?no="
				+ obj.link + ">보러가기</a>";

		html += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">";
		html += "<span aria-hidden=\"true\">&times;</span>";
		html += "</button>";
		html += "</div>";

		document.getElementById("alert").innerHTML += html;
	};

	var newpostHandle = function(obj) {
		console.log("newpost")
		var html = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">";
		html += "<strong>" + obj.msg
				+ "</strong><a href=\"${path}/recruit/jobpost.do?hino?"
				+ obj.link + ">보러가기</a>";

		html += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">";
		html += "<span aria-hidden=\"true\">&times;</span>";
		html += "</button>";
		html += "</div>";

		document.getElementById("alert").innerHTML += html;
	};
	</c:if>
</script>
